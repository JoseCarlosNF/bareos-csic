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

## :clapper-board: Histórico do projeto

- O repositório [barcus/bareos](https://github.com/barcus/bareos) foi adotado como base para o projeto, usando containers.
  - :warning: Foram encontrados alguns problemas ao reconstruir as imagens, a partir dos arquivos de definição(Dockerfiles) originais. Citados a seguir.
    1. As versões não eram mais compativeis.
    2. O container de entrega de notificações(namshi/smtp) foi atualizado.

        **Obs**: Atualmente o **telegram foi adotado como meio de notifiação**. Entretanto não é possível obter informações muito relevante a cerca dos processos, apenas o status final de execução dos jobs(OK, Fail, OK -- with warnings). Tal como era feito com o serviço de emails.

    3. O entrypoint do director, não era mais funcional. O projeto do bareos já foi atualizado e existem pontos a serem corrigidos.

        **Obs**: Os pontos já foram corrigidos. Tratava-se, de inconsistências nos arquivos de configuração, principalmente de notificação(messages). Fato que adicionado ao problema anterior gerava instabilidade na aplicação, por erros no processo de entregra das notificações.

- [x] Revisão dos containers
  - [x] Definir versões fixas para os pacotes, a fim de evitar novas compicações, em builds posteriores.
  - [x] Atualizar as **strings de substituição**, no entrypoint do director
    - Arquivos de `messages` foram atualizados.
  - Estudar o suporte a notificações por email. [namshi/docker-smtp](https://github.com/namshi/docker-smtp)

    **Obs**: Como citado anteriormente o telegram foi adotado como meio de notificação. Assim foi deixado de lado, ao menos por enquanto o uso de notificações por email.

    - A [issue](https://github.com/barcus/bareos/issues/73) e o [PR](https://github.com/barcus/bareos/pull/78), do repositório inspirador, relacionados ao suporte à notificações pelo Telegram/Slack foi imcorporada na aplicação.
