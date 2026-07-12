# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right\

from typing import Optional
class Solution:
    def isValidBST(self, root: Optional[TreeNode]) -> bool:

        def dfs(node, left, right):
            if not node:
                return True
            
            if left >= node.val or right <= node.val:
                return False

            leftside = dfs(node.left, left, node.val) 
            rightside = dfs(node.right, node.val, right)

            return (leftside and rightside)
        
        return(dfs(root, float("-inf"), float("inf")))
