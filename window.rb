require 'gosu'
require_relative 'object'
WIDTH = 512
HEIGHT = 512
BASE = 0
MENU = 0
JOGO = 1
RANKING = 2
PONTUACAO = 3

class GameWindow < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    self.caption = 'Desert Falcon'
    @font = Gosu::Font.new(30)
    @state = MENU
    @inicializou = false
    @background_image = Gosu::Image.new('spec/images/fundo.png', :tileable => true) # Os componentes do jogo sao inicializados aqui porque o metodo draw da janela eh chamado sempre no final do update oq causa erro na transiçao de modos da janela
    @player = Falcon.new('spec/images/falcon.png')
    @hieros = Array.new
    @obstaculos = Array.new
    @inimigos = Array.new
    
 

  end

  def update
    case @state # Case para rodar a logica de acordo com o estado da janela
    when MENU
      roda_menu
    when JOGO
      roda_jogo
    when PONTUACAO
      roda_pontuacao
    when RANKING
      roda_ranking
    end
  end

  def draw

    case @state # Case para desenhar de acordo com o estado da janela
    when MENU
      @font.draw("JOGAR(j)", 200, 200, 0, 1.0, 1.0, Gosu::Color::YELLOW)
      @font.draw("RANKING(r)", 200, 250, 0, 1.0, 1.0, Gosu::Color::YELLOW)
      @font.draw("SAIR(esc)", 200, 300, 0, 1.0, 1.0, Gosu::Color::YELLOW)
    when JOGO
      @background_image.draw(0, 0, 0)
      @obstaculos.each { |obstaculo| obstaculo.draw}
      @inimigos.each { |inimigo| inimigo.draw}
      @player.draw
      @hieros.each { |hiero| hiero.draw }
      @font.draw("Score: #{@player.score}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
    when PONTUACAO
      @font.draw("Score Final: #{@player.score}", 100, 200, 0, 1.0, 1.0, Gosu::Color::YELLOW)
      @font.draw("Digite seu nome para o ranking", 100, 250, 0, 1.0, 1.0, Gosu::Color::YELLOW)
      @font.draw("#{@text}", 100, 300, 0, 1.0, 1.0, Gosu::Color::YELLOW)
    when RANKING
      
    end

  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def roda_jogo
    if @inicializou == false
      @player.warp(130, 300)
      @player.score = 0
      @hieros = Array.new
      @obstaculos = Array.new
      @inimigos = Array.new
      @inicializou = true
    end

    @player.update
    @hieros.each { |hiero| hiero.update}
    @obstaculos.each { |obstaculo| obstaculo.update}
    @inimigos.each { |inimigo| inimigo.update}

    if rand(100) < 4 && @obstaculos.size < 3
      @obstaculos.push(Obstaculo.new('spec/images/obs.png')) #Imagem temporaria 
    end

    if rand(100) < 4 && @hieros.size < 3
      @hieros.push(Hiero.new('spec/images/hiero.png'))
    end

    if rand(100) < 4 && @inimigos.size < 3
      @inimigos.push(Inimigo.new('spec/images/inimigo.jpeg'))
    end

    @hieros.each { |hiero|   # Verificar
      if @player.notityCollision(hiero) && (@player.height == hiero.height)
        hiero.warp(WIDTH, rand(HEIGHT - 50))
        @player.score += 10
      end
    }
   @obstaculos.each { |obstaculo|   
      if @player.notityCollision(obstaculo) && @player.height == -1
        obstaculo.warp(WIDTH, rand(HEIGHT - 50))
        @state = PONTUACAO
        @inicializou = false
      end
    }

    @inimigos.each { |inimigo|   
      if @player.notityCollision(inimigo) && (@player.height == inimigo.height)
        inimigo.warp(WIDTH, rand(HEIGHT - 50))
        @state = PONTUACAO
        @inicializou = false
      end
    }
  end

  def roda_menu
    if Gosu.button_down? Gosu::KB_J
      @state = JOGO
      @inicializou = false
    end
  end

  def roda_pontuacao
    if @inicializou == false
      self.text_input= Gosu::TextInput.new #Caixa de input é criada aqui por que ela trava os comandos se tiver ativa na hora do jogo
      @inicializou = true
    end
    @text = text_input.text
  end

  def roda_ranking
    
  end
end



window = GameWindow.new
window.show
