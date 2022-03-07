
# Create an K8s cluster w Nginx-ingress & Argo-cd using kops and Terraform

In this repo I created a simple k8s cluster on ec2 machines using kops and Terraform

## Authors

- [@Amitk3293 ](https://github.com/Amitk3293)


## Prerequisites

 - Terraform >= 0.15, < 2.0.0
 - AWS account 
 - A configured AWS CLI w the relevant IAM permissions ("TF-API-admin" in that case)
 - IAM user w the relevant permissions
 - kubectl
 - kops v1.22.4
 - S3 buckets for kops and as an option for TF state
 - valid registered domain name
 - public and private ssh keys (which will be your access to the ec2 machines)


## Deployment

Clone the repo

```bash
  git clone https://github.com/Amitk3293/k8s-cluster-on-ec2-w-kops-terraform-argoCD-nginxIngress.git
```

Run kops to create your Terraform files, kops will create your TF files in kops2terraform folder
```bash
kops create cluster \                                                                     
--cloud=aws \
--name=k8s-cluster.amitk.link \
--state=s3://tf-backend-tikal-task \
--authorization RBAC \
--zones=eu-central-1a \
--node-count=2 \
--node-size=t3.small \
--master-size=t3.small \
--master-count=1 \
--out=kops2terraform \ #TF files path
--target=terraform \ #use kops to create TF files to deploy the cluster
--ssh-public-key=./ssh2task.pub \  #public key for ec2 access
--dns-zone=amitk.link #domain name
```

#### *Edit backend.tf w your remote backend to keep your state file sensitive data being "safe" or delete to use a local backend



## ### IMPORTANT ### - 
For being able to create ELB for nginx-ingress -  
edit kops2terraform/data/aws_iam_role_policy_masters.k8s-cluster.amitk.link_policy and add the following permissions -
```bash
    {
          "Effect": "Allow",
          "Action": "iam:CreateServiceLinkedRole",
          "Resource": "arn:aws:iam::*:role/aws-service-role/*"
         },
         {
           "Effect": "Allow",
           "Action": [
             "ec2:DescribeAccountAttributes",
             "ec2:DescribeInternetGateways"
            ],
           "Resource": "*"
    },
```

### go to kops2terraform folder and run terraform 

Initiallize Terraform, plan and apply
```bash
terraform init
terraform plan
terraform apply
```
When TF process ends your kubeconfig will be edited automatically.
To test it,run
```bash
k get nodes
```
## ### IMPORTANT ### - 
deploy the cluster using kops2terraform may take 30 minutes+
we have to wait for the k8s DNS controller to update the domain dns records to be able to work on the k8s cluster without any issues.


## using Terraform-helm provider


### For deploy nginx-ingress using Helm_provider go to /helm-tf/modules/nginx-ingress

**Edit backend.tf w your remote backend to keep your state file "safe" or delete to use a local backend

Initiallize Terraform, plan and apply
```bash
terraform init
terraform plan
terraform apply
```

When TF process ends successfully -  Get the ingress service to have your ingress external IP 

```bash
k get svc -n ingress
NAME                                 TYPE           CLUSTER-IP       EXTERNAL-IP                                                                 PORT(S)                      AGE
ingress-nginx-controller             LoadBalancer   172.20.x.x   zyhdkb6bunrzwaadam4pfzebwz2s99dn-404761402.eu-central-1.elb.amazonaws.com   80:31114/TCP,443:31853/TCP   54s
ingress-nginx-controller-admission   ClusterIP      172.20.x.x    <none>                                                                      443/TCP                      54s
```

### For deploy argo-cf using Helm_provider go to /helm-tf/modules/argo-cd
Edit argo-values.yaml hosts to argo-cd.<your-domain>
```bash
server:
  extraArgs:
    - --insecure
  ingress:
    enabled: true
    hosts:
      - argo-cd.amitk.link
    ingressClassName: nginx
    paths:
      - /
```
**Edit DNS Cname record with a record name- argo-cd.<your-domain> and a value of the ingress external IP we check before.


Initiallize Terraform, plan and apply
```bash
terraform init
terraform plan
terraform apply
```


browse to argo-cd.<your-domain>
```bash
amitk@pop-os ~ curl -I argo-cd.amitk.link
HTTP/1.1 200 OK
Date: Sun, 06 Mar 2022 19:33:25 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 843
Connection: keep-alive
Accept-Ranges: bytes
X-Frame-Options: sameorigin
X-Xss-Protection: 1
```


### To sync your application w argo-cd run 
```bash
helm get manifest ingress-nginx -n ingress
helm get manifest argo-cd -n argo-cd
```
and add the helm manigest output to a file named ingress.yaml or argo-cd.yaml outputs into application-charts/templates/<app-folder>/ folder in the repo. 
Then logg in to ArgoCD and sync the git repo and application-charts/templates/app-folder path.
