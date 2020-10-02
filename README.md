![logo-bareos](https://raw.githubusercontent.com/bareos/bareos/master/webui/public/img/bareos.png)

*Inspirado em: https://github.com/barcus/bareos*

---

## :rocket: Execução do ambiente de testes

**Requisitos**:

- vagrant
- ansible
- 1GB de RAM

1. Provisionar as VMs

```shell
vagrant up
````
2. Executar as tasks do ansible

```shell
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
