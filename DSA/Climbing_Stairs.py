class Solution:
    def climbStairs(self, n: int) -> int:
        prev, prevprev = 1, 1

        #when temp reaches n-1 then prev will be the answer as we are starting from 0th step and we need to reach n-1th step to reach nth step
        #kind of like fibonacci series where we are adding the previous two steps to reach the current step
        #when can also righ tit like curr, prev and then total it like that initally curr at just one below top which is prev.

        for i in range(n - 1):
            tmp = prev
            prev = prev + prevprev
            prevprev = tmp
        
        return prev