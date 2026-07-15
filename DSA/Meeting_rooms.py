from typing import (
    List,
)


# """
class Interval(object):
    def __init__(self, start, end):
        self.start = start
        self.end = end
# """

class Solution:
    """
    @param intervals: an array of meeting time intervals
    @return: if a person could attend all meetings
    """
    def can_attend_meetings(self, intervals: List[Interval]) -> bool:
        # Write your code here
        intervals.sort(key = lambda i: i.start)
         # could be done like this aswell
        """
         prev = intervals[0]
         for interval in intervals[1:]:
                if prev.end > interval.start:
                    return False
                prev = interval
            return True
        """
        for i in range (1,len(intervals)):
            i1 = intervals[i - 1]
            i2 = intervals[i]

            if i1.end > i2.start:
                return False
        return True

