require 'gosu'

TOP_LEVEL = 1 # eixo Z do jogo

class GameObject
  attr_accessor :x,:y,:vel_x,:vel_y,:angle
  public
    def warp(x, y)
      @x, @y = x, y
    end

    def draw
      @image.draw_rot(@x, @y, TOP_LEVEL, @angle)
    end
end

class Falcon < GameObject

  def initialize
    @image = Gosu::Image.new("images/falcon.png")
    @x = @y = @vel_x = @vel_y = 0.0
    @angle = 0.0
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

class Hiero < GameObject

	def initialize
    @image = Gosu::Image.new("images/hiero.png")
    @x = @y = @vel_x = @vel_y = 0.0
    @angle = 3.0
  end

  def move
    @x -= 2
    @y += 0.7
  end
end
