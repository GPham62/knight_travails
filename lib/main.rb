lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH << "lib"
require 'knight.rb'

knight = Knight.new

knight.all_possible_tiles # vertex_list
knight.move_combinations # adjacency list

knight.knight_moves(["a", 4], ["h", 8])