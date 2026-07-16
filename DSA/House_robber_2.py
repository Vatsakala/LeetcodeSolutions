class Solution:
    def rob(self, nums: List[int]) -> int:
        
        return max(nums[0], self.helper(nums[1:]), self.helper(nums[:-1]))
        #rob 1 , rob2, n , n + 1, n + n
    def helper(self, nums):
        rob1, rob2 = 0, 0

        for n in nums:
            maxrob = max(rob1 + n, rob2)
            rob1 = rob2
            rob2 = maxrob
        return rob2
