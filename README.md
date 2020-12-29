<h1 align="center">Bareos CSIC</h1>

<p align="center">
  <img src="https://raw.githubusercontent.com/bareos/bareos/master/webui/public/img/bareos.png" height="80">
  <img src="https://csirt.ufpa.br/images/ctic1112.png" height="80">
</p>

<p align="center"><b>UNIVERSIDADE FEDERAL DO PARÁ - UFPA</b></p>
<p align="center"><b>CENTRO DE TECNOLOGIA DA INFORMAÇÃO E COMUNICAÇÃO - CTIC</b></p>
<p align="center"><b>COORDENADORIA DE SEGURANÇA DA INFORMAÇÃO E COMUNICAÇÃO - CSIC</b></p>

<p align="center">Repositório Oficial do Bareos: https://github.com/bareos/bareos</p>
<p align="center">Inspirado em: https://github.com/barcus/bareos</p>

## :whale: Docker

[ambiente com containers](./docker)

## :rocket: Execução do ambiente de testes

**Requisitos**:

- vagrant
- ansible
- 1GB de RAM

1. Provisionar as VMs

```
vagrant up
```

2. Executar as tasks do ansible

```
cd ansible
ansible-playbook -i hosts.ini playbook.yml
```

### :computer: Acessar a interface web

1. http://192.168.0.2/bareos-webui/

2. Login

```
User: admin
Password: admin
```

- portas usadas para o serviço:
  - client escuta 9102
  - director escuta 9103
  - director escuta 9100

## :compass: Guias

- [Criar novos serviços de backup](./CRIAR-NOVOS-BACKUPS.md)
- [Adicionar novo cliente](./ADICIONAR-NOVO-CLIENTE.md)
- [Gerar certificados](./GERAR-CERTIFICADOS-TLS.md)

## :ballot_box_with_check: TO-DO
- Definir os arquivos de configuração. Uso especifico, não será versionado:
  - [ ] jobs
  - [ ] filesets
  - [ ] pools
  - [ ] storages
  - [ ] schedules
  - [ ] devices
  - [x] modificar as permissões de /etc/bareos no bareos-dir
  - [x] habilitar EXIM no entrypoint

- O repositório [barcus/bareos](https://github.com/barcus/bareos) foi adotado como base para o projeto, usando containers.
  - :warning: Foram encontrados alguns problemas ao rebuildar as imagens, a partir dos arquivos originais.
    1. As versões não são mais compativeis.
    2. O container de entrega de notificações foi atualizado.
    3. O entrypoint do director, não é mais funcional. O projeto do bareos já foi atualizado e existem pontos a serem corrigidos.
- [ ] Revisão dos containers
  - [ ] Definir versões fixas para os pacotes, a fim de evitar novas compicações, em builds posteriores.
  - [ ] Atualizar as **strings de substituição**, no entrypoint do director
    - Arquivos de `messages` foram atualizados.
  - [ ] testar o envio de mensagens para o smtp, a partir do director.
    - Comando `bsmtp`, enviador de mensagens do bacula.
  - [ ] Estudar o suporte a notificações por email. [namshi/docker-smtp](https://github.com/namshi/docker-smtp)
    - Existe uma [issue](https://github.com/barcus/bareos/issues/73) e um [PR](https://github.com/barcus/bareos/pull/78) em aberto no repositório original, sobre o suporte à notificações pelo Telegram/Slack.
