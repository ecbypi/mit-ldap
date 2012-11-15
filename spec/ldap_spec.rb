require 'mit-ldap'

module MIT
  describe LDAP do
    it "has a logger instance before connecting" do
      LDAP.logger.should be_instance_of Logger
    end

    describe ".connect!" do
      describe "when off campus" do
        it "returns false" do
          MIT.stub(:on_campus?).and_return(false)
          LDAP.connect!.should be_false
        end
      end

      describe "when on campus" do
        before :all do
          # kind of gross to pull into an instance variable to use later, but
          # these tests are so state dependent, it's the best middle ground
          @logger = LDAP.logger

          LDAP.connect!
        end

        it ":connected? is true" do
          LDAP.connected?.should be_true
        end

        it "an Ldaptic::Adapter is set" do
          LDAP.adapter.should_not be_nil
        end

        it "redefines the :search to return empty results if connection is lost" do
          LDAP.stub(:connected?).and_return(false)
          LDAP.stub(:reconnect!).and_return(nil)

          LDAP.search(:filter => { :uid => 'mrhalp' }).should eq []
        end

        it "prevents including Ldaptic::Module twice" do
          LDAP.should_not_receive(:include)

          LDAP.connect!
        end

        it "uses it's own logger as the adapter's" do
          LDAP.adapter.logger.should eq @logger
        end

        it "reloads connection object if previously connected and connection is nil" do
          LDAP.adapter.instance_variable_set(:@connection, nil)

          LDAP.connect!

          LDAP.adapter.instance_variable_get(:@connection).should_not be_nil
        end
      end
    end
  end
end
