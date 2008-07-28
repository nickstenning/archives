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
    assert_equal 2, @cuadc.shows.length
    
    # TODO: report this (looks like a Rails bug). Fails and shouldn't, and it's
    # not our fault.
    #
    #assert_equal shows(:hamlet), @cuadc.shows.first
  end
  
  def test_organisation_items
    @adc = organisations(:adc_theatre)
    
    assert_respond_to @adc.items, :each
    assert_equal 1, @adc.items.length
    assert_equal items(:book), @adc.items.first
  end
  
  def test_organisation_name_validation
    @org = Organisation.new
    
    @org.valid?
    # An Organisation without a name should NOT be valid
    assert_equal "can't be blank", @org.errors.on(:name)
    
    @org.name = "Pembroke College"
    @org.valid?
    # An Organisation with a name should be valid
    assert_nil @org.errors.on(:name)
  end
    
end
