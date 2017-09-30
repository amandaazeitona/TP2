require 'gosu'

TOP_LEVEL = 1 # eixo Z do jogo

class GameObject

  attr_accessor :x,:y,:vel_x,:vel_y,:angle

  public
    def initialize (str)
      @image = Gosu::Image.new(str)
      @x = @y = @vel_x = @vel_y = 0.0
      @angle = 0.0
    end

    def warp(x, y)
      @x, @y = x, y
    end

    def draw
      @image.draw_rot(@x, @y, TOP_LEVEL, @angle)
    end
end

class Falcon < GameObject

  def move_down
    @x += 2.975
    @y += 4.375
  end
  def move_up
    @x -= 2.975
    @y -= 4.375
  end
  def notityCollision (obj)
    if Gosu.distance(@x, @y, obj.x, obj.y) < 10
      return true
    end
  end
end

class Hiero < GameObject

  def move
    @x -= 2
    @y += 0.7
  end

  def notityCollision (obj)
    if Gosu.distance(@x, @y, obj.x, obj.y) < 10
      return true
    end
  end

end
