#!/usr/bin/env bash
sudo /usr/bin/bash -c "${ROOT_CMD}"
/usr/bin/bash -c "${USER_CMD}"
mkdir -p ~/.cache/paru
sudo pacman --noconfirm -Syu
for i in $@; do
    paru --useask --noconfirm -S $i
done
find ~/.cache/paru -name '*.pkg.tar.zst' -exec cp '{}' /packages \;
