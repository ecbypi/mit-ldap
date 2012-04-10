require 'mit-ldap'
require 'ldaptic/adapters/ldap_conn_adapter'

module MIT
  describe LDAP do

    # Use the legacy MIT ldap server that is accessible from off campus
    # so we can use a LDAP::Conn instance for stubbing tests
    #
    # Server is not properly configured so the attributes required
    # by Ldaptic when configuring class hierarchy do not exist resulting
    # searches failing (i.e., this method should only be used to get around
    # ldap-too only being accessible from campus)
    let!(:connection) { ::LDAP::Conn.new('ldap.mit.edu') }

    def stub_ldap_connection
      ::LDAP::Conn.stub(:new).and_return(connection)
      stub_ldaptic_adapter(connection)
    end

    def stub_ldaptic_adapter(connection = nil)
      adapter = double('adapter')
      adapter.stub(:instance_variable_get).with(:@connection).and_return(connection)
      LDAP.stub(:adapter).and_return(adapter)
    end

    def stub_ldaptic_include
      Ldaptic.stub(:Module).and_return(MIT::LDAP)
    end

    describe ".connect!" do
      describe "when off campus" do

        it "returns false" do
          MIT.stub(:on_campus?).and_return(false)
          LDAP.connect!.should be_false
        end
      end

      describe "when on campus" do
        before :each do
          MIT.stub(:on_campus?).and_return(true)
          stub_ldap_connection
          stub_ldaptic_include
        end

        it "sets up ldap connection" do
          ::LDAP::Conn.should_receive(:new).with('ldap-too.mit.edu')
          LDAP.connect!
        end

        it "includes Ldaptic::Module" do
          Ldaptic.should_receive(:Module).
            with(:adapter => :ldap_conn,
                 :base => 'dc=mit,dc=edu',
                 :connection => connection,
                 :host => 'ldap-too.mit.edu'
                )
          LDAP.connect!
        end
      end
    end
  end
end
