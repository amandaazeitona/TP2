require 'spec_helper'

describe Hiero do
  it 'return a new hiero' do
    hiero = Hiero.new('spec/images/hiero.png')
    expect(hiero).to be_a Hiero
  end

  it 'initialize hiero coordenate' do
    hiero = Hiero.new('spec/images/hiero.png')
    expect(hiero.x).to eql(0.0)
    expect(hiero.y).to eql(0.0)
  end

  it 'move' do
    hiero =  Hiero.new('spec/images/hiero.png')
    eixo_x = hiero.x
    eixo_y = hiero.y
    hiero.move
    expect(hiero.x).not_to eql eixo_x
    expect(hiero.y).not_to eql eixo_y
  end

  it 'inicilizacao altura' do 
    hiero = Hiero.new('spec/images/hiero.png')
    expect(hiero.height).to be >= -1
    expect(hiero.height).to be <= 1  
  end 
end

describe Falcon do
  it 'return a new falcon' do
    falcon = Falcon.new('spec/images/falcon.png')
    expect(falcon).to be_a Falcon
  end

  it 'initialize falcon coordenate' do
    falcon = Falcon.new('spec/images/falcon.png')
    expect(falcon.x).to eql(0.0)
    expect(falcon.y).to eql(0.0)
  end

  it 'move left' do
    falcon = Falcon.new('spec/images/falcon.png')
    eixo_x = falcon.x
    eixo_y = falcon.y
    falcon.move_up
    expect(falcon.x).not_to eql eixo_x
    expect(falcon.y).not_to eql eixo_y
  end

  it 'move right' do
    falcon = Falcon.new('spec/images/falcon.png')
    eixo_x = falcon.x
    eixo_y = falcon.y
    falcon.move_down
    expect(falcon.x).not_to eql eixo_x
    expect(falcon.y).not_to eql eixo_y
  end

  it 'move height_up' do
    falcon = Falcon.new('spec/images/falcon.png')
    eixo_height = falcon.height
    eixo_y = falcon.y
    falcon.move_height_up
    expect(falcon.height).not_to eql eixo_height
    expect(falcon.y).not_to eql eixo_y
  end

  it 'move height_up' do
    falcon = Falcon.new('spec/images/falcon.png')
    eixo_height = falcon.height
    eixo_y = falcon.y
    falcon.move_height_up
    expect(falcon.height).not_to eql eixo_height
    expect(falcon.y).not_to eql eixo_y
  end

  it 'move height_down' do
    falcon = Falcon.new('spec/images/falcon.png')
    eixo_height = falcon.height
    eixo_y = falcon.y
    falcon.move_height_down
    expect(falcon.height).not_to eql eixo_height
    expect(falcon.y).not_to eql eixo_y
  end

  it 'inicilizacao altura' do 
    falcon = Falcon.new('spec/images/falcon.png')
    expect(falcon.height).to eql 0
  end 


end

describe GameObject do

  it 'it happened' do
    falcon = Falcon.new('spec/images/falcon.png') # Valores inicados iguais a zero.
    hiero = Hiero.new('spec/images/hiero.png') # Valores iniciados iguais a zero.
    expect(falcon.notityCollision(hiero)).to be true
  end

  it 'it not happened' do
    falcon = Falcon.new('spec/images/falcon.png') # Valores iniciados iguais a zero.
    hiero = Hiero.new('spec/images/hiero.png') # valores iniciados iguais a zero.
    falcon.move_up  # Cada move_up equivale a x -= 2.975 y -= 4.375.
    falcon.move_up  # Mover o falcon para ficar com distancia > 10.
    falcon.move_up
    expect(falcon.notityCollision(hiero)).to be false
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

describe Obstaculo do 
  
  it 'return a new Obstaculo' do
    obstaculo = Obstaculo.new('spec/images/obs.png')
    expect(obstaculo).to be_a Obstaculo
  end

  it 'move' do
    obstaculo =  Obstaculo.new('spec/images/obs.png')
    eixo_x = obstaculo.x
    eixo_y = obstaculo.y
    obstaculo.move
    expect(obstaculo.x).not_to eql eixo_x
    expect(obstaculo.y).not_to eql eixo_y
  end

  it 'inicilizacao altura' do 
    obstaculo = Obstaculo.new('spec/images/obs.png')
    expect(obstaculo.height).to eql -1
  end 

end

describe Inimigo do 

  it 'return a new Obstaculo' do
    inimigo = Inimigo.new('spec/images/obs.png')
    expect(inimigo).to be_a Inimigo
  end

  it 'move' do
    inimigo =  Inimigo.new('spec/images/obs.png')
    eixo_x = inimigo.x
    eixo_y = inimigo.y
    inimigo.move
    expect(inimigo.x).not_to eql eixo_x
    expect(inimigo.y).not_to eql eixo_y
  end

  it 'inicilizacao altura' do 
    inimigo = Inimigo.new('spec/images/inimigo.jpeg')
    expect(inimigo.height).to be >= -1
    expect(inimigo.height).to be <= 1 
  end 

end