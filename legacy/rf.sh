#!/bin/bash

/usr/bin/time -f%E rsync -haAX --inplace \
              $1 $2 $3 $4




