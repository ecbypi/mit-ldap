# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'mit/ldap/version'

Gem::Specification.new do |s|
  s.name        = 'mit-ldap'
  s.version     = MIT::LDAP::VERSION
  s.authors     = ['Eduardo Gutierrez']
  s.email       = ['edd_d@mit.edu']
  s.homepage    = 'https://github.com/ecbypi/mit-ldap'
  s.summary     = %q{Ruby interface for querying MIT LDAP server}
  s.description = %q{Ruby interface for querying MIT LDAP server (only if you're on MITnet)}

  s.rubyforge_project = 'mit-ldap'

  s.files         = `git ls-files`.split('\n')
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split('\n')
  s.executables   = `git ls-files -- bin/*`.split('\n').map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'ldaptic', '~> 0.2'
  s.add_dependency 'ruby-ldap', '~> 0.9'
  s.add_dependency 'cocaine', '~> 0.2'

  s.add_development_dependency 'rspec', '~> 2.11'
end
