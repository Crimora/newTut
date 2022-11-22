#!/bin/bash
# (ОТМЕНА, см. п. 2) Указать прокси для http, https и ftp (gsettings)
# (ОТМЕНА, см. п. 2) Выполнить аналогичные действия и для apt (proxy02) (echo "smth" >> proxy02)

# 1) Указать DNS
if ! grep -q '^dns-nameservers 95.167.167.95 95.167.167.95$'; then
    echo 'dns-nameservers 95.167.167.95 95.167.167.95' | sudo tee -a /etc/network/interfaces
else
    echo 'DNS-серверы уже установлены!'; fi

# 2) (Упрощение) Через gsettings задаём прокси
if  ![[ $(gsettings get org.gnome.system.proxy.http host) == '10.0.16.52' ]] ||
    ![[ $(gsettings get org.gnome.system.proxy.http port) == '3128' ]]; then
    gsettings set org.gnome.sytem.proxy.http host '10.0.16.52'
    gsettings set org.gnome.sytem.proxy.http port '3128'
else
    echo 'HTTP-прокси уже установлен!'; fi
if  ![[ $(gsettings get org.gnome.system.proxy.https host) == '10.0.16.52' ]] ||
    ![[ $(gsettings get org.gnome.system.proxy.https port) == '3128' ]]; then
    gsettings set org.gnome.sytem.proxy.https host '10.0.16.52'
    gsettings set org.gnome.sytem.proxy.https port '3128'
else
    echo 'HTTPS-прокси уже установлен!'; fi
if  ![[ $(gsettings get org.gnome.system.proxy.ftp host) == '10.0.16.52' ]] ||
    ![[ $(gsettings get org.gnome.system.proxy.ftp port) == '3128' ]]; then
    gsettings set org.gnome.sytem.proxy.ftp host '10.0.16.52'
    gsettings set org.gnome.sytem.proxy.ftp port '3128'
else
    echo 'FTP-прокси уже установлен!'; fi

sudo systemctl restart network-manager

# 3) Скачать и установить сертификат (cd, wget, chown, mkdir, update-ca-certificates)

if ![ -e /usr/locla/share/ca-certificates/school/ca-root.crt]; then
    cd /usr/local/share/ca-certificates/school && sudo mkdir school && cd school && \
    sudo wget 'https://espd.wifi.rt.ru/docs/ca-root.crt' && sudo chmod 644 ca-root.crt && cd .. && \
    sudo chmod 755 school && sudo update-ca-certificates
else
    echo 'Cертификат уже установлен!'

# 4) Выполнить реконнекту
sudo systemctl restart network-manager
