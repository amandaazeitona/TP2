# Eixo Z do jogo.
TOP_LEVEL = 1
JANELA_WIDTH = 512
JANELA_HEIGHT = 512
# Modulo que define as sprites do jogo.
module Sprite
  attr_accessor
  # Inicializa
  def initialize(str)
    @image = Gosu::Image.new(str)
    @x = @y = @vel_x = @vel_y = @height = 0.0
    @angle = 0.0
    self.define_altura
  end
end
# Modulo das coordenadas x e y.
module Box
  def warp(x, y)
    @x = x
    @y = y
  end
end
# Modulo dos objetos do jogo.
module GameObject
  attr_accessor :x, :y, :vel_x, :vel_y, :angle, :height
  # Desenha a imagem
  def draw
    @image.draw_rot(@x, @y, TOP_LEVEL, @angle)
  end

  # Detecta colisao
  def notity_collision(obj)
    if Gosu.distance(@x, @y, obj.x, obj.y) < 10
      true
    else
      false
    end
  end
end
# Classe que compacta os tres modulos.
class BoxSpriteGameObject
  include Sprite
  include Box
  include GameObject
end
# Classe que define o falcao
class Falcon < BoxSpriteGameObject
  # Flags para evitar mudanca continua de altura.
  attr_accessor :flag_up, :flag_down, :score
  def update
    if (Gosu.button_down? Gosu::KB_LEFT) || (Gosu::button_down? Gosu::GP_BUTTON_4)
      # Um pouco maior que o tamanho da janela, se nao o falcao desaparece.
      if @x + 3 >= 20
        move_up
      end
    end

    if (Gosu.button_down? Gosu::KB_RIGHT) || (Gosu::button_down? Gosu::GP_BUTTON_6)
      # Um pouco maior que o tamanho da janela, se nao o falcao desaparece.
      if @y + 16 <= JANELA_HEIGHT
        move_down
      end
    end

    if Gosu.button_down? Gosu::KB_DOWN
      # Um pouco maior que o tamanho da janela, se nao o falcao desaparece.
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

  def move_down
    @x += 2.975
    @y += 4.375
  end

  def move_up
    @x -= 2.975
    @y -= 4.375
  end

  def move_height_down
    # Controle de altura do falcon os valores podem ser mudados.
    @height -= 1
    @y += 21.875
  end

  def move_height_up
    @height += 1
    @y -= 21.875
  end

  def define_altura
    @height = 0
  end
end
# Classe que define os hieros.
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

  def define_altura
    @height = 1
  end
end
# Classe que define os obstaculos.
class Obstaculo < BoxSpriteGameObject
  def update
    if @x >= BASE + 20 && @y <= JANELA_HEIGHT + 15
      # Detecta se o hiero chegou na extremidade esquerda ou no fim da janela.
      move
    else
      warp(JANELA_WIDTH, rand(JANELA_HEIGHT - 50))
    end
  end

  def move
    @x -= 2
    @y += 0.7
  end

  def define_altura
    @height = -1
  end
end
# Classe que define os inimigos.
class Inimigo < BoxSpriteGameObject
  def update
    if @x >= BASE + 20 && @y <= JANELA_HEIGHT + 15
      # Detecta se o inimigo chegou na extremidade esquerda ou no fim da janela.
      move
    else
      warp(JANELA_WIDTH, rand(JANELA_HEIGHT - 50))
    end
  end

  def move
    @x -= 3
    @y += 1
  end

  def define_altura
    case rand(3)
    when 0
      @height = -1
    when 1
      @height = 0
    when 2
      @height = 1
    end
  end
end
