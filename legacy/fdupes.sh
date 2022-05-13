fdupes -rnS . | sed -e 's/^$/B@R@E@A@K/g' | tr '\n' '\0' | sed -e 's/B@R@E@A@K\x00/\n/g' | sort -rn | tr '\0' '\n' | tee fdupes.txt
