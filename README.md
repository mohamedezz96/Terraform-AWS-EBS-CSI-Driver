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
    git clone https://github.com/mohamedezz96/Terraform-AWS-EBS-CSI-Driver.git
    ```
2. Change into the project directory:

    ```bash
    cd Terraform-AWS-EBS-CSI-Driver
    ```
    ### Configuration
    #### aws_ebs_csi_driver.tf
    - `aws_ebs_csi_driver_version`: The version of the EBS CSI Driver Helm Chart to use.
    - `values_file`: The path to the YAML file containing additional configuration values for the AWS EBS CSI Driver(aws_ebs_csi_driver.yaml).
    
        ##### aws_ebs_csi_driver.yaml
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
              type: gp3
              encrypted: "true"
        ```
### Deployment

Once configured, you can deploy the AWS EBS CSI Driver by running:

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

### Usage
To test your driver apply the following steps:
#### pvc.yaml
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ebs-claim
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: ebs-sc
  resources:
    requests:
      storage: 4Gi
```
1. Apply the pvc.yaml file on your cluster:
```bash
kubectl apply -f pvc.yaml
```
#### pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app
spec:
  containers:
  - name: app
    image: centos
    command: ["/bin/sh"]
    args: ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
    volumeMounts:
    - name: persistent-storage
      mountPath: /data
  volumes:
  - name: persistent-storage
    persistentVolumeClaim:
      claimName: ebs-claim
```
2. Apply the pod.yaml file on your cluster:
```bash
kubectl apply -f pod.yaml
```
3. Check that there is a pv created on your cluster:
```bash
kubectl get pv
```
4. Check the status of your pvc:
```bash
kubectl get pvc
```
5. Check the status of your application:
```bash
kubectl get pods -o wide
```
