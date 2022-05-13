#!/bin/bash
# P = progress and partial
rsync -ahP eirikurh@eirikur.net:eh/.bashrc ~/
rsync -ahP eirikurh@eirikur.net:eh/.emacs ~/
rsync -ahP eirikurh@eirikur.net:eh/.Xmodmap ~/
rsync -ahP eirikurh@eirikur.net:eh/emacs/ ~/
rsync -ahP eirikurh@eirikur.net:eh/.emacs.d/ ~/
notify-send "Fetch complete"
echo "Fetch complete."
