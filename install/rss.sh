#!/usr/bin/env bash

## RSS模组 RSS moudle

install_rss(){
set +e
cd /usr/share/nginx/
apt-get install php7.4-mysql -y
apt-get install php7.4-pgsql -y
apt-get install php7.4-sqlite -y
if [[ -d /usr/share/nginx/RSSHub ]]; then
    TERM=ansi whiptail --title "安装中" --infobox "更新rsshub中..." 7 68
    cd /usr/share/nginx/RSSHub
    git pull
    npm update
    npm install --production
    npm prune
  else
    git clone https://github.com/DIYgod/RSSHub.git
    cd /usr/share/nginx/RSSHub
    npm update
    npm install --production
    npm prune
    touch .env
cat > '.env' << EOF
CACHE_TYPE=redis
#REDIS_URL=redis://127.0.0.1:6379/
REDIS_URL=/var/run/redis/redis.sock
CACHE_EXPIRE=600
LISTEN_INADDR_ANY=0
EOF

cat > '/etc/systemd/system/rsshub.service' << EOF
[Unit]
Description=Rsshub
Documentation=https://docs.rsshub.app/
After=network.target
Wants=network.target

[Service]
Type=simple
WorkingDirectory=/usr/share/nginx/RSSHub
ExecStart=/bin/bash -c 'npm start'
Restart=on-failure
LimitNOFILE=65536
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOF
systemctl enable rsshub
systemctl restart rsshub
fi

cd /usr/share/nginx/
if [[ -d /usr/share/nginx/tt-rss/ ]]; then
    TERM=ansi whiptail --title "安装中" --infobox "更新tt-rss中..." 7 68
    #echo "dev ing"
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    git clone https://git.tt-rss.org/fox/ttrss-docker-compose.git ttrss-docker
    cd ttrss-docker
    git checkout static-dockerhub
    cp .env-dist .env
    sed -i "s/http:\/\/localhost:8280\/tt-rss/https:\/\/${domain}\/tt-rss/" .env
    docker-compose pull && docker-compose up -d
    # 安装Fever插件
    cd /var/lib/docker/volumes/ttrss-docker_app/_data/tt-rss/plugins.local/
    git clone https://github.com/DigitalDJ/tinytinyrss-fever-plugin fever
    # 安装Feedly主题
    mkdir /usr/share/nginx/themes/
    cd /usr/share/nginx/themes/
    git clone https://github.com/levito/tt-rss-feedly-theme.git feedly
    cd /usr/share/nginx/themes/feedly/
    cp -r feedly* /var/lib/docker/volumes/ttrss-docker_app/_data/tt-rss/themes.local
    rm -rf /usr/share/nginx/themes/
  else
    echo "dev ing"
fi
cd
}

