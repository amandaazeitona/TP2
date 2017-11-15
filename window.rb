require 'gosu'
require_relative 'object'
require_relative 'pontuacao'
WIDTH = 512
HEIGHT = 512
BASE = 0
MENU = 0
JOGO = 1
RANKING = 2
PONTUACAO = 3
PADDING = 20

class GameWindow < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    self.caption = 'Desert Falcon'
    @font = Gosu::Font.new(30)
    @state = MENU
    @inicializou = true

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
    def button_down(id)
      if id == Gosu::KbEscape
        close
      end
    end
  end

  def draw

    if @inicializou == true #Usado para nao tentar da draw em objetos nao inicializados
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
        @font.draw("Digite seu nome para o ranking:", 100, 250, 0, 1.0, 1.0, Gosu::Color::YELLOW)
        @font.draw("#{text_input.text}", 100, 300, 0, 1.0, 1.0, Gosu::Color::YELLOW)
      when RANKING
        @ranking.draw PADDING, PADDING, 0
      end
    end

  end

  def roda_jogo
    if @inicializou == false
      @background_image = Gosu::Image.new('spec/images/fundo.png', :tileable => true)
      @player = Falcon.new('spec/images/falcon.png')
      @player.score = 0
      @player.warp(130, 300)
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
      if @player.notityCollision(obstaculo) && @player.height == obstaculo.height
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
    @inicializou = true
    if Gosu.button_down? Gosu::KB_J
      @state = JOGO
      @inicializou = false
    end
    if Gosu.button_down? Gosu::KB_R
      @state = RANKING
      @inicializou = false
    end
  end

  def roda_pontuacao
    if @inicializou == false
      self.text_input= Gosu::TextInput.new #Caixa de input é criada aqui por que ela trava os comandos se tiver ativa na hora do jogo
      @inicializou = true
    end
    if text_input.text.size > 3 #Limita o tamnho da string
      text_input.text = text_input.text.slice(0..2)
    end
    text_input.text = text_input.text.upcase
    if (Gosu.button_down? Gosu::KB_RETURN) || (Gosu.button_down? Gosu::KB_ENTER)
      if text_input.text.size == 0
        text_input.text = "AAA"
      end
      inserir = Pontuacao.new
      inserir.SalvaScore("ranking.txt", @player.score, text_input.text)
      self.text_input= nil
      @state = MENU
      @inicializou = false
    end    
  end

  def roda_ranking
    if @inicializou == false
      leitura = Pontuacao.new
      @ranking = Gosu::Image.from_text leitura.DezPrimeiros("ranking.txt") , 20, :width => WIDTH - 2 * PADDING  #Usa a biblioteca GOSU para transformar um texto em imagem
      @inicializou = true
    end
    if (Gosu.button_down? Gosu::KB_RETURN) || (Gosu.button_down? Gosu::KB_ENTER)
      @state = MENU
      @inicializou = false
    end
  end
end



window = GameWindow.new
window.show
