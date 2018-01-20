class Robot

  DIRECTION = { "NORTH" => 0, "EAST" => 90, "SOUTH" => 180, "WEST" => 270 }
  ROTATION  = { "LEFT" => -90, "RIGHT" => 90}

  attr_accessor :x, :y, :facing, :direction, :rotation, :placed, :engine

  def set_engine(engine)
    @engine = engine
  end

  def place(x, y, facing)
    unless collides(x,y)
      @x = x
      @y = y
      @facing = 0
      face(facing)
      puts "set robot to a position on table #{@x}, #{@y}, #{facing}"
    end
  end

  def move
    if placed
      radian = (@facing * Math::PI / 180)
      xv = Math.sin(radian)
      yv = Math.cos(radian)
      unless collides(@x+xv,@y+yv)
        @x += xv
        @y += yv
      end
    end
  end

  def rotate(direction)
    if placed
      puts "#{direction}"
      if ROTATION.key?(direction)
        @facing += ROTATION[direction]
        @facing %= 360
        true
      else
        if (Integer(direction) rescue false)
          @facing += direction
        end
        false
      end
    end
  end

  def face(facing)
    if placed
      if DIRECTION.key?(facing)
        @facing = DIRECTION[facing]
        true
      else
        puts "unknown direction: #{facing}"
        false
      end
    end
  end

  def collides(x,y)
    if ((x < 0 || x > @engine.table.width) || (y < 0 || y > @engine.table.height))
      puts "would fall off table, skipping command"
      return true
    end
    if @engine.collides(x,y)
      puts "would hit object, skipping command"
      return true
    end
    false
  end

  def is_here(x, y)
    if placed
      return (x == @x && y == @y)
    end
    false
  end

  def placed
    if (@facing.nil? || @x.nil? || @y.nil?)
      return false
    end
    true
  end

  def report
    self.to_s
  end

  def to_s
    if placed
      puts
      puts "X: #{@x.round(5)}"
      puts "Y: #{@y.round(5)}"
      puts "F: #{DIRECTION.key(@facing)}"
      puts
    else
      puts "not on table"
    end
  end

end
