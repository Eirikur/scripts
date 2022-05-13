#!/bin/bash

if (nslookup argon.local);
then
    argon=1
else
    argon=0
fi

echo argon
