#!/bin/bash
# Email: nxcuong@ued.udn.vn
# Mobile : 0905014328
# KHAI BAO CAC BIEN MAU VAN BAN CHO SCRIPT
# https://dev.to/ifenna__/adding-colors-to-bash-scripts-48g4

echo -e "${LIGHT_GREEN} ################################## ${ENDCOLOR}"
echo -e "${LIGHT_GREEN} ### Email: nxcuong@ued.udn.vn  ### ${ENDCOLOR}"
echo -e "${LIGHT_GREEN} ### Phone: +84905014328        ### ${ENDCOLOR}"
echo -e "${LIGHT_GREEN} ### Script run on Ubuntu 22.04 ### ${ENDCOLOR}"
echo -e "${LIGHT_GREEN} ################################## ${ENDCOLOR}"

# GOI FUNCTION HIEN THI MAU CHO MENU
source functions/colors
# KHAI BAO BIEN CHO ROOT DIRECTORY WEB SERVER
WEB_ROOT_DIRECTORY=/var/www

# KIEM TRA USER LA ROOT
if [ "$EUID" -ne 0 ]
  then echo -e "${RED} Please run as root ${ENDCOLOR}"
  exit
fi

# Hien thi ten cac interface va ip cua interface trong may chu
echo -e "${LIGHT_GREEN} ######### DIA CHI IP CUA BAN #############${ENDCOLOR}"
ip addr | awk '
/^[0-9]+:/ { 
  sub(/:/,"",$2); iface=$2 } 
/^[[:space:]]*inet / { 
  split($2, a, "/")
  print iface" : "a[1] 
}'

#hien thi phien ban he dieu hanh
echo -e "${LIGHT_GREEN} ######### PHIEN BAN HE DIEU HANH ${ENDCOLOR}"
. /etc/lsb-release
echo $DISTRIB_DESCRIPTION

# Khai báo hàm gọi các file trong thư mục functions
echo -e "${LIGHT_GREEN} ########################################################### ${ENDCOLOR}"
echo -e "${LIGHT_GREEN} ###  CAI DAT MOI TRUONG VA CAC DICH VU CHO MAY CHU MOI  ### ${ENDCOLOR}"
echo -e "${LIGHT_GREEN} ########################################################### ${ENDCOLOR}"
echo -e "${YELLOW}   1) CAI DAT MOI TRUONG ${ENDCOLOR}"
echo -e "${YELLOW}   2) CAI DAT NTP ${ENDCOLOR}"
echo -e "${YELLOW}   3) CAI DAT VA QUAN LY DATABASE ${ENDCOLOR}"
echo -e "${YELLOW}   4) CAI DAT PHP ${ENDCOLOR}"
echo -e "${YELLOW}   5) CAI DAT NGINX ${ENDCOLOR}"
echo -e "${LIGHT_BLUE} ###  TU 1-> 5 CHI CAI DAT CHO MAY CHU MOI  ### ${ENDCOLOR}"
echo -e "${YELLOW}   6) CAI DAT MOODLE TREN NEN TANG NGINX ${ENDCOLOR}"
#echo -e "${YELLOW}   7) CAI DAT MOODLE VA APACHE2 ${ENDCOLOR}"
#echo -e "${YELLOW}   8) TAO VIRTUAL HOST APACHE2 ${ENDCOLOR}"
echo -e "${YELLOW}   9) BACKUP WEBSITE ${ENDCOLOR}"
echo -e "${YELLOW}   99) EXIT MENU ${ENDCOLOR}"

#read -rp 'NHAP SO THU TU CUA DICH VU MUON CAI DAT: ' INSTALL_CHOICE

read -p "$(echo -e ${LIGHT_GREEN}" NHAP SO THU TU CUA DICH VU MUON CAI DAT:  "$ENDCOLOR)" INSTALL_CHOICE
case $INSTALL_CHOICE in
  1) source functions/01_install_environment;;
  2) source functions/02_install_ntp;;
  3) source functions/mariadb/00_menu_mariadb;;
  4) source functions/php/00_menu_php;;
  5) source functions/nginx/01_install_nginx;;
  6) source functions/moodle_nginx;;
#  7) source functions/moodle_apche2;;
#  8) source functions/apache2/02_create_virtual_host;;
  9) source functions/backup/moodle/backup;;  
  99) exit;;
  *) echo "invalid option";;
esac
