Vertices = Struct.new(:x, :y, :parent) do
  attr_accessor :coordinates
  def coordinates
    @coordinates = [self.x, self.y]
  end
end