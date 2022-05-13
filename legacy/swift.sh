#!/bin/bash
# get swift.org keys into user's keyring
wget -q -O - https://swift.org/keys/all-keys.asc | \
  gpg --import -

# Allow verfiction of signed toolchains
wget -q -O - https://swift.org/keys/automatic-signing-key-3.asc | \
    gpg --import -


