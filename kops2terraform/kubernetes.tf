locals {
  cluster_name                 = "k8s-cluster.amitk.link"
  master_autoscaling_group_ids = [aws_autoscaling_group.master-eu-central-1a-masters-k8s-cluster-amitk-link.id]
  master_security_group_ids    = [aws_security_group.masters-k8s-cluster-amitk-link.id]
  masters_role_arn             = aws_iam_role.masters-k8s-cluster-amitk-link.arn
  masters_role_name            = aws_iam_role.masters-k8s-cluster-amitk-link.name
  node_autoscaling_group_ids   = [aws_autoscaling_group.nodes-eu-central-1a-k8s-cluster-amitk-link.id]
  node_security_group_ids      = [aws_security_group.nodes-k8s-cluster-amitk-link.id]
  node_subnet_ids              = [aws_subnet.eu-central-1a-k8s-cluster-amitk-link.id]
  nodes_role_arn               = aws_iam_role.nodes-k8s-cluster-amitk-link.arn
  nodes_role_name              = aws_iam_role.nodes-k8s-cluster-amitk-link.name
  region                       = "eu-central-1"
  route_table_public_id        = aws_route_table.k8s-cluster-amitk-link.id
  subnet_eu-central-1a_id      = aws_subnet.eu-central-1a-k8s-cluster-amitk-link.id
  vpc_cidr_block               = aws_vpc.k8s-cluster-amitk-link.cidr_block
  vpc_id                       = aws_vpc.k8s-cluster-amitk-link.id
}

output "cluster_name" {
  value = "k8s-cluster.amitk.link"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.master-eu-central-1a-masters-k8s-cluster-amitk-link.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-k8s-cluster-amitk-link.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-k8s-cluster-amitk-link.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-k8s-cluster-amitk-link.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-eu-central-1a-k8s-cluster-amitk-link.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-k8s-cluster-amitk-link.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.eu-central-1a-k8s-cluster-amitk-link.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-k8s-cluster-amitk-link.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-k8s-cluster-amitk-link.name
}

output "region" {
  value = "eu-central-1"
}

output "route_table_public_id" {
  value = aws_route_table.k8s-cluster-amitk-link.id
}

output "subnet_eu-central-1a_id" {
  value = aws_subnet.eu-central-1a-k8s-cluster-amitk-link.id
}

output "vpc_cidr_block" {
  value = aws_vpc.k8s-cluster-amitk-link.cidr_block
}

output "vpc_id" {
  value = aws_vpc.k8s-cluster-amitk-link.id
}

provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  alias  = "files"
  region = "eu-central-1"
}

resource "aws_autoscaling_group" "master-eu-central-1a-masters-k8s-cluster-amitk-link" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.master-eu-central-1a-masters-k8s-cluster-amitk-link.id
    version = aws_launch_template.master-eu-central-1a-masters-k8s-cluster-amitk-link.latest_version
  }
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "master-eu-central-1a.masters.k8s-cluster.amitk.link"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "k8s-cluster.amitk.link"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "master-eu-central-1a.masters.k8s-cluster.amitk.link"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "master-eu-central-1a"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"
    propagate_at_launch = true
    value               = "master"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/master"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/master"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "master-eu-central-1a"
  }
  tag {
    key                 = "kubernetes.io/cluster/k8s-cluster.amitk.link"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.eu-central-1a-k8s-cluster-amitk-link.id]
}

resource "aws_autoscaling_group" "nodes-eu-central-1a-k8s-cluster-amitk-link" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.nodes-eu-central-1a-k8s-cluster-amitk-link.id
    version = aws_launch_template.nodes-eu-central-1a-k8s-cluster-amitk-link.latest_version
  }
  max_size              = 2
  metrics_granularity   = "1Minute"
  min_size              = 2
  name                  = "nodes-eu-central-1a.k8s-cluster.amitk.link"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "k8s-cluster.amitk.link"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes-eu-central-1a.k8s-cluster.amitk.link"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes-eu-central-1a"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"
    propagate_at_launch = true
    value               = "node"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/node"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes-eu-central-1a"
  }
  tag {
    key                 = "kubernetes.io/cluster/k8s-cluster.amitk.link"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.eu-central-1a-k8s-cluster-amitk-link.id]
}

