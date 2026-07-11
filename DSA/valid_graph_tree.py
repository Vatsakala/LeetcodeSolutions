def valid_tree(self, n: int, edges: List[List[int]]) -> bool:
    # write your code here
    if not n:
        return true
    
    adj = {i:[] for i in range(n)} # n+1 if 1st indexed
    for n1, n2 in edges:
        adj[n1].append(n2)
        adj[n2].append(n1)
        
    visited = set()
    def dfs(i, prev):
            if i in visited:
                false
            visited.add(i)
            for nei in adj[i]:
                if nei == prev:
                    continue
                if not dfs(nei, i):
                    false
            return true
    return dfs(0, -1) and len(visited) == n