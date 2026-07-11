from typing import Optional

class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        if not p and not q:
            return True
        
        if not p or not q or p.val != q.val:
            return False

        a = self.isSameTree(p.left, q.left)
        b = self.isSameTree(p.right, q.right)
        return (a and b)
        