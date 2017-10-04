require 'spec_helper'


  describe Hiero do
    before :all do
      @hiero = Hiero.new
    end
    #it "return a new hiero" do
    #  @hiero.move be_an_intance_of Hiero
    #end

    it "return a correct move" do
      @hiero.move.should eql 12  
    end
  end
