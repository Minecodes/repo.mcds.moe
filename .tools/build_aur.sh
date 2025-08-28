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

gpg --import signkey.asc
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


echo "Building shortcuts..."
cd build/shortcuts || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building vmchamp..."
cd build/vmchamp || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building mods..."
cd build/mods || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building charm-pop..."
cd build/charm-pop || exit 1
sed -i 's/charm-pop-bin/charm-pop/g' PKGBUILD
sudo -u builder makepkg --printsrcinfo > .SRCINFO
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building mcds-keyring..."
cd build/mcds-keyring || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cp mcds.gpg /build/public/ || exit 1
cd /build || exit 1


echo "Building paru..."
cd build/paru || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building google-chrome..."
cd build/google-chrome || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building zoom..."
cd build/zoom || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building minecraft-launcher..."
cd build/minecraft-launcher || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building yay..."
cd build/yay || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building informant..."
cd build/informant || exit 1
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building floorp..."
cd build/floorp || exit 1
sed -i 's/-bin//g' PKGBUILD
sudo -u builder makepkg --printsrcinfo > .SRCINFO
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building ventoy..."
cd build/ventoy || exit 1
sed -i 's/-bin//g' PKGBUILD
sudo -u builder makepkg --printsrcinfo > .SRCINFO
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


echo "Building zen-browser..."
cd build/zen-browser || exit 1
sed -i 's/-bin//g' PKGBUILD
sudo -u builder makepkg --printsrcinfo > SRCINFO
sudo -u builder makepkg -sr --sign --noconfirm || exit 1
cd /build || exit 1


ls -al /build/build/partial/
python3 /build/.tools/sort.py


echo "Generating package index..."
cd /build/public/arch/x86_64 || exit 1
repo-add --verify --sign mcds.db.tar.gz *.pkg.tar.zst
cd /build/public/arch/any || exit 1
repo-add --verify --sign mcds.db.tar.gz *.pkg.tar.zst


python3 /build/.tools/genPage.py
exit 0
