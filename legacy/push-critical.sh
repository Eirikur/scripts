#!/bin/bash

cd
echo 'Making Thunderbird email archive...'
tar -zcf thunderbird-email.tar.gz .thunderbird
echo 'Making Firefox browser archive...'
tar -zcf firefox.tar.gz .mozilla

rsync -a --links --progress --human-readable thunderbird-email.tar.gz 9185@usw-s009.rsync.net:
rsync -a --links --progress --human-readable firefox.tar.gz 9185@usw-s009.rsync.net:

cd -
