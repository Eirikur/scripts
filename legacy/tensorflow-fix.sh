#!/bin/bash
version=1.5 # Currently the good version that works without an AVX CPU.

if ! python3 -c 'import tensorflow as tf;'; then # Tensorflow crashed on import. We don't have AVX, most likely.
    echo "Tensorflow crashes on import. Installing $version."
    sudo pip uninstall tensorflow
    sudo pip install tensorflow==$version
else
    echo "Tensorflow import succeeded."
fi
    



