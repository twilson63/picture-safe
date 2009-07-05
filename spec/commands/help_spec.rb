require File.dirname(__FILE__) + '/../base'
 
module PictureSafe::Command
  describe Help do
    # before do
    #   @args = [1, 2]
    #   @base = Base.new(@args)
    #   @base.stub!(:display)
    # end
 
    it "initializes the PictureSafe client with the Auth command" do
      PictureSafe::Command.should_receive(:run_internal).with('auth:client', @args)
      @base.PictureSafe
    end
  end
end