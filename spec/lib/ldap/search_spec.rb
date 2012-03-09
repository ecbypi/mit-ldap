require 'mit-ldap'

module MIT
  module LDAP
    describe Search do
      it "includes Ldaptic::Module" do
        should respond_to :search
        should respond_to :find
      end
    end
  end
end
