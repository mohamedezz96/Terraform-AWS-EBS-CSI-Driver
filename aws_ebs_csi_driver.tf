module "aws_ebs_csi_driver" {
  source                              = "github.com/mohamedezz96/Terraform-Modules/EKS-Tools/AWS-EBS-CSI-Driver"
  aws_ebs_csi_driver_version          = "2.29.1"
  eks_issuer                          = data.aws_eks_cluster.eks_data.identity[0].oidc[0].issuer
  values_file                         = "./aws_ebs_csi_driver.yaml"
}
