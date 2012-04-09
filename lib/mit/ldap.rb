module MIT
  module LDAP

    class << self
      attr_accessor :connection
    end

    def self.connect!
      if MIT.on_campus?
        self.connection = ::LDAP::Conn.new('ldap-too.mit.edu')
        singleton_class.send(:include,
          Ldaptic::Module(
            adapter: :ldap_conn,
            connection: connection,
            host: 'ldap-too.mit.edu',
            base: 'dc=mit,dc=edu',
          )
        )
      end
      return !self.connection.nil?
    end
  end
end
