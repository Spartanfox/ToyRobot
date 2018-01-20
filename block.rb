class Block
  attr_accessor :x, :y

  def initialize( x, y )
    @x = x
    @y = y
  end
  def collides(x,y)
    if (@x == x && @y == y)
      return true
    end
    false
  end
end
