provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {}

resource "aws_s3_bucket" "site" {
  bucket = var.site_domain
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_acl" "site" {
  bucket = aws_s3_bucket.site.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.site.arn,
          "${aws_s3_bucket.site.arn}/*",
        ]
      },
    ]
  })
}

resource "aws_s3_bucket" "www" {
  bucket = "www.${var.site_domain}"
}

resource "aws_s3_bucket_acl" "www" {
  bucket = aws_s3_bucket.www.id

  acl = "private"
}

resource "aws_s3_bucket_website_configuration" "www" {
  bucket = aws_s3_bucket.site.id

  redirect_all_requests_to {
    host_name = var.site_domain
  }
}

data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}

resource "cloudflare_record" "site_cname" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.site_domain
  value   = aws_s3_bucket.site.website_endpoint
  type    = "CNAME"

  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = "www"
  value   = var.site_domain
  type    = "CNAME"

  ttl     = 1
  proxied = true
}

resource "cloudflare_page_rule" "redirect-to-learn" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  target  = "${var.site_domain}/learn"
  actions {
    forwarding_url {
      status_code = 302
      url         = "https://learn.hashicorp.com/terraform"
    }
  }
}

resource "cloudflare_page_rule" "redirect-to-hashicorp" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  target  = "${var.site_domain}/hello"
  actions {
    forwarding_url {
      status_code = 302
      url         = "https://hashicorp.com"
    }
  }
}

resource "cloudflare_access_application" "staging_app" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name                      = "staging application"
  domain                    = var.staging_domain
  # type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = false
}

# one time pin
resource "cloudflare_access_identity_provider" "pin_login" {
  name       = "PIN login"
  type       = "onetimepin"
}

# oauth
resource "cloudflare_access_identity_provider" "github_oauth" {
  name       = "GitHub OAuth"
  type       = "github"
  config {
    client_id     = "example"
    client_secret = "secret_key"
  }
}

resource "random_id" "argo_secret" {
  byte_length = 35
}

resource "cloudflare_argo_tunnel" "argo_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "${var.argo_subdomain}-tunnel"
  secret     = random_id.argo_secret.b64_std
}

resource "cloudflare_record" "http_app" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.argo_subdomain
  value   = "${cloudflare_argo_tunnel.argo_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}
