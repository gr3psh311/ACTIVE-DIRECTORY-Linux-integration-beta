#!/bin/bash

echo "permitting authentication for all domain accounts.."
realm permit --all

#################################################
# realm permit --all
# realm deny -a					#
# realm permit --groups "domain.adds\group"	#
# realm permit user@domain.adds			#
#################################################

sleep 2

echo "enabling PAM profiles:"
echo "check all entries by pressing [space] key and hit ok to apply configuration.."
sleep 4
pam-auth-update

sleep 2
echo "now edit manually /etc/pam.d/common-session file and the line:"
echo "session    required    pam_mkhomedir.so    skel=/etc/skel/    umask=0022"

sleep 1

echo "when finished, type the below commands to apply changes:"
echo "    sudo systemctl restart realmd sssd"
echo "    sudo systemctl enable realmd sssd"

sleep 1

echo "then test the availability of your users using the following:"
echo "    id <domain_user>"
echo "    sudo getent passwd <domain_user>"
echo "    sudo getent group <domain_group>"
sleep 2
echo "reboot before connecting with AD users"
echo "end of script."
