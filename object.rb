
TOP_LEVEL = 1 # eixo Z do jogo

JANELA_WIDTH = 512
JANELA_HEIGHT = 512
 

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
  attr_accessor :height, :flag_up, :flag_down #Flags para evitar mudança continua de altura

  def update
    if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_BUTTON_4
      if @x + 3 >= 20 # Um pouco maior que o tamanho da janela, se nao o falcao desaparece
        self.move_up
      end
    end

    if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_BUTTON_6
      if @y + 16 <= JANELA_HEIGHT # Um pouco maior que o tamanho da janela, se nao o falcao desaparece
        self.move_down
      end
    end

    if Gosu.button_down? Gosu::KB_DOWN
      if @y + 25 <= JANELA_HEIGHT and @height != -1 and @flag_down == true# Um pouco maior que o tamanho da janela, se nao o falcao desaparece
        self.move_height_down
        @flag_down = false
      end
    else
      @flag_down = true
    end


    if Gosu.button_down? Gosu::KB_UP
      if @height != 1 and @flag_up == true
        self.move_height_up
        @flag_up = false
      end
    else
      @flag_up = true
    end
  end

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

  def update
    if @x >= BASE + 20 && @y <= JANELA_HEIGHT + 15 # Detecta se o hiero chegou na extremidade esquerda ou no fim da janela
      self.move
    else
      self.warp(JANELA_WIDTH, (rand(JANELA_HEIGHT - 50)))
    end
  end

  def move
    @x -= 2
    @y += 0.7
  end
end
