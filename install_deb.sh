#!/bin/bash


dir_atual=$(pwd)
log_erros=$dir_atual/log_erro_instalacao.txt
log_instalacao=$dir_atual/log_instalacao.txt


# redefinir cores
Color_Off='\033[0m'


# Cores regulares
Color_Off='\033[0m'
Red='\033[5;31m'
Yellow='\033[0;33m'
Cyan='\033[0;36m'
Purple='\033[0;35m'
Blue='\033[5;34m'

# lista os arquivos e cria o arquivo programas
apt install zip
unzip deb.zip
cd deb
ls *.deb > programas


# carrega a listagem no array lista
lista=($(<programas))


# remover um item do vetor
lista=(${lista[@]/programas})
lista=(${lista[@]/install_deb.sh})


# lista todos  os itens do array
#echo ${lista[*]}


# lista o primeiro item do array
#echo ${lista[0]}



# Inicio da instalacao dos programas .deb
for i in `echo ${!lista[*]}`;do
echo -e "$Blue \n Instalando aplicativo ${lista[$i]} \n $Color_Off"
sleep 2
if ! dpkg -i --force-confnew ${lista[$i]}
then
	echo -e "$Red \n Não foi possível instalar o programa ${lista[$i]}. \n $Color_Off" 
	echo -e "\n Não foi possível instalar o programa ${lista[$i]}. \n" >> $log_erros
	#exit 1
fi
echo -e "$Yellow \n Instalação do programa ${lista[$i]}, realizada com sucesso. \n $Color_Off"
echo -e "\n Instalação do programa ${lista[$i]}, realizada com sucesso. \n " >> $log_instalacao

sleep 2
done

# apagar pasta descompactada com os arquivos .deb
echo -e "$Red \n Apagando pasta deb... \n $Color_Off"
cd ..
chown $USER deb/
rm -Rf deb/
sleep 1

echo -e "$Yellow \n Instalando dependencias... \n $Color_Off"
sleep 1
apt install -fy


echo -e "$Yellow \n Atualizando dependencias... \n $Color_Off"
sleep 1
apt update -y


echo -e "$Yellow \n Realizando upgrade... \n $Color_Off"
sleep 1
apt upgrade -y


echo -e "$Yellow \n Limpando lixos das instalacoes... \n $Color_Off"
sleep 1
apt autoremove -y


echo -e "$Yellow Programas instalados \n"
echo -e "$Red Pressione Enter para Continuar \n"

read

exit

