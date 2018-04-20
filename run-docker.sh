#!/bin/bash

nvidia-docker run \
    --rm \
    --name cvpr-${USER} \
    -v ${HOME}/cvprclg/data/:/root/data/ \
    -v ${HOME}/cvprclg/code/:/root/code/ \
    -v ${HOME}/cvprclg/util/visualizer-2.0/:/root/visualizer-2.0/ \
    --workdir=/root/code \
    -ti unetsol \
    ./test.sh
