require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < ActiveSupport::TestCase
      
  def setup
    @angus = people(:angus)
  end
  
  def test_person_sanity
    assert_kind_of Person, @angus
  end
  
  def test_person_name
    assert_not_nil @angus.name
    assert_equal "Angus McPhee", @angus.name
  end
  
  def test_person_organisation_roles    
    assert_respond_to @angus.organisation_roles, :each
    assert_equal 1, @angus.organisation_roles.length
    assert_equal organisation_roles(:angus_cuadc_member), @angus.organisation_roles.first
  end
  
  def test_person_organisations
    organisations_from_organisation_roles = @angus.organisation_roles.map do |o_r|
      o_r.organisation
    end.uniq
    
    assert_respond_to @angus.organisations, :each
    assert_equal 1, @angus.organisations.length
    assert_equal organisations(:cuadc), @angus.organisations.first
    
    # This is the real functional mapping:
    assert_equal organisations_from_organisation_roles, @angus.organisations
  end
  
  def test_person_show_roles
    assert_respond_to @angus.show_roles, :each
    assert_equal 2, @angus.show_roles.length
    assert @angus.show_roles.include?(show_roles(:angus_hamlet_td))
    assert @angus.show_roles.include?(show_roles(:angus_rg_mc))
  end
  
  def test_person_shows
    shows_from_show_roles = @angus.show_roles.map do |s_r|
      s_r.show
    end.uniq
    
    assert_respond_to @angus.shows, :each
    assert_equal 2, @angus.shows.length
    assert @angus.shows.include?( shows(:hamlet) )
    assert @angus.shows.include?( shows(:rosencrantz_and_guildenstern) )
    
    assert_equal shows_from_show_roles, @angus.shows
  end
  
end
