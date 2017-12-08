require 'spec_helper'
require 'gosu'

# Aplicando testes na janela do jogo. Fazendo o uso de teste de caixa branca
describe GameWindow do

  it 'return a new window' do
    window = GameWindow.new
    expect(window).to be_a GameWindow
  end


  it "initilize constructor inicializou" do
    window = GameWindow.new
    expect(window.inicializou).to be true
  end

  it "initilize constructor state" do
    window = GameWindow.new
    expect(window.state).to be 0
  end

# def update
  it "update menu" do
    window = GameWindow.new
    window.state = 0 ;
    window.update
    expect(window.entrou).to be 1
  end

  it "update ranking" do
    window = GameWindow.new
    window.state = 2 ;
    window.update
    expect(window.entrou).to be 4
  end
#-----------------------------------------------------------
# roda_pontuação e fazendo o uso de teste de caixa preta
  it 'roda_pontuação with text more than 3 letters' do
    
    window = GameWindow.new
    window.entrou = 0
    window.inicializou = true
    window.text_input = Gosu::TextInput.new
    window.text_input.text = "ARTU" 
    window.roda_pontuacao
    expect(window.entrou).to eql 1
  end
  it 'roda_pontuação with text eql or less than 3 letters' do
    
    window = GameWindow.new
    window.entrou = 0
    window.inicializou = true
    window.text_input = Gosu::TextInput.new
    window.text_input.text = "LA" 
    window.roda_pontuacao
    expect(window.entrou).not_to eql 1
  end

  it 'roda_pontuação changing strings with more than 3 letters' do
    
    window = GameWindow.new
    window.entrou = 0
    window.inicializou = true
    window.text_input = Gosu::TextInput.new
    window.text_input.text = "LATEX" 
    window.roda_pontuacao
    expect(window.text_input.text).to eq("LAT")
  end

  it 'roda_pontuação with text down to upcase' do
    
    window = GameWindow.new
    window.entrou = 0
    window.inicializou = true
    window.text_input = Gosu::TextInput.new
    window.text_input.text = "art" 
    window.roda_pontuacao
    expect(window.text_input.text).to eq("ART")
  end
#--------------------------------------------------------------------
# def roda_ranking
  it 'roda_ranking' do
  	window = GameWindow.new
  	window.inicializou = false
  	window.send(:roda_ranking)
  	expect(window.inicializou).to be true
  end






end
