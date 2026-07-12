from typing import List
import heapq
from heapq import heappush, heappop
class MedianFinder:

    def __init__(self):
        self.small, self.large = [], [] #heaps #small is amax heap, large is amin heap
        
    def addNum(self, num: int) -> None:
        heapq.heappush(self.small, -1*num)

        #comparing both heaps for max and min
        if (self.small and self.large and (-1*self.small[0]) > self.large[0]):
            val = -1 * heapq.heappop(self.small)
            heapq.heappush(self.large, val)
        
        #comparing uneven sizes
        if len(self.small) > len(self.large) + 1:
            val = -1 * heapq.heappop(self.small)
            heapq.heappush(self.large, val)
        
        if len(self.small) + 1 < len(self.large):
            val = heapq.heappop(self.large)
            heapq.heappush(self.small, -val)

    def findMedian(self) -> float:
        if len(self.small) < len(self.large):
            return self.large[0]
        
        elif len(self.small) > len(self.large):
            return -1 * self.small[0]
        else:
            return (-1* self.small[0] + self.large[0])/ 2
        


# Your MedianFinder object will be instantiated and called as such:
# obj = MedianFinder()
# obj.addNum(num)
# param_2 = obj.findMedian()