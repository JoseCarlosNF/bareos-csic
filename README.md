<h1 align="center">Bareos CSIC</h1>

<p align="center">
  <img src="https://raw.githubusercontent.com/bareos/bareos/master/webui/public/img/bareos.png" height="80">
  <img src="https://csirt.ufpa.br/images/ctic1112.png" height="80">
</p>

<p align="center">Repositório Oficial do Bareos: https://github.com/bareos/bareos</p>
<p align="center">Inspirado em: https://github.com/barcus/bareos</p>

## :rocket: Execução do ambiente de testes

**Requisitos**:

- vagrant
- ansible
- 1GB de RAM

1. Provisionar as VMs

```
vagrant up
````
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

## :compass: Guias

- [Criar novos serviços de backup](./CRIAR-NOVOS-BACKUPS.md)
- [Adicionar novo cliente](./ADICIONAR-NOVO-CLIENTE.md)
- [Gerar certificados](./GERAR-CERTIFICADOS-TLS.md)

## :ballot_box_with_check: TO-DO

- [ ] jobs
- [ ] filesets
- [ ] pools
- [ ] storages
- [ ] schedules
- [ ] devices
- [x] Construir imagem docker. Pesquisar por alternativas prontas também é uma opção.
  - O repositório [barcus/bareos](https://github.com/barcus/bareos) é uma otima alternativa ao trabalho de contrução da infraestrutura em containers. Mas, deve-se ressaltar a **importancia do rebuild das imagens**.
  - [ ] Estudar o suporte a notificações por email. [namshi/docker-smtp](https://github.com/namshi/docker-smtp)
