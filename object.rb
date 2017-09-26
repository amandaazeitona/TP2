require 'gosu'

TOP_LEVEL = 1 # eixo Z do jogo

class Falcon
  attr_accessor :x,:y,:vel_x,:vel_y,:angle
  def initialize
    @image = Gosu::Image.new("images/falcon.png")
    @x = @y = @vel_x = @vel_y = 0.0
    @angle = 0.0
  end

  public
    def warp(x, y)
      @x, @y = x, y
    end

    def draw
      @image.draw_rot(@x, @y, TOP_LEVEL, @angle)
    end
    def move_down
      @x += 2.975
      @y += 4.375
    end
    def move_up
      @x -= 2.975
      @y -= 4.375
    end
end

class Hiero
  attr_accessor :x,:y,:vel_x,:vel_y,:angle
	def initialize
    @image = Gosu::Image.new("images/hiero.png")
    @x = @y = @vel_x = @vel_y = 0.0
    @angle = 3.0
  	end

  	def warp(x, y)
      @x, @y = x, y
    end

  	def draw
      @image.draw_rot(@x, @y, TOP_LEVEL, @angle)
    end

    def move
      @x -= 2
      @y += 0.7
    end
end
