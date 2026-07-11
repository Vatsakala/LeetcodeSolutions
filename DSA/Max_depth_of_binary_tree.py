from typing import Optional
import collections
# BFSfor a binary tree node.
class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        
        level = 0
        q = collections.deque([root])

        while q:
            for i in range(len(q)):
                node = q.popleft()
                if node.left:
                    q.append(node.left)
                if node.right:
                    q.append(node.right)
            level += 1
        return level

# dfs for a binary tree node.
class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        l = self.maxDepth(root.left)
        r = self.maxDepth(root.right)

        return 1 + max(l, r) 