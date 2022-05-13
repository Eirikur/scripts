#!/bin/bash

path='~/Projects/External/kernel_smb'
mkdir -p "$path"
cd "$path"

git clone https://github.com/namjaejeon/ksmbd-tools.git

git clone https://github.com/namjaejeon/ksmbd.git

git clone https://github.com/smfrench/smb3-kernel.git

