#!/usr/bin/env bash
mkdir -p ~/.cache/paru
for i in $@; do
    paru --noconfirm -Syu $i
done
find ~/.cache/paru -name '*.pkg.tar.zst' -exec mv '{}' /packages \;
