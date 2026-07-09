from git import List


class solution1:
    def missing_number(self, nums: list[int]) -> int:
        res = len(nums)
        for i in range(len(nums)):
            res += i - nums[i]
        return res
    
class Solution2:
    def missingNumber(self, nums: List[int]) -> int:
        res = 0

        for i in range(len(nums) + 1):
            res ^= i

        for num in nums:
            res ^= num

        return res

class solution3:
    def missingNumber(self, nums: List[int]) -> int:
        res = 0

        for i in range(len(nums) + 1):
            res ^= i

        for num in nums:
            res ^= num

        return res
    
"""
Given an array arr[] of size n-1 with distinct integers in the range of [1, n]. This array represents a permutation of the integers from 1 to n with one element missing. Find the missing element in the array.

Examples: 

Input: arr[] = [8, 2, 4, 5, 3, 7, 1]
Output: 6
Explanation: All the numbers from 1 to 8 are present except 6.

Input: arr[] = [1, 2, 3, 5]
Output: 4
Explanation: Here the size of the array is 4, so the range will be [1, 5]. The missing number between 1 to 5 is 4
"""