class Slot
  attr_accessor :alive, :x, :y

  def initialize(world, x, y, alive = false)
    @world = world
    @x = x
    @y = y
    @alive = alive
  end

  def neighbours_count
    x_coords = (@x-1..@x+1).to_a
    y_coords = (@y-1..@y+1).to_a
    neighbours = x_coords.product(y_coords).select{|el| el[0] >= 0 && el[1] >= 0}.reject{|el| el[0] == x && el[1] == y}
    neighbours.select{|coords| @world.get_slot(coords[0], coords[1])}.count
  end

  def generate_next
    @world.next_slots << Slot.new(@world, @x, @y, alive_next) if self.alive_next
  end

  def alive_next
    if @alive
      self.neighbours_count == 2 || self.neighbours_count == 3
    else
      self.neighbours_count == 3
    end
  end
end
