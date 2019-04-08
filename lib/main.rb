lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH << "lib"
require 'knight.rb'


def knight_moves(origin, destination)
  knight = Knight.new
  knight.all_possible_tiles # vertex_list
  knight.move_combinations # adjacency list
  knight.knight_moves(origin, destination)
end

knight_moves(["a", 4], ["h", 8])