class Solution:
    def isPalindrome(self, s: str) -> bool:
        l,r = 0 , len(s) - 1

        while l <= r:
        
            while l < r and not self.alphaNumeric(s[l]):
                l += 1
            while r > l and not self.alphaNumeric(s[r]):
                r -= 1

            if s[l].lower() != s[r].lower():
                return False

            l +=1
            r -=1
        return True
    # own alphaNumeric function to check if a character is alphanumeric or not, instead of using the built-in isalnum() function
    def alphaNumeric(self, c: str) -> bool:
        return (ord('a') <= ord(c) <= ord('z')) or (ord('A') <= ord(c) <= ord('Z')) or (ord('0') <= ord(c) <= ord('9'))

        