# To view explicitly install packages - pacman -Qe
FROM archlinux/archlinux:latest

RUN pacman -Syu

# Setup yay for AUR support - https://www.debugpoint.com/2021/01/install-yay-arch/#install-yay-arch
RUN yes | pacman -S git
RUN pacman -S base-devel --noconfirm
RUN cd /opt
RUN git clone https://aur.archlinux.org/yay.git
# RUN cd yay
# RUN useradd -m test
# RUN su test
# RUN makepkg -si
# RUN exit
# RUN userdel test
# RUN yay -Syu
# RUN cd

# Install KDE
# RUN pacman -S plasma-desktop
# RUN pacman -S plasma-wayland-session
# RUN pacman -S egl-wayland

# Install and setup VNC - https://wiki.archlinux.org/title/TigerVNC#Installation - https://www.youtube.com/watch?v=w1HS_xVnFFo
#RUN pacman -S tigervnc


# Install Steam/gaming stuff
#RUN pacman -S steam
#RUN yay -S mangohud
#RUN yay -S goverlay-bin



# Maybe enable ssh - https://manjaro.site/enable-ssh-root-login-arch-linux-2017/
# Maybe do nomachine if vnc doesnt work - https://wiki.archlinux.org/title/NoMachine#Installation
# Sunshine is another option for game streaming - https://github.com/loki-47-6F-64/sunshine
# might need to install nvidia too
# maybe grab Glorious Eggroll version of Proton.
# maybe install ProtonUp-Qt - https://davidotek.github.io/protonup-qt/