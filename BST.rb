require_relative "class_node.rb"
require_relative "class_tree.rb"

# test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

test_array = Array.new(25) { rand(1..100) }
BST = Tree.new(test_array)
BST.pretty_print
p BST.balanced?(BST.root)
p BST.inorder(BST.root)
p BST.preorder(BST.root)
p BST.postorder(BST.root)
# p BST.size
BST.insert(BST.root, 250)
# p BST.size
BST.insert(BST.root, 190)
# p BST.size
BST.insert(BST.root, 230)
BST.insert(BST.root, 550)
BST.insert(BST.root, 680)
BST.insert(BST.root, 750)
# p BST.size
# BST.delete(BST.root, 9)
# p BST.size
# BST.delete(BST.root, 4)
# p BST.size
BST.pretty_print
p BST.balanced?(BST.root)

BST.rebalance

BST.pretty_print
p BST.balanced?(BST.root)
# p BST.depth(test_node) 
p BST.inorder(BST.root)
p BST.preorder(BST.root)
p BST.postorder(BST.root) 