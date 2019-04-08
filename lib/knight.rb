$LOAD_PATH << '.'
require 'chess_board.rb'
require 'knight_moves.rb'

class Knight
  attr_accessor :possible_moves, :chess_board
  def initialize
    @possible_moves = []
    @chess_board = ChessBoard.new
    self.chess_board.create_vertex_list
    self.chess_board.create_adjency_list
  end

  def all_possible_tiles
    @chess_board.board
  end

  def move_combinations
    @chess_board.adjency_list
  end

  def knight_moves(origin, destination)
    KnightMoves.new(self, origin, destination).compute
  end
end