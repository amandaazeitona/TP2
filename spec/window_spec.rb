require 'spec_helper'
require 'gosu'

# Aplicando testes na janela do jogo.
describe GameWindow do
  it 'return a new window' do
    window = GameWindow.new
    expect(window).to be_a GameWindow
  end

  it 'move out window right' do
    falcon = Falcon.new('spec/images/falcon.png')
    falcon.y = 511
    eixo_x = falcon.x
    eixo_y = falcon.y
    Gosu.button_down? Gosu::KB_RIGHT = 1
    expect(falcon.x).to eql eixo_x
    expect(falcon.y).to eql eixo_y
  end

  it 'move out window left' do
    falcon = Falcon.new('spec/images/falcon.png')
    falcon.x = 18
    eixo_x = falcon.x
    eixo_y = falcon.y
    Gosu.button_down? Gosu::KB_LEFT = 1
    expect(falcon.x).to eql eixo_x
    expect(falcon.y).to eql eixo_y
  end

  it 'move out window down' do
    falcon = Falcon.new('spec/images/falcon.png')
    falcon.x = 488
    eixo_x = falcon.x
    eixo_y = falcon.y
    Gosu.button_down? Gosu::KB_DOWN = 1
    expect(falcon.x).to eql eixo_x
    expect(falcon.y).to eql eixo_y
  end
end
