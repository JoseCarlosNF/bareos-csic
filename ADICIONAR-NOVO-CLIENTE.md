# Passos p/ adição de um novo Cliente

## No Cliente
- Instalar o pacote `bareos-client`

## No Servidor
- Entrar no `bconsole` e digitar o seguinte comando:

        configure client add name=$HOSTNAME-fd address=$IP password=$(openssl rand -base64 32)

- Copiar o arquivo de saida em `/etc/bareos/bareos-dir-export/client/$HOSTNAME-fd/bareos-fd.d/director/$NOME_DO_DIRECTOR.conf` para o cliente.

## No Cliente
- Colocar o arquivo copiado em `/etc/bareos/bareos-fd.d/$NOME_DO_DIRECTOR.conf`
- Reiniciar o serviço `bareos-fd`

