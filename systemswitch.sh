#!/bin/sh
pushd $HOME/dotfiles/system
sudo nixos-rebuild switch --flake $HOME/dotfiles/system/#Ahmed
popd
