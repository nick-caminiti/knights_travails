# frozen_string_literal: true

require_relative 'knight.rb'
require_relative 'position.rb'

class GameBoard
  attr_accessor :board, :knight

  def initialize
    # @board = GameBoard.new
    @knight = Knight.new
    @board_array = (0..7).to_a.repeated_permutation(2).to_a
  end

  def knight_moves(start_position, end_position)
    knight_moves_tree = @knight.create_knight_moves_tree(start_position)
    # @knight.print_nodes_and_children
    found = false
    paths = [[start_position]]

    until found == true
      current_node = @knight.find_node(paths[0][-1])
      current_path = paths[0]
      path_dup = current_path.dup

      current_node.children.each do |child|
        found = true if child.position == end_position
        new_path = path_dup.dup
        new_path << child.position
        paths.append(new_path)
        break if found
      end
      paths.shift
    end
    fast_path = paths[-1]
    puts "You made it in #{fast_path.length - 1} moves! Here's your path:"
    fast_path.each { |position| p position }
  end
end
