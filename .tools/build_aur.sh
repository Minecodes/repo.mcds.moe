#!/usr/bin/bash
echo "Updating system..."
pacman -Syu --noconfirm
echo "Installing dependencies..."
pacman -S --noconfirm base-devel git go python3 python-pip gpgme sudo || exit 1


useradd -m -G wheel -s /bin/bash builder
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chown -R builder:builder /home/builder
chown builder:builder signkey.asc
chown -R builder:builder /build/build
chown -R builder:builder /build/build/*

sudo -u builder gpg --import signkey.asc
pacman-key --add signkey.asc
cp .config/makepkg.conf /etc/makepkg.conf


echo "Building pikaur..."
cd build/pikaur || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building lopriv..."
cd build/lopriv || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building rbcat..."
cd build/rbcat || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building shortcuts-bin..."
cd build/shortcuts-bin || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


ls -al /build/build/partial/
python3 /build/.tools/sort.py

echo "Generating package index..."
cd /build/public/arch/x86_64 || exit 1
repo-add --verify --sign mcds.db.tar.gz *.pkg.tar.zst

python3 /build/.tools/genPage.py
exit 0