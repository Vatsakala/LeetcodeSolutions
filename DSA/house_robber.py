class Solution:
    def rob(self, nums: List[int]) -> int:
        # take = max(currmax, n + dfs(n-2))
        # leave = max(currmax,dfs(n - 1))
        #rob1, rob2, n, n + 1 , n+2, n + n
        rob1, rob2 = 0,0
        for n in nums:
            temp = max(n + rob1, rob2)
            rob1 = rob2
            rob2 = temp
        return rob2