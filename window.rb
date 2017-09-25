require 'gosu'
require_relative 'object'
WIDTH = 512
HEIGHT = 512

class GameWindow < Gosu::Window

  def initialize
    super WIDTH, HEIGHT
    self.caption = "Desert Falcon"
    @player = Falcon.new
    @player.warp(130,300)
    @hiero = Hiero.new
    @hiero.warp(130,200)
  end

  def update
    if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_5
      if @player.x + 3 >= 20 # Um pouco maior que o tamanho da janela, se nao o falcao desaparece
        @player.move_up
      end
    end
    if Gosu.button_down? Gosu::KB_DOWN or Gosu::button_down? Gosu::GP_BUTTON_0
      if @player.y + 3 <= 500 # Um pouco maior que o tamanho da janela, se nao o falcao desaparece
        @player.move_down
      end
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
