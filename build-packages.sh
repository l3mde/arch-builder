#!/usr/bin/env bash
paru --noconfirm -Syu $@
find ~/.cache/paru -name '*.pkg.tar.zst' -exec mv '{}' /packages \;
