require 'mit-ldap'

describe MIT do

  describe ".on_campus_network?" do
    it "confirms if we're on the campus network meaning we have a .mit.edu hostname" do

      MIT.stub(:hostname).and_return('localhost')
      MIT.on_campus_network?.should eq false

      MIT.stub(:hostname).and_return('server.mit.edu')
      MIT.on_campus_network?.should eq true
    end
  end
end
