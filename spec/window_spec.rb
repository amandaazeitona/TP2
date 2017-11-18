require 'spec_helper'
require 'gosu'

# Aplicando testes na janela do jogo.
describe GameWindow do

  it 'return a new window' do
    window = GameWindow.new
    expect(window).to be_a GameWindow
  end

  it 'access method roda_ranking' do
  	window = GameWindow.new
  	window.entrou_ranking = 0
  	window.roda_ranking
  	expect(window.entrou_ranking).to eql 1
  end

  #it 'verify draw ' do
  	#@state = 1
  	#inicializou = true
  	#window = GameWindow.new
   # window.draw
  #	expect(@inimigos.size).to be > 0
  #end

  #it 'roda_ranking' do
  #	window = GameWindow.new
  #	inicializou = false
  #	window.roda_ranking
  #	expect(inicializou).to be true
  #end


#  it 'menu apertando ver ranking' do
#  	state = 0
#  	Gosu.button_down? Gosu::KB_R = true
#  	varl = Gosu.button_down? Gosu::KB_R
#  	puts varl
#  	expect(state).to eql 2
#  end


end
