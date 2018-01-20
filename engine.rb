class Engine
  attr_accessor :table, :robot, :objects, :commands, :command, :running

  def initialize(table,robot)
    @table = table
    @robot = robot
    @robot.engine = self
    @table.engine = self
    @objects = []
    #@objects << Block.new(4,4)

  end
  def collides(x,y)
    @objects.each do |ob|
      if ob.collides(x,y)
        return true
      end
    end
    false
  end
  def run
    @running = true
    while @running do
      retreive_input
      process_input
    end
  end

  def retreive_input
    print "Next input: "
    @commands = gets
    puts
  end

  def process_input
    while @commands.split(' ').length > 0 do
      @command  = @commands.split(' ').first.upcase
      @commands = @commands.split(' ').drop(1).join(' ')
      if @commands.split(' ').first =~ /\d/
        execute_input_with_params(@commands.split(' ').first.upcase.split(','))
        @commands = @commands.split(' ').drop(1).join(' ')
      else
        execute_input
      end
    end
  end

  def execute_input
      if @command == "MOVE"
        @robot.move
      elsif @command == "REPORT"
        @robot.report
      elsif @command == "MAP"
        @table.to_s
      elsif @command == "PLACE_OBJECT"
        radian = (@robot.facing * Math::PI / 180)
        xv = Math.sin(radian)
        yv = Math.cos(radian)
        @objects << Block.new(@robot.x+xv,@robot.y+yv)
      elsif @command == "EXIT"
        @running = false
      elsif @robot.rotate(@command)
      elsif @robot.face(@command)
      else
        puts "Malformed command #{@command}"
      end
  end

  def execute_input_with_params(params)
    if @command == "PLACE"
      @robot.place(params[0].to_i,params[1].to_i,params[2])
    elsif @command == "ROTATE"
      @robot.rotate(params[0])
    end
  end

end