resource "aws_ebs_volume" "a-etcd-events-k8s-cluster-amitk-link" {
  availability_zone = "eu-central-1a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "a.etcd-events.k8s-cluster.amitk.link"
    "k8s.io/etcd/events"                           = "a/a"
    "k8s.io/role/master"                           = "1"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_ebs_volume" "a-etcd-main-k8s-cluster-amitk-link" {
  availability_zone = "eu-central-1a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "a.etcd-main.k8s-cluster.amitk.link"
    "k8s.io/etcd/main"                             = "a/a"
    "k8s.io/role/master"                           = "1"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_iam_instance_profile" "masters-k8s-cluster-amitk-link" {
  name = "masters.k8s-cluster.amitk.link"
  role = aws_iam_role.masters-k8s-cluster-amitk-link.name
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "masters.k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
}

resource "aws_iam_instance_profile" "nodes-k8s-cluster-amitk-link" {
  name = "nodes.k8s-cluster.amitk.link"
  role = aws_iam_role.nodes-k8s-cluster-amitk-link.name
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "nodes.k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
}

resource "aws_iam_role" "masters-k8s-cluster-amitk-link" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_masters.k8s-cluster.amitk.link_policy")
  name               = "masters.k8s-cluster.amitk.link"
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "masters.k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
}

resource "aws_iam_role" "nodes-k8s-cluster-amitk-link" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_nodes.k8s-cluster.amitk.link_policy")
  name               = "nodes.k8s-cluster.amitk.link"
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "nodes.k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
}

resource "aws_iam_role_policy" "masters-k8s-cluster-amitk-link" {
  name   = "masters.k8s-cluster.amitk.link"
  policy = file("${path.module}/data/aws_iam_role_policy_masters.k8s-cluster.amitk.link_policy")
  role   = aws_iam_role.masters-k8s-cluster-amitk-link.name
}

resource "aws_iam_role_policy" "nodes-k8s-cluster-amitk-link" {
  name   = "nodes.k8s-cluster.amitk.link"
  policy = file("${path.module}/data/aws_iam_role_policy_nodes.k8s-cluster.amitk.link_policy")
  role   = aws_iam_role.nodes-k8s-cluster-amitk-link.name
}

resource "aws_internet_gateway" "k8s-cluster-amitk-link" {
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-amitk-link.id
}

resource "aws_key_pair" "kubernetes-k8s-cluster-amitk-link-f08589b16de3769d41fd26fc9b20c778" {
  key_name   = "kubernetes.k8s-cluster.amitk.link-f0:85:89:b1:6d:e3:76:9d:41:fd:26:fc:9b:20:c7:78"
  public_key = file("${path.module}/data/aws_key_pair_kubernetes.k8s-cluster.amitk.link-f08589b16de3769d41fd26fc9b20c778_public_key")
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
}

resource "aws_launch_template" "master-eu-central-1a-masters-k8s-cluster-amitk-link" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 64
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.masters-k8s-cluster-amitk-link.id
  }
  image_id      = "ami-05b308c240ae70bb6"
  instance_type = "t3.small"
  key_name      = aws_key_pair.kubernetes-k8s-cluster-amitk-link-f08589b16de3769d41fd26fc9b20c778.id
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 3
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "master-eu-central-1a.masters.k8s-cluster.amitk.link"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.masters-k8s-cluster-amitk-link.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                                                     = "k8s-cluster.amitk.link"
      "Name"                                                                                                  = "master-eu-central-1a.masters.k8s-cluster.amitk.link"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"                               = "master-eu-central-1a"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"                                      = "master"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/master"                          = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "master-eu-central-1a"
      "kubernetes.io/cluster/k8s-cluster.amitk.link"                                                          = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                                                     = "k8s-cluster.amitk.link"
      "Name"                                                                                                  = "master-eu-central-1a.masters.k8s-cluster.amitk.link"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"                               = "master-eu-central-1a"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"                                      = "master"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/master"                          = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "master-eu-central-1a"
      "kubernetes.io/cluster/k8s-cluster.amitk.link"                                                          = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                                                     = "k8s-cluster.amitk.link"
    "Name"                                                                                                  = "master-eu-central-1a.masters.k8s-cluster.amitk.link"
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"                               = "master-eu-central-1a"
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
    "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"                                      = "master"
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/master"                          = ""
    "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
    "k8s.io/role/master"                                                                                    = "1"
    "kops.k8s.io/instancegroup"                                                                             = "master-eu-central-1a"
    "kubernetes.io/cluster/k8s-cluster.amitk.link"                                                          = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_master-eu-central-1a.masters.k8s-cluster.amitk.link_user_data")
}

