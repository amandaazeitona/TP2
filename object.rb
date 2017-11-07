# Eixo Z do jogo.
TOP_LEVEL = 1
JANELA_WIDTH = 512
JANELA_HEIGHT = 512
# Guarda e manipula imagens.
module Sprite
  def initialize(str)
    @image = Gosu::Image.new(str)
    @x = @y = @vel_x = @vel_y = @height = 0.0
    @angle = 0.0
  end
end

# Guarda posicao x e y da entidade.
module Box
  def warp(x, y)
    @x = x
    @y = y
  end
end

# Metodos comuns as entidades do jogo.
module GameObject
  attr_accessor :x, :y, :vel_x, :vel_y, :angle

  # Desenha a imagem associada a si proprio.
  def draw
    @image.draw_rot(@x, @y, TOP_LEVEL, @angle)
  end

  # Detecta colisao.
  def notity_collision(obj)
    if Gosu.distance(@x, @y, obj.x, obj.y) < 10
      true
    else
      false
    end
  end
end
# Integra as tres classes Sprite, Box e GameObject.
class BoxSpriteGameObject
  include Sprite
  include Box
  include GameObject
end
# Classe Falcon herdando de BoxSpriteGameObject.
class Falcon < BoxSpriteGameObject
  # Flags para evitar mudanca continua de altura.
  attr_accessor :height, :flag_up, :flag_down, :score

  def update
    if (Gosu.button_down? Gosu::KB_LEFT) || (Gosu::button_down? Gosu::GP_BUTTON_4)
      # Um pouco maior que o tamanho da janela se nao o falcao desaparece.
      if @x + 3 >= 20
        move_up
      end
    end
    if (Gosu.button_down? Gosu::KB_RIGHT) || (Gosu::button_down? Gosu::GP_BUTTON_6)
      # Um pouco maior que o tamanho da janela se nao o falcao desaparece.
      if @y + 16 <= JANELA_HEIGHT
        move_down
      end
    end
    if Gosu.button_down? Gosu::KB_DOWN
      # Um pouco maior que o tamanho da janela se nao o falcao desaparece.
      if @y + 25 <= JANELA_HEIGHT && @height != -1 && @flag_down == true
        move_height_down
        @flag_down = false
      end
    else
      @flag_down = true
    end
    if Gosu.button_down? Gosu::KB_UP
      if @height != 1 && @flag_up == true
        move_height_up
        @flag_up = false
      end
    else
      @flag_up = true
    end
  end

  # Metodos que controlam os movimentos do falcao.
  def move_down
    @x += 2.975
    @y += 4.375
  end

  def move_up
    @x -= 2.975
    @y -= 4.375
  end

  # Controle de altura do falcon os valores podem ser mudados.
  def move_height_down
    @height -= 1
    @y += 21.875
  end

  def move_height_up
    @height += 1
    @y -= 21.875
  end
end

# Classe Hiero herdando de BoxSpriteGameObject.
class Hiero < BoxSpriteGameObject
  def update
    # Detecta se o hiero chegou na extremidade esquerda ou no fim da janela.
    if @x >= BASE + 20 && @y <= JANELA_HEIGHT + 15
      move
    else
      warp(JANELA_WIDTH, rand(JANELA_HEIGHT - 50))
    end
  end

  def move
    @x -= 2
    @y += 0.7
  end
end