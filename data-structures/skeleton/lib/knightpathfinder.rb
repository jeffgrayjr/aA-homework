require_relative "00_tree_node.rb"

class KnightPathFinder
    def initialize(starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_positions = []
        self.build_move_tree
    end

    def self.valid_move(pos)
        possible_moves = []
        [-2, -1, 1, 2].each do |x|
            if x == -2 || x == 2
                [-1, 1].each {|y| possible_moves << [pos[0] + x, pos[1] + y]}
            else
                [-2, 2].each {|y| possible_moves << [pos[0] + x, pos[1] + y]}
            end
        end
        valid_moves = possible_moves.select do |move|
            move[0] >= 0 && move[0] < 8 && move[1] >= 0 && move[1] < 8
        end
        return valid_moves
    end

    def new_move_positions(pos)
        valid_moves = KnightPathFinder.valid_move(pos).select {|move| !@considered_positions.include?(move)}
        @considered_positions += valid_moves
        return valid_moves
    end

    def build_move_tree
        queue = [@root_node]
        until queue.length == 0
            ele = queue.shift
            children = self.new_move_positions(ele.value)
            p children
            p "\n"
            children.each do |child| 
                ele.add_child(PolyTreeNode.new(child))
            end
            ele.children.each {|child| queue << child}
        end
    end

    def find_path(end_pos)
        queue = [@root_node]
        until queue.length == 0
            ele = queue.shift
            return trace_path_back(ele) if ele.value == end_pos
            ele.children.each {|child| queue << child}
        end
        nil
    end

    def trace_path_back(end_node)
        path = []
        queue = [end_node]
        loop do
            ele = queue.shift
            path << ele.value
            if ele.parent == nil
                return path.reverse
            else
                queue << ele.parent
            end
        end
        return path
    end
end