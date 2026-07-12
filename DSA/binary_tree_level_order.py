from typing import List, Optional
import collections
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
class Solution:
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        res = []
    
        q = collections.deque()
        q.append(root)

        while q:
            qlen = len(q)
            levelresult = []
            for i in range(qlen):
                node = q.popleft()
                if node:
                    levelresult.append(node.val)
                    q.append(node.left)
                    q.append(node.right)

            if levelresult:
                res.append(levelresult)

        return res
           

        


       
           
        



        