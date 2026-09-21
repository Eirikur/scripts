

sudo apt install -y flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo flatpak install -y flathub org.nicotine_plus.Nicotine

flatpak run org.nicotine_plus.Nicotine



