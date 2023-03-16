//
//  QSTreeNode.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2023/3/16.
//

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}

extension TreeNode {
    // 构建一个棵二叉排序树
    static func createTreeNode(_ values: [Int]) -> TreeNode? {
        var rootNode: TreeNode? = nil
        for value in values {
            rootNode = TreeNode.addSubNode(rootNode, value)
        }
        return rootNode
    }
    static private func addSubNode(_ rootNode: TreeNode?, _ value: Int) -> TreeNode? {
        var node = rootNode
        if node == nil {
            node = TreeNode(val: value)
        } else if value <= rootNode!.val {
            node?.left = TreeNode.addSubNode(rootNode?.left, value)
        } else {
            node?.right = TreeNode.addSubNode(rootNode?.right, value)
        }
        return node
    }
    
    // 技巧：以根节点的遍历位置去记，先序根节点第1个遍历，中序根节点第2个遍历，后序根节点第3个遍历，左子树始终比右子树先遍历。
    // 先序遍历（递归）
    // 根节点 -> 左子树 -> 右子树
    static func preorderTreeNode(_ treeNode: TreeNode?, _ block: (TreeNode) -> Void) {
        guard let node = treeNode else {
            return
        }
        block(node)
        TreeNode.preorderTreeNode(node.left, block)
        TreeNode.preorderTreeNode(node.right, block)
    }
    
    // 中序遍历（递归）
    // 左子树 -> 根节点 -> 右子树
    static func inorderTreeNode(_ treeNode: TreeNode?, _ block: ((TreeNode?) -> Void)) {
        guard let node = treeNode else {
            return
        }
        TreeNode.inorderTreeNode(node.left, block)
        block(treeNode)
        TreeNode.inorderTreeNode(node.right, block)
    }
    
    // 后序遍历（递归）
    // 左子树 -> 右子树 -> 根节点
    static func postorderTreeNode(_ treeNode: TreeNode?, _ block: ((TreeNode?) -> Void)) {
        guard let node = treeNode else {
            return
        }
        TreeNode.postorderTreeNode(node.left, block)
        TreeNode.postorderTreeNode(node.right, block)
        block(treeNode)
    }
    
    // 二叉树的深度（深度优先遍历算法：递归）
    // 1、确定终止条件：节点为空或者节点没有左右子树
    // 2、第n层的深度等于第n-1层深度 + 1
    static func depthTreeNode(_ rootNode: TreeNode?) -> Int {
        if rootNode == nil {
            return 0
        }
        if rootNode?.left == nil && rootNode?.right == nil {
            return 1
        }
        
        let leftDepth = TreeNode.depthTreeNode(rootNode?.left)
        let rightDepth = TreeNode.depthTreeNode(rootNode?.right)
        
        return max(leftDepth, rightDepth) + 1
    }
    // 二叉树的深度（广度优先遍历算法）
    static func depthTreeNode_1(_ rootNode: TreeNode?) -> Int {
        guard let node = rootNode else {
            return 0
        }
        var queue = [TreeNode]()
        var depth = 0
        queue.append(node)
        while queue.count > 0 {
            let size = queue.count
            for _ in 0..<size {
                if let left = queue[0].left {
                    queue.append(left)
                }
                if let right = queue[0].right {
                    queue.append(right)
                }
                queue.removeFirst()
            }
            depth += 1
        }
        return depth
    }
    
    static func invertTreeNode(_ rootNode: TreeNode?) {
        if rootNode == nil {
            return
        }
        if rootNode?.left == nil && rootNode?.right == nil {
            return
        }
        
        self.invertTreeNode(rootNode?.left)
        self.invertTreeNode(rootNode?.right)
        
        let temp = rootNode?.left
        rootNode?.left = rootNode?.right
        rootNode?.right = temp
    }
}

class TreeNodeTest {
    func fire() {
        let values = [5, 2, 4, 6, 9, 0, 3, 7, 8, 1]
        let rootTreeNode = TreeNode.createTreeNode(values)
        TreeNode.inorderTreeNode(rootTreeNode) { treeNode in
            if let node = treeNode {
                print("\(node.val)")
            }
        }
        
        let depth = TreeNode.depthTreeNode_1(rootTreeNode)
        print("depth:\(depth)")
    }
}
