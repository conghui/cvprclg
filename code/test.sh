#!/bin/bash
# set -x
set -e

# export LC_ALL=C.UTF-8
# export LANG=C.UTF-8
export THEANO_FLAGS=mode=FAST_RUN,device=gpu,floatX=float32

export PROJ_BASE_PATH="/root"
if [[ $USER == "rice" ]]; then
  export PROJ_BASE_PATH="/home/rice/cvprclg/"
fi

RESULT=17.csv
TEST_PATH_LIST="
# $PROJ_BASE_PATH/data/train/AOI_3_Paris_Train
"
# $PROJ_BASE_PATH/data/train/AOI_2_Vegas_Train
# $PROJ_BASE_PATH/data/train/AOI_3_Paris_Train
# $PROJ_BASE_PATH/data/train/AOI_4_Shanghai_Train
# $PROJ_BASE_PATH/data/train/AOI_5_Khartoum_Train

# clean up
mkdir -p $PROJ_BASE_PATH/data/output $PROJ_BASE_PATH/data/working
rm -f $PROJ_BASE_PATH/data/working/images/v5/test_AOI_*_im.h5
rm -f $PROJ_BASE_PATH/data/working/images/v5/test_AOI_*_mul.h5
rm -f $PROJ_BASE_PATH/data/working/images/v12/test_AOI_*_mul.h5
rm -f $PROJ_BASE_PATH/data/working/images/v16/test_AOI_*_osm.h5

# source activate /home/rice/softs/install/anaconda3/envs/py35
source activate py35
for test_path in $TEST_PATH_LIST; do
    echo ">>> PREPROCESSING STEP"
    echo ">>>" python v5_im.py preproc_test $test_path  && python v5_im.py preproc_test $test_path
    echo ">>>" python v12_im.py preproc_test $test_path && python v12_im.py preproc_test $test_path
    # echo ">>>" python v16.py preproc_test $test_path    && python v16.py preproc_test $test_path

    echo ">>> INFERENCE STEP"
    echo ">>>" python v17.py testproc $test_path && python v17.py testproc $test_path
done

# Merge infenrece results
echo ">>> MERGE INFERENCE RESULTS"
echo ">>>" python merge.py $TEST_PATH_LIST $RESULT
python merge.py $TEST_PATH_LIST $RESULT
