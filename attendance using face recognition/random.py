import numpy as np

x = np.array([
    1,2,3,4,5,6,7,8,9,10
])

y1 = np.array([
   15,30,45,60,75,90,105,120,135,150
])

weights = [0]
bias = 0

for i in range(1000):
    y2 = np.dot(x,y1)+bias
    dw = (1/10)*np.dot(x.T,(y2-y1))
    db = (1/10)*np.sum(y2-y1)
    weights = weights-0.001*dw
    bias = bias - 0.001*db

print(f'weights  = {weights}')
print(f'bias = {bias}')
 