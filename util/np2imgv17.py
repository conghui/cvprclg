#!/usr/bin/env python

import numpy as np
from skimage.io import imsave
import pandas as pd
from pathlib import Path

# for MODEL v17
IMG_LIST_FN = '/home/rice/cvprclg/data/working/images/v5/AOI_3_Paris_test_ImageId.csv'
NUMPY_FILE  = '/home/rice/cvprclg/data/working/models/v17/AOI_3_Paris_poly.npy'
PNG_DIR     = '/home/rice/cvprclg/data/working/models/v17/AOI_3_Paris_test_png_v17'

# assert the OUTPUT_DIR exists
if not Path(PNG_DIR).exists():
  Path(PNG_DIR).mkdir(parents=True)

# read image list and numpy array
image_list = pd.read_csv(IMG_LIST_FN, index_col='ImageId').index.tolist()
image_array = np.load(NUMPY_FILE)

print('# of files in image_list: ', len(image_list))
print('# of array in numpy array: ', image_array.shape[0])

if len(image_list) != image_array.shape[0]:
  print('# of files in %s != # of images in %s' % (IMG_LIST_FN, NUMPY_FILE))

# write png file
for idx in range(len(image_list)):
  png_fn = PNG_DIR + '/' + image_list[idx] + '.png'
  imsave(png_fn, image_array[idx])
  print('png written to ', png_fn)

