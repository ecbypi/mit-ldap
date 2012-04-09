require 'rbconfig'
require 'ldap'
require 'ldaptic'

module MIT

  class << self

    def on_campus?
      ip_addresses.split(/\n/).map { |ip| !(ip =~ /^18\./).nil? }.any?
    end

    private

    def ip_addresses
      if RbConfig::CONFIG['host_os'] =~ /darwin/
        `ifconfig | awk '/inet / {print $2}'`
       else
         `ifconfig | sed -rn 's/.*r:([^ ]+) .*/\1/p'`
       end
    end
  end
end

require 'mit/ldap'
require 'mit/ldap/version'
