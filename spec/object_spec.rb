require 'spec_helper'


  describe Hiero do
   
    it "return a new hiero" do
      hiero = Hiero.new("spec/images/hiero.png")
      expect(hiero).to be_a Hiero
  
    end

    it "initialize hiero move" do
      hiero = Hiero.new("spec/images/hiero.png")
      expect(hiero.x).to_not be >= 20 
      expect(hiero.y).to be <= 510 
    end
  end
