#!/usr/bin/env python3

from math import pi
import math
import numpy as np


def cordic(beta, n):

    if (beta < -pi/2) or (beta > pi/2):
        if beta < 0:
            v = cordic(beta + pi, n)
        else:
            v = cordic(beta - pi, n)
        return -v

    angles = [math.atan(2**-x) for x in range(n)]
    v = np.array([1, 0])

    power_of_two = 1

    for i, angle in enumerate(angles):
        if beta < 0:
            sigma = -1
        else:
            sigma = 1

        # factor = sigma * power_of_two
        # R = np.array([[1, -factor], [factor, 1]])
        # v = np.matmul(R, v)

        x = v[0] - sigma * (v[1] * power_of_two)
        y = v[1] + sigma * (v[0] * power_of_two)
        beta = beta - sigma * angle

        v = np.array([x, y])

        power_of_two = power_of_two / 2

    # This value is only valid when n > 6

    return v*0.60725293500888


iterations = 20
degs = 190
rads = math.radians(degs)
print([math.cos(rads), math.sin(rads)])
print(cordic(rads, iterations))
