# CCV SWT wrapper for Python

This is a wrapper for libccv's SWT realization for use in Python.
<br/>Based on http://zablo.net/blog/post/stroke-width-transform-swt-python


## Build

1. First you need:
	- swig
	- libjpeg
	- gcc
	- python 2.7
1. Clone libccv
	```bash
	git clone https://github.com/liuliu/ccv
	```
1. Put _ccvswt.*_ files into _ccv/lib_ folder
1. Build wrapper
	```bash
	./ccvswt.sh
	```
1. Copy _ccvswt_ dir into your project

## Use

```python
from ccvswt.ccvswt import swt
import cv2
import numpy as np
import urllib

def get_swt(img_data):
    image = cv2.imdecode(np.fromstring(img_data, dtype=np.uint8), cv2.IMREAD_UNCHANGED)
    swt_result_raw = swt(img_data, len(img_data), image.shape[0], image.shape[1])
    swt_result = np.reshape(swt_result_raw, (len(swt_result_raw) / 4, 4))
    return swt_result

response = urllib.urlopen('http://image.url')
img_data = response.read()
result = swt(img_data)
print('{}'.format(result))
```