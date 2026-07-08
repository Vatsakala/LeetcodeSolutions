from typing import List

class Solution:
    def maxProduct(self, nums: List[int]) -> int:
        res = max(nums)
        curmin, curmax = 1, 1

        for n in nums:
            if n == 0:
                curmin, curmax = 1, 1
                continue
            tmp = n * curmax
            curmax = max(n*curmax, n*curmin, n)
            curmin = min(tmp, n*curmin, n)
            res = max(res, curmax)
        return res
    
"""
152. Maximum Product Subarray
Solved
Medium
Topics
Companies
Given an integer array nums, find the contiguous subarray within an array (containing at least one number) which has the largest product and return the product.

The test cases are generated so that the answer will fit in a 32-bit integer.

 

Example 1:

Input: nums = [2,3,-2,4]
Output: 6
Explanation: [2,3] has the largest product 6.
Example 2:

Input: nums = [-2,0,-1]
Output: 0
Explanation: The result cannot be 2, because [-2,-1] is not a contiguous subarray.
 

Constraints:

1 <= nums.length <= 2 * 104
-10 <= nums[i] <= 10
 

Follow up: If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.
"""