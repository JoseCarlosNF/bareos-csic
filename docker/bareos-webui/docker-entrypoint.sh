#!/usr/bin/env ash

if [ ! -f /etc/bareos-webui/bareos-config.control ]
  then

  # Update bareos-webui config
  sed -i "s/diraddress = \"localhost\"/diraddress = \"${BAREOS_DIR_HOST}\"/" /etc/bareos-webui/directors.ini

  # Control file
  touch /etc/bareos-webui/bareos-config.control
fi

if [ ! -f /usr/share/bareos-webui/bareos-config.control ]
  then

    touch /usr/share/bareos-webui/bareos-config.control
fi

# Start php-fpm
/usr/bin/env php-fpm7

exec "$@"
