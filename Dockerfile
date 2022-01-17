# REFERENCES
# To view explicitly install packages = pacman -Qe
# To pass yes to a command = yes | pacman -S git
# Setup Yay - https://www.debugpoint.com/2021/01/install-yay-arch/#install-yay-arch
# NOTES
# Maybe enable ssh - https://manjaro.site/enable-ssh-root-login-arch-linux-2017/
# Maybe do nomachine if vnc doesnt work - https://wiki.archlinux.org/title/NoMachine#Installation
# Sunshine is another option for game streaming - https://github.com/loki-47-6F-64/sunshine
# might need to install nvidia too
# maybe grab Glorious Eggroll version of Proton.
# maybe install ProtonUp-Qt - https://davidotek.github.io/protonup-qt/
# Maybe set up flatpak - https://wiki.archlinux.org/title/Flatpak#Installation
# Maybe get Fwupd to update firmware from outside the container somehow
FROM archlinux/archlinux:latest

RUN pacman -Syu --noconfirm

# Setup yay for AUR support
RUN pacman -S base-devel git go sudo --noconfirm
RUN useradd -mu 8877 nonroot &&\
    chown nonroot: /home/nonroot
RUN echo "nonroot ALL=(ALL) NOPASSWD: /usr/bin/pacman" >> /etc/sudoers &&\
    echo "nonroot ALL=(ALL) NOPASSWD: /usr/bin/yay" >> /etc/sudoers
USER nonroot
RUN cd &&\
    git clone https://aur.archlinux.org/yay.git &&\
    cd yay &&\
    makepkg -si --noconfirm
RUN yay -Syu
USER root
RUN cd

# Install KDE
RUN pacman -S plasma-desktop plasma-wayland-session egl-wayland --noconfirm

# Setup remote connection to desktop
# Install and setup VNC - https://wiki.archlinux.org/title/TigerVNC#Installation - https://www.youtube.com/watch?v=w1HS_xVnFFo
#RUN pacman -S tigervnc

# Install and setup SSH
RUN pacman -S openssh && \
    systemctl start sshd && \
    sed -i 's/PermitRootLogin/#\PermitRootLogin/g' /etc/ssh/sshd_config &&\
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config &&\
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config &&\
    systemctl restart sshd
EXPOSE 22

# maybe try to do PipeWire for desktop streaming since it plays nice with wayland. - https://wiki.archlinux.org/title/PipeWire

# Install Steam
# RUN sed -i 's/#\[multilib]/[multilib]/g' /etc/pacman.conf &&\
#     sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist/Include = \/etc\/pacman.d\/mirrorlist/g' /etc/pacman.conf
RUN echo "[multilib]" >> /etc/pacman.conf &&\
    echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
RUN pacman -Syu --noconfirm
RUN pacman -S steam --noconfirm

# Install extra gaming tools
#RUN yay -S mangohud goverlay-bin protonup-qt --noconfirm

# Expose port and entrypoint
#EXPOSE 8080

#Server Start - https://www.educba.com/docker-entrypoint/
#ENTRYPOINT ["/opt/scripts/start.sh"]
