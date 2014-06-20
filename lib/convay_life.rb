require_relative 'controllers/life_controller'
require_relative 'renderers/simple_console_renderer'

LifeController.new.start_game(SimpleConsoleRenderer, ARGV[0])
