#!/bin/bash
# set -x
pool="$1"

if [ -z "$pool" ]; then # $1 is empty
    echo "Please specify pool."
    exit 1
fi

echo "Exporting storage pool..."
sudo zpool export "$pool"
echo "Importing storage pool..."
sudo zpool import "$pool"
cd /"$pool"
echo "Finding the top 10 largest files..."
/usr/bin/time -f%E -f%E du -hsx * | sort -rh | head -1
echo "Reading 10GB..."
/usr/bin/time -f%E cat /"$pool"/10GB.dat > /dev/null
echo "Writing 10GB..."
/usr/bin/time -f%E cp ~/10GB.dat /"$pool"/
echo "Done."
echo ""
# ## Onyx as the host.
# # eSATA
# eh@Onyx ~ $ /usr/bin/time -f%E ./scripts/big-compare.sh
# 7:15.26
# 605G	InternalTank
# 7:19.53

# # USB3 no uasp
# 605G	InternalTank
# 7:43.19








# eh@Onyx ~ $ /usr/bin/time -f%E cat /"$pool"/10G.dat > /dev/null
# ^[[A
# 0:44.88
# eh@Onyx ~ $ /usr/bin/time -f%E cat /"$pool"/10G.dat > /dev/null
# 0:44.49
