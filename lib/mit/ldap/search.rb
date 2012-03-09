require 'ldap'
require 'ldaptic'

module MIT
  module LDAP
    module Search
      include Ldaptic::Module(
        host: 'ldap-too.mit.edu',
        base: 'dc=mit,dc=edu',
        adapter: :ldap_conn
      )
    end
  end
end
