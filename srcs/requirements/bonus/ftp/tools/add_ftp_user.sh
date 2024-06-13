# #!/bin/bash

FTP_CONFIG_FILE="/etc/vsftpd.conf"
SCRIPT_FILE="/usr/local/bin/add_ftp_user.sh"

sleep 10
service vsftpd start > /dev/null 2>&1

cat<<EOF > cr





y
EOF

#SET UP FTP USER
adduser --home /var/www/wordpress $FTP_USER --disabled-password < cr > /dev/null 2>&1
rm cr
echo "${FTP_USER}:${FTP_PASSWORD}" | /usr/sbin/chpasswd 
chown -R $FTP_USER:$FTP_USER /var/www/wordpress/wp-content > /dev/null 2>&1
echo $FTP_USER | tee -a /etc/vsftpd.userlist > /dev/null 2>&1
adduser ${FTP_USER} root > /dev/null 2>&1

#ADD&MODIFIE CUSTOM FTP CONFIGURATION
sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g"  $FTP_CONFIG_FILE && \
sed -i "s|#local_enable=YES|local_enable=YES|g"  $FTP_CONFIG_FILE && \
sed -i "s|#write_enable=YES|write_enable=YES|g"  $FTP_CONFIG_FILE && \
sed -i "s|#local_umask=022|local_umask=007|g"  $FTP_CONFIG_FILE && \


echo "allow_writeable_chroot=YES" >> $FTP_CONFIG_FILE && \
echo 'seccomp_sandbox=NO' >> $FTP_CONFIG_FILE && \
echo 'pasv_enable=YES' >> $FTP_CONFIG_FILE

service vsftpd stop > /dev/null 2>&1

rm $SCRIPT_FILE

#LAUNCH FTP DAEMON
/usr/sbin/vsftpd > /dev/null 2>&1