$LOAD_PATH << '.'
require 'vertices.rb'

class ChessBoard
  attr_accessor :board, :knight, :adjency_list

  def initialize
    @board = []
    @adjency_list = Array.new(64, [])
  end

  def create_vertex_list_row(row)
    ("a".."h").each { |letter| @board << Vertices.new(letter, row) }
  end

  def create_vertex_list
    (1..8).each { |num| create_vertex_list_row(num) }
  end

  def convert_letter_to_number(letter)
    (letter - 97) % 7
  end

  def create_adjency_list
    (0..63).each do |n|
      @adjency_list[n] += [@board[n + 17]] if n % 8 < 7 && @board[n][1] <= 6 # Up right moves (2 up 1 right)
      @adjency_list[n] += [@board[n + 10]] if n % 8 < 6 && @board[n][1] <= 7 # Up right moves (1 up 2 right)
      @adjency_list[n] += [@board[n + 15]] if n % 8 > 0 && @board[n][1] <= 6 # Up left moves (2 up 1 left)
      @adjency_list[n] += [@board[n + 6]] if n % 8 > 1 && @board[n][1] <= 7# Up left moves (1 up 2 left)
      @adjency_list[n] += [@board[n - 6]] if n % 8 < 6 && @board[n][1] >= 2  # Down right moves (1 down 2 right)
      @adjency_list[n] += [@board[n - 15]] if n % 8 < 7 && @board[n][1] >= 3 # Down right moves (2 down 1 right)
      @adjency_list[n] += [@board[n - 17]] if n % 8 > 0 && @board[n][1] >= 3  # Down left moves (2 down 1 left)
      @adjency_list[n] += [@board[n - 10]] if n % 8 > 1 && @board[n][1] >= 2  # Down left moves (1 down 2 left)      
    end
    @adjency_list
  end
  
  def get_index(origin)
    (0..63).each do |n|
      return n if origin == @board[n].coordinates
      nil if n == 63 && origin != @board[n].coordinates
    end
  end

end
