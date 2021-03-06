# :runner: Como rodar

Para rodar o projeto basta executar os seguintes comandos:

```plaintext
cd bareos-dir && tar -czvf bareos-dir.tgz bareos-dir.d
cd ../bareos-sd && tar -czvf bareos-sd.tgz bareos-sd.d
cd .. && ./build-containers.sh
docker-compose up -d
```

## :memo: Variáveis de ambiente - exemplos

Os arquivos, abaixo representados, são utilizados como **pontos de configuração para as variáveis de ambiente**, necessárias para o funcionamento da aplicação.

A separação de arquivos é feita com o fim de prover maior segurança para a aplicação, evitando a exposição das variáveis de ambiente com conteúdo sensível, tal como as credências de acesso a aplicação e banco de dados, diretamente no arquivo de orquestração(`docker-composer.yml`).

### `bareos-fd.env`

```properties
BAREOS_FD_HOST=bareos-fd
BAREOS_FD_PASSWORD=ThisIsMySecretFDp4ssw0rd
```

### `bareos-sd.env`

```properties
BAREOS_SD_HOST=bareos-sd
BAREOS_SD_PASSWORD=ThisIsMySecretSDp4ssw0rd
```

### `bareos-webui.env`

```properties
# bareos web ui login: admin
BAREOS_WEBUI_PASSWORD=ThisIsMySecretUIp4ssw0rd
BAREOS_DIR_HOST=bareos-dir
```

### `database.env`

```properties
MYSQL_ROOT_PASSWORD=ThisIsMySecretDBp4ssw0rd
DB_HOST=bareos-db
DB_PORT=3306
DB_NAME=bareos
DB_USER=root
DB_PASSWORD=$MYSQL_ROOT_PASSWORD
```

### `notification.env`

```properties
# - SMTP_HOST=smtpd
# - SENDER_MAIL=your-sender@mail.address #optional
# - ADMIN_MAIL=your@mail.address # Change me!

# ! Optional you can get backup notification via Slack or Telegram
# true or false if set to true email notification gets disabled
WEBHOOK_NOTIFICATION=true

# choose slack or telegram
WEBHOOK_TYPE=telegram

# set the slack or telegram URL
WEBHOOK_URL=https://api.telegram.org/bot<token>/sendMessage

# for get chat_id telegram use (https://api.telegram.org/bot<YourBOTToken>/getUpdates)
WEBHOOK_CHAT_ID=<chat_id>
```

## :clipboard: docker-compose.yml

```yaml
---
version: '3'
services:
  bareos-dir:
    image: bareos-dir
    volumes:
      - director_config:/etc/bareos
      - director_data:/var/lib/bareos # required for MyCatalog backup
    env_file:
      - ./credentials/bareos-fd.env
      - ./credentials/bareos-sd.env
      - ./credentials/bareos-webui.env
      - ./credentials/database.env
      - ./credentials/notification.env
    depends_on:
      - bareos-db

  bareos-sd:
    image: bareos-sd
    ports:
      - 9103:9103
    volumes:
      - storage_config:/etc/bareos
      - storage_data:/var/lib/bareos/archive
    env_file:
      - ./credentials/bareos-sd.env

  bareos-fd:
    image: bareos-fd
    volumes:
      - client_config:/etc/bareos
      - director_data:/var/lib/bareos-director:ro # required for MyCatalog backup
    env_file:
      - ./credentials/bareos-fd.env

  bareos-webui:
    image: bareos-webui
    ports:
      - 8080:9100
    volumes:
      - webui_config:/etc/bareos-webui
      - webui_data:/usr/share/bareos-webui
    env_file:
      - ./credentials/bareos-webui.env

  bareos-db:
    image: mysql:5.6
    volumes:
      - mysql_data:/var/lib/mysql
    env_file:
      - ./credentials/database.env

  # smtpd:
  #   image: namshi/smtp

volumes:
  director_config:
  director_data:
  storage_config:
  storage_data:
  client_config:
  webui_config:
  webui_data:
  mysql_data:
...
```

