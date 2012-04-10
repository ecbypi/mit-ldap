# mit-ldap

Ruby wrapper for the MIT LDAP server. Can only be used if on MIT campus network. Leverages tpope's wonderful [Ldaptic](https://github.com/tpope/ldaptic)

## Installation:

```
gem 'mit-ldap'
```

## Usage:

```ruby
require 'mit-ldap'
MIT::LDAP.connect!
MIT::LDAP.search(:filter => '(uid=mrhalp)') # any Ldaptic syntax
```
