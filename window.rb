require 'gosu'
require_relative 'object'
WIDTH = 512
HEIGHT = 512
BASE = 0


class GameWindow < Gosu::Window

  def initialize
    super WIDTH, HEIGHT
    self.caption = "Desert Falcon"

    @player = Falcon.new("spec/images/falcon.png")
    @player.warp(130,300)
    @hiero = Hiero.new("spec/images/hiero.png")
    @hiero.warp(130,200)
  end

  def update

    if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_BUTTON_4
      if @player.x + 3 >= 20 # Um pouco maior que o tamanho da janela, se nao o falcao desaparece
        @player.move_up
      end
    end

    if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_BUTTON_6
      if @player.y + 16 <= height # Um pouco maior que o tamanho da janela, se nao o falcao desaparece
        @player.move_down
      end
    end

    if Gosu.button_down? Gosu::KB_DOWN
      if @player.y + 25 <= HEIGHT and @player.height != -1 and @player.flag_down == true# Um pouco maior que o tamanho da janela, se nao o falcao desaparece
        @player.move_height_down
        @player.flag_down = false
      end
    else
      @player.flag_down = true
    end


    if Gosu.button_down? Gosu::KB_UP
      if @player.height != 1 and @player.flag_up == true
        @player.move_height_up
        @player.flag_up = false
      end
    else
      @player.flag_up = true
    end

    if @player.notityCollision(@hiero)
      @hiero.warp(WIDTH, (rand(HEIGHT - 50)))
    end

    if @hiero.x >= BASE + 20 && @hiero.y <= HEIGHT + 15 # Detecta se o hiero chegou na extremidade esquerda ou no fim da janela
      @hiero.move
    else
      @hiero.warp(WIDTH, (rand(HEIGHT - 50)))
    end
  end

  def draw
    @player.draw
    @hiero.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
