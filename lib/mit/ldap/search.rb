require 'ldap'
require 'ldaptic'

module MIT
  module LDAP
    module Search
      if MIT.on_campus_network?
        include Ldaptic::Module(
          host: 'ldap-too.mit.edu',
          base: 'dc=mit,dc=edu',
          adapter: :ldap_conn
        )
      else
        class InetOrgPerson
        end

        def self.search(*args)
          []
        end

        def self.find(*args)
          InetOrgPerson.new
        end
      end
    end
  end
end
