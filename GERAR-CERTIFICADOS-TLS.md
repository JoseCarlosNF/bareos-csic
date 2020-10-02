## Geração de Ceritifcado

Par `pem`

    openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout chaveprivada.pem -out certificado.pem -extensions v3_ca -subj "/C=BR/ST=Para/L=Belem/O=UFPA/OU=CSIC/CN=bareos-csic.ufpa.br"

Par `crt` e `key`

    openssl req -x509 -nodes -newkey rsa:2048 -keyout server.key -out server.crt -days 365 -subj "/C=BR/ST=PA/L=Belem/O='UNIVERSIDADE FEDERAL DO PARA'/OU=CSIC/CN=bareos-csic.ufpa.br"

## Visualização do certificado

    openssl x509 -noout -in <chave(.pem ou .key)> -text

## Revisar em:
[Criptografia, Hash e Assinatura Digital com Open SSL](https://www.ppgia.pucpr.br/~jamhour/Pessoal/Graduacao/Ciencia/Pratica/SSL/certificados509.html)
