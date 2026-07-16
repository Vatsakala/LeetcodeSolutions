from typing import List
class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        LIS = [1]* len(nums) #1 becuase thats the max length the final element in the subsequence can have is 1
        #We will iterate from the end of the array to the start of the array and check if the current element is less than any of the elements after it. If it is, we will update the LIS value for that element to be the maximum of its current value and 1 + the LIS value of the element after it. This way, we are building up the LIS values for each element in the array.

        for i in range(len(nums)-1 , -1, -1):
            for j in range(i+1, len(nums)):
                if nums[i] < nums[j]:
                    LIS[i] = max(LIS[i], 1 + LIS[j])
        return max(LIS)