require 'spec_helper'


  describe Hiero do
   
    it "return a new hiero" do
      hiero = Hiero.new("spec/images/hiero.png")
      expect(hiero).to be_a Hiero
  
    end

    
    it "initialize hiero coordenate" do
      hiero = Hiero.new("spec/images/hiero.png")
      expect(hiero.x).to eql(0.0) 
      expect(hiero.y).to eql(0.0)  
    end

  end

  describe Falcon do
    it "return a new falcon" do
      falcon = Falcon.new("spec/images/falcon.png")
      expect(falcon).to be_a Falcon
    end

    it "initialize falcon coordenate" do
      falcon = Falcon.new("spec/images/falcon.png")
      expect(falcon.x).to eql(0.0) 
      expect(falcon.y).to eql(0.0)  
    end

    it "move left" do
      falcon =  Falcon.new("spec/images/falcon.png")
      eixo_x = falcon.x
      eixo_y = falcon.y
      falcon.move_up
      expect(falcon.x).not_to eql (eixo_x)
      expect(falcon.y).not_to eql (eixo_y)

    end    
    it "move right" do
      falcon =  Falcon.new("spec/images/falcon.png")
      eixo_x = falcon.x
      eixo_y = falcon.y
      falcon.move_down
      expect(falcon.x).not_to eql (eixo_x)
      expect(falcon.y).not_to eql (eixo_y)

    end 
    it "move height_up" do
      falcon =  Falcon.new("spec/images/falcon.png")
      eixo_height = falcon.height
      eixo_y = falcon.y
      falcon.move_height_up
      expect(falcon.height).not_to eql (eixo_height)
      expect(falcon.y).not_to eql (eixo_y)
    end
  end

  describe GameObject do
    it "it happened" do
      falcon =  Falcon.new("spec/images/falcon.png") # valores inicados iguais a zero
      hiero = Hiero.new("spec/images/hiero.png") # valores iniciados iguais a zero
      expect(falcon.notityCollision(hiero)).to be true
    end  
    #it "it not happened" do
    #  falcon =  Falcon.new("spec/images/falcon.png") # valores inicados iguais a zero
    #  hiero = Hiero.new("spec/images/hiero.png") # valores iniciados iguais a zero
    #  falcon.move_up


     
    

    #  expect(falcon.notityCollision(hiero)).to be false
    #end 

  end

