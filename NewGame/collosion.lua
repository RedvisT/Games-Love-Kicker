function AABB(x1, y1, w1, h1, x2, y2, raduis)
    return  x1 < x2 + raduis and
            x1 + w1 > x2 and
            y1 < y2 + raduis and
            y1 + h1 > y2

end