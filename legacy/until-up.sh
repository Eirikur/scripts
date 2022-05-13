#!/bin/bash
host="$1"

if not ping -c1 "$host";

until ping -c1 silver.local;
do
    echo$status
    sleep 1
done
