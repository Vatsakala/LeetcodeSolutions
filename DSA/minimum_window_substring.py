class Solution:
    def minWindow(self, s: str, t: str) -> str:
        if t == "":
            return ""
        
        curwin, Tcount = {}, {}

        for a in t:
            Tcount[a] = 1 + Tcount.get(a, 0)
        
        l = 0
        have, need = 0, len(Tcount)
        res, reslen = [-1 , -1], float("infinity")

        for r in range(len(s)):
            a = s[r]
            curwin[a] = 1 + curwin.get(a, 0)

            if a in Tcount and curwin[a] == Tcount[a]:
                have += 1
            
            while have == need: #because we have a valid window, we have to shrink it to get a minimum window
                if (r-l+1) < reslen:
                    res = [l, r]
                    reslen = (r-l+1)
                
                curwin[s[l]] -= 1
                if s[l] in Tcount and curwin[s[l]] < Tcount[s[l]]: # here we are checking that after popping the value from the left, if we still have a valid window or not, if not we will break the loop and move to the next character
                    have -= 1
                l +=1
        l, r = res

        return s[l: r+1] if reslen != float("infinity") else ""

            








        