from typing import Optional
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
class Solution1:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        self.counter = 0
        self.answer = None

        def dfs(node):
            if not node:
                return
              
            dfs(node.left)

            self.counter += 1

            if self.counter == k:
                self.answer = node.val
                return
                
            dfs(node.right)

        dfs(root)
        return  self.answer
# BFS SOLUTION
class Solution2:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        n = 0
        stack = []
        cur = root

        while cur or stack:
            while cur:
                stack.append(cur)
                cur = cur.left

            cur = stack.pop()
            n += 1

            if n == k:
                return cur.val
            cur = cur.right
        
