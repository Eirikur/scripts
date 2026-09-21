#!/bin/bash

source="$1"

rsync -av "$source:.ssh" .
rsync -av "$source:scripts" .
rsync -av "$source:.profile" .
rsync -av "$source:.bashrc" .
rsync -av "$source:Projects/Pi/Four" .
 
