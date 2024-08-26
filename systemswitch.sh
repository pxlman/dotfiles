#!/bin/sh
pushd /home/$USER/dotfiles/system
sudo nixos-rebuild switch --flake /home/$USER/dotfiles/system/#Ahmed
popd
