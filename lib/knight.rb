# frozen_string_literal: true

require_relative 'gameboard.rb'
require_relative 'position.rb'

class Knight

  def initialize; end

  # def create_knight_moves_tree(start_position)
  #   KnightMovesTree.new(start_position)
  # end

  def create_knight_moves_tree(start_position)
    @knight_moves_tree = []
    queue = [start_position]

    until queue.empty?
      current_position = Position.new(queue[0])
      queue.shift
      @knight_moves_tree << current_position

      current_position.children.each do |child|
        queue << child if child.is_a? Array
      end
      remove_existing_nodes_from_queue(queue)
    end
    replace_children_arrays_with_node_ref
  end

  def remove_existing_nodes_from_queue(queue)
    @knight_moves_tree.each do |position|
      queue.delete(position.position) if queue.include?(position.position)
    end
  end

  def replace_children_arrays_with_node_ref
    @knight_moves_tree.each do |position|
      position.children.each_with_index do |child, index|
        position.children[index] = find_node(child) if child.is_a? Array
      end
    end
  end

  def find_node(find_position)
    @knight_moves_tree.each_with_index do |position, index|
      return @knight_moves_tree[index] if position.position == find_position
    end
    nil
  end

  def print_nodes_and_children
    @knight_moves_tree.each do |position|
      puts "parent position: #{position.position} node: #{position}"
      position.children.each_with_index do |child, index|
        puts "  child #{index} position: #{child.position} node: #{child}"
      end
    end
  end
end
