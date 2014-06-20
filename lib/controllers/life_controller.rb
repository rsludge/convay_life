require_relative '../models/world'

class LifeController
  def start_game(renderer, input_file)
    sizes, coords = parse_params(input_file)

    world = World.new(sizes, coords)
    
    renderer.new(world).render
  end

  def parse_params(file)
    index = 0
    coords = []
    sizes = []
    File.readlines(file).each do |line|
      if index == 0
        sizes = line.split(',').map(&:to_i)
        index += 1
      else
        coords << line.chomp.split(',').map(&:to_i)
      end
    end
    [sizes, coords]
  end
end
