require 'rbconfig'
require 'ldaptic'
require 'cocaine'

module MIT

  class << self

    def on_campus?
      ip_addresses.map { |ip| !(ip =~ /^18\./).nil? }.any?
    end

    private

    def ip_addresses
      @ip_addresses ||= ifconfig.split(/\n/).grep(/inet (?:addr:)?((?:\d{1,3}\.){3}\d{1,3})/) { $1 }
    end

    def ifconfig
      @ifconfig ||= Cocaine::CommandLine.new('/sbin/ifconfig')
      @ifconfig.run
    end
  end
end

require 'mit/ldap'
require 'mit/ldap/version'
