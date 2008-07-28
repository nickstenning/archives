require File.dirname(__FILE__) + '/../test_helper'

class OrganisationRoleTest < ActiveSupport::TestCase

  def setup
    @jane_bats_president = organisation_roles(:jane_bats_president)
  end 
  
  def test_organisation_role_sanity
    assert_kind_of OrganisationRole, @jane_bats_president
  end
  
  def test_organisation_role_name
    assert_not_nil @jane_bats_president.name
    assert_equal "President", @jane_bats_president.name
  end

  def test_organisation_role_organisation
    assert_not_nil @jane_bats_president.organisation
    assert_kind_of Organisation, @jane_bats_president.organisation
    assert_equal organisations(:bats), @jane_bats_president.organisation
  end
  
  def test_organisation_role_person
    assert_not_nil @jane_bats_president.person
    assert_kind_of Person, @jane_bats_president.person
    assert_equal people(:jane), @jane_bats_president.person
  end
  
  def test_organisation_role_name_validation
    @or = OrganisationRole.new
    
    @or.valid?
    # An OrganisationRole without a name should NOT be valid
    assert_equal "can't be blank", @or.errors.on(:name)
    
    @or.name = "General Manager"
    @or.valid?
    # An OrganisationRole with a name should be valid
    assert_nil @or.errors.on(:name)
  end

end
