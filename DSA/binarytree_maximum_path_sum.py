from typing import Optional
class Solution:
    def maxPathSum(self, root: Optional[TreeNode]) -> int:
        maxpath = [root.val]

        def dfs(root):
            if not root:
                return 0
            
            l = dfs(root.left)
            r = dfs(root.right)
            
            leftmax = max(l, 0)
            rightmax = max(r, 0)

            maxpath[0] = max(maxpath[0], root.val + leftmax + rightmax) #max path sum with splitting for the subtree
            
            return root.val + max(leftmax, rightmax) #maxpath wihtout splti whic hwe give to parent node
        
        dfs(root)
        return maxpath[0]
    
    # catch: we also need to accoutn for subtrees being more value so we need to calculate the max path sum for each subtree (which essentially means with splitting) and compare it with the current max path sum.