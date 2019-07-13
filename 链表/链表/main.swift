//
//  main.swift
//  链表
//
//  Created by 李小龙 on 2018/12/27.
//  Copyright © 2018 李小龙. All rights reserved.
//

import Foundation

print("Hello, World!")

class ListNode {
    var val : Int
    var next : ListNode?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


class List {
    var head: ListNode?
    var tail: ListNode?
    
    //尾插法
    func appendToTail(_ val: Int) {
        if tail == nil {
            tail = ListNode(val)
            head = tail
        }else{
            tail!.next = ListNode(val)
            tail = tail!.next
        }
    }
    
    //尾插法
    func appendToHead(_ val: Int){
        if head == nil {
            head = ListNode (val)
            tail = head
        }else {
            let temp = ListNode(val)
            temp.next = head
            head = temp
        }
    }
}

// 给一个链表和一个值 x，要求将链表中所有小于 x 的值放到左边，所有大于等于 x 的值放到右边。原链表的节点顺序不能变。

//例：1->5->3->2->4->2，给定x = 3。则我们要返回1->2->2->5->3->4

//先处理左边
//给一个链表和一个值 x，要求只保留链表中所有小于 x 的值，原链表的节点顺序不能变。
//
//例：1->5->3->2->4->2，给定x = 3。则我们要返回 1->2->2
//
//我们只要采用尾插法，遍历链表，将小于 x 值的节点接入新的链表即可
//func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
//    let dummy = ListNode(0)
//    var pre = dummy, node = head
//
//    while node != nil {
//        if node!.val < x {
//            pre.next = node
//            pre = node!
//        }
//        node = node!.next
//    }
//
//    //防止构成环
//    pre.next = nil
//    return dummy.next
//}


//完整代码
func parttition(_ head: ListNode?, _ x: Int) -> ListNode? {
    // 引入Dummy节点
    let prevDummy = ListNode(0), postDummy = ListNode(0)
    var prev = prevDummy, post = postDummy
    
    var node = head
    
    // 用尾插法处理左边和右边
    while node != nil {
        if node!.val < x {
            prev.next = node
            prev = node!
        }else{
            post.next = node
            post = node!
        }
        
        node = node!.next
    }
    
    // 防止构成环
    post.next = nil
    //左右拼接
    prev.next = postDummy.next
    
    return prevDummy.next
    
}

//如何检测一个链表中是否有环？
func hasCycle(_ head: ListNode?) -> Bool {
    
    var slow = head
    var fast = head
    
    while fast != nil && fast!.next != nil {
        slow = slow!.next;
        fast = fast!.next!.next
        
        if slow === fast {
            return true
        }
    }
    
    return false
}

func removeNthFromEnd(head: ListNode?, _ n: Int) -> ListNode? {
    guard let head = head else {
        return nil
    }
    
    let dummy = ListNode(0)
    dummy.next = head
    var prev: ListNode? = dummy
    var post: ListNode? = dummy
    
    // 设置后一个节点初始位置
    for _  in 0 ..< n {
        if post == nil {
            break
        }
        
        post = post!.next
    }
    
    // 同时移动前后节点
    while post != nil && post!.next != nil {
        prev = prev!.next
        post = post!.next
        
    }
    
     // 删除节点
    prev!.next = prev!.next!.next
    
    return dummy.next
}
