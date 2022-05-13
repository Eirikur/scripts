# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac



# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# if [ "$color_prompt" = yes ]; then
#     if [[ ${EUID} == 0 ]] ; then
#         PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
#     else
#         PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
#     fi
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
# fi
if [ "$color_prompt" = yes ]; then
    if [[ ${EUID} == 0 ]] ; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi









# [ -f ~/.fzf.bash ] && source ~/.fzf.bash


unset color_prompt force_color_prompt

# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



export TODO_DIR="$HOME/todo"
export TODO_FILE="$TODO_DIR/todo.txt"
export DONE_FILE="$TODO_DIR/done.txt"
export EDITOR="emacsclient-snapshot -nca emacs-snapshot"
export SYSTEMD_PAGER=''
export PATH=~/local/bin:${PATH}
export PATH=~/.local/bin:${PATH}
export PATH=~/local/share/man:${PATH}
export PATH=~/scripts:${PATH}
# export PATH=~/.poetry/bin:${PATH}
# export PATH="$PATH:~/Applications/flutter/bin"
export TERM=xterm-256color # Fix ugly colors in terminals
export GOPATH=$HOME/go
export PATH=~/go/bin:${PATH}

# Bash stuff
set show-all-if-ambiguous on
set completion-ignore-case on

alias in='source ~/.profile'
alias mkfs='mke2fs -t ext4 -vv -cc -b 4096 -J size=40960'
alias mounted='mount | column -t'
alias s=clear
alias cs2=~/coffee/cs2.coffee
alias c=~/scripts/calc.sh
alias emacs='emacsclient-snapshot -nca emacs-snapshot & disown'
alias e='/usr/bin/emacs-snapshot &'
alias ed='/usr/bin/emacs-snapshot --debug-init &'
alias bamboo='xhost +;ssh -X bamboo'
alias f='~/scripts/f.sh'
alias profile=~/coffee/profile.coffee
alias p=~/coffee/profile.coffee
alias swapi='sudo sysctl -w vm.swappiness=10'
alias fixprot=~/scripts/fixprot.sh # chown eh:eh; chmod u:rwx
alias update='sudo ~/scripts/setup.sh' # Perform an update via apt-get
alias bp3=bpython3
alias bp=bpython3
alias bpi='bpython3 -i'
alias mysync=~/scripts/mysync.sh
alias yt='youtube-dl --write-thumbnail --embed-thumbnail --extract-audio  --audio-format mp3 --audio-quality 0 '
alias skb='~/scripts/mysync.sh /home/eh eh@192.168.1.200:'
alias skeleton='ssh -X 192.168.1.200'
alias fa='java -jar ~/Applications/Fantasia-0.9.jar'
alias renet=~/scripts/renet.sh
alias pr='cd /home/eh/Projects/Raspyfex'
alias rn='pacmd set-default-sink 0; cd /home/eh/Projects/RaspyII; ./raspyfex.py --nolaunch'
alias r='pacmd set-default-sink 0; cd /home/eh/Projects/RaspyII; ./raspyfex.py'
alias csync=/home/eh/coffee/csync.coffee
alias basic=~'sudo /scripts/basic.sh'
alias setup='sudo ~/scripts/setup.sh'
alias fetch='~/scripts/fetch.sh'
alias push='~/scripts/push.sh'
alias pull='~/scripts/pull.sh'
alias protfix='sudo chown eh:eh /home/eh --recursive && sudo chmod 0744 /home/eh --recursive'
alias octal="stat -c '%A %a %n'"
alias ns='linuxsampler --lscp-port 9999'
alias ddi=~/scripts/ddimage.sh
alias ddif=~/scripts/ddifast.sh
alias ddit=~/scripts/dditest.sh
alias pib='cd ~/Projects/Pi/pibakery/ && npm start'
alias mount='mount |column -t'
alias backup='~/scripts/backup.sh'
alias used='du -h --summarize'
alias getnode=~/scripts/getnode.sh
alias xb='~/Applications/XCTU-NG/launcher &'
alias four='cd ~/Projects/Pi/Four'
alias pishrink='sudo ~/scripts/pishrink.sh'
alias gradio='/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=gradio de.haeckerfelix.gradio'
alias sys='sudo systemctl -l --no-pager'
alias spindown='~/scripts/spindown.sh'
alias ssh-remove='~/scripts/ssh-remove-key.sh'
alias mm='~/scripts/mm.sh'
alias df='df -h '
alias l='lscp -p 9999'
alias mb='~/scripts/mail-browser-backup.sh'
alias uasp='~/scripts/uasp.sh'
alias grpi='~/scripts/get-raspi-os.sh'
alias red='~/scripts/wake-red.sh'
alias wakez='wakeonlan 1c:c1:de:33:87:5a'
alias g='./go.sh'
alias vpn='~/scripts/vpn.sh'
alias git='git -c http.sslVerify=false'
alias ds='~/scripts/dir-snapshot-backup.sh'
alias pc='~/scripts/push-compressed-dir.sh'
alias pc2='~/scripts/pc2.sh'
alias mytime='/usr/bin/time -f%E'
alias pp='~/scripts/pp.sh'
alias tpull='~/scripts/tpull.sh'
alias empty='rm -rfv ~/.local/share/Trash/*'
alias sw='flatpak run de.haeckerfelix.Shortwave & disown'
alias fx='pactl set-default-sink alsa_output.usb-Burr-Brown_from_TI_USB_Audio_DAC-00.iec958-stereo' # alsa_output.usb-Burr-Brown_from_TI_USB_Audio_DAC-00.analog-stereo'
alias ava='pactl set-default-sink alsa_output.usb-0a12_Avantree_DG60_ABCDEF0123456789-00.analog-stereo && pactl set-default-source alsa_input.usb-0a12_Avantree_DG60_ABCDEF0123456789-00.analog-mono'
alias ng='/usr/local/bin/ng'
alias pulse='echo "Sinks:"; pactl list sinks | grep -i usb | grep Name:; echo "Sources:"; pactl list sources | grep -i usb | grep Name:'
alias argon='ssh -X argon.local'
alias decant=dtrx
alias sq='~/scripts/squish.sh'
alias cc='git log --format=format: --name-only | egrep -v '^$' | sort | uniq -c | sort -rg | head -10'
alias b='git branch'
alias a='git add'
alias cm='git commit -m'
alias co='git checkout'
alias br='git branch -r'
alias st='git status'
alias lo='git log'
alias gc='cd ~/Projects/External && git clone'
alias ph='~/scripts/git-pull-hard.sh'
alias piconf='~/scripts/pi-conf.sh'
alias mk2fs='/usr/bin/time -f%E mke2fs -c -t ext4 -b 4096 -S -FF -O dir_index extent'
alias gsx='~/scripts/gsx-1000.sh'
alias bee='~/scripts/beecaster.sh'
alias ng='~/local/bin/ng'
alias console='sudo systemctl set-default multi-user.target'
alias gui='sudo systemctl set-default graphical.target'
alias listen='~/scripts/listen.sh'
alias fnt='~/scripts/fnt'
alias reaper='~/scripts/reaper.sh'
alias msi='wine start' # .msi installer files.
alias gr='~/scripts/reaper-gsx.sh'
alias it='~/scripts/internalank.sh'
alias wb="udisksctl mount -b /dev/sda1; rsync -a --update ~/.wine/* '/media/eh/Internal Tank/wine-music/' -v"
alias chandler='~/".wine/drive_c/Program Files (x86)/Chandler1.0.3/chandler.exe"'
alias relens='~/Projects/Lens/relens.py'
alias broken='sudo apt-get check && sudo dpkg -l | grep ^..r'
alias aptfb='sudo apt --fix-broken install -y'
alias thunderbird='~/Applications/thunderbird/thunderbird'
alias cups='cupsctl WebInterface=yes ; ~/scripts/chrome-frame.sh http://localhost:631/printers'
alias cockpit='~/scripts/chrome-frame.sh http://localhost:9090'
alias jt='~/Projects/j/senderp.py'
alias j='cd ~/Projects/j'
alias serve='~/scripts/serve.sh'
alias df='echo "Filesystem      Size  Used Avail Use% Mounted on"; df -h | grep /dev/sd --color=never'
alias etcher='~/scripts/etcher.sh'
alias etch='~/scripts/etcher.sh'
alias ff='~/Applications/firefox/firefox & disown'
alias firefox='~/Applications/firefox/firefox & disown'
alias ffde='~/Applications/firefox-developer-edition/firefox/firefox' # Should auto-update.
alias getpdm='curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3 - && pdm --pep582 bash'
alias nu='sudo /usr/bin/com.github.babluboy.nutty'
alias ls='ls -lah'
alias pg='ps -e | grep -i '
alias pe='flatpak run com.github.wwmm.pulseeffects'
alias tgz='~/scripts/tgz.sh'
alias rpush='~/scripts/rpush.sh'
alias rpv='~/scripts/rpv.sh'
alias rr='~/scripts/rr.sh'
alias rrn='~/scripts/rr.sh'
alias rc='ssh 9185@usw-s009.rsync.net'
alias cpr='cp -rauvx'
alias rs='~/scripts/mysync.sh /home/eh 9185@usw-s009.rsync.net:'
alias reaper='~/Applications/reaper_linux_x86_64/REAPER/reaper'
alias rpc='~/scripts/rpc.sh'
alias rpcall='~/scripts/rpcall.sh'
alias rpcd='~/scripts/rpcd.sh'
alias zero='/usr/bin/time -f%E sudo dd if=/dev/zero of=~/__ZEROS__.dat bs=8M status=progress'
alias ssh='ssh -X'
alias silver='ssh -X silver.local'
alias black='ssh -X black.local'
alias z='ssh -X z.local'
alias big='du -hsx * | sort -rh | head -10'
# Maybe remove some columns in iostat....
alias iostat='watch -n 0.5 iostat -xy --human 1 1'
alias gd='gnome-disks'
alias sgd='sudo gnome-disks'
alias mine='sudo chown eh:eh --recursive'
alias rf='~/scripts/rf.sh '
# Fix Firefox search prefs
# sudo rm -rf /usr/lib/firefox
alias fixfox='cp ~/Configuration/firefox/prefs.js ~/.mozilla/firefox/profile/'
alias enshrine='cp ~/.mozilla/firefox/profile/prefs.js ~/Configuration/firefox/'
alias time='/usr/bin/time -f%E'
alias overwrite='sudo apt-get -o Dpkg::Options::="--force-overwrite" install --reinstall'
alias update='~/scripts/update.sh'
# zfs
alias zfs='sudo zfs'
alias zp='sudo zpool'
# halt/reboot/shutdown
alias reboot='sudo sync && sudo reboot'
alias halt='sudo sync && sudo halt'
alias shut='sudo sync && sudo shutdown now'
#
alias aiy='sudo apt install -y'
alias ary='sudo apt remove -y '

