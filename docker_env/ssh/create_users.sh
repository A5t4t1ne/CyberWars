#!/bin/bash

home_rights=(
    750 # bob - foothold user
    750 # john - normal user
)

users=(
	bob 
	john
)
passwds=(
    extrude-iodize-lisp # bob
    Y6gDTAm8LPO17zEeV048B # john
)


if [[ $1 == "rights_only" ]]; then
	for i in "${!users[@]}"; do
		chown -R "${users[$i]}":"${users[$i]}" /home/"${users[$i]}"
		chmod "${home_rights[$i]}" /home/"${users[$i]}"
	done

		
	echo "rights only changed" 
	exit
fi

# create all users
for i in "${!users[@]}"; do
    if id "${users[$i]}" &>/dev/null; then
        echo "User ${users[$i]} already exists"
    else
        useradd -s /bin/bash "${users[$i]}"
        echo "User ${users[$i]} created"
    fi
    mkdir -p /home/"${users[$i]}"
    chown -R "${users[$i]}":"${users[$i]}" /home/"${users[$i]}"
    chmod "${home_rights[$i]}" /home/"${users[$i]}"
    echo "${users[$i]}:${passwds[$i]}" | chpasswd
done


# Make hosts file exploitable
groupadd netw_admins
usermod -aG netw_admins john
chown "root:netw_admins" /etc/hosts
chmod 664 /etc/hosts


mkdir -p /var/run/docker
chown root:docker /var/run/docker
chmod 770 /var/run/docker
