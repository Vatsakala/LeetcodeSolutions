class Solution:
    def longestPalindrome(self, s: str) -> str:
        res = ""
        reslen = 0

        for i in range(len(s)):
            #for odd number
            l,r = i, i
            while l >= 0 and r < len(s) and s[l] == s[r]:
                if (r - l + 1) > reslen: #length of this palindrome
                    res = s[l:r+1] #need to include r
                    reslen = r - l + 1
                l -= 1
                r += 1
            # for even
            l,r = i, i+1
            while l >= 0 and r < len(s) and s[l] == s[r]:
                if  (r - l + 1) > reslen: #length of this palindrome
                    res = s[l:r+1] #need to include r
                    reslen = r - l + 1
                l -= 1
                r += 1
        return res
