
TOP_LEVEL = 1 # eixo Z do jogo

 

module Sprite
    def initialize (str)
      @image = Gosu::Image.new(str)
      @x = @y = @vel_x = @vel_y = @height= 0.0
      @angle = 0.0
    end
end

module Box 
  def warp(x, y)
    @x, @y = x, y
  end
end



module GameObject 

  attr_accessor :x,:y,:vel_x,:vel_y,:angle
  public
    

    def draw
      @image.draw_rot(@x, @y, TOP_LEVEL, @angle)
    end

    def notityCollision(obj)
      if Gosu.distance(@x, @y, obj.x, obj.y) < 10
        return true
      else
        return false  
      end
    end
end

class Box_Sprite_GameObject
  include Sprite
  include Box
  include GameObject
end

class Falcon < Box_Sprite_GameObject
  attr_accessor :height

  def move_down
    @x += 2.975
    @y += 4.375
  end
  def move_up
    @x -= 2.975
    @y -= 4.375
  end
  def move_height_down #Controle de altura do falcon os valores podem ser mudados
    @height -= 1
    @y += 21.875
  end
  def move_height_up
    @height += 1
    @y -= 21.875
  end
end

class Hiero < Box_Sprite_GameObject

  def move
    @x -= 2
    @y += 0.7
  end
end
