class Solution:
    def isPalindrome(self, x: int) -> bool:
        if x < 0 or (x % 10 == 0 and x != 0):
            return False
            
        a = str(x)

        rev = ""

        for c in a:
            rev = c + rev
        
        if a == rev:
            return True
        else:
            return False
    
class Solution2:
    def isPalindrome(self, x: int) -> bool:
        #with math

        if x < 0 or (x % 10 == 0 and x != 0): #negative numbers and vlues ending with 0 are not palindromes except 0 itself
            return False
        
        rh = 0 #reverse half of the number

        while x > rh: #because once reverse half is greater than the other half, we have reversed enough digits to check for palindrome
            rh = (rh * 10) + x % 10
            x = x//10 #it rounds towards the nearest integer, so 123//10 = 12, 12//10 = 1, 1//10 = 0
        
        return x == rh or x == rh//10 # if the number of digits is odd, Then it woudl be like 12, reverse half = 123 so we need to remove the middle digit by doing rh//10, if even then it would be like 12, reverse half = 21 so we can just check for equality
