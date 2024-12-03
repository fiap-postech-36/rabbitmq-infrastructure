# Infraestrutura RabbitMQ com EKS

Este guia descreve como configurar e subir a infraestrutura do cluster EKS que inclui o serviço RabbitMQ, utilizando Terraform.

## Estrutura do Projeto

O Terraform está configurado na pasta `envs/prod`. Este guia assume que você está nesta pasta para executar os comandos.

## Pré-requisitos

Certifique-se de que você possui os seguintes itens configurados antes de prosseguir:
- [Terraform](https://www.terraform.io/) instalado.
- [AWS CLI](https://aws.amazon.com/cli/) configurada com credenciais válidas.
- Permissões necessárias para criar recursos na AWS, incluindo VPC, sub-redes, e clusters EKS.

## Instruções de Configuração

1. **Inicialize o Terraform**  
   Navegue até a pasta `envs/prod` e execute o comando:

   ```bash
   terraform init
   ```

2. **Criar a VPC**  
   Para criar os recursos de rede (VPC), execute o seguinte comando:

   ```bash
   terraform apply -target="module.vpc"
   ```

   Aguarde a criação da VPC antes de prosseguir para o próximo passo.

3. **Subir o Cluster EKS**  
   Após a VPC estar criada, execute o comando a seguir para criar o cluster EKS e os demais recursos:

   ```bash
   terraform apply
   ```

   Confirme as alterações propostas e aguarde a conclusão do processo.

4. **Verificar a Infraestrutura**  
Após o cluster ser criado, será emitido no terminal o output do endpoint que estará acessível, como no exemplo:

```bash
Outputs:

url_api = "af4b45659baf047e49724279ab7d29eb-1909975876.***.elb.amazonaws.com"
```

## Notas Adicionais

- O módulo de VPC está sendo utilizado a partir de um repositório GitHub. Certifique-se de que a versão referenciada (`v1.0.0`) está correta para o seu projeto.
- O Terraform pode solicitar confirmações adicionais dependendo da configuração da sua conta AWS e permissões.

## Problemas Conhecidos

- Certifique-se de que as sub-redes públicas estejam configuradas corretamente para que o cluster possa ser acessado externamente.
- Caso encontre erros de autenticação, verifique se o token de acesso EKS foi gerado corretamente ou se foi configurado corretamente.

## Limpeza

Para destruir a infraestrutura criada, você pode usar o comando:

```bash
terraform destroy
```

Certifique-se de executar este comando com cuidado para evitar exclusões acidentais.
