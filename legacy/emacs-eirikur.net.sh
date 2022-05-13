#!/bin/bash
tar -zvcf ~/emacs.tar.gz ~/.emacs.d ~/.emacs
scp ~/emacs.tar.gz eirikurh@eirikur.net:eirikur.net/

