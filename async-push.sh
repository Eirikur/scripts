#!/bin/bash
# Used by emacs-push.sh
offsite_user='9185'
offsite_host='usw-s009.rsync.net'
offsite_root='eh/'

path="$1"
directory_path="$(dirname $(realpath $1))"
destination="$2"
target_dir="$3"

report_text=""
good_report="$1.good"
bad_report="$1.bad"
report=""



# unused
# [[ "$@" == *"--progress"* ]]  && progress='--info=progress2'
# [[ "$@" == *"-v"* ]] && v='-v'

if timeout 2 gethostip $destination  >/dev/null; then # server is reachable.
    if [[ "$destination" == "$offsite_host" ]]; then # Offsite host requires username.
        destination="$offsite_user@$offsite_host:eh/${PWD##/home/eh}"; # Offsite has eh dir inside the account root.
    else
        destination="$destination:$directory_path/"
    fi
    if rsync "$path" "$destination" --recursive -haAX --no-i-r --update --archive \
          --human-readable -e "ssh -T -c aes128-ctr -o Compression=no -x"; then
        echo "Successful backup to $destination." > "$report" 
    else
        echo "Failed backup to $destination." >
    fi
else
    # echo "$destination is bad." # For debugging. This is the name-doesn't-resolve case.
    exit 1
fi
