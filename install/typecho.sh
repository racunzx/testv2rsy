#!/usr/bin/env bash

## typecho模组 typecho moudle

install_typecho(){
	set +e
	cd /usr/share/nginx/
	curl -LO https://typecho.org/downloads/1.1-17.10.30-release.tar.gz
	tar -xvf *.tar.gz
	rm *.tar.gz
	mv build typecho
	mysql -u root -e "CREATE DATABASE typecho CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    mysql -u root -e "create user 'typecho'@'localhost' IDENTIFIED BY '${password1}';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON typecho.* to typecho@'localhost';"
    mysql -u root -e "flush privileges;"
}