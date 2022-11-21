#!/bin/bash

echo "Привет! Данная программа проверяет свойства любой папки или файла."

echo "Для работы необходимо установить zenity (установлен по умолчанию в gtk-окружениях)."

while true
	do
	read -p "Продолжить? (д/н) " answer
	if [ $answer == "д" ] || [ $answer == "y" ]
		then
		echo "1) Свойства файла"
		echo "2) Свойства папки"
		read -p "> " type
		if [[ $type -eq 1 ]]
			then
			path=$(zenity \
			      --file-selection \
			      --title="Выберите путь для получения информации о файле..." 2> /dev/null)
			      if [[ "$path" == "" ]]
			      	then
			      	echo
			      	echo "--ОТМЕНА!--"
			      	echo
			      	continue
			      fi
		else if [[ $type -eq 2 ]]
			then
			path=$(zenity \
			      --file-selection --directory\
			      --title="Выберите путь для получения информации о папке..." 2> /dev/null)
			      if [[ "$path" == "" ]]
			      	then
			      	echo "--ОТМЕНА!--"
			      	continue
			      fi
		else
			echo
			echo "--ОТМЕНА!--"
			echo
			continue
		fi
		fi
		operands=$(zenity \
	                  --list --checklist --multiple --height 300 \
	                  --title="Свойства" --text="Выберите какие пункты свойств вам необходимы:" \
	                  --column="Д/Н" --column="Параметр" --column="Операнд" \
	                  --hide-column=3 --print-column=2,3 --separator="," \
	                  FALSE "Всё" all \
	                  FALSE "Всё кроме" allex \
	                  TRUE "Полное имя" %n \
	                  TRUE "Тип файла" %F \
	                  FALSE "Точка монтирования" %m \
	                  FALSE "Pазрешения" %A \
	                  FALSE "ID пользователя-владельца" %u \
	                  FALSE "Имя пользователя владельца" %U \
	                  FALSE "ID группы-владельца" %g \
	                  FALSE "Имя группы-владельца" %G \
	                  TRUE "Pазмер (в байтах)" %s \
	                  TRUE "Время создания файла" %w \
	                  FALSE "Время изменения файла" %z \
	                  2> /dev/null)
	        if [[ "$operands" == "" ]]
	        	then
	        	echo "--ОТМЕНА!--"
	        	break
	        else if [[ "$operands" == *"all"* ]]
	        	then
	        	operands= "Полное имя,%n,Тип файла,%F,Точка монтирования,%m,Разрешения,%A,ID пользователя-владельца,%u" \
	        		  "Имя пользователя-владельца,%U,ID группы-владельца,%g,Имя группы-владельца,%G,Размер (в байтах),%s" \
	        		  "Время создания файла,%w,Время изменения файла,%z"
	        fi
	        fi           
	        SUB=","
	        REPLACE1=": "
	        REPLACE2="\n"
	        while true
	        	do
	        	if [[ "$operands" == *","* ]]
	        		then
	        		operands=${operands/$SUB/$REPLACE1}
	        		operands=${operands/$SUB/$REPLACE2}
	        	else
	        	break
	        	fi
	        done
	        echo
	        if [[ $type -eq 1 ]]
	        	then
	        	echo "--СВОЙСТВА ФАЙЛА$(basename "$path")--"
	        	stat --printf="$operands\n" "$path"
	        	echo "--КОНЕЦ СВОЙСТВ ФАЙЛА--"
	        else
	        	echo "--СВОЙСТВА ПАПКИ$(basename "$path")--"
	        	stat --printf="$operands\n" "$path"
	        	echo "--КОНЕЦ СВОЙСТВ ПАПКИ--"
	        fi
		echo
	else
		break
	fi
done
read -rsn1 -p "Пока! Нажмите любую клавишу для выхода..."
