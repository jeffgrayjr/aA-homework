require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    if @next_mover_mark = :x
      @next_mover_mark = :o 
    else
      @next_mover_mark = :x
    end
    child_nodes = []
    @board.rows.each_with_index do |row, idx_x|
      row.each_with_index do |pos, idx_y|
        if pos == nil
          available_move = @board.dup
          available_move[[idx_x, idx_y]] = @next_mover_mark
          child_nodes << TicTacToeNode.new(available_move, @next_mover_mark, [idx_x, idx_y])
        end
      end
    end
    return child_nodes
  end
end
