x#!/bin/bash
# 11 May 2022 Now looping and trying to wake local machines.
# 11 Jan 2022 after big backup loss before HD job.
# 10 Feb 2022 added looping over list of arguments.
offsite_user='9185'
offsite_host='usw-s009.rsync.net'
server_list="onyx.local z.local tma-1.local $offsite_host"
servers=($server_list)
target_list='/home/eh/Archives /syba/Archives /home/eh/Archives'
targets=($target_list)

for path in "$@"
do
    echo "Backing up $path"
    file="$path"
    file="${file#.}" # Somehow strips a leading period.
    file=$(echo "$file" | sed 's:/*$::') # Strip trailing slash.
    archive="$file.tgz"

    size=$(du -sh "$path" | cut -f1)
    echo "$path  $size"
    /usr/bin/time -f%E tar -cf - "$path" | zstd --adapt --rsyncable  | ssh onyx.local "zstd -d -s 1M -m 32M | tar -xvf"
    size=$(du -h "$archive" | cut -f1)
    echo "Archive done. Size: $size"

    for ((index=0; index<${#servers[@]}; ++index)); do
        server="${servers[index]}"
        target_dir="${targets[index]}"
        if [[ "$server" == *".local"* ]]; then # It's on our LAN.
            if ! timeout 2 gethostip &>/dev/null $server; then
            if ! ~/scripts/wake.sh "$server"; then continue; fi
            fi
        fi

        if [[ "$destination" == "$offsite_host" ]]; then # Offsite host requires username.
            destination="$offsite_user@$offsite_host}";
        fi


        /usr/bin/time -f%E rsync --no-i-r --times --update \
                      --archive --human-readable --info=progress2 "$archive" \
                      $path "$server:$target_dir"



    done
done