resource "aws_launch_template" "nodes-eu-central-1a-k8s-cluster-amitk-link" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 128
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.nodes-k8s-cluster-amitk-link.id
  }
  image_id      = "ami-05b308c240ae70bb6"
  instance_type = "t3.small"
  key_name      = aws_key_pair.kubernetes-k8s-cluster-amitk-link-f08589b16de3769d41fd26fc9b20c778.id
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "nodes-eu-central-1a.k8s-cluster.amitk.link"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.nodes-k8s-cluster-amitk-link.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "k8s-cluster.amitk.link"
      "Name"                                                                       = "nodes-eu-central-1a.k8s-cluster.amitk.link"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"    = "nodes-eu-central-1a"
      "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"           = "node"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-eu-central-1a"
      "kubernetes.io/cluster/k8s-cluster.amitk.link"                               = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "k8s-cluster.amitk.link"
      "Name"                                                                       = "nodes-eu-central-1a.k8s-cluster.amitk.link"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"    = "nodes-eu-central-1a"
      "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"           = "node"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-eu-central-1a"
      "kubernetes.io/cluster/k8s-cluster.amitk.link"                               = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "k8s-cluster.amitk.link"
    "Name"                                                                       = "nodes-eu-central-1a.k8s-cluster.amitk.link"
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"    = "nodes-eu-central-1a"
    "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"           = "node"
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/node"                                                           = "1"
    "kops.k8s.io/instancegroup"                                                  = "nodes-eu-central-1a"
    "kubernetes.io/cluster/k8s-cluster.amitk.link"                               = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_nodes-eu-central-1a.k8s-cluster.amitk.link_user_data")
}

resource "aws_route" "route-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.k8s-cluster-amitk-link.id
  route_table_id         = aws_route_table.k8s-cluster-amitk-link.id
}

resource "aws_route" "route-__--0" {
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.k8s-cluster-amitk-link.id
  route_table_id              = aws_route_table.k8s-cluster-amitk-link.id
}

resource "aws_route_table" "k8s-cluster-amitk-link" {
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
    "kubernetes.io/kops/role"                      = "public"
  }
  vpc_id = aws_vpc.k8s-cluster-amitk-link.id
}

resource "aws_route_table_association" "eu-central-1a-k8s-cluster-amitk-link" {
  route_table_id = aws_route_table.k8s-cluster-amitk-link.id
  subnet_id      = aws_subnet.eu-central-1a-k8s-cluster-amitk-link.id
}

resource "aws_s3_bucket_object" "cluster-completed-spec" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_cluster-completed.spec_content")
  key      = "k8s-cluster.amitk.link/cluster-completed.spec"
  provider = aws.files
}

resource "aws_s3_bucket_object" "etcd-cluster-spec-events" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_etcd-cluster-spec-events_content")
  key      = "k8s-cluster.amitk.link/backups/etcd/events/control/etcd-cluster-spec"
  provider = aws.files
}

resource "aws_s3_bucket_object" "etcd-cluster-spec-main" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_etcd-cluster-spec-main_content")
  key      = "k8s-cluster.amitk.link/backups/etcd/main/control/etcd-cluster-spec"
  provider = aws.files
}

