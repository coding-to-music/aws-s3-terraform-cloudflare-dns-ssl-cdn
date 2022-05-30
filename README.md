# aws-s3-terraform-cloudflare-dns-ssl-cdn

# 🚀 Javascript full-stack 🚀

https://github.com/coding-to-music/aws-s3-terraform-cloudflare-dns-ssl-cdn

From https://github.com/coding-to-music/learn-terraform-cloudflare-static-website

https://learn.hashicorp.com/tutorials/terraform/cloudflare-static-website

https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication

## Learn Terraform Cloudflare Static Website

Learn how to use Terraform to set up a static website using AWS bucket for object storage and Cloudflare for DNS, SSL and CDN. Follow along with [this tutorial](https://learn.hashicorp.com/tutorials/terraform/cloudflare-static-website) on HashiCorp Learn.

The [`acm-cloudfront`](https://github.com/hashicorp/learn-terraform-cloudflare-static-website/tree/acm-cloudfront) branch uses ACM for SSL certificate and Cloudfront for CDN. This configuration is more complex and works even if your S3 bucket name is already taken.

## Environment Values

```java
.
.
```

## GitHub

```java
git init
git add .
git remote remove origin
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:coding-to-music/aws-s3-terraform-cloudflare-dns-ssl-cdn.git
git push -u origin main
```

Install Terraform

Linux

HashiCorp officially maintains and signs packages for the following Linux distributions.

Ubuntu/Debian

Ensure that your system is up to date, and you have the gnupg, software-properties-common, and curl packages installed. You will use these packages to verify HashiCorp's GPG signature, and install HashiCorp's Debian package repository.

```java
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
```

Add the HashiCorp GPG key.

```java
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

Add the official HashiCorp Linux repository.

```java
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Update to add the repository, and install the Terraform CLI.

```java
sudo apt-get update && sudo apt-get install terraform
```

TIP: Now that you have added the HashiCorp repository, you can install Vault, Consul, Nomad and Packer with the same command.

## Verify the installation

Verify that the installation worked by opening a new terminal session and listing Terraform's available subcommands.

```java
terraform -help
```

Output

```java
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.
##...
```

Add any subcommand to terraform -help to learn more about what it does and available options.

```java
terraform -help plan
```

## Troubleshoot

If you get an error that terraform could not be found, your PATH environment variable was not set up properly. Please go back and ensure that your PATH variable contains the directory where Terraform was installed.

## Enable tab completion

If you use either Bash or Zsh, you can enable tab completion for Terraform commands. To enable autocomplete, first ensure that a config file exists for your chosen shell.

# AWS Provider

Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS. You must configure the provider with the proper credentials before you can use it.

Use the navigation to the left to read about the available resources.

To learn the basics of Terraform using this provider, follow the hands-on get started tutorials on HashiCorp's Learn platform. Interact with AWS services, including Lambda, RDS, and IAM by following the AWS services tutorials.

# Example Usage

Terraform 0.13 and later:

```java
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
```

Terraform 0.12 and earlier:

# Configure the AWS Provider

```java
# Configure the AWS Provider
provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
```

# Authentication and Configuration

https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication

Configuration for the AWS Provider can be derived from several sources, which are applied in the following order:

- Parameters in the provider configuration
- Environment variables
- Shared credentials files
- Shared configuration files
- Container credentials
- Instance profile credentials and region

This order matches the precedence used by the AWS CLI and the AWS SDKs.

The AWS Provider supports assuming an IAM role, either in the provider configuration block parameter assume_role or in a named profile.

The AWS Provider supports assuming an IAM role using web identity federation and OpenID Connect (OIDC). This can be configured either using environment variables or in a named profile.

When using a named profile, the AWS Provider also supports sourcing credentials from an external process.

## Provider Configuration

Warning:

Hard-coded credentials are not recommended in any Terraform configuration and risks secret leakage should this file ever be committed to a public version control system.

Credentials can be provided by adding an access_key, secret_key, and optionally token, to the aws provider block.

Usage:

```java
provider "aws" {
region = "us-west-2"
access_key = "my-access-key"
secret_key = "my-secret-key"
}
```

Other settings related to authorization can be configured, such as:

- profile
- shared_config_files
- shared_credentials_files

### Environment Variables

Credentials can be provided by using the AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and optionally AWS_SESSION_TOKEN environment variables. The region can be set using the AWS_REGION or AWS_DEFAULT_REGION environment variables.

For example:

```java
provider "aws" {}
```

```java
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_REGION="us-west-2"
terraform plan
```

Other environment variables related to authorization are:

```java
AWS_PROFILE
AWS_CONFIG_FILE
AWS_SHARED_CREDENTIALS_FILE
```

## Shared Configuration and Credentials Files

The AWS Provider can source credentials and other settings from the shared configuration and credentials files. By default, these files are located at $HOME/.aws/config and $HOME/.aws/credentials on Linux and macOS, and "%USERPROFILE%\.aws\config" and "%USERPROFILE%\.aws\credentials" on Windows.

If no named profile is specified, the default profile is used. Use the profile parameter or AWS_PROFILE environment variable to specify a named profile.

The locations of the shared configuration and credentials files can be configured using either the parameters shared_config_files and shared_credentials_files or the environment variables AWS_CONFIG_FILE and AWS_SHARED_CREDENTIALS_FILE.

For example:

```java
provider "aws" {
  shared_config_files      = ["/Users/tf_user/.aws/conf"]
  shared_credentials_files = ["/Users/tf_user/.aws/creds"]
  profile                  = "customprofile"
}
```

## Container Credentials

If you're running Terraform on CodeBuild or ECS and have configured an IAM Task Role, Terraform can use the container's Task Role. This support is based on the underlying AWS_CONTAINER_CREDENTIALS_RELATIVE_URI and AWS_CONTAINER_CREDENTIALS_FULL_URI environment variables being automatically set by those services or manually for advanced usage.

If you're running Terraform on EKS and have configured IAM Roles for Service Accounts (IRSA), Terraform can use the pod's role. This support is based on the underlying AWS_ROLE_ARN and AWS_WEB_IDENTITY_TOKEN_FILE environment variables being automatically set by Kubernetes or manually for advanced usage.

## Instance profile credentials and region

When the AWS Provider is running on an EC2 instance with an IAM Instance Profile set, the provider can source credentials from the EC2 Instance Metadata Service. Both IMDS v1 and IMDS v2 are supported.

A custom endpoint for the metadata service can be provided using the ec2_metadata_service_endpoint parameter or the AWS_EC2_METADATA_SERVICE_ENDPOINT environment variable.

## Assuming an IAM Role

If provided with a role ARN, the AWS Provider will attempt to assume this role using the supplied credentials.

Usage:

```java
provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::123456789012:role/ROLE_NAME"
    session_name = "SESSION_NAME"
    external_id  = "EXTERNAL_ID"
  }
}
```

Hands-on: Try the Use AssumeRole to Provision AWS Resources Across Accounts tutorial on HashiCorp Learn.

Assuming an IAM Role Using A Web Identity
If provided with a role ARN and a token from a web identity provider, the AWS Provider will attempt to assume this role using the supplied credentials.

Usage:

```java
provider "aws" {
  assume_role {
    role_arn                = "arn:aws:iam::123456789012:role/ROLE_NAME"
    session_name            = "SESSION_NAME"
    web_identity_token_file = "/Users/tf_user/secrets/web-identity-token"
  }
}
```

## Using an External Credentials Process

To use an external process to source credentials, the process must be configured in a named profile, including the default profile. The profile is configured in a shared configuration file.

For example:

```java
provider "aws" {
  profile = "customprofile"
}
```

```java
[profile customprofile]
credential_process = custom-process --username jdoe
```

# AWS Configuration Reference

https://registry.terraform.io/providers/hashicorp/aws/latest/docs#aws-configuration-reference

# Host a Static Website with S3 and Cloudflare

https://learn.hashicorp.com/tutorials/terraform/cloudflare-static-website

Reference this often? Create an account to bookmark tutorials.

18 MIN

PRODUCTS USED: terraform

This tutorial also appears in: Use Cases, Associate Tutorials and AWS Services.
Cloudflare is a popular service that offers a Content Delivery Network (CDN), Domain Name System (DNS), and protection against Distributed Denial of Service (DDoS) attacks. The Terraform Cloudflare provider allows you to deploy and manage your content distribution services with the same workflow you use to manage infrastructure. Using Terraform, you can provision DNS records and distribution rules for your web applications hosted in AWS and other cloud services, as well as the underlying infrastructure hosting your services.

In this tutorial, you will deploy a static website using the AWS and Cloudflare providers. The site will use AWS to provision an S3 bucket for object storage and Cloudflare for DNS, SSL and CDN. Then, you will add Cloudflare page rules to always redirect HTTP requests to HTTPS and to temporarily redirect users when they visit a specific page.

This diagram shows how users interact with CloudFlare and S3 bucket
https://mktg-content-api-hashicorp.vercel.app/api/assets?product=tutorials&version=main&asset=public%2Fimg%2Fterraform%2Fuse-cases%2Fcloudflare-static-website%2Fstatic-website-service-diagram.png

## Prerequisites

This tutorial assumes that you are familiar with the standard Terraform workflow. If you are new to Terraform, complete the Get Started tutorials first.

For this tutorial, you will need:

the Terraform CLI 0.14+ installed locally
an AWS account with credentials configured for Terraform
a Cloudflare account
a domain name with nameservers pointing to Cloudflare. Cloudflare needs to manage the domain's DNS records. You can either register a new domain or change an existing domain's nameserver to Cloudflare.
Note: Some of the infrastructure in this tutorial may not qualify for the AWS free tier. Destroy the infrastructure at the end of the guide to avoid unnecessary charges. We are not responsible for any charges that you incur.

## Create a scoped Cloudflare API token

There are several ways to authenticate the Terraform Cloudflare provider. In this tutorial, you will use a Cloudflare API token. This method grants granular control of token permissions, keeps the token out of version control, and allows you to revoke the token when necessary.

This tutorial requires a Cloudflare API token with "Edit" permissions for your zone's DNS and Page Rules. If you would like to use an existing Cloudflare API token that already has these permissions, you can go to the Clone the sample repository section.

To create this scoped Cloudflare API token, go to the "API Tokens" page for your Cloudflare account. You can access this page by clicking on the user icon on the top right corner > "My Profile" > "API Tokens".

https://mktg-content-api-hashicorp.vercel.app/api/assets?product=tutorials&version=main&asset=public%2Fimg%2Fterraform%2Fuse-cases%2Fcloudflare-static-website%2Fcloudflare-api-token-page.png

- Cloudflare API token page

Click on "Create Token", then the "Get Started" button near "Create Custom Token".

- Cloudflare create custom API token

On the "Create Custom Token" page, modify the following fields:

- In "Token name", enter "Terraform Token".
- In the "Permissions" section, grant the API token permission to edit your zone's DNS and Page Rules.
- Set the first row to "Zone", "DNS", and "Edit".
- Set the second row to "Zone", "Page Rules", and "Edit".
- In the "Zone Resources" section, select "Include", "Specific zone", and the domain you want to manage with Cloudflare.
- This page should look like the following, with your domain name instead of hashicorp.fun in the "Zone Resources" section.

- Cloudflare custom API token settings

Click "Continue to summary", then "Create Token" to create your scoped Cloudflare API token.

- Cloudflare custom API token confirmation page

Cloudflare only displays your API token once. Record it somewhere safe. You will use this token to authenticate the Cloudflare provider.

- Cloudflare custom API token

To avoid committing your API token to version control, set it as an environment variable.

Create an environment variable named CLOUDFLARE_API_TOKEN and set it to your Cloudflare API token. The Cloudflare provider will retrieve the API token from this environment variable.

```java
export CLOUDFLARE_API_TOKEN=Oo-bF...
```

Terraform will reference this environment variable to authenticate the Cloudflare Provider.

## Clone the sample repository

Clone the sample repository for this tutorial, which contains Terraform configuration for an S3 bucket and Cloudflare DNS records. The next section will walk you through each resource's configuration.

```java
git clone https://github.com/hashicorp/learn-terraform-cloudflare-static-website.git
```

Change into the repository directory.

```java
cd learn-terraform-cloudflare-static-website
```

## Review configuration

In this section, you will review the files and Terraform resource definitions in the sample repository. If you want to jump ahead to provisioning the resources, you can go to the Modify variables section and use this section as a reference later.

This tutorial offers two options for CDN:

- Cloudflare - The simplest option is to use Cloudflare's native SSL and CDN, included in its free tier. If you're using Cloudflare for DNS, Cloudflare's included SSL and CDN services allow you to set up a secure, cached static website with just an S3 bucket.

- Note: To use Cloudflare for SSL and CDN, you must use an S3 bucket matching your domain name. Bucket names must be globally unique.

- AWS's ACM and CloudFront - If you cannot create an S3 bucket matching your domain name, you can use ACM for SSL certificate management and CloudFront for CDN. Using both ACM and Cloudfront allows you to secure and cache traffic to your S3 bucket.

Select the tab for your preferred CDN option to review the configuration. If you are not sure which to pick, choose Cloudflare for ease of use.

Cloudflare

### ACM and CloudFront

You will find the following files in the sample repository:

- The main.tf file contains configuration to provision the S3 bucket and update your Cloudflare DNS records.
- The outputs.tf file defines outputs that display your S3 bucket name, bucket endpoint, and domain name.
- The providers.tf file contains the required_providers block that specifies which provider versions to use.
- The variables.tf file contains the input variable declarations, including the AWS region and website domain name.
- The terraform.tfvars.example file is an example variable definition file. Later in this tutorial, you will copy this file and modify it to include your AWS region and domain name.
- The /website directory contains Terramino, a demo website containing a HashiCorp-skinned Tetris game. This directory is located in this repository to simplify this tutorial. Ordinarily you should not store your static website in the same directory as your Terraform configuration.
- The terraform.lock.hcl file ensures that Terraform uses the same provider versions for each run.

Open the main.tf file in your editor to review the configuration.

- The AWS provider block authenticates to AWS, scoped to the region specified by the aws_region input variable. The Cloudflare provider authenticates using the scoped API token you created in the Prerequisites, accessed by an environment variable.

```java
provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {}
```

- The aws_s3_bucket.site, aws_s3_bucket_website_configuration.site, aws_s3_bucket_acl.site, and aws_s3_bucket_policy.site resources create a new S3 bucket and set it to be publicly readable. This policy allows anyone to view your static website.

```java
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
```

- Tip: In this tutorial, the S3 bucket policy is set to public-read. When creating an S3 bucket, create the appropriate policy for your bucket.

The aws_acm_certificate.cert and aws_acm_certificate_validation.cert resources respectively create an ACM certificate and validate it via DNS. CloudFront will use this as an SSL certificate. Notice that the certificate will apply to both your domain name and all its subdomains (\*.${var.site_domain}).

```java
resource "aws_acm_certificate" "cert" {
  domain_name               = var.site_domain
  subject_alternative_names = ["*.${var.site_domain}"]
  validation_method         = "DNS"

  tags = {
      Name = var.site_domain
  }
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.cert.arn
}
```

```java
data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}
```

The cloudflare_record.acm resource creates a CNAME DNS record to validate the ACM token. Note that the zone_id attribute references the cloudflare_zones.domain data source.

```java
resource "cloudflare_record" "acm" {
 zone_id = data.cloudflare_zones.domain.zones[0].id

 name  = aws_acm_certificate.cert.domain_validation_options.*.resource_record_name[0]
 type  = aws_acm_certificate.cert.domain_validation_options.*.resource_record_type[0]
 value = trimsuffix(aws_acm_certificate.cert.domain_validation_options.*.resource_record_value[0], ".")

 // Must be set to false. ACM validation false otherwise
 proxied = false
}
```

- The aws_cloudfront_distribution.dist resource creates a CloudFront distribution using your S3 bucket as the source. CloudFront is required for static site hosting with S3 if the domain for your bucket name is already taken. This configuration uses CloudFront's default values.

Notice that the alias attribute contains both the root and www domains. The viewer_certificate references the ACM certificate created by aws_acm_certificate.cert.

```java
resource "aws_cloudfront_distribution" "dist" {
  origin {
    domain_name = aws_s3_bucket.site.website_endpoint
    origin_id   = aws_s3_bucket.site.id
    ## ...
  }
  enabled             = true
  default_root_object = "index.html"

  aliases = [
    var.site_domain, "www.${var.site_domain}"
  ]

  ## ...

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
    ssl_support_method  = "sni-only"
  }
}
```

Finally, the cloudflare_record.site_cname and cloudflare_record.www resources create a Cloudflare CNAME record that points to the CloudFront distribution domain name.

Notice that both records have proxied set to true, which routes your site traffic through Cloudflare's proxy. This enables you to use CloudFlare page rules and DDoS protection features.

```java
resource "cloudflare_record" "site_cname" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.site_domain
  value   = aws_cloudfront_distribution.dist.domain_name
  type    = "CNAME"

  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = "www"
  value   = aws_cloudfront_distribution.dist.domain_name
  type    = "CNAME"

  ttl     = 1
  proxied = true
}
```

## Modify variables

Copy the contents of terraform.tfvars.example into a new file named terraform.tfvars.

```java
cp terraform.tfvars.example terraform.tfvars
```

Cloudflare

## ACM and CloudFront

Open terraform.tfvars and modify the values to match your site_domain. Your terraform.tfvars file will look similar to the following.

aws_region = "us-east-1"
site_domain = "hashicorp.fun"
Warning: Never commit sensitive values into source control. The .gitignore file found in this repo ignores the terraform.tfvars file. You should include a .gitignore file your Terraform repositories.

## Apply configuration

Initialize the Terraform configuration.

```java
terraform init
```

Output

```java
Initializing the backend...

Initializing provider plugins...

- Reusing previous version of hashicorp/random from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of cloudflare/cloudflare from the dependency lock file
- Installing hashicorp/aws v4.0.0...
- Installed hashicorp/aws v4.0.0 (signed by HashiCorp)
- Installing cloudflare/cloudflare v2.19.2...
- Installed cloudflare/cloudflare v2.19.2 (signed by a HashiCorp partner, key ID DE413CEC881C3283)
- Installing hashicorp/random v3.1.0...
- Installed hashicorp/random v3.1.0 (signed by HashiCorp)

Partner and community providers are signed by their developers.

If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Next, apply the configuration. Respond yes to the prompt to confirm.

Note: If you encounter a duplicate name error while creating the S3 bucket, destroy the provisioned resources, then select the "ACM and CloudFront tab" in the Review configuration section and follow the steps to re-provision.

```java
terraform apply
```

```java
## ...

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bucket_endpoint     = (known after apply)
  + domain_name         = "hashicorp.fun"
  + website_bucket_name = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

Once finished, Terraform returns the output parameters.

```java
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

bucket_endpoint = "hashicorp.fun.s3-website-us-east-1.amazonaws.com"
domain_name = "hashicorp.fun"
website_bucket_name = "hashicorp.fun"
```

## Add website files to S3 bucket

Now that you have set up the static website, upload the contents in the /website directory to your newly provisioned S3 bucket. Notice that the following command retrieves the bucket name from Terraform output.

```java
aws s3 cp website/ s3://$(terraform output -raw website_bucket_name)/ --recursive
upload: website/index.html to s3://turkey-hashicorp.fun/index.html
upload: website/background.png to s3://turkey-hashicorp.fun/background.png
```

Navigate to your website in your web browser. Your Terramino app should start automatically.

## Create Cloudflare page rules

Cloudflare has page rules that trigger actions whenever the page URL matches a specified URL pattern. You can use page rules to forward URLs, configure security/cache levels, and enforce HTTPS. Refer to Cloudflare's recommended page rules for more use cases.

First, add a page rule to the main.tf file to convert any http:// request to https:// using a 301 redirect.

```java
resource "cloudflare_page_rule" "https" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  target  = "*.${var.site_domain}/*"
  actions {
    always_use_https = true
  }
}
```

Next, add another page rule to the main.tf file to temporarily redirect <your-domain>/learn to the Terraform Learn page, where your-domain is your domain name.

```java
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
```

Apply these changes. Respond yes to the prompt to confirm.

```java
terraform apply

cloudflare_page_rule.redirect-to-learn: Creating...
cloudflare_page_rule.https: Creating...
cloudflare_page_rule.https: Creation complete after 1s [id=5681df98c982f0b5af15d5183756a487]
cloudflare_page_rule.redirect-to-learn: Creation complete after 1s [id=c6be51ba9e52cb21ce9c7c8fd584bd22]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

bucket_endpoint = "hashicorp.fun.s3-website-us-east-1.amazonaws.com"
domain_name = "hashicorp.fun"
website_bucket_name = "hashicorp.fun"
```

Verify these changes by visiting http://your-domain.com and https://your-domain.com/learn, where your-domain is your domain name. In the first instance, your browser should redirect you to the https:// version of the website. In the second instance, your browser should redirect you to the Terraform Learn page.

## Clean up resources

Congrats! You successfully used Terraform to set up a SSL secured static website with S3 and Cloudflare. You can choose to keep your website or destroy it.

## Keep website

You can repurpose this website to your needs by updating the contents of the S3 bucket

You may want to remove cloudflare_page_rule.redirect-to-learn, which temporarily redirects your-domain.com/learn to the Terraform Learn page. Remove the resource from main.tf.

```java
- resource "cloudflare_page_rule" "redirect-to-learn" {
-   zone_id = data.cloudflare_zones.domain.zones[0].id
-   target  = "${var.site_domain}/learn"
-   actions {
-     forwarding_url {
-       status_code = 302
-       url         = "https://learn.hashicorp.com/terraform"
-     }
-   }
- }
```

Apply these changes. Respond yes to the prompt to confirm.

```java
terraform apply
```

Output

```
Terraform will perform the following actions:

  # cloudflare_page_rule.https will be updated in-place
  ~ resource "cloudflare_page_rule" "https" {
        id       = "REDACTED"
      ~ priority = 2 -> 1
        # (3 unchanged attributes hidden)

        # (1 unchanged block hidden)
    }

  # cloudflare_page_rule.redirect-to-learn will be destroyed
  - resource "cloudflare_page_rule" "redirect-to-learn" {
      - id       = "REDACTED" -> null
      - priority = 1 -> null
      - status   = "active" -> null
      - target   = "hashicorp.fun/learn" -> null
      - zone_id  = "REDACTED" -> null

      - actions {
          - always_use_https    = false -> null
          - disable_apps        = false -> null
          - disable_performance = false -> null
          - disable_railgun     = false -> null
          - disable_security    = false -> null
          - edge_cache_ttl      = 0 -> null

          - forwarding_url {
              - status_code = 302 -> null
              - url         = "https://learn.hashicorp.com/terraform" -> null
            }
        }
    }

Plan: 0 to add, 1 to change, 1 to destroy.

## ...

cloudflare_page_rule.redirect-to-learn: Destroying... [id=c6be51ba9e52cb21ce9c7c8fd584bd22]
cloudflare_page_rule.https: Modifying... [id=5681df98c982f0b5af15d5183756a487]
cloudflare_page_rule.redirect-to-learn: Destruction complete after 0s
cloudflare_page_rule.https: Modifications complete after 1s [id=5681df98c982f0b5af15d5183756a487]

Apply complete! Resources: 0 added, 1 changed, 1 destroyed.

## ...
```

## Destroy website

First, delete the files in your bucket so that Terraform can destroy the bucket.

```java
aws s3 rm s3://$(terraform output -raw website_bucket_name)/ --recursive
```

Then, destroy the resources you created. Respond yes to the prompt to confirm.

```java
terraform destroy
```

Output

```
## ...

cloudflare_record.site_cname: Destroying... [id=59a310eb88cc56078a88e7ae4b4c52a7]
cloudflare_record.www: Destroying... [id=ac97a4bea02575615d41f1ef0c772f11]
cloudflare_page_rule.redirect-to-learn: Destroying... [id=c6be51ba9e52cb21ce9c7c8fd584bd22]
cloudflare_page_rule.https: Destroying... [id=5681df98c982f0b5af15d5183756a487]
cloudflare_record.www: Destruction complete after 1s
cloudflare_record.site_cname: Destruction complete after 1s
cloudflare_page_rule.https: Destruction complete after 1s
cloudflare_page_rule.redirect-to-learn: Destruction complete after 1s
aws_s3_bucket_policy.public_read: Destroying... [id=sympo.io]
aws_s3_bucket.www: Destroying... [id=www.sympo.io]
aws_s3_bucket_policy.public_read: Destruction complete after 0s
aws_s3_bucket.site: Destroying... [id=sympo.io]
aws_s3_bucket.www: Destruction complete after 0s
aws_s3_bucket.site: Destruction complete after 1s

Destroy complete! Resources: 7 destroyed.
```

## Next steps

To learn more about managing the resources used in this tutorial with Terraform, visit the following documentation:

- The Terraform Cloudflare Provider Registry page contains documentation for Cloudflare resources, including arguments, attributes, and example configuration.
- The Create IAM policies tutorial guides you through creating differently scoped IAM policies for your AWS resources.
- The Cloudflare-managed Terraform documentation contains tutorials for topics such as using the Cloudflare provider to rate limit and load balance requests, importing existing Cloudflare resources, and customizing the provider.
- This AWS Knowledge Center post walks you through updating your CloudFront cache to reflect the latest changes to your S3 bucket.
