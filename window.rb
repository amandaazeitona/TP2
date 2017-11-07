require 'gosu'
require_relative 'object'
WIDTH = 512
HEIGHT = 512
BASE = 0
# Nova classe que deriva de Gosu::Window.
class GameWindow < Gosu::Window
  # O construtor inicializa a classe base Gosu::Window.
  def initialize
    super WIDTH, HEIGHT
    self.caption = 'Desert Falcon'
    # Define a imagem de fundo.
    @background_image = Gosu::Image.new('spec/images/fundo.png', tileable: true)
    @font = Gosu::Font.new(20)
    @player = Falcon.new('spec/images/falcon.png')
    @player.warp(130, 300)
    @player.score = 0
    @hieros = []
  end

  # Contem a logica principal do jogo: mover objetos, tratar colisoes, etc.
  def update
    @player.update
    @hieros.each { |hiero| hiero.update }

    if rand(100) < 4 && @hieros.size < 3
      @hieros.push(Hiero.new('spec/images/hiero.png'))
    end

    @hieros.each { |hiero|
      if @player.notity_collision(hiero)
        hiero.warp(WIDTH, rand(HEIGHT - 50))
        @player.score += 10
      end
    }
  end

  # Deve conter o codigo para redesenhar a tela inteira.
  def draw
    @background_image.draw(0, 0, 0)
    @player.draw
    @hieros.each { |hiero| hiero.draw }
    @font.draw("Score: #{@player.score}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  # Fecha a janela com a tecla ESC.
  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end
# Cria a janela do jogo.
window = GameWindow.new
window.show