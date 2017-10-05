require 'spec_helper'
describe GameWindow do

    it "return a new window" do
      window = GameWindow.new
      expect(window).to be_a GameWindow
    end

#    it "out window bottom" do
#    	window = GameWindow.new
#    	falcon = Falcon.new("spec/images/falcon.png")
#
  #  	falcon.y = 17 + 512
  #  	Gosu::KB_DOWN
  #  	expect(window.update).to be nil
  #  end


end
