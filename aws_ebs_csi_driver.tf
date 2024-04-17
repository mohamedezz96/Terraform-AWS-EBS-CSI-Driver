module "aws_ebs_csi_driver" {
  source                              = "github.com/mohamedezz96/Terraform-Modules/EKS-Tools/AWS-EBS-CSI-Driver"
  aws_efs_csi_driver_version          = "2.29.1"
  eks_issuer                          = data.aws_eks_cluster.eks_data.identity[0].oidc[0].issuer
  aws_efs_controller_sa_name          = "aws-ebs-controller-sa"
  aws_efs_node_sa_name                = "aws-ebs-node-sa"
  values_file                         = "./values/aws_ebs_csi_driver.yaml"
}
