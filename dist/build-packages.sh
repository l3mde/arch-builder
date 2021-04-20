#!/usr/bin/env bash
mkdir -p ~/.cache/paru
sudo pacman --noconfirm -Syu
for i in $@; do
    paru --useask --noconfirm -S $i
done
find ~/.cache/paru -name '*.pkg.tar.zst' -exec mv '{}' /packages \;