resource "aws_s3_bucket_object" "k8s-cluster-amitk-link-addons-aws-ebs-csi-driver-addons-k8s-io-k8s-1-17" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_k8s-cluster.amitk.link-addons-aws-ebs-csi-driver.addons.k8s.io-k8s-1.17_content")
  key      = "k8s-cluster.amitk.link/addons/aws-ebs-csi-driver.addons.k8s.io/k8s-1.17.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "k8s-cluster-amitk-link-addons-bootstrap" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_k8s-cluster.amitk.link-addons-bootstrap_content")
  key      = "k8s-cluster.amitk.link/addons/bootstrap-channel.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "k8s-cluster-amitk-link-addons-core-addons-k8s-io" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_k8s-cluster.amitk.link-addons-core.addons.k8s.io_content")
  key      = "k8s-cluster.amitk.link/addons/core.addons.k8s.io/v1.4.0.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "k8s-cluster-amitk-link-addons-coredns-addons-k8s-io-k8s-1-12" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_k8s-cluster.amitk.link-addons-coredns.addons.k8s.io-k8s-1.12_content")
  key      = "k8s-cluster.amitk.link/addons/coredns.addons.k8s.io/k8s-1.12.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "k8s-cluster-amitk-link-addons-dns-controller-addons-k8s-io-k8s-1-12" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_k8s-cluster.amitk.link-addons-dns-controller.addons.k8s.io-k8s-1.12_content")
  key      = "k8s-cluster.amitk.link/addons/dns-controller.addons.k8s.io/k8s-1.12.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "k8s-cluster-amitk-link-addons-kops-controller-addons-k8s-io-k8s-1-16" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_k8s-cluster.amitk.link-addons-kops-controller.addons.k8s.io-k8s-1.16_content")
  key      = "k8s-cluster.amitk.link/addons/kops-controller.addons.k8s.io/k8s-1.16.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "k8s-cluster-amitk-link-addons-kubelet-api-rbac-addons-k8s-io-k8s-1-9" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_k8s-cluster.amitk.link-addons-kubelet-api.rbac.addons.k8s.io-k8s-1.9_content")
  key      = "k8s-cluster.amitk.link/addons/kubelet-api.rbac.addons.k8s.io/k8s-1.9.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "k8s-cluster-amitk-link-addons-limit-range-addons-k8s-io" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_k8s-cluster.amitk.link-addons-limit-range.addons.k8s.io_content")
  key      = "k8s-cluster.amitk.link/addons/limit-range.addons.k8s.io/v1.5.0.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "k8s-cluster-amitk-link-addons-storage-aws-addons-k8s-io-v1-15-0" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_k8s-cluster.amitk.link-addons-storage-aws.addons.k8s.io-v1.15.0_content")
  key      = "k8s-cluster.amitk.link/addons/storage-aws.addons.k8s.io/v1.15.0.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "kops-version-txt" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_kops-version.txt_content")
  key      = "k8s-cluster.amitk.link/kops-version.txt"
  provider = aws.files
}

