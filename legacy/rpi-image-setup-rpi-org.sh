#! /usr/bin/env bash
 
# ---------------------------------- METADATA ----------------------------------
scriptname=$(basename "$0")
version="1.0.0"
author="Till Neuhaus"
description="This script downloads and verifies the actual \"Raspbian Lite\" image from \"raspberrypi.org\" and then writes it to a hotplug-device of your choice."
license_short="AGPL3+"
license_long="GNU Affero General Public License (https://www.gnu.org/licenses/agpl.html)"
 
# ---------------------------------- VARIABLES ---------------------------------
working_directory="/tmp/downloads/raspbian_lite"
 
image_download_page="https://www.raspberrypi.org/downloads/raspbian/"
image_file_url="https://downloads.raspberrypi.org/raspbian_lite_latest"
image_archive_file="raspbian_lite_latest.zip"
 
mountpoint="/media/rpi-sd-card"
boot_partition="${mountpoint}/boot"
rootfs_partition="${mountpoint}/rootfs"
 
distupgrade_script="https://kryptopraxis.de/code/bash/distupgrade.sh"
 
# -------------------------------DIALOG-FUNCTIONS-------------------------------
backtitle="$scriptname - v${version} by ${author}, licensed under $license_short"
 
# man dialog -> https://www.systutorials.com/docs/linux/man/1-dialog/
# Help in german -> http://openbook.rheinwerk-verlag.de/shell_programmierung/shell_007_007.htm
 
# Show infotext while waiting for a command to get done
dialog_infobox()
{
	dialog  --backtitle "$backtitle" \
            --title "$1" \
			--infobox "$2" \
			${3:-0} ${4:-0} # height width
}
 
# Send a message to creature
dialog_msgbox()
{
	dialog  --backtitle "$backtitle" \
            --title "$1" \
			--msgbox "$2" \
			${3:-0} ${4:-0} # height width
}
 
# Ask the creature a yes/no question
dialog_yesno()
{
	dialog  --backtitle "$backtitle" \
            --title "$1" \
			--yesno "$2" \
			${3:-0} ${4:-0} # height width
}
 
 # Ask the creature for input
dialog_inputbox()
{
	dialog	--stdout \
			--backtitle "$backtitle" \
            --title "$1" \
			--inputbox "$2" \
			${3:-0} ${4:-0} # height width
}
 
#  Ask the creature for a password
dialog_passwordbox()
{
	dialog  --stdout \
			--backtitle "$backtitle" \
            --title "$1" \
			--passwordbox "$2" \
			${3:-0} ${4:-0} # height width
}
 
# ------------------------------ OTHER FUNCTIONS -------------------------------
 
