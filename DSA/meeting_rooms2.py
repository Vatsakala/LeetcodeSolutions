from typing import List
class Interval(object):
    def __init__(self, start, end):
        self.start = start
        self.end = end
class Solution:
    def min_meeting_rooms(self, intervals: List[Interval]) -> int:
            # Write your code here
            count, res = 0, 0
            start = sorted([i.start for i in intervals])
            end = sorted([i.end for i in intervals])
            s, e = 0, 0

            while s < len(intervals):
                if start[s] < end[e]:
                    count += 1
                    s += 1
                else:
                    count -= 1
                    e += 1
                res = max(res, count)
            return res

#one more solution more logical in interview is using min heap to track the end time and if the next meeting start time is greater than the min end time then pop the min end time and push the new end time into the heap. The size of the heap will be the number of meeting rooms required.
import heapq
class Solution2:
    def min_meeting_rooms(self, intervals: List[Interval]) -> int:
        if not intervals:
            return 0

        # Process meetings in order of start time
        intervals.sort(key=lambda interval: interval.start)

        min_heap = []  # end times of currently active meetings
        max_rooms = 0

        for interval in intervals:
            # Remove every meeting that has already ended
            while min_heap and min_heap[0] <= interval.start:
                heapq.heappop(min_heap)

            # Assign a room to the current meeting
            heapq.heappush(min_heap, interval.end)

            # Number of active meetings = rooms currently required
            max_rooms = max(max_rooms, len(min_heap))

        return max_rooms