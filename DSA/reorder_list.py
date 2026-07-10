# Definition for singly-linked list.
from typing import Optional
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
class Solution:
    def reorderList(self, head: Optional[ListNode]) -> None:
        """
        Do not return anything, modify head in-place instead.
        """
        s, f = head, head.next

        while f and f.next:
            s = s.next
            f = f.next.next

        second = s.next # second part start
        prev = None #previous of second
        s.next = None

        while second:
            tmp = second.next
            second.next = prev
            prev = second
            second = tmp
        
        first, last = head, prev # because in the last loop prev would reach the last node while reversing it
        while last: #because last (second part) would always be shorter or equal to first
            tmp1, tmp2= first.next, last.next 
            first.next = last
            last.next = tmp1
            first, last = tmp1, tmp2
        
"""
143. Reorder List
Solved
Medium
Topics
premium lock icon
Companies
You are given the head of a singly linked-list. The list can be represented as:

L0 → L1 → … → Ln - 1 → Ln
Reorder the list to be on the following form:

L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …
You may not modify the values in the list's nodes. Only nodes themselves may be changed.

 

Example 1:


Input: head = [1,2,3,4]
Output: [1,4,2,3]
Example 2:


Input: head = [1,2,3,4,5]
Output: [1,5,2,4,3]
 

Constraints:

The number of nodes in the list is in the range [1, 5 * 104].
"""