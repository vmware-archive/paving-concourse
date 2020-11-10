# Pave GCP for Concourse

## Description

This repository is derived from https://github.com/pivotal/paving

It's designed to create the infrastructure necessary to deploy Concourse for platform automation.

- Only the GCP IaaS is concerned.
- terraform resources needed for Concourse have been added
- resources not necessary for Concourse have been removed

## Assumptions

- This repository was cloned to your workspace
- terraform v0.12 is installed
- A service account key with permissions necessary to create resources in your gcp project

## Steps

1. In GCP create a DNS zone for your subdomain

1. Make a copy of `terraform.tfvars.example`; name the copy `terraform.tfvars`

1. Edit `terraform.tfvars` and fill in these fields

    - an environment name of your choosing
    - the target GCP project id
    - the name of the hosted zone created above
    - and a JSON-encoded GCP service account key

1. Initialize terraform

    ```bash
    terraform init
    ```

1. Run `terraform refresh` to update the state with what currently exists in GCP

    ```bash
    terraform refresh -var-file terraform.tfvars
    ```

1. Run `terraform plan` to see what changes will be made in the infrastructure

    ```bash
    terraform plan -out terraform.tfplan -var-file terraform.tfvars
    ```

1. Run `terraform apply` to create the resources in the IaaS

    ```bash
    terraform apply -parallelism=5 terraform.tfplan
    ```
