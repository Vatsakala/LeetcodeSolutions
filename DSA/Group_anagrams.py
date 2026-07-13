from collections import defaultdict
from typing import List
class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        res = defaultdict(list)

        for s in strs:
            count = [0] * 26
        
            for c in s:
                count[ord(c) - ord("a")] += 1 # doing the ord() to basically get the ascii of a so thay wewe can map 0 oon the coutn list to a bascially create a list for  abc like [1,1,1,0,0....]
            
            res[tuple(count)].append(s)
        
        return list(res.values()) # cannot return [res.values()]  as they will return a list of dict_values object, not a list of lists