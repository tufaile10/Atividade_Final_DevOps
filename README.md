
# README — Atividade 3 (Terraform na AWS)

## Objetivo da Atividade
O objetivo desta atividade é provisionar infraestrutura básica na AWS utilizando Terraform como ferramenta de Infraestrutura como Código (IaC).  
Os recursos solicitados são:  
1. Instância EC2 (Amazon Linux 2) rodando um servidor Apache simples.  
2. Application Load Balancer (ALB), responsável por encaminhar tráfego HTTP para a EC2.  
3. Banco de Dados RDS (MySQL), configurado em sub-redes privadas para maior segurança.  

Além disso, foram adicionados componentes necessários para funcionamento da arquitetura, como:  
- VPC, sub-redes públicas e privadas.  
- Internet Gateway e tabelas de rota.  
- Grupos de segurança (ALB, EC2 e RDS).  

## Pré-requisitos
Antes de executar o projeto, é necessário ter instalado e configurado:  
- Conta AWS ativa com permissões para EC2, ELB, RDS e VPC.  
- AWS CLI configurada com suas credenciais (`aws configure`).  
- Terraform v1.5.0 ou superior.  
- Visual Studio Code (opcional) para edição e execução do código.  

## Estrutura do Projeto
O projeto está organizado da seguinte forma:  

```
atividade3_terraform_aws/
├── versions.tf         # Definição de versão do Terraform e providers
├── providers.tf        # Configuração do provider AWS
├── variables.tf        # Variáveis do projeto
├── vpc.tf              # Criação da VPC, sub-redes e rotas
├── security.tf         # Grupos de segurança (ALB, EC2, RDS)
├── ec2.tf              # Instância EC2 + Apache (via user_data)
├── alb.tf              # Application Load Balancer + Listener + Target Group
├── rds.tf              # Banco de Dados RDS (MySQL) + Subnet Group
├── outputs.tf          # Saídas (DNS do ALB, IP da EC2, Endpoint do RDS)
└── README.md           # Documentação detalhada do projeto
```

## Como Executar

### 1. Clonar ou baixar o projeto
Baixe o .zip do repositório e extraia em uma pasta local.  
Entre no diretório no terminal:  
```bash
cd atividade3_terraform_aws
```

### 2. Inicializar o Terraform
```bash
terraform init
```
Esse comando baixa os plugins necessários (AWS e Random).  

### 3. Planejar a execução
```bash
terraform plan -out=tfplan
```
O Terraform irá mostrar todos os recursos que serão criados. O parâmetro `-out=tfplan` salva o plano para ser aplicado.  

### 4. Aplicar as mudanças
```bash
terraform apply tfplan
```
Isso vai provisionar toda a infraestrutura na sua conta AWS.  
A criação leva alguns minutos (principalmente o RDS).  

## Testando a Arquitetura
Após o apply, o Terraform exibirá os outputs:  

- alb_dns_name → endereço público do Load Balancer.  
  - Abra no navegador: `http://<alb_dns_name>/`  
  - Deve aparecer a página “OK” servida pela instância EC2.  

- ec2_public_ip → IP público da EC2 (não é necessário acessar diretamente, pois o tráfego vem pelo ALB).  

- rds_endpoint → endpoint do banco de dados RDS.  
  - O RDS está em sub-redes privadas. Para conectar, é necessário acessar a partir da EC2 ou outra máquina dentro da VPC.  
  - Usuário padrão: `appuser`  
  - Senha: gerada automaticamente e armazenada no state do Terraform (random_password).  

## Como Remover os Recursos
Para evitar cobranças desnecessárias, destrua tudo ao final da atividade:  
```bash
terraform destroy
```
Confirme com `yes`. Isso remove todos os recursos criados.  

## Personalizações
Você pode alterar variáveis no arquivo variables.tf:  
- aws_region → Região (padrão sa-east-1).  
- ec2_instance_type → Tipo da instância EC2 (padrão t3.micro).  
- db_engine → Banco de dados (mysql ou postgres).  
- db_engine_version → Versão do banco.  
- open_ssh_cidr → Caso queira habilitar acesso SSH à EC2 (ex.: 1.2.3.4/32).  

## Considerações de Segurança
- A EC2 não tem SSH habilitado por padrão.  
- O RDS não é público, aceitando conexões somente da EC2.  
- A senha do banco é gerada automaticamente e não deve ser versionada.  

## Conclusão
Este projeto demonstra o uso de Terraform para provisionar infraestrutura essencial na AWS, composta por:  
- EC2 com servidor web,  
- ALB para balanceamento de carga,  
- RDS para persistência de dados.  

Tudo automatizado com IaC, reforçando boas práticas de segurança e organização.  
