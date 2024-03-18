# IaC for RDS

IaC provisionada de RDS for Postgres na AWS com Terraform.

Repositório principal: [tech-challenge](https://github.com/FIAP-3SOAT-G15/tech-challenge)

## Recursos criados

Instância de banco de dados no Relational Database Service (RDS), parâmetros (endpoint e nome do BD) no SSM Parameter Store e secrets (username e password) no Secrets Manager (gerenciada pela AWS), policies para leitura dessas secrets e parâmetros, e security group para o banco de dados com regras de ingresso.

## Dependências

- VPC e [subnet groups para banco de dados](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Subnets)

Essas dependências são criadas nos outros repositórios de infraestrutura da organização e são utilizadas neste repositório através [remote state como data source](https://developer.hashicorp.com/terraform/language/state/remote-state-data).

## Estrutura

```text
.
├── .github/
│   └── workflows/
│       └── provisioning.yml  # provisionamento de IaC com Terraform
└── terraform/                # IaC com Terraform
```
