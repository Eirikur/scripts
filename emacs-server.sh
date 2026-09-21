#!/bin/bash
killall emacs || killall -KILL emacs
emacs --daemon
