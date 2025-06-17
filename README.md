source codes:
https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

https://blog.searce.com/using-helm-with-terraform-to-deploy-aws-load-balancer-controller-on-aws-eks-84ea102352f2

Verify EKS Cluster is Ready:

sh
aws eks --region us-east-1 describe-cluster --name <your-cluster-name> | grep status
Should show "status": "ACTIVE"

Update kubeconfig:

sh
aws eks --region us-east-1 update-kubeconfig --name <your-cluster-name>
Verify connection:

sh
kubectl get nodes
Then Deploy ALB Controller:

After fixing both issues, run terraform apply in the Helm ALB repo