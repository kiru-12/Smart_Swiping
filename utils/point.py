import numpy as np

class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def getNoisedPoint(self, noise = 1.8):
        return Point( np.random.normal(self.x, noise), np.random.normal(self.y, noise) )



