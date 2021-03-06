FROM archlinux:latest
ENV ROOT_CMD="echo root-cmd; whoami"
ENV USER_CMD="echo user-cmd; whoami"
RUN echo "[multilib]" >> /etc/pacman.conf \
&& echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf \
&& pacman --noconfirm -Syu base-devel sudo git cargo \
; pacman --noconfirm -Scc \
&& useradd -m -b /home build \
&& echo 'build ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/build \
&& mkdir /packages \
&& chown build:build /packages
USER build
WORKDIR /home/build
RUN curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/paru.tar.gz \
&& tar -xvzf paru.tar.gz \
&& cd paru \
&& makepkg \
&& sh -c 'find . -name "*.pkg.tar.zst" -exec sudo pacman --noconfirm -U "{}" \;' \
&& rm -rf ~/paru* ~/.cache
VOLUME /packages
COPY ./dist/build-packages.sh /usr/bin/build-packages
ENTRYPOINT ["/usr/bin/build-packages"]
