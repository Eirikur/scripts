#!/usr/bin/sh
if [ -z "$1" ];
then
du -hs -- * 2>/dev/null | sort -rh | head -n 25
else
du -hs --  $1/* 2>/dev/null | sort -rh | head -n 25
fi