resource "aws_s3_bucket_object" "manifests-etcdmanager-events" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_manifests-etcdmanager-events_content")
  key      = "k8s-cluster.amitk.link/manifests/etcd/events.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "manifests-etcdmanager-main" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_manifests-etcdmanager-main_content")
  key      = "k8s-cluster.amitk.link/manifests/etcd/main.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "manifests-static-kube-apiserver-healthcheck" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_manifests-static-kube-apiserver-healthcheck_content")
  key      = "k8s-cluster.amitk.link/manifests/static/kube-apiserver-healthcheck.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "nodeupconfig-master-eu-central-1a" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_nodeupconfig-master-eu-central-1a_content")
  key      = "k8s-cluster.amitk.link/igconfig/master/master-eu-central-1a/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_s3_bucket_object" "nodeupconfig-nodes-eu-central-1a" {
  bucket   = "tf-backend-tikal-task"
  content  = file("${path.module}/data/aws_s3_bucket_object_nodeupconfig-nodes-eu-central-1a_content")
  key      = "k8s-cluster.amitk.link/igconfig/node/nodes-eu-central-1a/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_security_group" "masters-k8s-cluster-amitk-link" {
  description = "Security group for masters"
  name        = "masters.k8s-cluster.amitk.link"
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "masters.k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-amitk-link.id
}

resource "aws_security_group" "nodes-k8s-cluster-amitk-link" {
  description = "Security group for nodes"
  name        = "nodes.k8s-cluster.amitk.link"
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "nodes.k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-amitk-link.id
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-22to22-masters-k8s-cluster-amitk-link" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-k8s-cluster-amitk-link.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-22to22-nodes-k8s-cluster-amitk-link" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.nodes-k8s-cluster-amitk-link.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-443to443-masters-k8s-cluster-amitk-link" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-k8s-cluster-amitk-link.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-22to22-masters-k8s-cluster-amitk-link" {
  from_port         = 22
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-k8s-cluster-amitk-link.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-22to22-nodes-k8s-cluster-amitk-link" {
  from_port         = 22
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.nodes-k8s-cluster-amitk-link.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-443to443-masters-k8s-cluster-amitk-link" {
  from_port         = 443
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-k8s-cluster-amitk-link.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-masters-k8s-cluster-amitk-link-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.masters-k8s-cluster-amitk-link.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-k8s-cluster-amitk-link-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.masters-k8s-cluster-amitk-link.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-k8s-cluster-amitk-link-ingress-all-0to0-masters-k8s-cluster-amitk-link" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.masters-k8s-cluster-amitk-link.id
  source_security_group_id = aws_security_group.masters-k8s-cluster-amitk-link.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-k8s-cluster-amitk-link-ingress-all-0to0-nodes-k8s-cluster-amitk-link" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-k8s-cluster-amitk-link.id
  source_security_group_id = aws_security_group.masters-k8s-cluster-amitk-link.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-amitk-link-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-k8s-cluster-amitk-link.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-amitk-link-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-k8s-cluster-amitk-link.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-amitk-link-ingress-all-0to0-nodes-k8s-cluster-amitk-link" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-k8s-cluster-amitk-link.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-amitk-link.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-amitk-link-ingress-tcp-1to2379-masters-k8s-cluster-amitk-link" {
  from_port                = 1
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-cluster-amitk-link.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-amitk-link.id
  to_port                  = 2379
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-amitk-link-ingress-tcp-2382to4000-masters-k8s-cluster-amitk-link" {
  from_port                = 2382
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-cluster-amitk-link.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-amitk-link.id
  to_port                  = 4000
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-amitk-link-ingress-tcp-4003to65535-masters-k8s-cluster-amitk-link" {
  from_port                = 4003
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-cluster-amitk-link.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-amitk-link.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-amitk-link-ingress-udp-1to65535-masters-k8s-cluster-amitk-link" {
  from_port                = 1
  protocol                 = "udp"
  security_group_id        = aws_security_group.masters-k8s-cluster-amitk-link.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-amitk-link.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_subnet" "eu-central-1a-k8s-cluster-amitk-link" {
  availability_zone = "eu-central-1a"
  cidr_block        = "172.20.32.0/19"
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "eu-central-1a.k8s-cluster.amitk.link"
    "SubnetType"                                   = "Public"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
    "kubernetes.io/role/elb"                       = "1"
    "kubernetes.io/role/internal-elb"              = "1"
  }
  vpc_id = aws_vpc.k8s-cluster-amitk-link.id
}

resource "aws_vpc" "k8s-cluster-amitk-link" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = "172.20.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "k8s-cluster-amitk-link" {
  domain_name         = "eu-central-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    "KubernetesCluster"                            = "k8s-cluster.amitk.link"
    "Name"                                         = "k8s-cluster.amitk.link"
    "kubernetes.io/cluster/k8s-cluster.amitk.link" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "k8s-cluster-amitk-link" {
  dhcp_options_id = aws_vpc_dhcp_options.k8s-cluster-amitk-link.id
  vpc_id          = aws_vpc.k8s-cluster-amitk-link.id
}

terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      "configuration_aliases" = [aws.files]
      "source"                = "hashicorp/aws"
      "version"               = ">= 3.59.0"
    }
  }
}
