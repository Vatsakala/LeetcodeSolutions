from typing import List, Optional
# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
class Solution:
    def buildTree(self, inorder: List[int], postorder: List[int]) -> Optional[TreeNode]:
        if not inorder or not postorder:
            return None
        
        root = TreeNode(postorder[-1])
        head = inorder.index(postorder[-1])

        root.left = self.buildTree(inorder[:head], postorder[:head])
        root.right =self.buildTree(inorder[head+1:], postorder[head:-1])
        
        return root
        
    