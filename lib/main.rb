# frozen_string_literal: true

require_relative 'knight.rb'
require_relative 'gameboard.rb'
require_relative 'position.rb'

game = GameBoard.new
game.knight_moves([1, 1], [3, 6])