module MIT

  def self.on_campus_network?
    !(hostname =~ /\.mit\.edu$/i).nil?
  end

  private

  def self.hostname
    @hostname ||= `hostname`
  end
end

require 'mit/ldap'
