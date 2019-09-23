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
end