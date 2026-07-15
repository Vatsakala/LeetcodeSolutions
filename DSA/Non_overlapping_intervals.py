from typing import List
class Solution:
    def eraseOverlapIntervals(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda i: i[0])
        
        res = 0
        prevend = intervals[0][1]
        for start, end in intervals[1:]:
            if start >= prevend:
                prevend = end
            else:
                res += 1
                prevend = min(end, prevend)
        return res
