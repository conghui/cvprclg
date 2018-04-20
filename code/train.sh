#!/bin/bash
set -x
set -e

export THEANO_FLAGS=mode=FAST_RUN,device=gpu,floatX=float32

export PROJ_BASE_PATH="/root"
if [[ $USER == "rice" ]]; then
  export PROJ_BASE_PATH="/home/rice/cvprclg/"
fi

TRAIN_PATH_LIST="
$PROJ_BASE_PATH/data/train/AOI_3_Paris_Train
"
# $PROJ_BASE_PATH/data/train/AOI_2_Vegas_Train
# $PROJ_BASE_PATH/data/train/AOI_3_Paris_Train
# $PROJ_BASE_PATH/data/train/AOI_4_Shanghai_Train
# $PROJ_BASE_PATH/data/train/AOI_5_Khartoum_Train

echo ">>> CLEAN UP" && echo rm -rf $PROJ_BASE_PATH/data/working && rm -rf $PROJ_BASE_PATH/data/working && mkdir -p $PROJ_BASE_PATH/data/working

# rm -rf /home/rice/projects/BuildingDetectors_Round2/1-XD_XD/data/working/*.pkl
# rm -rf /home/rice/projects/BuildingDetectors_Round2/1-XD_XD/data/working/images/v16
# rm -rf /home/rice/projects/BuildingDetectors_Round2/1-XD_XD/data/working/images/v12
# rm -rf /home/rice/projects/BuildingDetectors_Round2/1-XD_XD/data/working/images/

source activate py35

for train_path in $TRAIN_PATH_LIST; do
  echo $train_path
    # echo ">>> PREPROCESSING STEP"
    echo python v5_im.py preproc_train $train_path  && python v5_im.py preproc_train $train_path
    echo python v12_im.py preproc_train $train_path && python v12_im.py preproc_train $train_path
    # echo python v16.py preproc_train $train_path    && python v16.py preproc_train $train_path

    # echo ">>> TRAINING v9s model"
    echo python v9s.py validate $train_path &&  python v9s.py validate $train_path
    echo python v9s.py evalfscore $train_path &&   python v9s.py evalfscore $train_path

    ### v13 --------------
    echo ">>>>>>>>>> v13.py: Training for v13 model"              && python v13.py validate $train_path
    echo ">>>>>>>>>> v13.py: Parametr optimization for v13 model" && python v13.py evalfscore $train_path

    # ### v16 --------------
    # echo ">>>>>>>>>> v16.py Training for v16 model" &&   python v16.py validate $train_path
    # echo ">>>>>>>>>> v16.py Parametr optimization for v16 model" && python v16.py evalfscore $train_path

    # ### v17 --------------
    echo ">>>>>>>>>> v17.py" &&   python v17.py evalfscore $train_path
done
