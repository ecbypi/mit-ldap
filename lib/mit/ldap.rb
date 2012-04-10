module MIT
  module LDAP

    def self.connect!
      if MIT.on_campus?
        ldap_connection = ::LDAP::Conn.new('ldap-too.mit.edu')
        singleton_class.send(:include,
          Ldaptic::Module(
            :adapter => :ldap_conn,
            :connection => ldap_connection,
            :host => 'ldap-too.mit.edu',
            :base => 'dc=mit,dc=edu',
          )
        )
      end
      return connected?
    end

    def self.connection
      respond_to?(:adapter) ? adapter.instance_variable_get(:@connection) : nil
    end

    def self.connected?
      !self.connection.nil?
    end
  end
end
