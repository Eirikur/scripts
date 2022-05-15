#!/bin/bash
# Used by emacs-push.sh
offsite_user='9185'
offsite_host='usw-s009.rsync.net'
offsite_root='eh/'

path="$1"
directory_path="$(dirname $(realpath $1))"
destination="$2"
target_dir="$3"


# unused
# [[ "$@" == *"--progress"* ]]  && progress='--info=progress2'
# [[ "$@" == *"-v"* ]] && v='-v'


if timeout 2 gethostip $destination  >/dev/null; then # server is reachable.
    if [[ "$destination" == "$offsite_host" ]]; then # Offsite host requires username.
        destination="$offsite_user@$offsite_host:eh/${PWD##/home/eh}"; # Offsite has eh dir inside the account root.
    else
        destination="$destination:$directory_path/"
    fi
    if timeout 5 rsync "$path" "$destination" --recursive -haAX --no-i-r --noatime --update --archive \
          --human-readable -e "ssh -T -c aes128-ctr -o Compression=no -x"; then
        exit
    else
        exit 1  
    fi
fi
    
