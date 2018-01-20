class Table

  attr_accessor :width, :height, :engine
  def initialize( width,  height)
    @width = width
    @height = height
  end

  def to_s
    @height.times do |y|
      @width.times do |x|
        if @engine.robot.is_here(x,y)
          print " #{Robot::DIRECTION.key(@engine.robot.facing).split("").first}"
        elsif @engine.collides(x,y)
          print " #"
        else
          print ' .'
        end
      end
      puts
    end
    puts
  end

end
