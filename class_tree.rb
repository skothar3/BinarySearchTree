
class Tree
  attr_reader :root, :size

  def initialize(array)
    array = array.uniq.sort
    @size = array.length
    @root = build_tree(array, 0, array.length - 1)
  end

  def build_tree(array, start_idx, end_idx)
    return nil if end_idx < start_idx

    root_idx = (start_idx + end_idx) / 2
    root = Node.new(array[root_idx])
    root.left = build_tree(array, start_idx, root_idx - 1)
    root.right = build_tree(array, root_idx + 1, end_idx)

    return root
  end

  def insert(root, value)
    if root.nil?
      @size += 1
      return Node.new(value) 
    end
    return root if root.data == value

    if root.data < value
      root.right = insert(root.right, value)
    else
      root.left = insert(root.left, value)
    end
    
    return root
  end

  def delete(root, value)
    return root if root.nil?

    if root.data > value
      root.left = delete(root.left, value)
    elsif root.data < value
      root.right = delete(root.right, value)
    else
      
      if root.left.nil?
        temp = root.right
        root = nil
        @size -= 1
        return temp
      elsif root.right.nil?
        temp = root.left
        root = nil
        @size -= 1
        return temp
      end

      temp = min_value_node(root.right)

      root.data = temp.data

      root.right = delete(root.right, temp.data)
    end

    return root
  
  end

  def find(root, value)
    if root.nil? || root.data == value
      return root
    end

    if root.data < value
      return find(root.right, value)
    end

    return find(root.left, value)
  end

  def min_value_node(root)
    current = root

    until current.left.nil?
      current = current.left
    end

    return current
  end

  def height(node)
    return 0 if node.nil?

    l_height = height(node.left)
    r_height = height(node.right)

    return l_height + 1 if l_height > r_height

    return r_height + 1

  end

  def depth(node)
    current = @root
    node_depth = 0
    until node == current
      if node < current
        current = current.left
      elsif node > current
        current = current.right
      end
      return nil if current.nil?
      
      node_depth += 1
    end

    return node_depth
  end

  def balanced?(root)
    return 0 if root.nil?

    # Return -1 if any node in tree is unbalanced
    lh = balanced?(root.left)
    return -1 if lh == -1

    rh = balanced?(root.right)
    return -1 if rh == -1

    return -1 if (lh - rh).abs > 1

    # Return height of root if balanced
    return [lh, rh].max + 1
  end

  def rebalance()
    array = inorder(@root)
    initialize(array)
  end

  def level_order(root, &block)
    return if root.nil?

    queue = []

    queue.push(root)

    level_ordered_array = []

    while queue.length > 0
      yield queue[0] if block_given?
            
      level_ordered_array.push(queue[0].data)
        
      node = queue.shift()

      queue.push(node.left) unless node.left.nil?

      queue.push(node.right) unless node.right.nil?
    end

    return level_ordered_array unless block_given?
  end

  def inorder(root, accum = [], &block)
    return accum if accum.size == @size && !block_given?

    unless root.nil?
      inorder(root.left, accum, &block)
      yield root if block_given?
      accum << root.data
      inorder(root.right, accum, &block)
    end
  end

  def preorder(root, accum = [], &block)
    return accum if accum.size == @size && !block_given?

    unless root.nil?
      yield root if block_given?
      accum << root.data
      preorder(root.left, accum, &block)
      preorder(root.right, accum, &block)
    end
  end

  def postorder(root, accum = [], &block)
    return accum if accum.size == @size && !block_given?

    unless root.nil?
      postorder(root.left, accum, &block)
      postorder(root.right, accum, &block)
      yield root if block_given?
      accum << root.data
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end