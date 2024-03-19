from typing import Dict, List

from utils.point import Point
from utils.curve import drawBezierCurve 


# Class based implementation from simulate.ipynb


class KeyBoard:

    KEYSLIST = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
    keysPointsDict : Dict[str, Point]  = {}


    def __init__(self, height = 5 ,width = 400, padding = 2 ):

        self.height = height
        self.width = width
        self.padding = padding

        self.initKeyBoard()

    
    def initKeyBoard(self):
        self.WIDTH_OF_KEY =  (self.width - (2 * self.padding)) / len(self.KEYSLIST[0])

        for rowIndex, keys in enumerate(self.KEYSLIST):
            heightOffset = (rowIndex * (self.height + (2 * self.padding))) + (self.height / 2)
            initalWidthOffset = (self.width - (len( keys) * self.WIDTH_OF_KEY)) / 2

            for index, key in enumerate(keys):
                widthOffset = initalWidthOffset + (index * self.WIDTH_OF_KEY) + (self.WIDTH_OF_KEY/2)
                point = Point(widthOffset,heightOffset)

                self.keysPointsDict[key] = point

    
    def addKeyAndReturnText(self, text, key):
        if (len(text) == 0) or text[-1] != key:
            text += key
        
        return text
    

    def addAllKeysNearestToCurve(self, text: str, Bx, By):

        for i in range(len(Bx)):
            key = self.getNearestKeyFromPoint(Point(Bx[i],By[i]))
            text = self.addKeyAndReturnText(text, key)

        return text


    def getNearestKeyFromPoint(self, p : Point):
        rowIndex = int( p.y // (self.height +  (2* self.padding)) )
        rowIndex  = rowIndex if rowIndex >= 0 else 0
        rowIndex  = rowIndex if rowIndex < len(self.KEYSLIST) else -1
        keys = self.KEYSLIST[rowIndex]

        initalWidthOffset = self.padding if rowIndex == 0 else (self.width - self.padding - (len(keys) * self.WIDTH_OF_KEY)) / 2

        x = int((p.x - initalWidthOffset) // self.WIDTH_OF_KEY)
        x = x if x >= 0 else 0
        x = x if x < len(keys) else -1
        key = keys[x]

        return key
    
    
    def simulate(self,  text : str, noise = 1.5 ):
        wordPointsList = []

        for char in text:
            char = char.lower()
            if (char != " "):
                point =  self.keysPointsDict.get(char)
                if point is None:
                    raise Exception("Error  got char :  ",char)
                noised_point =point.getNoisedPoint( noise = noise )
                wordPointsList.append(noised_point)


        
        if ( len(wordPointsList) == 1 ):
           return text[0]

        sim_text = ""
        TOTAL_GESTURE_POINTS = 500
        gesturePointsBetweenTwoChar = TOTAL_GESTURE_POINTS / (len(wordPointsList) - 1)



        for i in range(len( wordPointsList) -1):
            p1 = wordPointsList[i]
            p2 = wordPointsList[ i + 1]
            points = drawBezierCurve(p1, p2, gesturePointsBetweenTwoChar)

            sim_text = self.addAllKeysNearestToCurve(sim_text,points[0], points[1])

        return sim_text


