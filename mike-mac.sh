 function recordCard()
# Record audio from a specific card
# Arg 1: card number
 {
   local cardNum=$1
  local cardDir="/proc/asound/card$cardNum/pcm0c/sub0"
  if [ ! -d $cardDir ]; then
    echo "Uh-oh! $cardDir is not a directory"
    exit 4
  fi
  local hw_paramsFile="$cardDir/hw_params"
  if [ ! -f $hw_paramsFile ]; then
    echo "Uh-oh! $hw_paramsFile is not a file"
    exit 4
  fi

  # try to get rate, num channels and format from the hw_params file, or use defaults
  local rateClause=`grep rate: $cardDir/hw_params | awk '{print $2}'`
  if [ "$verbose" = 2 ]; then
    echo "rate = $rate"
  fi
  if [ ${#rateClause} != 0 ]; then         # a rate was found
    rateClause="-r $rateClause"            # add -r flag
  else
    rateClause="-r 44100"                  # default to 44100 bit sample rate
  fi
  local channelsClause=`grep channels: $hw_paramsFile | awk '{print $2}'`
  if [ "$verbose" = 2 ]; then
    echo "channelsClause = $channelsClause"
  fi
  if [ ${#channelsClause} != 0 ]; then     # number of channels found
    channelsClause="-c $channelsClause"    # add -c flag else default to 1 channel
  fi
  local formatClause=`grep ^format: $hw_paramsFile | awk '{print $2}'`
  if [ "$verbose" = 2 ]; then
    echo "formatClause = $formatClause"
  fi
  if [ ${#formatClause} != 0 ]; then       # format found in hw_params file
    formatClause="-f $formatClause"        # add -f flag
  else
    formatClause="-f S24_LE"               # default to 24 bit format
  fi

  # put the arecord command together and run it
  cmd="arecord $rateClause $channelsClause $formatClause -d $numSecs /tmp/test-mic.wav"
  echo "Testing your microphone for $numSecs seconds - SAY SOMETHING!"
  echo "INFO: running command: $cmd"
  $cmd                                     # run the command
  rc=$?
  if [ "$rc" != 0 ]; then                  # something didn't work
    echo "ERROR: command $cmd failed with $rc"
    exit $rc                               # not successful
  fi
 }                                         # recordCard()
