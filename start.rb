require_relative 'robot'
require_relative 'engine'
require_relative 'table'
require_relative 'block'

sam = Robot.new()
desk = Table.new(5,5)
engine = Engine.new(desk,sam)
engine.run
