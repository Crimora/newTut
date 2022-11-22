#!/bin/bash
# (ОТМЕНА, см. 2 п.) Указать прокси для http, https и ftp (gsettings)
# (ОТМЕНА, см. 2 п.) Выполнить аналогичные действия и для apt (proxy02) (echo "smth" >> proxy02)
# 1) Указать DNS (echo nameserver "smth" >> /path_to/interfaces)
# 2) (Упрощение) Экспортируем перемменнные среды отвечающие за прокси (export HTTP_PROXY=kakoi.tam.proksi.ya_xz)
# 3) Скачать и установить сертификат (wget, cp, chown, mkdir, dpkg-reconfigure, update-ca-certificates)
# 4) Выполнить реконнект, а лучше ребут
