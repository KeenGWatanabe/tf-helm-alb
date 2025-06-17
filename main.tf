terraform {
  backend "s3" {
    bucket         = "custom.tfstate-backend.com"  # Must match the bucket name above
    key            = "custom-helm/terraform.tfstate"        # State file path
    region         = "us-east-1"                # Same as provider
    dynamodb_table = "custom-terraform-state-locks"    # If using DynamoDB
    # use_lockfile   = true                       # replaces dynamodb_table
    encrypt        = true                       # Use encryption
    acl            = "bucket-owner-full-control" # Optional, for cross-account access
  }
}


resource "helm_release" "alb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.7.1" # Chart version

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
  set {
      name  = "serviceAccount.create"
      value = "false"
    }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "region"
    value = "us-east-1" # Your region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id # Ensure this variable is defined in your variables.tf
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.node_security_group_id # Or your custom IRSA role ARN
  }
  
  # depends_on = [
  #   module.eks,
  #   module.eks.eks_managed_node_groups,
    
  # ]
  
}



# Note: Ensure the AWS Load Balancer Controller version matches your EKS version
# eks 1.29 (ln6) = alb_ctrl 1.7.x (ln54)
# eks 1.32 (ln6) = alb_ctrl 1.8.x (ln54)