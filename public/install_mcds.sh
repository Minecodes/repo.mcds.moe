#!/usr/bin/bash
if [ "$EUID" -ne 0 ]
	then echo "Please run as root or using sudo"
	exit
fi

pacman-key --init
pacman-key --recv-keys 6E2ED1AF080C73ABDD7031C5A81F296D72A1530A --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 6E2ED1AF080C73ABDD7031C5A81F296D72A1530A

echo -e "[mcds]\nServer = https://repo.mcds.moe/arch/$(uname -m)" | tee -a /etc/pacman.conf
pacman -Sy
pacman -S --noconfirm mcds-keyring
pacman-key --populate mcds
