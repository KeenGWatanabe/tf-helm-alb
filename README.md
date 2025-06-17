source codes:
https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

https://blog.searce.com/using-helm-with-terraform-to-deploy-aws-load-balancer-controller-on-aws-eks-84ea102352f2

# steps
> k8-eks/module: Creates the actual EKS cluster infrastructure
> tf-helm-alb: Deploys the AWS Load Balancer Controller onto an existing cluster

`You were getting the 403 error because you were trying to access an EKS cluster that might not be fully provisioned or configured yet.`

# Verify EKS Cluster is Ready:

sh
aws eks --region us-east-1 describe-cluster --name custom-eks-cluster | grep status
Should show "status": "ACTIVE"

Update kubeconfig:

sh
aws eks --region us-east-1 update-kubeconfig --name custom-eks-cluster
Verify connection:

sh
kubectl get nodes
# Then Deploy ALB Controller:

After fixing both issues, run terraform apply in the Helm ALB repo