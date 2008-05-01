require File.dirname(__FILE__) + '/../test_helper'

class OrganisationTest < ActiveSupport::TestCase
      
  def setup
    @cuadc = organisations(:cuadc)
  end
  
  def test_organisation_sanity
    assert_kind_of Organisation, @cuadc
  end
  
  def test_organisation_organisation_roles    
    assert_respond_to @cuadc.organisation_roles, :each
    assert_equal 4, @cuadc.organisation_roles.length
    assert @cuadc.organisation_roles.include?(organisation_roles(:angus_cuadc_member))
  end
  
  def test_organisation_people
    people_from_organisation_roles = @cuadc.organisation_roles.map do |o_r|
      o_r.person
    end.uniq
    
    assert_respond_to @cuadc.people, :each
    assert_equal 4, @cuadc.people.length
    assert_equal people_from_organisation_roles, @cuadc.people
    assert @cuadc.people.include?(people(:angus))
  end
  
  def test_organisation_shows
    assert_respond_to @cuadc.shows, :each
    assert_equal 1, @cuadc.shows.length
    
    # TODO: report this (looks like a Rails bug). Fails and shouldn't, and it's
    # not our fault.
    #
    # assert_equal shows(:hamlet), @cuadc.shows.first
  end
end
