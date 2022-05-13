#!/bin/bash
# 11 Jan 2022 after big backup loss before HD job.
# 10 Feb 2022 added looping over list of arguments.
cd ~/
for path in Writing Configuration Customization scripts .config .local .thunderbird .mozilla Music Documents
do
    echo $path
    rsync -a --update --info=progress2 "solo:$path" .
    echo ""
done
