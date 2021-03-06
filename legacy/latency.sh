#!/bin/bash
#
# curl wrapper returning timing information.
#
# curl format adapted by Matthaias Lüdtke, http://www.better-idea.org/
# from http://josephscott.org/archives/2011/10/timing-details-with-curl/
#
# Example usage:
# $ curlt http://www.apple.com
# $ time curlt http://www.apple.com -v
set -e
curl_format='{
"time_namelookup": %{time_namelookup},
"time_connect": %{time_connect},
"time_appconnect": %{time_appconnect},
"time_pretransfer": %{time_pretransfer},
"time_redirect": %{time_redirect},
"time_starttransfer": %{time_starttransfer},
"time_total": %{time_total}
}'
exec curl -Iw "$curl_format" -o /dev/null -s "$@"
