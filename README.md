# Partitioning with cfdisk then mkfs.... then mount
```bash
mount /dev/sdXI /mnt 
mount /dev/sdXJ /mnt/home
mkfs.fat -F 32 -n boot /dev/sdXK
mount -o umask=077 /dev/sdXK /mnt/boot
mkswap -L swap /dev/sdXL
swapon /dev/sdXL
```
# Clone the repo at your home  
```bash
nix-shell -p nixos.git
git clone https://github.com/pxlman/dotfiles
```
# Make the hardware-configuration.nix
```bash
sudo nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration /path/to/dotfiles
```
# Install the System
```bash
sudo nixos-install --flake /path/to/dotfiles/system/#Ahmed
```
# After logging in the user do
## Build System
```bash
./systemswitch.sh
```
## Build Home
```bash
mkdir -p ~/.config/nvim
cd /path/to/dotfiles/users
stow pxlman -t ~/
./homeswitch.sh
```
# Other things
Install Wallpapers at ~/Pictures/Wallpapers
```bash
git clone https://github.com/antoniosarosi/Wallpapers`
```
