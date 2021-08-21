#!/usr/bin/env bash

## OUTPUT模组 Tor moudle

prase_output(){
set +e
clear
	cat > '/etc/profile.d/mymotd.sh' << EOF
#!/usr/bin/env bash
#!!! Do not change these settings unless you know what you are doing !!!
bold=\$(tput bold)
normal=\$(tput sgr0)
# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'
###
domain="$( jq -r '.domain' "/root/.trojan/config.json" )"
password1="$( jq -r '.password1' "/root/.trojan/config.json" )"
password2="$( jq -r '.password2' "/root/.trojan/config.json" )"
neofetch
echo -e " --- 欢迎使用VPSToolBox,如果您想要关闭本报告，请使用以下命令"
echo -e " --- mv /etc/profile.d/mymotd.sh /etc/"
echo -e " --- 再次启用 mv /etc/mymotd.sh /etc/profile.d/mymotd.sh"
echo -e " --- \${BLUE}服務狀態(Service Status)\${NOCOLOR} ---"
  if [[ -f /usr/local/bin/trojan ]]; then
echo -e "Trojan-GFW:\t\t"\$(systemctl is-active trojan)
  fi
  if [[ -f /usr/sbin/nginx ]]; then
echo -e "Nginx:\t\t\t"\$(systemctl is-active nginx)
  fi
  if [[ -f /usr/bin/hexo ]]; then
echo -e "Hexo:\t\t\t"\$(systemctl is-active hexo)
  fi
  if [[ -f /usr/sbin/dnscrypt-proxy ]]; then
echo -e "Dnscrypt-proxy:\t\t"\$(systemctl is-active dnscrypt-proxy)
  fi
  if [[ -f /usr/bin/qbittorrent-nox ]]; then
echo -e "Qbittorrent:\t\t"\$(systemctl is-active qbittorrent)
  fi
  if [[ -f /usr/sbin/opentracker ]]; then
echo -e "Bittorrent-tracker:\t"\$(systemctl is-active tracker)
  fi
  if [[ -f /usr/local/bin/aria2c ]]; then
echo -e "Aria2c:\t\t\t"\$(systemctl is-active aria2)
  fi
  if [[ -f /usr/local/bin/filebrowser ]]; then
echo -e "Filebrowser:\t\t"\$(systemctl is-active filebrowser)
  fi
  if [[ -f /opt/netdata/usr/sbin/netdata ]]; then
echo -e "Netdata:\t\t"\$(systemctl is-active netdata)
  fi
  if [[ -f /usr/bin/dockerd ]]; then
echo -e "Docker:\t\t\t"\$(systemctl is-active docker)
  fi
  if [[ -f /usr/sbin/mysqld ]]; then
echo -e "MariaDB:\t\t"\$(systemctl is-active mariadb)
  fi
  if [[ -f /usr/sbin/php-fpm7.4 ]]; then
echo -e "PHP:\t\t\t"\$(systemctl is-active php7.4-fpm)
  fi
  if [[ -f /usr/sbin/dovecot ]]; then
echo -e "Dovecot:\t\t"\$(systemctl is-active dovecot)
  fi
  if [[ -f /usr/sbin/postfix ]]; then
echo -e "Postfix:\t\t"\$(systemctl is-active postfix)
  fi
  if [[ -f /usr/bin/fail2ban-server ]]; then
echo -e "Fail2ban:\t\t"\$(systemctl is-active fail2ban)
  fi
  if [[ -f /usr/bin/tor ]]; then
echo -e "Tor:\t\t"\$(systemctl is-active tor)
  fi
  if [[ -f /usr/sbin/i2pd ]]; then
echo -e "i2p:\t\t"\$(systemctl is-active i2pd)
  fi
echo -e " --- \${BLUE}帶寬使用(Bandwith Usage)\${NOCOLOR} ---"
echo -e "         接收(Receive)    发送(Transmit)"
tail -n +3 /proc/net/dev | awk '{print \$1 " " \$2 " " \$10}' | numfmt --to=iec --field=2,3
#echo -e " --- \${GREEN}證書狀態(Certificate Status)\${NOCOLOR} ---"
#ssl_date=\$(echo |openssl s_client -connect ${domain}:443 -tls1_3 2>&1 |sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'|openssl x509 -text)
#tmp_last_date=\$(echo "\${ssl_date}" | grep 'Not After :' | awk -F' : ' '{print \$NF}')
#last_date=\$(date -ud "\${tmp_last_date}" +%Y-%m-%d" "%H:%M:%S)
#day_count=\$(( (\$(date -d "\${last_date}" +%s) - \$(date +%s))/(24*60*60) ))
#echo -e "\e[40;33;1m The [${domain}] expiration date is : \${last_date} && [\${day_count} days] \e[0m"
#echo -e "--------------------------------------------------------------------------"
echo -e " --- \${BLUE}Trojan-GFW快速链接\${NOCOLOR}(Trojan links) ---"
echo -e " --- 请在VPS控制面板上彻底禁用防火墙(firewall)以达到最佳效果(allow all ports) ---"
###
echo -e "    \${YELLOW}trojan://$password1@$domain:${trojanport}\${NOCOLOR}"
echo -e "    \${YELLOW}trojan://$password2@$domain:${trojanport}\${NOCOLOR}"
###
if [[ -d /usr/share/nginx/nextcloud/ ]]; then
echo -e " --- \${BLUE}Nextcloud快速链接\${NOCOLOR}(Nextcloud links) ---"
###
echo -e "    \${YELLOW}https://$domain/nextcloud/\${NOCOLOR}"
echo -e "    \${YELLOW}用户名: admin\${NOCOLOR}"
echo -e "    \${YELLOW}密码: ${password1}\${NOCOLOR}"
###
fi
if [[ -d /usr/share/nginx/trojan-panel/ ]]; then
echo -e " --- \${BLUE}Trojan-panel快速链接\${NOCOLOR}(Trojan-panel links) ---"
###
echo -e "    \${YELLOW}https://$domain/config/\${NOCOLOR}"
###
fi
if [[ -f /usr/bin/tor ]]; then
echo -e " --- \${BLUE}Onion快速链接\${NOCOLOR}(onion link) ---"
echo -e "\$(cat /var/lib/tor/hidden_service/hostname)"
fi
echo -e " --- 請\${bold}訪問以下鏈接\${normal}以獲得更多详细結果(Please visit the following link to get more info) "
echo -e "    \${YELLOW}https://$domain/${password1}/\${NOCOLOR}"
echo -e " --- 有關錯誤報告或更多信息，請訪問以下鏈接"
echo -e " --- https://github.com/johnrosen1/vpstoolbox"
echo -e " --- \${YELLOW}https://t.me/vpstoolbox_chat\${NOCOLOR}"
echo -e "*********************"
EOF
chmod +x /etc/profile.d/mymotd.sh
echo "" > /etc/motd
echo "Install complete!"
whiptail --title "Success" --msgbox "安装成功(Install Success),欢迎使用VPSTOOLBOX !" 8 68
bash /etc/profile.d/mymotd.sh
}
