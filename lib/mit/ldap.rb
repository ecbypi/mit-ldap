module MIT
  module LDAP

    class << self
      def connect!
        if MIT.on_campus?
          include Ldaptic::Module(
            :adapter => :ldap_conn,
            :connection => ::LDAP::Conn.new('ldap-too.mit.edu'),
            :host => 'ldap-too.mit.edu',
            :base => 'dc=mit,dc=edu',
          )
        end
        return connected?
      end

      def connected?
        !connection.nil?
      end

      def reconnect!
        if adapter_present? && !connected?
          adapter.instance_variable_set(:@connection, ::LDAP::Conn.new('ldap-too.mit.edu'))
        elsif !adapter_present?
          connect!
        end
      end

      private

      def connection
        adapter.instance_variable_get(:@connection) if adapter_present?
      end

      def adapter_present?
        respond_to?(:adapter)
      end
    end
  end
end
