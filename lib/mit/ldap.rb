module MIT
  module LDAP

    class << self
      def search(options = {})
        []
      end

      def connect!
        if MIT.on_campus? && !adapter_present?
          include Ldaptic::Module(
            :adapter => :ldap_conn,
            :connection => ::LDAP::Conn.new('ldap-too.mit.edu'),
            :host => 'ldap-too.mit.edu',
            :base => 'dc=mit,dc=edu'
          )

          instance_eval do
            def search(options = {})
              connected? || reconnect! ? super : []
            end
          end
        end

        connected?
      end

      def connected?
        !connection.nil?
      end

      def reconnect!
        if adapter_present?
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
