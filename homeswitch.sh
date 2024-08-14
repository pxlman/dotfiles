#!/bin/sh
pushd $HOME/dotfiles/users/$USER
home-manager switch -f $HOME/dotfiles/users/$USER/.config/home-manager/home.nix
popd
