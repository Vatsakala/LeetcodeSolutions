from typing import Optional
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
class Solution:
    def isSubtree(self, s: Optional[TreeNode], t: Optional[TreeNode]) -> bool:
        if not t:
            return True
        if not s:
            return False

        if self.istree(s, t):
            return True
        
        leftcheck = self.isSubtree(s.left, t)
        rightcheck = self.isSubtree(s.right, t)

        return (leftcheck or rightcheck)

    def istree(self, s: Optional[TreeNode], t: Optional[TreeNode]):
        if not s and not t:
            return True

        if not s or not t or s.val != t.val:
            return False
        
        leftloop = self.istree(s.left, t.left)
        rightloop = self.istree(s.right, t.right)

        return (leftloop and rightloop)
        


        
    