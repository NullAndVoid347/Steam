# REFERENCES
# To view explicitly install packages = pacman -Qe
# To pass yes to a command = yes | pacman -S git
FROM archlinux/archlinux:latest

RUN pacman -Syu --noconfirm

# Setup yay for AUR support - https://www.debugpoint.com/2021/01/install-yay-arch/#install-yay-arch
RUN pacman -S base-devel git go sudo --noconfirm
RUN useradd -mu 8877 nonroot &&\
    chown nonroot: /home/nonroot
RUN echo "nonroot ALL=(ALL) NOPASSWD: /usr/bin/pacman" >> /etc/sudoers &&\
    echo "nonroot ALL=(ALL) NOPASSWD: /usr/bin/yay" >> /etc/sudoers
USER nonroot
RUN cd &&\
    mkdir something &&\
    git clone https://aur.archlinux.org/yay.git &&\
    cd yay &&\
    makepkg -si --noconfirm
RUN yay -Syu
USER root

# # Install KDE
RUN pacman -S plasma-desktop plasma-wayland-session egl-wayland --noconfirm

# Install and setup VNC - https://wiki.archlinux.org/title/TigerVNC#Installation - https://www.youtube.com/watch?v=w1HS_xVnFFo
#RUN pacman -S tigervnc


# Install Steam/gaming stuff
#RUN pacman -S steam --noconfirm
RUN yay -S steam mangohud goverlay-bin protonup-qt --noconfirm



# Maybe enable ssh - https://manjaro.site/enable-ssh-root-login-arch-linux-2017/
# Maybe do nomachine if vnc doesnt work - https://wiki.archlinux.org/title/NoMachine#Installation
# Sunshine is another option for game streaming - https://github.com/loki-47-6F-64/sunshine
# might need to install nvidia too
# maybe grab Glorious Eggroll version of Proton.
# maybe install ProtonUp-Qt - https://davidotek.github.io/protonup-qt/
# Maybe set up flatpak and get things you normally would get from AUR from flatpak instead
# Maybe get Fwupd to update firmware from outside the container somehow


# ------------------------https://github.com/ich777/docker-novnc-baseimage--------------------------------------------------------
# COPY novnccheck /usr/bin
# RUN chmod 755 /usr/bin/novnccheck

# RUN pacman -Syu  --noconfirm
# RUN pacman -S wget --noconfirm
# RUN cd /tmp &&\
#     wget -O /tmp/novnc.tar.gz https://github.com/novnc/noVNC/archive/v1.2.0.tar.gz &&\
#     tar -xvf /tmp/novnc.tar.gz &&\
#     echo $(ls -1 /tmp/) &&\
#     cd /tmp/noVNC* &&\
#     sed -i 's/credentials: { password: password } });/credentials: { password: password },\n                           wsProtocols: ["'"binary"'"] });/g' app/ui.js
# RUN mkdir -p /usr/share/novnc
# RUN cp -r app /usr/share/novnc/
# RUN cp -r core /usr/share/novnc/
# RUN cp -r utils /usr/share/novnc/
# RUN cp -r vendor /usr/share/novnc/
# RUN cp -r vnc.html /usr/share/novnc/
# RUN cp package.json /usr/share/novnc/
# RUN cd /usr/share/novnc/
# RUN chmod -R 755 /usr/share/novnc
# RUN rm -rf /tmp/noVNC* /tmp/novnc.tar.gz

# RUN pacman -Syu  --noconfirm
# RUN pacman -S xvfb wmctrl x11vnc websockify fluxbox screen libxcomposite-dev libxcursor1 xauth --noconfirm
# RUN sed -i '/    document.title =/c\    document.title = "noVNC";' /usr/share/novnc/app/ui.js
# RUN rm -rf /var/lib/apt/lists/*

# - Need to replace with an Arch source
# RUN cd /tmp
# RUN wget -O /tmp/turbovnc.deb https://sourceforge.net/projects/turbovnc/files/2.2.6/turbovnc_2.2.6_amd64.deb/download
# RUN dpkg -i /tmp/turbovnc.deb
# RUN rm -rf /opt/TurboVNC/java /opt/TurboVNC/README.txt
# RUN cp -R /opt/TurboVNC/* /
# RUN rm -rf /opt/TurboVNC /tmp/turbovnc.deb
# RUN sed -i '/# $enableHTTP = 1;/c\$enableHTTP = 0;' /etc/turbovncserver.conf

