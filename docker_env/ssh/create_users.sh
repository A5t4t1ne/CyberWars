#!/bin/bash

home_rights=(
    750 # Groot
    750 # Drax
    750 # Rocket
    750 # Gamora
    750 # Starlord
    750 # EGO
)

users=(Groot Drax Rocket Gamora Starlord EGO)
passwds=(
    pneumonoultramicroscopicsilicovolcanoconiosis # Groot
    I_4m_7h3_gr34t3st_0f_7h3m_4ll # Drax
    1_4m_7h3_b357_p1l07 # Rocket
    1_4m_4_n0n-d4nc3r_0k? # Gamora
    Y0u_m1gh7_kn0w_m3_45_Starlord # Star-Lord
    7h3_un1v3rs3_n33d5_t0_b3_m3 # EGO
)


if [[ $1 == "rights_only" ]]; then
	for i in "${!users[@]}"; do
		chown -R "${users[$i]}":"${users[$i]}" /home/"${users[$i]}"
		chmod "${home_rights[$i]}" /home/"${users[$i]}"
	done

	echo $(getent passwd EGO)
	echo $(getent group celestials)

	chown EGO:celestials /home/Celestials
	chmod 770 /home/Celestials
	echo "Ownership changed for Celestials"

	mkdir -p /var/run/docker
	chown root:docker /var/run/docker
	chmod 770 /var/run/docker

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

groupadd celestials
usermod -aG celestials EGO
usermod -aG celestials Starlord
echo "Group celestials created and Starlord and EGO added to it"

chown root:celestials /home/Celestials
chmod 770 /home/Celestials
echo "Ownership changed for EGO and /home"

usermod -aG sudo EGO

# yes I know it's ugly. Idc
usermod -aG Rocket Gamora

mkdir -p /var/run/docker
chown root:docker /var/run/docker
chmod 770 /var/run/docker