# Is this a Broadcom-based Raspberry Pi?
if command -v vcgencmd &> /dev/null
then
    model=$(cat /proc/cpuinfo | grep Model |  cut -d ':' -f 2)
    echo ""
    source ~/scripts/raspi-status.sh
    echo ""
else # Intel case. TODO support others
    model=$(cat /proc/cpuinfo | grep 'model name' | uniq | cut -d ':' -f 2)
fi
model=${model# } # Strip off leading space.

# Still blocks Samba browsing in December 2020
# sudo killall --quiet gvfsd-smb-browse
if command -v numlockx &> /dev/null
then
    numlockx
fi

# gsettings set org.mate.mate-menu hot-key ''
# gsettings set com.solus-project.brisk-menu hot-key ''

# Make capslock be control.
setxkbmap -option ctrl:nocaps -option ‘shift:both_capslock’ &> /dev/null
setxkbmap -option terminate:ctrl_alt_bksp &> /dev/null

xmodmap ~/.Xmodmap &> /dev/null

# xrdb -merge $HOME/.Xresources

# date +"%A %B %e,,,, %k %M" | espeak -v other/en-wm &
mint_version=$(lsb_release -a 2>&1 | grep 'Description:' | cut -f 2)
mint_name=$(lsb_release -a 2>&1 | grep 'Codename:' | cut -f 2)
mint_name=$(echo "${mint_name^}")
if [ -e /etc/upstream-release/lsb-release ]
   then
       ubuntu_name=$(cat /etc/upstream-release/lsb-release | grep DESCRIPTION | cut -d = -f 2 | tr -d '"')
       ubuntu_version=$(cat /etc/upstream-release/lsb-release | grep DISTRIB_RELEASE | cut -d = -f 2 | tr -d '"')
fi

echo "$mint_version $mint_name on $ubuntu_name $ubuntu_version"
uname -srv
echo "$model"
echo ""
free -h
echo ""
di | grep -v tmpfs # no tmpfs
echo ""

# zfs
if command -v zpool &> /dev/null
then
    pools=$(zpool list -o name,size,free)
    if [ "$pools" != "no pools available" ]
    then
        # echo ""
        # echo "$pools"
        zpool iostat
        echo ""
    fi
fi

# Unused disks have no partitions.
# unused=$(~/scripts/disks.sh)
# if [ -z "$unused_disks" ]; then
#     echo 'Unused disks (no partitions):';
#     echo "$unused"
#     echo ""
# fi

echo "$(hostname) $(hostname -I | cut -d ' ' -f 1)"
echo ""
date
