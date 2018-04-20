#!/bin/bash

job=train
nvidia-docker run \
    --rm \
    --name shanghai-${job}-${USER} \
    -v ${HOME}/cvprclg/data/:/root/data/ \
    -v ${HOME}/cvprclg/code/:/root/code/ \
    -v ${HOME}/cvprclg/util/visualizer-2.0/:/root/visualizer-2.0/ \
    --workdir=/root/code \
    -t unetsol \
    ./${job}.sh
