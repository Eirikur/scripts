#!/bin/bash
# set -x
/usr/bin/time -f%E ~/scripts/big-compare.sh
echo " --- "
/usr/bin/time -f%E ~/scripts/big-compare.sh
echo " --- "
/usr/bin/time -f%E ~/scripts/big-compare.sh



# ## Onyx as the host.
# # eSATA
# eh@Onyx ~ $ time ./scripts/big-compare.sh 
# 7:15.26
# 605G	InternalTank
# 7:19.53

# # USB3 no uasp
# 605G	InternalTank
# 7:43.19








# eh@Onyx ~ $ time cat /syba/10G.dat > /dev/null
# ^[[A
# 0:44.88
# eh@Onyx ~ $ time cat /syba/10G.dat > /dev/null
# 0:44.49
