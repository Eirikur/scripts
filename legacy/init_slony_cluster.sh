#!/bin/bash
for config_file in /usr/local/slony/etc/*.conf; do
    filename=`basename $config_file`
    db_name=${filename%%.conf}
    echo "%%%%%% Processing $db_name %%%%%%"
    echo "%%%%%% $db_name: drop node 1... %%%%%%"
    slonik_drop_node --conf=$config_file 1
    echo "%%%%%% $db_name: drop node 2... %%%%%%"
    slonik_drop_node --conf=$config_file 2
    echo "%%%%%% slonik_init_cluster --conf=$config_file | slonik %%%%%%"
    slonik_init_cluster --conf=$config_file | slonik
done

#slonik_init_cluster --conf=

