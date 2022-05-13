#!/bin/bash
mke2fs -t ext4 -vv -cc -b 4096 -O dir_index, extent, filetype, flex_bg, has_journal, large_file, uninit_bg -G 16
