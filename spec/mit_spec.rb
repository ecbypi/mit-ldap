require 'mit-ldap'

describe MIT do

  describe ".on_campus?" do
    it "returns true if IP starts with 18" do
      MIT.stub(:ip_addresses).and_return("18.0.0.0\n127.0.0.1")
      MIT.on_campus?.should be_true
    end

    it "returns false if no network device has a campus address" do
      MIT.stub(:ip_addresses).and_return("192.168.1.2\n127.0.0.1")
      MIT.on_campus?.should be_false
    end
  end
end
