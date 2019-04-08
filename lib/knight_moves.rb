# This is a method object for knight_moves in 'Knight' instances
class KnightMoves
  attr_reader :origin, :destination, :queue, :visited_coordinates, :vertices_in_current_depth,
              :path_to_destination, :current_vertex, :knight
  attr_accessor :current_coord_idx

  def initialize(knight, origin, destination)
    @knight = knight
    @origin = origin
    @destination = destination
    @queue = []
    @visited_coordinates = []
    @vertices_in_current_depth = []
    @path_to_destination = []
  end

  def invalid_origin?
    !("a".."h").include?(origin[0]) || !(1..8).include?(origin[1])
  end

  def invalid_destination?
    !("a".."h").include?(destination[0]) || !(1..8).include?(destination[1])
  end

  def determine_valid_inputs
    puts "Origin and destination are the same." if origin == destination
    puts "Coordinates need to be between 'a' and 'h' and 1 to 8." if invalid_origin? || invalid_destination?
  end

  def enqueue_origin_and_record_visited_coordinates
    self.queue << origin
    self.visited_coordinates << origin
  end

  def explore_vertex(coordinates)
    self.current_coord_idx = @knight.chess_board.get_index(coordinates)
    @knight.move_combinations[current_coord_idx].each do |v|
      v.parent ||= @knight.all_possible_tiles[current_coord_idx] unless v.coordinates == origin
      if !(visited_coordinates.include? v.coordinates)
        queue << v
        visited_coordinates << v.coordinates
      end
    end
  end

  def check_vertices_in_current_depth
    loop do
      raise StopIteration if vertices_in_current_depth.empty? || vertices_in_current_depth[0].coordinates == destination
      if vertices_in_current_depth[0].coordinates != destination
        explore_vertex(vertices_in_current_depth.shift.coordinates)
        queue.shift
      end
    end
  end

  def display_number_of_steps
    if count_steps(vertices_in_current_depth[0]) == 1
      puts "You have completed the goal in #{count_steps(vertices_in_current_depth[0])} step. Here is your path:"
    else
      puts "You have completed the goal in #{count_steps(vertices_in_current_depth[0])} steps. Here is your path:"
    end
  end

  def search_shortest_path
    loop do
      queue.each { |v| vertices_in_current_depth << v }
      check_vertices_in_current_depth
      break if !vertices_in_current_depth.empty? && vertices_in_current_depth[0].coordinates == destination
    end
  end

  def determine_path_to_destination
    current_vertex = vertices_in_current_depth[0]
    loop do
      path_to_destination << current_vertex.coordinates
      break if current_vertex.parent.nil?
      current_vertex = current_vertex.parent
    end
    path_to_destination.reverse!.each { |coord| puts "#{coord}" }
  end

  def compute
    return determine_valid_inputs if origin == destination || invalid_origin? || invalid_destination?
    enqueue_origin_and_record_visited_coordinates
    explore_vertex(queue.shift)
    search_shortest_path
    display_number_of_steps
    determine_path_to_destination
  end
    #
  def count_steps(destination)
      current_vertex = destination
    steps = 0
    loop do
      current_vertex = current_vertex.parent
      steps += 1
      break if current_vertex.parent.nil?
    end
    steps
  end
end