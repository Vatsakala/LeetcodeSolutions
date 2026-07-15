from typing import List
class Solution:
    def dailyTemperatures(self, temperatures: List[int]) -> List[int]:
        res = [0]*len(temperatures)

        stack = [] #monotonic stack # temp, index
        for i, t in enumerate(temperatures):
            while stack and t > stack[-1][0]:
                stackval, stackint = stack.pop()
                res[stackint] = (i - stackint)
            stack.append([t, i])
        return res