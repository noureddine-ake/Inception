# #!/bin/bash

# # service vsftpd start

# # mkdir -p /var/www/wordpress
# # echo pipoftp > /etc/vsftpd.userlist;
# # echo "pipoftp:$FTP_PASSWORD" | chpasswd
# # chown -R pipoftp:pipoftp /var/www/wordpress

# # /usr/sbin/vsftpd

# service vsftpd start

# mkdir -p /var/run/vsftpd/empty
# mkdir -p /var/www/wordpress
# chmod 0555 /var/www/wordpress
# chmod +x /etc/vsftpd.conf
# useradd -d /var/www/wordpress -s /bin/false pipoftp
# echo $FTP_USER > /etc/vsftpd.userlist
# echo ${FTP_USER}:${FTPPASS} | chpasswd
# chown -R ${FTP_USER}:${FTP_USER} "/var/www/wordpress"

# echo "local_enable=YES" >> /etc/vsftpd.conf;
# echo "write_enable=YES" >> /etc/vsftpd.conf;
# echo "chroot_local_user=YES" >> /etc/vsftpd.conf;
# echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf;
# echo "pasv_enable=YES" >> /etc/vsftpd.conf;
# echo "pasv_min_port=21000" >> /etc/vsftpd.conf;
# echo "pasv_max_port=21010" >> /etc/vsftpd.conf;
# echo "userlist_enable=YES" >> /etc/vsftpd.conf;
# echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf;
# echo "userlist_deny=NO" >> /etc/vsftpd.conf;
# echo "secure_chroot_dir=/var/www/wordpress" >> /etc/vsftpd.conf;

# service vsftpd stop

# # service vsftpd stop


FTP_CONFIG_FILE="/etc/vsftpd.conf"
# SSL_CERT="/etc/ssl/private/vsftpd.crt"
# SSL_CRT_KET="/etc/ssl/private/vsftpd.key"
SCRIPT_FILE="/usr/local/bin/add_ftp_user.sh"

sleep 10
service vsftpd start

cat<<EOF > cr





y
EOF

#SET UP FTP USER
adduser --home /var/www/wordpress $FTP_USER --disabled-password < cr
rm cr
echo "${FTP_USER}:${FTP_PASSWORD}" | /usr/sbin/chpasswd
chown -R $FTP_USER:$FTP_USER /var/www/wordpress
echo $FTP_USER | tee -a /etc/vsftpd.userlist &> /dev/null
adduser ${FTP_USER} root > /tmp/tst

#CREATE SSL CERTIFICATE FOR FTP
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $SSL_CRT_KET -out $SSL_CERT -subj "/C=XX/ST=Morocco/L=Khoribga/O=42/OU=1337/CN=aelbrahm.42.fr"

#ADD&MODIFIE CUSTOM FTP CONFIGURATION
sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g"  $FTP_CONFIG_FILE && \
sed -i "s|#local_enable=YES|local_enable=YES|g"  $FTP_CONFIG_FILE && \
sed -i "s|#write_enable=YES|write_enable=YES|g"  $FTP_CONFIG_FILE && \
sed -i "s|#local_umask=022|local_umask=007|g"  $FTP_CONFIG_FILE && \
sed -i "s|ssl_enable=NO|ssl_enable=YES|g"  $FTP_CONFIG_FILE && \

#SSL CONFIG FOR FTP
# sed -i "s|rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem|rsa_cert_file=/etc/ssl/private/vsftpd.crt|g"  $FTP_CONFIG_FILE && \
# sed -i "s|rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key|rsa_private_key_file=/etc/ssl/private/vsftpd.key|g"  $FTP_CONFIG_FILE

# echo "allow_anon_ssl=YES" >> $FTP_CONFIG_FILE && \
# echo "force_local_data_ssl=YES" >> $FTP_CONFIG_FILE && \
# echo "force_local_logins_ssl=YES" >> $FTP_CONFIG_FILE && \
# echo "force_local_logins_ssl=YES" >> $FTP_CONFIG_FILE && \
# echo "ssl_tlsv1=YES" >> $FTP_CONFIG_FILE && \
# echo "ssl_sslv2=NO" >> $FTP_CONFIG_FILE && \
# echo "ssl_sslv3=NO" >> $FTP_CONFIG_FILE && \
# echo "require_ssl_reuse=NO" >> $FTP_CONFIG_FILE && \
# echo "ssl_ciphers=HIGH" >> $FTP_CONFIG_FILE && \

echo "allow_writeable_chroot=YES" >> $FTP_CONFIG_FILE && \
echo 'seccomp_sandbox=NO' >> $FTP_CONFIG_FILE && \
echo 'pasv_enable=YES' >> $FTP_CONFIG_FILE

service vsftpd stop

rm $SCRIPT_FILE

#LAUNCH FTP DAEMON
/usr/sbin/vsftpd