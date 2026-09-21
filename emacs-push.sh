#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
if [[ -z "$1" ]]; then
    echo "Usage: emacs-push.sh FILE" >&2
    exit 2
fi

# Colors
red="\u001b[31m"
green="u001b[32m"
green=$'\e[32m'
yellow="\u001b[33m"
blue="\u001b[34m"
reset="\u001b[0m"

full_file_path="$(realpath "$1")" # As Emacs provides it. Quote: paths hold spaces.
# NOTE: this used to run the path through `sed 's/ //g'`, which DELETED spaces
# rather than escaping them -- turning "my notes.txt" into "mynotes.txt" and
# pushing a path that does not exist. Spaces are handled by quoting every
# expansion below, plus rsync -s (--protect-args) so the REMOTE shell does not
# word-split the path either.
target_dir='Emacs_Backups'
offsite_user='de4686'
offsite_host='de4686.rsync.net'
# de4686@de4686.rsync.net


# The trailing colon is load-bearing. Without it rsync treats this as a LOCAL
# destination filename and silently copies the file to ./de4686@de4686.rsync.net
# in the current directory -- and succeeds, so the "Saved on ..." message lies.
offsite="$offsite_user@$offsite_host:"

# Mirror the home tree the way push.sh does (destination_directory=${PWD##/home/}/),
# but derive it from the file itself: Emacs's cwd is not reliably the buffer's
# directory, and using $PWD here would scatter files into the wrong mirror paths.
file_dir="$(dirname "$full_file_path")"

if [[ "$file_dir" != /home/* ]]; then
    status="Not saved to a remote: $file_dir is outside /home."
else
    remote_dir="${file_dir##/home/}/"

    # Free guard, no network: a destination with no colon is a LOCAL path, and
    # rsync would happily "succeed" writing ./de4686@de4686.rsync.net. This is
    # the exact bug that hid here for months.
    if [[ "$offsite" != *:* ]]; then
        echo "emacs-push: BUG - destination '$offsite' has no colon; that is a local path." >&2
        exit 3
    fi

    # --mkpath creates missing remote directories (needs rsync >= 3.2.3; 3.2.7 here).
    if rsync -a -s --mkpath "$full_file_path" "$offsite$remote_dir"; then
        status="Saved on $offsite$remote_dir"

        # Confirm the file really landed on the remote. Costs one extra ssh
        # round-trip (~1s), so set PUSH_VERIFY=0 if Emacs saves feel sluggish.
        if [[ "${PUSH_VERIFY:-1}" != 0 ]]; then
            remote_path="$remote_dir$(basename "$full_file_path")"
            # Single-quote for the REMOTE shell so spaces survive. (rsync -s
            # handles its own args; ssh does not.)
            if ssh -o BatchMode=yes "$offsite_user@$offsite_host" \
                   ls "'$remote_path'" >/dev/null 2>&1; then
                status="$status [verified]"
		exit_status=1
            else
		exit_status=0 
                status="NOT VERIFIED on remote: $white $remote_path"
            fi
        fi
    else
        status="Not saved to a remote (rsync exit $?)."
    fi
fi

# source ~/scripts/ansi.sh
# if [ ${exit_status} -eq 1 ];
# then
#     ansi::red
# else
#     ansi::green
# fi

echo -n   "$status"     
# ansi::resetForeground
### Local save.

date_stamp=$(date +"%A-%b-%d-%Y+%H%M%S.%N")

# A local copy is the fastest recovery point.
# NOTE: mkdir used to build its path from $(pwd) while cp built its path from
# $full_file_path. Those agree only when the cwd happens to be the file's own
# directory, so the copy silently failed whenever Emacs was elsewhere. Both now
# derive from $file_dir.
local_dir="/home/eh/.emacs.d/$target_dir/$file_dir"
mkdir -p "$local_dir"
cp "$full_file_path" "$local_dir/$(basename "$full_file_path").$date_stamp"





