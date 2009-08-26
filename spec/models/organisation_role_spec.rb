require File.dirname(__FILE__) + '/../spec_helper'

describe "OrganisationRole" do
  fixtures :organisation_roles, :organisations, :people

  before do
    @jane_bats_president = organisation_roles(:jane_bats_president)
  end 
  
  it "organisation role sanity" do
    assert_kind_of OrganisationRole, @jane_bats_president
  end
  
  it "organisation role name" do
    @jane_bats_president.name.should_not == nil
    @jane_bats_president.name.should == "President"
  end

  it "organisation role organisation" do
    @jane_bats_president.organisation.should_not == nil
    assert_kind_of Organisation, @jane_bats_president.organisation
    @jane_bats_president.organisation.should == organisations(:bats)
  end
  
  it "organisation role person" do
    @jane_bats_president.person.should_not == nil
    assert_kind_of Person, @jane_bats_president.person
    @jane_bats_president.person.should == people(:jane)
  end
  
  it "organisation role name validation" do
    @or = OrganisationRole.new
    
    @or.valid?
    # An OrganisationRole without a name should NOT be valid
    @or.errors.on(:name).should == "can't be blank"
    
    @or.name = "General Manager"
    @or.valid?
    # An OrganisationRole with a name should be valid
    @or.errors.on(:name).should == nil
  end

end
