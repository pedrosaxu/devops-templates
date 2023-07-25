#!/bin/bash

# Tested on Ubuntu 20.04

# Variáveis de configuração
DB_NAME="my_database"
DB_HOST="my-database-instance.123456789012.us-east-1.rds.amazonaws.com"
DB_USER="my_username"
DB_PASSWORD="my_password"
TABLE_PREFIX="myprefix_"
SSL_CERT="/etc/ssl/certs/apache-selfsigned.crt"
SSL_KEY="/etc/ssl/private/apache-selfsigned.key"

# Instalando depdnências
sudo apt update -y &&
sudo apt install -y apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip || exit 1

# Instalando o Wordpress
sudo mkdir -p /srv/www &&
sudo chown www-data: /srv/www || exit 1
sudo -u www-data curl https://wordpress.org/latest.tar.gz | tar zx -C /srv/www || exit 1

# Sobrescrevendo o arquivo de configuração do Wordpress
sudo cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php || exit 1
sudo sed -i "s/database_name_here/$DB_NAME/" /srv/www/wordpress/wp-config.php || exit 1
sudo sed -i "s/localhost/$DB_HOST/" /srv/www/wordpress/wp-config.php || exit 1
sudo sed -i "s/username_here/$DB_USER/" /srv/www/wordpress/wp-config.php || exit 1
sudo sed -i "s/password_here/$DB_PASSWORD/" /srv/www/wordpress/wp-config.php || exit 1
sudo sed -i "s/wp_/$TABLE_PREFIX/" /srv/www/wordpress/wp-config.php || exit 1

# Configurando o Apache para o Wordpress
sudo tee /etc/apache2/sites-available/wordpress.conf <<EOF
<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
EOF

sudo tee /etc/apache2/sites-available/wordpress-ssl.conf <<EOF
<VirtualHost _default_:443>
    DocumentRoot /srv/www/wordpress
    SSLEngine on
    SSLCertificateFile $SSL_CERT
    SSLCertificateKeyFile $SSL_KEY
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride All
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
        AllowOverride All
    </Directory>
    ErrorLog /var/log/apache2/errorSSL.log
    LogLevel warn
    CustomLog \${APACHE_LOG_DIR}/accessSSL.log combined
</VirtualHost>
EOF

# Gerando certificado auto-assinado
echo -e "BR\nSaoPaulo\nSaoPaulo\nTest\nTest\nWordpress\nwordpress@test.com" \
| sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "$SSL_KEY" -out "$SSL_CERT" || exit 1


sudo chown www-data: /srv/www || exit 1

sudo a2dissite 000-default || exit 1
sudo a2ensite wordpress || exit 1
sudo a2ensite wordpress-ssl || exit 1
sudo a2enmod ssl || exit 1
sudo a2enmod rewrite || exit 1
sudo service apache2 reload || exit 1


echo "----------------------------------------------------------------------------"
echo "Grab the values below and paste them in the /srv/www/wordpress/wp-config.php file:"
sudo curl -s https://api.wordpress.org/secret-key/1.1/salt/ | sudo tee -a /srv/www/wordpress/wp-config.php >/dev/null
echo "----------------------------------------------------------------------------"