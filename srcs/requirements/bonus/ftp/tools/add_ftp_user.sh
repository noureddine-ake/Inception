#!/bin/bash

# service vsftpd start

# mkdir -p /var/www/wordpress
# echo pipoftp > /etc/vsftpd.userlist;
# echo "pipoftp:$FTP_PASSWORD" | chpasswd
# chown -R pipoftp:pipoftp /var/www/wordpress

# /usr/sbin/vsftpd

service vsftpd start

mkdir -p /var/run/vsftpd/empty
mkdir -p /var/www/wordpress
chmod 0555 /var/www/wordpress
chmod +x /etc/vsftpd.conf
useradd -d /var/www/wordpress -s /bin/false pipoftp
echo $FTP_USER > /etc/vsftpd.userlist
echo ${FTP_USER}:${FTPPASS} | chpasswd
chown -R ${FTP_USER}:${FTP_USER} "/var/www/wordpress"

echo "local_enable=YES" >> /etc/vsftpd.conf;
echo "write_enable=YES" >> /etc/vsftpd.conf;
echo "chroot_local_user=YES" >> /etc/vsftpd.conf;
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf;
echo "pasv_enable=YES" >> /etc/vsftpd.conf;
echo "pasv_min_port=21000" >> /etc/vsftpd.conf;
echo "pasv_max_port=21010" >> /etc/vsftpd.conf;
echo "userlist_enable=YES" >> /etc/vsftpd.conf;
echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf;
echo "userlist_deny=NO" >> /etc/vsftpd.conf;
echo "secure_chroot_dir=/var/www/wordpress" >> /etc/vsftpd.conf;

service vsftpd stop

# service vsftpd stop