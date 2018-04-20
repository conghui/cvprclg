#!/bin/bash

nvidia-docker run \
    --rm \
    --name cvpr-${USER} \
    -v /home/rice/cvprclg/data/:/root/data/ \
    -v /home/rice/cvprclg/code/:/root/code/ \
    -v /home/rice/cvprclg/util/visualizer-2.0/:/root/visualizer-2.0/ \
    -ti rice-sol \
    bash
