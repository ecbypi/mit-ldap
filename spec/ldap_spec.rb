require 'mit-ldap'

module MIT
  describe LDAP do
    it "has a logger instance before connecting" do
      LDAP.logger.should be_instance_of Logger
    end

    describe ".search" do
      it "returns empty array before connecting" do
        MIT::LDAP.search.should eq []
      end
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
          @logger = LDAP.logger

          LDAP.connect!
        end

        it ":connected? is true" do
          LDAP.connected?.should be_true
        end

        it "an Ldaptic::Adapter is set" do
          LDAP.adapter.should be_a Ldaptic::Adapters::LDAPConnAdapter
        end

        it "redefines the search method to check if the connection has expired" do
          LDAP.adapter.should_receive(:search).and_return([])

          LDAP.search(filter: { uid: 'mrhalp' })
        end

        it "prevents being called twice" do
          LDAP.should_not_receive(:include)

          LDAP.connect!
        end

        it "calls :reconnect! if connected already" do
          LDAP.should_receive(:reconnect!)

          LDAP.connect!
        end

        it "uses it's own logger as the adapter's" do
          LDAP.adapter.logger.should eq @logger
        end
      end
    end

    describe ".reconnect!" do
      it "reloads connection object" do
        LDAP.adapter.instance_variable_set(:@connection, nil)
        LDAP.reconnect!
        LDAP.adapter.instance_variable_get(:@connection).should be_a ::LDAP::Conn
      end

      it "calls .connect! if not connected already" do
        LDAP.stub(:adapter_present?).and_return(false)
        LDAP.should_receive(:connect!)
        LDAP.reconnect!
      end
    end
  end
end