# Gather the actual checksum from https://www.raspberrypi.org/downloads/raspbian/
get_checksum_web()
{
	checksum_web=$(curl -s ${image_download_page} | \
				   grep -A 15 "<h3>Raspbian Stretch Lite</h3>" | \
				   grep "SHA")
	checksum_web=${checksum_web##*<strong>}
	checksum_web=${checksum_web%%</strong>*}
	checksum_web="${checksum_web}  ${working_directory}/${image_archive_file}"
}
 
# Calculate the checksum of a local archive file
get_checksum_file()
{
	dialog_infobox "Checksum" "Calculating the checksum of the local archive, please be patient..."
	checksum_file=$(sha256sum "${working_directory}/${image_archive_file}")
}
 
# Download the actual archive file, then calculate its checksum and then compare the calculated checksum with the one given on the download-page.
download_archive()
{
	dialog_infobox "Download" "Downloading archive in background; please be patient..."
	wget -q -O "${working_directory}/${image_archive_file}" ${image_file_url}
	get_checksum_file
	if [[ ! "${checksum_web}" = "${checksum_file}" ]]
		then
			dialog_msgbox "Download" "Something went wrong! The checksums of the downloaded file and the one of the download-page don't match each other.\nThis can have several reasons:\n1.) This script has a a bug.\n2.) The file was corrupted during the download.\n3.) The file from the download page and it's checksum given on the page differ.\n4.) Anything else.\nIn each case: Try again later and contact the script-author or the webadmin of raspberrypi.org if the problem persists."
			clear && exit 1
	fi
}
 
# Credits to "geirha" from #bash on freenode.org who helped me getting the lsblk-output into an array for radiolist
get_targetdevice()
{
	unset hotpluglist
	hotpluglist=( "-?-" "rescan devices" on )
	while read -r hotplug name size description
	do
		if [[ $hotplug = 1 && $name = sd? ]] # TODO: Or "mmcblk#"
		then hotpluglist+=( "$name" "$description with ${size}byte" off )
		fi
	done < <(lsblk -nlo HOTPLUG,NAME,SIZE,VENDOR,MODEL)
	targetdevice=$(dialog 	--stdout \
							--backtitle "${backtitle}" \
							--title "Target-Device" \
							--radiolist "On wich device do you want the image to be written?" 0 0 5 "${hotpluglist[@]}")
	if [[ "$targetdevice" = "-?-" ]]
	  then
	    get_targetdevice
	fi
}
 
mount_partitions()
{
	mkdir -p "$boot_partition" "$rootfs_partition"
	mount /dev/${targetdevice}1 "$boot_partition"
	mount /dev/${targetdevice}2 "$rootfs_partition"
}
 
# Add WiFi/WLAN
# For more information see: https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md
add_wifi()
{
	wireless_network_ssid=$(dialog_inputbox "WiFi" "Please give a valid SSID:")
	wireless_network_password=$(dialog_passwordbox "WiFi" "Please enter the according WiFi/WLAN-password (leave empty for open networks like 'Freifunk')")
	if [[ -z "$wireless_network_password" ]]
		then
			echo >> "$rootfs_partition/etc/wpa_supplicant/wpa_supplicant.conf"
			echo "network={" >> "$rootfs_partition/etc/wpa_supplicant/wpa_supplicant.conf"
			echo "    ssid=\"$wireless_network_ssid\"" >> "$rootfs_partition/etc/wpa_supplicant/wpa_supplicant.conf"
			echo "    key_mgmt=NONE" >> "$rootfs_partition/etc/wpa_supplicant/wpa_supplicant.conf"
			echo "}" >> "$rootfs_partition/etc/wpa_supplicant/wpa_supplicant.conf"
		else
			wpa_passphrase "$wireless_network_ssid" "$wireless_network_password" >> "$rootfs_partition/etc/wpa_supplicant/wpa_supplicant.conf"
	fi
	dialog_yesno "WiFi" "Do you want to set up an additional WiFi connection?"
	if [[ $? -eq 0 ]]
		then # YES
			add_wifi
	fi
}
 
# Disable Password Authentication
ssh_disable_password_authentication()
{
	dialog_yesno "SSH-Keys" "Do you want to disable password authentication (recommended)?"
	if [[ $? -eq 0 ]]
		then
			sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" "${rootfs_partition}/etc/ssh/sshd_config"
	fi
}
 
# Force sshd to only serve the ssh_host_ed25519_key
ssh_force_ed25519_cert()
{
	dialog_yesno "SSH-Key" "Do you want to force sshd to only serve the ssh_host_ed25519_key (recommended)?"
	if [[ $? -eq 0 ]]
		then
			sed -i "s/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/" "${rootfs_partition}/etc/ssh/sshd_config"
	fi
}
 
# Add local ssh-keys to account 'pi'
{
	dialog_yesno "SSH-Keys" "Do you want to add all local ssh-keys to the 'authorised keys'-file of 'pi' on raspbian?"
	if [[ $? -eq 0 ]]
		then
			mkdir "$rootfs_partition"/home/pi/.ssh/
			cat /home/*/.ssh/*.pub > "$rootfs_partition"/home/pi/.ssh/authorized_keys
			ssh_disable_password_authentication
			ssh_force_ed25519_cert
	fi
}
 
# End
end()
{
	dialog_msgbox "Happy End" "Congratulations!\nYou're done!"
	clear && exit
}
 
# ---------------------------------- CODE -----------------------------------
 
# Introduction
dialog_msgbox "Introduction" "$description"
 
# Check if the script is run with administrative privileges and exit if not
if [[ $EUID -ne 0 ]]
	then
		dialog_msgbox "Privileges" "In order to write an image to a device, this script must be executed with administrative privileges.\n\nPlease try\n\"sudo ${0}\"" 12 65
		clear && exit 1
fi
 
# Check if the working directory is missing - and create it if so.
if [ ! -d ${working_directory} ]
then
	mkdir -p "${working_directory}"
fi
 
get_checksum_web
# dialog_msgbox "The actual checksum from the download-page is:\n\n${checksum_web%%\ *}" 0 0
 
# Check if there is already an existing archive in the working directory.
# If so: Check if the calculated checksum of the local archive matches with "checksum_web".
# If they match: skip the download, else download and verify download.
if [[ -f "${working_directory}/${image_archive_file}" ]]
	then
		get_checksum_file
		if [[ "${checksum_web}" = "${checksum_file}" ]]
			then
				dialog_msgbox "Download" "An archive file already exists in the working directory whose checksum matches the checksum of the website. Download will be skipped."
			else
				dialog_msgbox "Download" "An archive file already exists in the working directory, but its checksum does not match the checksum of the website.\n\nThe local archive will now be renamed to \"${image_archive_file}.old\" before downloading the new archive."
				mv "${working_directory}/${image_archive_file}" "${working_directory}/${image_archive_file}.old"
				download_archive
		fi
	else
		download_archive
fi
 
# Get the filename of the image from the archive
image=$(unzip -l "${working_directory}/${image_archive_file}" | grep img | tr -s ' ' | cut -d ' ' -f4)
 
# Check if there is already an extracted imagefile in the working directory.
# If so: skip extracting the file again.
# Else: extract file.
if [ -f  "${working_directory}/${image}" ]
	then
		dialog_msgbox "Unzip" "The imagefile of the local archive is already extracted. Skipping to unzip again."
	else
		dialog_infobox "Unzip" "The imagefile of the local archive will now be extracted; please be patient..."
		unzip -qqo "${working_directory}/${image_archive_file}" -d "${working_directory}"
fi
 
# Ask the creature to connect the MicroSD-Card of his Raspberry Pi to this computer.
dialog_msgbox "Target-Device" "Now please connect the (Micro)SD-Card of your Raspberry Pi to this computer.\n\nHit \"OK\" when ready."
 
get_targetdevice
if [[ -z "$targetdevice" ]]
    then
      dialog_infobox "Target-Device" "Script cancelled"
      exit
fi
 
# Security question
dialog_yesno "ATTENTION" "Do you really want to write the image to ${targetdevice}? Data on device will be overwritten without further promting (be cautious here)!"
antwort=${?}
 
if [[ "$antwort" -eq 255 ]]
	then
		dialog_infobox "Target-Device" "Script cancelled"
		exit 255
	elif [[ "$antwort" -eq 1 ]]
		then
    		get_targetdevice
	elif [[ "$antwort" -eq 0 ]]
		then
    		dialog_infobox "Writing" "The image is now written to the media. Please be patient..."
    		dd bs=4M if="${working_directory}/${image}" of="/dev/${targetdevice}" conv=fsync
fi
 
dialog_yesno "Options" "Your (Micro)SDcard is ready to use now.\nDo you want to configure additional options like Updates, SSH-server, WiFi, etc. before unmounting?"
if [[ $? -ne 0 ]]
	then
		end
fi
 
# ----------------------------------- OPTIONS ----------------------------------
 
mount_partitions
 
dialog_yesno "Auto-Updates" "Do you want to enable daily dist-upgrades (cronjob)?"
if [[ $? -eq 0 ]]
	then
		wget --quiet \
			--output-document="${rootfs_partition}/etc/cron.daily/${distupgrade_script##*/}" \
			"$distupgrade_script"
		chmod +x "${rootfs_partition}/etc/cron.daily/${distupgrade_script##*/}"
fi
 
# Optional: Change hostname
dialog_yesno "Hostname" "Do you want to change the hostname (default: 'raspberrypi')? "
if [[ $? -eq 0 ]]
	then
		hostname=$(dialog_inputbox "Hostname" "Please enter desired hostname (small letters, numbers, no spaces): ")
		sed -i "s/raspberrypi/$hostname/g" "${rootfs_partition}/etc/hostname" "${rootfs_partition}/etc/hosts"
fi
 
# Optional: enable sshd on startup
dialog_yesno "SSH-Server" "Do you want to enable the SSH-Server on startup?"
if [[ $? -eq 0 ]]
	then
		touch "${boot_partition}/ssh"
		add_ssh_keys
fi
 
# Optional: Add WiFi
dialog_yesno "WiFi" "Do you want to configure WiFi now?"
if [[ $? -eq 0 ]]
	then
		add_wifi
fi
 
show_results()
{
	clear
	echo "Auto-Updates:"
	ls -l "${rootfs_partition}/etc/cron.daily/${distupgrade_script##*/}"
	echo
	echo "Correct Hostname:"
	echo "/etc/hostname:"
	cat "${rootfs_partition}/etc/hostname"
	echo
	echo "/etc/hosts:"
	cat "${rootfs_partition}/etc/hosts"
	echo
	echo "ssh-startup:"
	ls "${boot_partition}/ssh"
	echo
	echo "SSH-Keys:"
	cat "${rootfs_partition}/home/pi/.ssh/authorized_keys"
	echo
	echo "SSH-Password-Authentication:"
	grep PasswordAuthentication "${rootfs_partition}/etc/ssh/sshd_config"
	echo
	echo "SSH-ED25519-Key:"
	grep ssh_host_ed25519_key "${rootfs_partition}/etc/ssh/sshd_config"
	echo
	echo "WiFi-Setup:"
	cat "$rootfs_partition/etc/wpa_supplicant/wpa_supplicant.conf"
	echo
	read -p "Hit Enter to continue "
}
 
# show_results
 
dialog_yesno "Happy End" "Unmount device now?"
if [[ $? -eq 0 ]]
	then
		umount "$boot_partition" "$rootfs_partition"
		rm -r "$mountpoint"
fi
 
end

