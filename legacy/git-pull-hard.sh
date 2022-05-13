#!/bin/bash
# David McCarty's "make really sure you have the updates from the server."
set -x
export GIT_SSL_NO_VERIFY=true
git checkout $1
git fetch origin $1
git reset --hard origin/$1



