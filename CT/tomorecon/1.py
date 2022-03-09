from PIL import Image
import numpy as np

w, h = 512, 512
#data = np.zeros((h, w, 3), dtype=np.uint8)
#data[256, 256] = [255, 0, 0]
#data = np.zeros((10,10), dtype=np.uint8)
data = np.zeros((10), dtype=np.uint8)
#data[1][1] = 1;

img = Image.fromarray(data)
img.save('my.png')
img.show()

