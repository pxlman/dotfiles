#!/usr/bin/bash

cp -r ~/.config/{nvim/*[^cpptools]} ./nvim/
cp -r ~/.config/{polybar,ranger,bspwm,sxhkd,kitty,picom,zathura} ./.config/
cp -r ~/.conky/conf/{conky-altcoin-monitor,conky-calendar} ./.conky/
cp -r ~/.conky/conky-configure.sh ./.conky
cp -r ~/{.zshrc,.xinitrc,.p10k.zsh} ./
