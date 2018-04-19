#!/bin/bash

nvidia-docker run \
    --rm \
    --name cvpr-${USER} \
    -v /home/rice/cvprclg/data/:/root/data/ \
    -v /home/rice/cvprclg/code/:/root/code/ \
    -ti rice-sol \
    bash