# ENV CUSTOM_RES_W=640
# ENV CUSTOM_RES_H=480

# COPY /x11vnc /usr/bin/x11vnc
# RUN chmod 751 /usr/bin/x11vnc
# -------------------------------------------------------------------------------------------------
# ------------------------docker-debian-buster--------------------------------------------------------
# LABEL maintainer="admin@minenet.at"

# RUN export TZ=America/New_York
# RUN pacman -Syu --noconfirm
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
# RUN echo $TZ > /etc/timezone
# RUN ARCH_FRONTEND=noninteractive pacman -S man-db hdparm udev whiptail reportbug init vim-common iproute2 nano gdbm-l10n less iputils-ping netcat-traditional perl bzip2 gettext-base manpages file liblockfile-bin python3-reportbug libnss-systemd isc-dhcp-common systemd-sysv xz-utils perl-modules-5.28 debian-faq wamerican bsdmainutils systemd cpio logrotate traceroute dbus kmod isc-dhcp-client telnet krb5-locales lsof debconf-i18n cron ncurses-term iptables ifupdown procps rsyslog apt-utils netbase pciutils bash-completion vim-tiny groff-base apt-listchanges bind9-host doc-debian libpam-systemd openssh-client xfce4 xorg dbus-x11 sudo gvfs-backends gvfs-common gvfs-fuse gvfs firefox-esr at-spi2-core gpg-agent mousepad xarchiver sylpheed unzip gtk2-engines-pixbuf gnome-themes-standard lxtask xfce4-terminal p7zip unrar curl msttcorefonts gedit zip fonts-vlgothic --noconfirm
# RUN cd /tmp
# RUN wget -O /tmp/theme.tar.gz https://gitlab.manjaro.org/artwork/themes/breath-gtk/-/archive/master/breath-gtk-master.tar.gz
# RUN tar -xvf /tmp/theme.tar.gz
# RUN mv /tmp/breath*/Breath-Dark /usr/share/themes/
# RUN rm -R /tmp/breath*
# RUN rm /tmp/theme.tar.gz
# RUN wget -O /tmp/icons.zip https://github.com/daniruiz/flat-remix/archive/master.zip
# RUN unzip /tmp/icons.zip
# RUN mv /tmp/flat*/Flat-Remix-Green-Dark/ /usr/share/icons/
# RUN rm -R /tmp/flat*
# RUN rm /tmp/icons.zip
# RUN gtk-update-icon-cache -f -t /usr/share/icons/Flat-Remix-Green-Dark/
# RUN cd /usr/share/locale
# RUN wget -O /usr/share/locale/translation.7z https://github.com/ich777/docker-debian-buster/raw/master/translation.7z
# RUN p7zip -d /usr/share/locale/translation.7z
# RUN chmod -R 755 /usr/share/locale/
# RUN rm -rf /var/lib/apt/lists/*
# RUN sed -i '/    document.title =/c\    document.title = "DebianBuster - noVNC";' /usr/share/novnc/app/ui.js
# RUN mkdir /tmp/config
# RUN rm /usr/share/novnc/app/images/icons/*

# ENV DATA_DIR=/arch
# ENV FORCE_UPDATE=""
# ENV CUSTOM_RES_W=1280
# ENV CUSTOM_RES_H=720
# ENV NOVNC_PORT=8080
# ENV RFB_PORT=5900
# ENV X11VNC_PARAMS=""
# ENV UMASK=000
# ENV UID=99
# ENV GID=100
# ENV DATA_PERM=770
# ENV USER="Arch"
# ENV ROOT_PWD="Docker!"
# ENV DEV=""
# ENV USER_LOCALES="en_US.UTF-8 UTF-8"

# RUN mkdir $DATA_DIR
# RUN useradd -d $DATA_DIR -s /bin/bash $USER
# RUN chown -R $USER $DATA_DIR
# RUN ulimit -n 2048

# ADD /scripts/ /opt/scripts/
# COPY /icons/* /usr/share/novnc/app/images/icons/
# COPY /arch.png /usr/share/backgrounds/xfce/
# COPY /config/* /tmp/config/
# RUN chmod -R 770 /opt/scripts/
# RUN chmod -R 770 /tmp/config/

#EXPOSE 8080

#Server Start
#ENTRYPOINT ["/opt/scripts/start.sh"]
# -------------------------------------------------------------------------------------------------
