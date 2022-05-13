DEVICE=/dev/sdb
VOLUME=MultiBootUSB
 
 
# create filesystem on usb pen
sudo mkfs.vfat -n ${VOLUME} ${DEVICE}1
 
 
# mount usb
mount ${DEVICE}1 /mnt/
 
 
# install grub2 on usb pen
grub-install --no-floppy --root-directory=/mnt ${DEVICE}
 
 
# create grub config
cat <<EOF> /mnt/boot/grub/grub.cfg
menuentry "Ubuntu Live 9.10 32bit" {
 loopback loop /boot/iso/ubuntu-9.10-desktop-i386.iso
 linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=/boot/iso/ubuntu-9.10-desktop-i386.iso noeject noprompt --
 initrd (loop)/casper/initrd.lz
}
 
menuentry "Ubuntu Live 9.10 64bit" {
 loopback loop /boot/iso/ubuntu-9.10-desktop-amd64.iso
 linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=/boot/iso/ubuntu-9.10-desktop-amd64.iso noeject noprompt --
 initrd (loop)/casper/initrd.lz
}
 
menuentry "Grml small 2009.10" {
  loopback loop /boot/iso/grml-small_2009.10.iso
  linux (loop)/boot/grmlsmall/linux26 findiso=/boot/iso/grml-small_2009.10.iso apm=power-off lang=us vga=791 boot=live nomce noeject noprompt --
  initrd (loop)/boot/grmlsmall/initrd.gz
}
 
menuentry "tinycore" {
 loopback loop /boot/iso/tinycore_2.3.1.iso
 linux (loop)/boot/bzImage --
 initrd (loop)/boot/tinycore.gz
}
 
menuentry "Netinstall 32 preseed" {
  loopback loop /boot/iso/mini.iso
  linux (loop)/linux auto url=http://www.panticz.de/pxe/preseed/preseed.seed locale=en_US console-setup/layoutcode=de netcfg/choose_interface=eth0 debconf/priority=critical --
  initrd (loop)/initrd.gz
}
 
menuentry "debian-installer-amd64.iso" {
  loopback loop /boot/iso/debian-installer-amd64.iso
  linux (loop)/linux vga=normal --
  initrd (loop)/initrd.gz
}
 
menuentry "BackTrack 4" {
 linux /boot/bt4/boot/vmlinuz BOOT=casper boot=casper nopersistent rw vga=0x317 --
 initrd /boot/bt4/boot/initrd.gz
}
 
menuentry "Memory test (memtest86+)" {
 linux /boot/img/memtest86+.bin
}
 
menuentry "BackTrack ERR" {
 loopback loop /boot/iso/bt4-pre-final.iso
 linux (loop)/boot/vmlinuz find_iso/filename=/boot/iso/bt4-pre-final.iso BOOT=casper boot=casper nopersistent rw vga=0x317--
 initrd (loop)/boot/initrd.gz
}          
 
menuentry "XBMC ERR" {
 loopback loop /boot/iso/XBMCLive.iso
 linux (loop)/vmlinuz boot=cd isofrom=/dev/sda1/boot/iso/XBMCLive.iso xbmc=nvidia,nodiskmount,tempfs,setvolume loglevel=0 --
 initrd (loop)/initrd0.img
}
 
menuentry "netboot.me ERR" {
 loopback loop /boot/iso/netbootme.iso
 linux (loop)/gpxe.krn
}
 
menuentry "debian installer amd64 netboot XEN pressed" {
  linux /boot/debian/linux auto preseed/url=http://www.panticz.de/pxe/preseed/xen.seed locale=en_US console-setup/layoutcode=de netcfg/choose_interface=eth0 debconf/priority=critical --
  initrd /boot/debian/initrd.gz
}
EOF
 
# create iso directory
mkdir /mnt/boot/iso
 
#
# download images
#
# Ubuntu Live 9.10 32bit
wget http://ftp.uni-kl.de/pub/linux/ubuntu.iso/9.10/ubuntu-9.10-desktop-i386.iso -P /mnt/boot/iso
 
# Ubuntu Live 9.10 64bit
wget http://ftp.uni-kl.de/pub/linux/ubuntu.iso/9.10/ubuntu-9.10-desktop-amd64.iso -P /mnt/boot/iso
 
# grml
wget http://grml.deb.at/grml-small_2009.10.iso -P /mnt/boot/iso
 
# tinycore
wget http://distro.ibiblio.org/pub/linux/distributions/tinycorelinux/2.x/release/tinycore_2.3.1.iso -P /mnt/boot/iso
 
# netinstall
wget http://archive.ubuntu.com/ubuntu/dists/jaunty/main/installer-i386/current/images/netboot/mini.iso -P /mnt/boot/iso
 
# xbmc
# unzip http://downloads.sourceforge.net/sourceforge/xbmc/XBMC_Live-9.04.1.zip
 
# debian
wget http://ftp.debian.org/debian/dists/etch/main/installer-amd64/current/images/netboot/mini.iso -O /mnt/boot/iso/debian-installer-amd64.iso
 
# netboot.me
wget http://static.netboot.me/gpxe/netbootme.iso -P /mnt/boot/iso
 
# umount
sync
umount /mnt/
 
 
 
# test
# debian
wget http://cdimage.debian.org/debian-cd/5.0.2/amd64/iso-cd/debian-502-amd64-netinst.iso
 
 
menuentry "debian-502-amd64-netinst.iso" {
  loopback loop /boot/iso/debian-502-amd64-netinst.iso
  linux (loop)/install.amd/vmlinuz vga=normal --
  initrd (loop)/install.amd/initrd.gz
}
 
menuentry "debian installer amd64 netboot" {
  linux /boot/debian/linux auto=true priority=critical vga=normal --
  initrd /boot/debian/initrd.gz
}
 
# update debian installation files (/mnt/boot/debian/update.sh)
wget http://ftp.de.debian.org/debian/dists/stable/main/installer-amd64/current/images/netboot/debian-installer/amd64/initrd.gz -O initrd.gz
wget http://ftp.de.debian.org/debian/dists/stable/main/installer-amd64/current/images/netboot/debian-installer/amd64/linux -O linux
 
 
 
 
# links
https://bugs.launchpad.net/ubuntu/+bug/94204
http://debianforum.de/forum/viewtopic.php?f=32&t=111249
http://michael-prokop.at/blog/2009/05/25/boot-an-iso-via-grub2/
https://wiki.edubuntu.org/Grub2

