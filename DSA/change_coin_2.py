from typing import List

#brute force solution
class Solution1:
    def change(self, amount: int, coins: List[int]) -> int:
        def dfs(i: int, remaining: int) -> int:
            # We successfully formed the amount. 
            # this means that if we reach reaming 0 , we found a valid combination of coins that sum up to the target amount.
            if remaining == 0:
                return 1

            # This path cannot form the amount.
            if remaining < 0 or i == len(coins):
                return 0

            # Choice 1: take coins[i].
            # Stay at i because this coin can be reused.
            take = dfs(i, remaining - coins[i])

            # Choice 2: skip coins[i].
            # Move to the next denomination.
            skip = dfs(i + 1, remaining)

            return take + skip

        return dfs(0, amount)

# optimized solution needcode 3 hr 2d dp series 
class Solution:
    def change(self, amount: int, coins: List[int]) -> int:
        cache = {}

        def dfs(i, a):
            if a == amount:
                return 1
            if a > amount or i == len(coins):
                return 0
            if (i, a) in cache:
                return cache[(i, a)]
            
            cache[(i, a)] = dfs(i, a + coins[i]) + dfs(i + 1, a)
            return cache[(i, a)]

        return dfs(0, 0)