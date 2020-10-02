![logo-bareos](https://raw.githubusercontent.com/bareos/bareos/master/webui/public/img/bareos.png)

## :rocket: Execução do ambiente de testes

Requisitos:

- vagrant
- ansible
- 1GB de RAM

1. Provisionar as VMs

    vagrant up

2. Executar as tasks do ansible

    cd ansible
    ansible-playbook -i hosts.ini playbook.yml

### :computer: Acessar a interface web

1. http://192.168.0.2/bareos-webui/

2. Login

    User: admin
    Password: admin

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
- [ ] Buscar por meios de definir a senha do FD externamente, antes da criação da infraestrutura. https://github.com/fw7/docker-bareos-client
- [ ] Construir imagem docker. Pesquisar por alternativas prontas também é uma opção.

