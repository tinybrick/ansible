#! /usr/bin/bash

DC_HOSTNAME="dc"
DOMAIN="cloud.local"
REALM=$(echo "$DOMAIN" | tr '[:lower:]' '[:upper:]')
USER_GROUP="Domain Linux Users"

if [ "$1" != "" ];then
    PASSWORD="$1"
else
    echo $0 password_for_domain_admin
    exit 1
fi

yum -y install realmd sssd oddjob oddjob-mkhomedir adcli samba-common-tools

sed -i "s/EXAMPLE.COM/$REALM/" /etc/krb5.conf
sed -i "s/kerberos.example.com/$DC_HOSTNAME.$DOMAIN/" /etc/krb5.conf
sed -i "s/example.com/$DOMAIN/" /etc/krb5.conf
sed -i '2,$s/^#//' /etc/krb5.conf

echo "$PASSWORD" | realm --verbose join --user=administrator@$REALM $REALM
realm permit -g "$USER_GROUP"

realm permit -g "Domain Admins"
realm permit -g "Domain Linux Admins"

sed -i '/^%wheel\tALL=(ALL)\tALL/a\%Domain\\x20Admins ALL=\(ALL\)  NOPASSWD: ALL' /etc/sudoers
sed -i '/^%wheel\tALL=(ALL)\tALL/a\%Domain\\x20Linux\\x20Admins ALL=\(ALL\)  NOPASSWD: ALL' /etc/sudoers

sed -i -e 's/use_fully_qualified_names = True/use_fully_qualified_names = False/' /etc/sssd/sssd.conf
chmod 600 /etc/sssd/sssd.conf

systemctl restart sssd
exit 0

