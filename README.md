# Terraform-AWS-EBS-CSI-Driver
This repository contains Terraform code for deploying an AWS EBS CSI Driver.

## Getting Started

To get started, follow these instructions:

### Prerequisites

- Terraform installed on your local machine. You can download it from [here](https://www.terraform.io/downloads.html).
- An AWS account with appropriate permissions to create resources.
- Set the following Terraform variables as environment variables on your machine:

    ```bash
    export TF_VAR_cluster_name="cluster_name"
    ```

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/mohamedezz96/Terraform-AWS-EFS-CSI-Driver.git
    ```
2. Change into the project directory:

    ```bash
    cd Terraform-AWS-EFS-CSI-Driver
    ```
### Configuration
#### aws_efs_csi_driver.tf
- `aws_efs_csi_driver_version`: The version of the EBS CSI Driver Helm Chart to use.
- `values_file`: The path to the YAML file containing additional configuration values for the AWS EBS CSI Driver.

#### values/aws_efs_csi_driver.yaml
```yaml
storageClasses: 
  - name: ebs-sc
    # annotation metadata
    annotations:
      storageclass.kubernetes.io/is-default-class: "true"
    # label metadata
    labels:
      sc: ebs
    # defaults to WaitForFirstConsumer
    volumeBindingMode: WaitForFirstConsumer
    provisioner: ebs.csi.aws.com
    # defaults to Delete
    reclaimPolicy: Retain
    parameters:
      encrypted: "true"
```
### Deployment

Once configured, you can deploy the ALB controller by running:

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

### Usage
To test your driver follow this link: https://docs.aws.amazon.com/eks/latest/userguide/ebs-sample-app.html

