require 'mit-ldap'

module MIT
  describe LDAP do
    describe ".connect!" do

      describe "when off campus" do
        it "returns false" do
          MIT.stub(:on_campus?).and_return(false)
          LDAP.connect!.should be_false
        end
      end

      describe "when on campus" do
        before :all do
          LDAP.connect!
        end

        it ":connected? is true" do
          LDAP.connected?.should be_true
        end

        it "an Ldaptic::Adapter is set" do
          LDAP.adapter.should be_a Ldaptic::Adapters::LDAPConnAdapter
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
