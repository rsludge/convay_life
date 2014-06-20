require_relative 'slot'

class World
  attr_accessor :slots, :next_slots, :width, :height

  def initialize(sizes, coords)
    @slots = []
    @width = sizes[0]
    @height = sizes[1]
    init_slots(coords)
    @next_slots = []
  end

  def make_step
    @width.times do |i|
      @height.times do |j|
        slot = self.get_slot(i, j) || Slot.new(self, i, j, false)
        slot.generate_next
      end
    end
    @slots = @next_slots
    @next_slots = []
  end

  def init_slots(coords)
    coords.each do |coord|
      self.add_slot(coord[0], coord[1])
    end
  end

  def add_slot(x, y)
    @slots << Slot.new(self, x, y, true)
  end

  def get_slot(x, y)
    slot_index = @slots.index{|s| s.x == x && s.y == y}
    return @slots[slot_index] if slot_index
  end
end
