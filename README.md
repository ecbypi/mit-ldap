# mit-ldap

Ruby wrapper for the MIT LDAP server. Can only be used if on the MIT campus
network. Leverages tpope's wonderful
[Ldaptic](https://github.com/tpope/ldaptic)

## Installation:

```
gem 'mit-ldap'
```

## Usage:

```ruby
require 'mit-ldap'
MIT::LDAP.connect! # => true
MIT::LDAP.search(:filter => '(uid=mrhalp)') # => any Ldaptic options/methods

# if the connection fails or expires

MIT::LDAP.connected? # => false
MIT::LDAP.connect! # => true (re-establishes connection)
```

Stubbing out the LDAP server in development can be difficult as it requires
setting up a private LDAP server or continuously being on campus for
development. This library maintains the expected interface (`logger`, `search`)
that can be faked in the event where the connection cannot be made or has
failed and cannot be made again.
