require_relative "00_tree_node.rb"

class KnightPathFinder
    def initialize(starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
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
end