#!/bin/bash

echo "initializing parameters.."
domain="company_name.adds"
DOMAIN_MAJ="COMPANY_name.ADDS"
admin="admin_user_name"

echo "your domain name: " $domain ", " $DOMAIN_MAJ
echo "your admin user: " $admin
echo "abort if there's an error!"
sleep 5

echo "cheking host address.."
host $domain

sleep 2

echo "syncronizing machine time.."
ntpdate $domain

sleep 2

echo "copiying files.."
cp ./files/sssd.conf /etc/sssd/sssd.conf
chmod 700 /etc/sssd/sssd.conf

cp ./files/realmd.conf /etc/realmd.conf

cp ./files/smb.conf /etc/samba/smb.conf

sleep 2

echo "files copied, checking errors in configuration file.."
testparm

sleep 2

echo "testing kerberos authentification.."
kinit $admin"@"$DOMAIN_MAJ

klist

sleep 3

echo "discovering" $domain "domain.."
realm discover -v $DOMAIN_MAJ
sleep 2
realm list
sleep 2

echo "joining" $domain
realm join $DOMAIN_MAJ -U $admin"@"$domain -v
sleep 2
net ads join -k
sleep 3

echo "check your AD UC to verify if your computer has been successfully joined!"
echo "if yes, configure permitions and enable PAM profiles, then apply changes and test your users."
sleep 5
echo "end of script part1"
