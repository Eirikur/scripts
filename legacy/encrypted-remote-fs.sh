#!/bin/bash
# confirm uid and gid using the id command. 1000 appears to be Ubuntu default.
# encfs encrypted dir, clear dir
echo 'birthdaybastille' | encfs ~/.hidden/.encrypted-remote-fs ~/Desktop/eirikur.net
