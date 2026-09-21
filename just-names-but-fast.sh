tree  -d  ../ | grep "^├─"  | tr "[]" "  " | tr -s   | cut -f 1 --complement --delimiter=" "
