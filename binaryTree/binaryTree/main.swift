//
//  main.swift
//  binaryTree
//
//  Created by weizhou on 6/11/15.
//  Copyright © 2015 weizhou. All rights reserved.
//

import Foundation

let root = TreeNode(data:6)
let node1 = TreeNode(data:3)
let node2 = TreeNode(data:10)
let node3 = TreeNode(data:1)
let node4 = TreeNode(data:4)
let node5 = TreeNode(data:7)
let node6 = TreeNode(data:2)
let node7 = TreeNode(data: 11)
root.left = node1
root.right = node2
node1.left = node3
node1.right = node4
node2.left = node5
node3.right = node6
node2.right = node7

BinaryTreePrinter.printTreeAtRoot(root)

func lookup(value: Int, root: TreeNode?) -> Bool {
    guard let node = root else {
        return false
    }
    if value == node.data {
        return true
    } else if value < node.data {
        return lookup(value, root: node.left)
    } else if value > node.data {
        return lookup(value, root: node.right)
    } else {
        return false
    }
}

func isBST(root: TreeNode?) -> Bool {
    func isBSTInRange(root: TreeNode?, maxValue: Int, minValue: Int) -> Bool {
        guard let node = root else {
            return true
        }
        if node.data > maxValue || node.data < minValue {
            return false
        }
        if node.left == nil && node.right == nil {
            return true
        }
        if (node.left != nil && node.left?.data < node.data && node.left?.data < maxValue) || (node.right != nil && node.right?.data > node.data && node.right?.data > minValue) {
            return isBSTInRange(node.left, maxValue: node.data, minValue: minValue) && isBSTInRange(node.right, maxValue: maxValue, minValue: node.data)
        } else {
            return false
        }
    }
    return isBSTInRange(root, maxValue: Int.max, minValue: Int.min)
}

func insert(value: Int, root: TreeNode) {
    if value == root.data {
        return
    } else if value < root.data {
        if root.left != nil {
            insert(value, root: root.left!)
        } else {
            root.left = TreeNode(data: value)
        }
    } else {
        if root.right != nil {
            insert(value, root: root.right!)
        } else {
            root.right = TreeNode(data: value)
        }
    }
}

func maxInTree(root: TreeNode) -> Int {
    if root.right == nil {
        return root.data
    } else {
        return maxInTree(root.right!)
    }
}

func minInTree(root: TreeNode) -> Int {
    if root.left == nil {
        return root.data
    } else {
        return minInTree(root.left!)
    }
}

func delete(value: Int, root: TreeNode) {
    func deleteNode(value: Int, root: TreeNode) {
        var targetNode: TreeNode? = nil
        if value <= root.data {
            targetNode = root.left
        } else if value > root.data {
            targetNode = root.right
        }
        if targetNode != nil && targetNode!.data != value {
            deleteNode(value, root: targetNode!)
        } else if targetNode != nil && value == targetNode!.data {
            //需要删除的出现了
            if targetNode!.left == nil && targetNode!.right == nil {
                //1. 没有子节点
                if value <= root.data {
                    root.left = nil
                } else if value > root.data {
                    root.right = nil
                }       
            } else if targetNode!.left != nil && targetNode!.right == nil {
                //2. 只有左节点
                targetNode = targetNode!.left
            } else if targetNode!.left == nil && targetNode!.right != nil {
                //3. 只有右节点
                targetNode = targetNode!.right
            } else {
                //4. 有两个节点
                let max = maxInTree(targetNode!.left!)
                deleteNode(max, root: targetNode!)
                targetNode!.data = max
            }
        }
        
    }
    
    //单独处理根
    if value == root.data {
        if root.left == nil && root.right == nil {
            print("can't delete the only root")
        } else if root.left != nil {
            root.data = maxInTree(root.left!)
            deleteNode(root.data, root: root)
        } else {
            root.data = minInTree(root.right!)
            deleteNode(root.data, root: root)
        }
    } else {
        //排除了是根的情况
        deleteNode(value, root: root)
    }
}

func invert(root: TreeNode?) {
    guard let node = root else {
        return
    }
    invert(node.left)
    invert(node.right)
    
    let tmp: TreeNode? = node.left
    node.left = node.right
    node.right = tmp
}

delete(10, root: root)

BinaryTreePrinter.printTreeAtRoot(root)
