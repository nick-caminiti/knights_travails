# frozen_string_literal: true

require_relative 'knight.rb'
require_relative 'gameboard.rb'

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