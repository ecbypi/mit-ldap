require 'mit-ldap'

module MIT
  module LDAP
    describe Search do
      if MIT.on_campus_network?
        it "includes Ldaptic::Module" do
          should respond_to :search
          should respond_to :find
        end
      else
        it "defines stubs that return empty arrays" do
          Search.search.should eq []
          Search.find.should be_instance_of Search::InetOrgPerson
        end
      end
    end
  end
end
