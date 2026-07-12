class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        count = {} #tracks occurence in current window
        res = 0

        l = 0
        for r in range(len(s)):
            count[s[r]] = 1 + count.get(s[r], 0)
            
            while  r - (l-1) - max(count.values()) > k: #check if we can replace the characters in the current window and basically if thw indow is valid or not
                count[s[l]] -= 1
                l += 1
            
            res = max(res, r - (l - 1))
        return res

