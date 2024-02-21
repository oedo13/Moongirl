#!/bin/bash

#La trampa que utilitzat ha sigut que si fas ctrl + c no deixi sortir del programa
trap 'echo NO POTS FER CONTROL + C ' SIGINT

#He creat dos funcions que basicament són els dos menus que utilitzo al meu codi principal
menu(){
	echo "********************************"
	echo "* Escull una opcio:            *"
	echo "********************************"
	echo "* 1.Mostra l'estat de la xarxa.*"
	echo "* 2.Mostrar ports.             *"
	echo "* 3.Mostra estat dels serveis. *"
	echo "* 4.Rendiment de la CPU        *"
	echo "* 5.Informació sobre la RAM    *"
	echo "* 6.Surt                       *"
	echo "********************************"
	read -p "" opcio
}
menu_2(){
	echo "*********************************************"
	echo "*  Escull el servei que vols saber l'estat: *"
	echo "*********************************************"
	echo "*  1.Apache2                                *"
	echo "*  2.Bind9                                  *"
	echo "*  3.Smtp                                   *"
	echo "*  4.Dhcp                                   *"
	echo "*********************************************"
	read -p "" opcio2
}

#Primer és fa un bucle que fins que no fasi ping al servidor remot no entri al codi principal
until ping -c 4 192.168.0.1;
do
	echo 'Error de conexio'
	sleep 4
done

fi=0

#Aques Here-Docs el que fa és instalar els dos paquets que necistarem per executar diferents comandes idns del codi principal 
ssh root@192.168.0.1 <<- eof
apt update
apt install net-tools
apt install nmap
eof

#El bucle principal el que fa és basicament que mententres la opcio no sigui 6 que segeixi en el bucle 
while [ $fi -eq 0 ]
do
	menu
#Aquest és el case principal on seleciones la informació que volem que aparegui
	case $opcio in
		'1')
			cat index1.html >> index.html
			echo "<h2>`date +%F`</h2>">> index.html
			ssh root@192.168.0.1 "netstat" >> index.html
			cat index2.html >> index.html
			firefox index.html
			echo "" > index.html
		;;
		'2')
			cat index1.html >> index.html
  			echo "<h2>`date +%F`</h2>">> index.html
			ssh root@192.168.0.1 "nmap -u 127.0.0.1" >> index.html
			cat index2.html >> index.html
			firefox index.html
			echo "" > index.html
		;;
		'3')
			menu_2
#Aquest segon case és per selecionar el tipus de servei que vols veure
			case $opcio2 in
				'1')
				cat index1.html >> index.html
    				echo "<h2>`date +%F`</h2>">> index.html
				ssh root@192.168.0.1 "service apache2 status" >> index.html
				cat index2.html >> index.html
				firefox index.html
				echo "" > index.html
				;;
				'2')
				cat index1.html >> index.html
    				echo "<h2>`date +%F`</h2>">> index.html
				ssh root@192.168.0.1 "service bind9 status" >> index.html
				cat index2.html >> index.html
				firefox index.html
				echo "" > index.html
				;;
				'3')
				cat index1.html >> index.html
    				echo "<h2>`date +%F`</h2>">> index.html
				ssh root@192.168.0.1 "service postfix status" >> index.html
				cat index2.html >> index.html
				firefox index.html
				echo "" > index.html
				;;
				'4')
				cat index1.html >> index.html
    				echo "<h2>`date +%F`</h2>">> index.html
				ssh root@192.168.0.1 "service isc-dhcp-server status" >> index.html
				cat index2.html >> index.html
				firefox index.html
				echo "" > index.html
				;;
			esac

		;;
		'4')
			cat index1.html >> index.html
   			echo "<h2>`date +%F`</h2>">> index.html
			ssh root@192.168.0.1 "lscpu" >> index.html
			cat index2.html >> index.html
			firefox index.html
			echo "" > index.html
		;;
		'5')
			cat index1.html >> index.html
   			echo "<h2>`date +%F`</h2>">> index.html
			ssh root@192.168.0.1 "free -m" >> index.html
			cat index2.html >> index.html
			firefox index.html
			echo "" > index.html
		;;
		'6')
			fi=1
		;;
	esac
done
