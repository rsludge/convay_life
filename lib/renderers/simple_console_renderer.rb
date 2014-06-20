class SimpleConsoleRenderer
  def initialize(world)
    @world = world
  end

  def render
    while true do
      system 'clear'
      show_world
      @world.make_step
      sleep 1
    end
  end

  def show_world
    @world.width.times do |i|
      @world.height.times do |j|
        slot = @world.get_slot(i, j)
        if slot
          print "*"
        else
          print " "
        end
      end
      puts
    end
  end
end
