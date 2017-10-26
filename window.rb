require 'gosu'
require_relative 'object'
WIDTH = 512
HEIGHT = 512
BASE = 0

class GameWindow < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = 'Desert Falcon'
    @background_image = Gosu::Image.new('spec/images/fundo.png', :tileable => true)
    @font = Gosu::Font.new(20)

    @player = Falcon.new('spec/images/falcon.png')
    @player.warp(130, 300)
    @player.score = 0
    @hiero = Hiero.new('spec/images/hiero.png')
    @hiero.warp(130, 200)
  end

  def update
    @player.update
    @hiero.update

    if @player.notityCollision(@hiero)
      @hiero.warp(WIDTH, rand(HEIGHT - 50))
      @player.score += 10
    end
  end

  def draw
    @background_image.draw(0, 0, 0)
    @player.draw
    @hiero.draw
    @font.draw("Score: #{@player.score}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
