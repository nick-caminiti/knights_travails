# frozen_string_literal: true

class Game
  attr_accessor :board, :knight

  def initialize
    # @board = GameBoard.new
    @knight = Knight.new
  end

  def knight_moves(start_position, end_position)
    knight_moves_tree = @knight.create_knight_moves_tree(start_position)
    # knight_moves_tree.print_nodes_and_children
    found = false
    paths = [[start_position]]

    until found == true
      current_node = knight_moves_tree.find_node(paths[0][-1])
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

class GameBoard
  attr_accessor :board_array

  def initialize
    @board_array = (0..7).to_a.repeated_permutation(2).to_a
  end
end

class Knight
  attr_accessor :knight_movements_array, :knight_moves_tree

  def initialize; end

  def create_knight_moves_tree(start_position)
    KnightMovesTree.new(start_position)
  end
end

class KnightMovesTree
  def initialize(start_position)
    @positions = build_tree(start_position)
  end

  def build_tree(start_position)
    @positions = []
    queue = [start_position]

    until queue.empty?
      current_position = Position.new(queue[0])
      queue.shift
      @positions << current_position

      current_position.children.each do |child|
        queue << child if child.is_a? Array
      end
      remove_existing_nodes_from_queue(queue)
    end
    replace_children_arrays_with_node_ref
  end

  def remove_existing_nodes_from_queue(queue)
    @positions.each do |position|
      queue.delete(position.position) if queue.include?(position.position)
    end
  end

  def replace_children_arrays_with_node_ref
    @positions.each do |position|
      position.children.each_with_index do |child, index|
        position.children[index] = find_node(child) if child.is_a? Array
      end
    end
  end

  def find_node(find_position)
    @positions.each_with_index do |position, index|
      return @positions[index] if position.position == find_position
    end
    nil
  end

  def print_nodes_and_children
    @positions.each do |position|
      puts "parent position: #{position.position} node: #{position}"
      position.children.each_with_index do |child, index|
        puts "  child #{index} position: #{child.position} node: #{child}"
      end
    end
  end
end

class Position
  attr_accessor :children
  attr_reader :position

  def initialize(position)
    @position = position
    @children = determine_children(position)
  end

  def determine_children(position)
    knight_movements_array = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
    children = []
    knight_movements_array.each do |movement|
      new_position = []
      new_position << position[0] + movement[0]
      new_position << position[1] + movement[1]
      children << new_position if new_position[0].between?(0, 7) && new_position[1].between?(0, 7)
    end
    children
  end
end

game = Game.new
game.knight_moves([1, 1], [3, 6])
