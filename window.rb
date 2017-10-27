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
    @hieros = Array.new
    @obstaculos = Array.new
  end

  def update
    @player.update
    @hieros.each { |hiero| hiero.update}
    @obstaculos.each { |obstaculo| obstaculo.update}

    if rand(100) < 4 && @obstaculos.size < 3
      @obstaculos.push(Obstaculo.new('spec/images/obs.png')) #Imagem temporaria 
    end

    if rand(100) < 4 && @hieros.size < 3
      @hieros.push(Hiero.new('spec/images/hiero.png'))
    end

    @hieros.each { |hiero|   
      if @player.notityCollision(hiero)
        hiero.warp(WIDTH, rand(HEIGHT - 50))
        @player.score += 10
      end
    }
   @obstaculos.each { |obstaculo|   
      if @player.notityCollision(obstaculo) && @player.height == -1
        obstaculo.warp(WIDTH, rand(HEIGHT - 50))
      end
    }
  end

  def draw
    @background_image.draw(0, 0, 0)
    @obstaculos.each { |obstaculo| obstaculo.draw}
    @player.draw
    @hieros.each { |hiero| hiero.draw }
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
