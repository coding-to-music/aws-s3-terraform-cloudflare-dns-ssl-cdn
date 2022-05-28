# aws-s3-terraform-cloudflare-dns-ssl-cdn

# 🚀 Javascript full-stack 🚀

https://github.com/coding-to-music/aws-s3-terraform-cloudflare-dns-ssl-cdn

From https://github.com/coding-to-music/learn-terraform-cloudflare-static-website

https://learn.hashicorp.com/tutorials/terraform/cloudflare-static-website

## Learn Terraform Cloudflare Static Website

Learn how to use Terraform to set up a static website using AWS bucket for object storage and Cloudflare for DNS, SSL and CDN. Follow along with [this tutorial](https://learn.hashicorp.com/tutorials/terraform/cloudflare-static-website) on HashiCorp Learn.

The [`acm-cloudfront`](https://github.com/hashicorp/learn-terraform-cloudflare-static-website/tree/acm-cloudfront) branch uses ACM for SSL certificate and Cloudfront for CDN. This configuration is more complex and works even if your S3 bucket name is already taken.

## Environment Values

```java

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
