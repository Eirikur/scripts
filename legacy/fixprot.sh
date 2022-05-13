#!/bin/bash
chown eh:eh $1 --recursive
echo 'chown done'
chmod u+rwx $1 --recursive
echo 'chmod done'
