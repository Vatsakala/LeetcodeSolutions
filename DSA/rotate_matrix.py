from typing import List

class Solution:
    def rotate(self, matrix: List[List[int]]) -> None:
        """
        Do not return anything, modify matrix in-place instead.
        """
        left, right = 0, len(matrix[0]) - 1 # == len(matrix -1) as n*n 
        
        while left < right:

            for i in range(right - left): #here cannot right left, right or somethign because we want a constant number and left, right change every iteration
                top, bottom = left, right
                temp = matrix[top][left + i]

                matrix[top][left + i] = matrix[bottom - i][left]
                matrix[bottom - i][left] = matrix[bottom][right - i]
                matrix[bottom][right - i] = matrix[top + i][right]
                matrix[top + i][right] = temp
            right -= 1
            left +=1