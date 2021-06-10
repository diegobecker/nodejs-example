# nodejs-example

Projeto de infraestrutura para rodar uma aplicação NodeJS

Infraestrutura criada com Packer e Terraform na AWS

O que fazer

Criar arquivo gitignore


- Criar uma imagem Ubuntu utilizando Packer
- Provisionar NodeJS, Git, Nginx na imagem criada
- Criar uma infraestrutura de servidor EC2 utilizando a AMI criada
- Executar uma aplicação de teste no servidor

https://learn.hashicorp.com/tutorials/packer/aws-get-started-build-image?in=packer/aws-get-started


https://github.com/hashicorp/learn-terraform-provisioning


https://github.com/lightninglife/ImmutableInfrastructure

Enable SSH
https://aku.dev/create_aws_ec2_instance_with_terraform/

Packer, Ansible e terraform
https://github.com/rohitgabriel/packer-ansible-terraform

Packer with Ansible
https://www.packer.io/docs/provisioners/ansible

Ansible com NodeJS
https://www.tderflinger.com/en/ansible-node


Passos para instalação na instância
- Atualizar
- Instalar
    - Node sudo apt install nodejs -y
    - NPM sudo apt install npm -y
    - Yarn sudo npm install --global yarn
    - Git sudo apt install git
- Clonar projeto de teste git clone https://github.com/budimanfajarf/node-hello-world.git

AMI até aqui: ami-023216154d570ea0e

Teste 
cd node-hello-world/
- Instalar dependências npm i
- Executar projeto node app.js

Instalar Nginx
https://ubuntu.com/tutorials/install-and-configure-nginx#2-installing-nginx
