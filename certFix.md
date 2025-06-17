The `SEC_E_UNTRUSTED_ROOT` error indicates your Windows system doesn't trust the EKS API server's certificate. This is actually a **good sign** - it means:

1. **You're reaching the EKS endpoint successfully** (network connectivity is working)
2. **Only certificate verification is failing** (which we can handle)

### Quick Fixes (Choose One)

#### Option 1: Skip Certificate Verification (for testing only)
```bash
curl -vk https://20DABBE6...eks.amazonaws.com  # -k ignores SSL errors
```

#### Option 2: Proper Certificate Trust (Recommended)
1. Export the EKS CA certificate:
   ```bash
   aws eks describe-cluster --name custom-eks-cluster --query "cluster.certificateAuthority.data" --output text | base64 -d > eks-ca.crt
   ```
2. Trust the certificate in Windows:
   ```powershell
   Import-Certificate -FilePath .\eks-ca.crt -CertStoreLocation Cert:\LocalMachine\Root
   ```

### For Terraform/Kubectl Operations

#### 1. Update kubeconfig with proper CA
```bash
aws eks update-kubeconfig --name custom-eks-cluster --region us-east-1 --certificate-authority eks-ca.crt
```

#### 2. Verify kubectl works
```bash
kubectl get nodes
```

#### 3. Update Terraform Provider
```hcl
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = filebase64("eks-ca.crt")  # Use the saved cert
  
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
  }
}
```

### Why This Happens
- Windows uses its own certificate store (Schannel)
- EKS uses certificates from Amazon Root CA
- Corporate environments often strip CA certificates

### Permanent Solution
1. Install the **Amazon Root CA certificates**:
   Download from [Amazon Trust Services](https://www.amazontrust.com/repository/)
2. Install both:
   - Amazon Root CA 1
   - Amazon Root CA 3

After applying these fixes, both `curl` and Terraform operations should work correctly. The cluster is reachable - we just needed to properly handle the certificate trust.