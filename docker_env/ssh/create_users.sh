#!/bin/bash

home_rights=(
    750 # bob - foothold user
    750 # john - normal user
)

users=(bob john)
passwds=(
    bdkOW4LgTXr1dGoYI9DC7J9Cr # bob
    Y6gDTAm8LPO17zEeV048B # john
)


if [[ $1 == "rights_only" ]]; then
	for i in "${!users[@]}"; do
		chown -R "${users[$i]}":"${users[$i]}" /home/"${users[$i]}"
		chmod "${home_rights[$i]}" /home/"${users[$i]}"
	done

	# echo $(getent passwd EGO)
	# echo $(getent group celestials)

	# chown EGO:celestials /home/Celestials
	# chmod 770 /home/Celestials
	# echo "Ownership changed for Celestials"

	# mkdir -p /var/run/docker
	# chown root:docker /var/run/docker
	# chmod 770 /var/run/docker

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

# groupadd celestials
# usermod -aG celestials EGO
# usermod -aG celestials Starlord
# echo "Group celestials created and Starlord and EGO added to it"

# chown root:celestials /home/Celestials
# chmod 770 /home/Celestials
# echo "Ownership changed for EGO and /home"

# usermod -aG sudo EGO

# yes I know it's ugly. Idc
# usermod -aG Rocket Gamora

mkdir -p /var/run/docker
chown root:docker /var/run/docker
chmod 770 /var/run/docker
