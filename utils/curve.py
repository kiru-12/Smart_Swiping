import numpy as np
from utils.point import Point

def drawBezierCurve( p1 : Point, p2 : Point)  :
    x_diff = abs(p1.x - p2.x)
    y_diff = abs(p1.y - p2.y)

    x_min = min(p1.x, p2.x)
    y_min = min(p1.y, p2.y)

    P2 =  Point(x_min + (np.random.rand(1)[0] * x_diff),y_min + (np.random.rand(1)[0] * y_diff))
    P3 = Point(x_min + (np.random.rand(1)[0] * x_diff),y_min + (np.random.rand(1)[0] * y_diff))

    t = np.linspace(0, 1, 100)

    Bx = (1 - t)**3 * p1.x + 3 * t * (1 - t)**2 * P2.x + 3 * t**2 * (1 - t) * P3.x + t**3 * p2.x
    By = (1 - t)**3 * p1.y + 3 * t * (1 - t)**2 * P2.y + 3 * t**2 * (1 - t) * P3.y + t**3 * p2.y

    return (Bx, By)