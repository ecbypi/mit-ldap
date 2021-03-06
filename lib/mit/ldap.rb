require 'ldaptic'
require 'logger'

module MIT::LDAP
  class << self
    attr_accessor :logger

    def logger
      @logger ||= Logger.new('mit-ldap.log')

      adapter_present? ? adapter.logger : @logger
    end

    def connect!
      if MIT.on_campus? && !adapter_present?
        include Ldaptic::Module(
          :adapter => :net_ldap,
          :host => 'ldap-too.mit.edu',
          :base => 'dc=mit,dc=edu',
          :logger => logger
        )

        instance_eval do
          def search(options = {})
            connected? || reconnect! ? super : []
          end
        end
      elsif MIT.on_campus? && adapter_present? && !connected?
        reconnect!
      end

      connected?
    end

    def connected?
      !connection.nil?
    end

    private

    def reconnect!
      adapter.instance_variable_set(:@connection, Net::LDAP.new(host: 'ldap-too.mit.edu'))
    end

    def connection
      adapter.instance_variable_get(:@connection) if adapter_present?
    end

    def adapter_present?
      respond_to?(:adapter)
    end
  end
end
