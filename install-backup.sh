#!/bin/bash
#S3 backup
#bash shell scripts for setting up backups on S3 service
#PATH=

read -p "Enter your root mysql password" mysqlpwd
read -p "Enter your s3 folder path ie my-bucket/my-folder/" s3path
MPWD="$mysqlpwd"
S3PTH="$s3path"
INSTALL_DIR=/usr/local;

sudo mkdir -p $INSTALL_DIR/etc
sudo cp -r sbin $INSTALL_DIR && for file in $(ls etc); do if [ ! -f "$INSTALL_DIR/etc/$file" ]; then sudo cp etc/$file $INSTALL_DIR/etc/; fi; done
cd ../
sudo chown root:root $INSTALL_DIR/etc/mysql-connection.cnf
sudo chmod 0600 $INSTALL_DIR/etc/mysql-connection.cnf
sudo chmod a+x $INSTALL_DIR/sbin/backup*.sh $INSTALL_DIR/sbin/mysql-backup.sh
rm -rf backup-master backup.zip
cd /usr/local/etc
echo 'password = ${MPWD}' >> mysql-connection.cnf
echo 'S3_PATH=s3://${S3PTH}' >> backup.conf
yum install s3cmd python-magic && sudo s3cmd --configure -c /root/.s3cfg

exit 0
