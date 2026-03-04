# Módulo Terraform para provisionar um cluster Amazon EKS

Este repositório entrega um **módulo Terraform reutilizável** para criar e configurar um cluster **Amazon EKS (Elastic Kubernetes Service)** na AWS.

Em vez de configurar EKS manualmente (IAM, segurança, add-ons, node groups e integrações), você usa este módulo como base para subir um ambiente Kubernetes consistente, versionável e reproduzível.

## Para que este projeto serve

Este projeto foi criado para equipes que precisam:

- Provisionar clusters EKS com padrão único entre ambientes (dev, hml, prod);
- Reduzir esforço operacional na criação de infraestrutura Kubernetes na AWS;
- Aplicar boas práticas de segurança e observabilidade já no provisionamento;
- Ter infraestrutura como código (IaC) com controle de versão e revisão via Git.

Na prática, ele provisiona os blocos principais de um cluster EKS:

- **Cluster EKS gerenciado**;
- **Node groups** para execução dos workloads;
- **IAM roles e policies** para control plane e workers;
- **KMS key** para criptografia de segredos do cluster;
- **CloudWatch log group** para logs do control plane;
- **Add-ons gerenciados** (CoreDNS, kube-proxy e VPC CNI);
- **Security groups e regras** para comunicação entre plano de controle, nós e serviços;
- **Configuração `aws-auth`** no Kubernetes para autenticação/autorização inicial.

## Quando usar este módulo

Use este módulo quando você já possui (ou quer definir) uma VPC/subnets e precisa de um cluster EKS pronto para receber aplicações containerizadas.

Ele é especialmente útil para:

- Plataformas internas de microserviços;
- Times que estão migrando de ECS/VM para Kubernetes;
- Ambientes multi-conta/multi-região que exigem padronização de infraestrutura.

## Pré-requisitos

1. **Terraform** instalado (`~> 1.9.0`);
2. **AWS CLI** configurado com credenciais válidas;
3. Permissões IAM para criar recursos de EKS, IAM, EC2, KMS e CloudWatch;
4. **kubectl** instalado para administrar o cluster após o provisionamento.

## Como começar

### 1) Clonar o repositório

```bash
git clone https://github.com/rhoribe/aws-eks.git
cd aws-eks
```

### 2) Usar o exemplo como ponto de partida

Há uma pasta `example/` com um uso de referência do módulo. Ajuste os valores de acordo com sua conta e rede AWS.

### 3) Inicializar e aplicar

```bash
terraform init
terraform plan
terraform apply
```

Após o `apply`, utilize os outputs do módulo para configurar acesso com `kubectl`.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.14.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.14.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0.4 |


## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eks_addon.coredns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.kubeproxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc-cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.eks_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_worker_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ec2_container_registry_read_only_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_cluster_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_cni_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_service_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_worker_node_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.all_control_plane](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_ingress_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_master_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_master_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_ports_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_ports_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_webhooks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_coredns_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_coredns_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nodeport_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nodeport_cluster_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nodeport_master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nodeport_master_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [kubernetes_config_map_v1_data.aws_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1_data) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_addon_version.coredns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_addon_version) | data source |
| [aws_eks_addon_version.kubeproxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_addon_version) | data source |
| [aws_eks_addon_version.vpc-cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_addon_version) | data source |
| [aws_iam_policy_document.eks_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_worker_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_auth_template_file"></a> [aws\_auth\_template\_file](#input\_aws\_auth\_template\_file) | AWS Auth Template File | `any` | n/a | yes |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | cidrs for the private endpoint, most likely from the subnet (only needed when not using subnets automatic lookup) | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of EKS | `string` | n/a | yes |
| <a name="input_control_plane_logs_retention"></a> [control\_plane\_logs\_retention](#input\_control\_plane\_logs\_retention) | Control Plane Logs Retention | `number` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | AMI for EKS | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes Version | `string` | n/a | yes |
| <a name="input_log_group_class"></a> [log\_group\_class](#input\_log\_group\_class) | Log Group Class | `string` | n/a | yes |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | config block for node groups | `any` | n/a | yes |
| <a name="input_public_cidr_access"></a> [public\_cidr\_access](#input\_public\_cidr\_access) | cidrs allowed to access the public endpoint | `list(string)` | `[]` | no |
| <a name="input_subnets_ids"></a> [subnets\_ids](#input\_subnets\_ids) | IDs of private subnets in VPC (only needed when not using subnets automatic lookup) | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of VPC to deploy to (only needed when not using subnets automatic lookup) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for the EKS cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID of the EKS cluster |
| <a name="output_cluster_role_arn"></a> [cluster\_role\_arn](#output\_cluster\_role\_arn) | ARN of the IAM role used by the EKS cluster for managing AWS resources |
| <a name="output_cluster_security_group_custom_id"></a> [cluster\_security\_group\_custom\_id](#output\_cluster\_security\_group\_custom\_id) | Security group ID attached to the EKS cluster |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Security group ID attached to the EKS cluster |
| <a name="output_worker_role_arn"></a> [worker\_role\_arn](#output\_worker\_role\_arn) | ARN of the IAM role assigned to EKS worker nodes, allowing them to interact with AWS resources |
