class PolyTreeNode
    attr_reader :value, :parent
    attr_accessor :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent)
        old_parent = @parent
        @parent = parent
        if parent != nil && !parent.children.include?(self)
            parent.children << self
            old_parent.children.delete(self) if old_parent != nil
        end  
    end

    def add_child(child_node)
        @children << child_node
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "Passed node was not a child" if !@children.include?(child_node)
        @children.delete(child_node)
        child_node.parent = nil
    end

    def dfs(target_value)
        true
    end

    def bfs(target_value)
        queue = [self]
        until queue.length == 0
            ele = queue.shift
            return ele if ele.value == target_value
            ele.children.each {|child| queue << child}
        end
        nil
    end
end