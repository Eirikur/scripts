#!/bin/bash

find $PWD -iname "*.pdf" -print0 | xargs -0 ls -laht | less
