#!/usr/bin/bash
pacman -Syu --noconfirm
pacman -S --noconfirm base-devel git go python3 python-pip gpg
gpg --import signkey.asc
pacman-key --add signkey.asc
cp .config/makepkg.conf /etc/makepkg.conf
cd build/pikaur || exit 1
makepkg -sr --sign --noconfirm || exit 1
cd ../../public/arch/x86_64 || exit 1
cp ../../build/pikaur/*.pkg.tar.zst .
cp ../../build/pikaur/*.sig .
exit 0