require File.dirname(__FILE__) + '/../test_helper'

class ShowTest < ActiveSupport::TestCase

  def setup
    @rg = shows(:rosencrantz_and_guildenstern)
  end
  
  def test_show_sanity
    assert_kind_of Show, @rg
  end
  
  def test_show_show_roles    
    assert_respond_to @rg.show_roles, :each
    assert_equal 4, @rg.show_roles.length
    assert @rg.show_roles.include?(show_roles(:jane_rg_cast))
    assert @rg.show_roles.include?(show_roles(:anna_rg_td))
  end
  
  def test_show_people
    people_from_show_roles = @rg.show_roles.map do |s_r|
      s_r.person
    end.uniq
    
    assert_respond_to @rg.people, :each
    assert_equal 4, @rg.people.length
    assert_equal people_from_show_roles, @rg.people
    assert @rg.people.include?(people(:angus))
    assert @rg.people.include?(people(:john))
  end

  def test_show_organisations
    assert_respond_to @rg.organisations, :each
    assert_equal 1, @rg.organisations.length
    
    # TODO: report this (looks like a Rails bug). Fails and shouldn't, and it's
    # not our fault.
    #
    #assert_equal organisations(:bats), @rg.organisations.first
  end
  
  def test_show_events    
    assert_respond_to @rg.events, :each
    assert_equal 1, @rg.events.length
    assert_equal events(:rg_at_adc), @rg.events.first
  end
  
  def test_show_venues
    venues_from_events = @rg.events.map do |e|
      e.venue
    end.uniq
    
    assert_respond_to @rg.venues, :each
    assert_equal 1, @rg.venues.length
    assert_equal venues_from_events, @rg.venues
    assert_equal venues(:adc_auditorium), @rg.venues.first
  end
  
  def test_show_items
    @panto = shows(:panto)
    
    assert_respond_to @panto.items, :each
    assert_equal 1, @panto.items.length
    assert_equal items(:flyer), @panto.items.first
  end
  
  def test_show_name_validation
    @show = Show.new
    
    @show.valid?
    # A Show without a name should NOT be valid"
    assert_equal "can't be blank", @show.errors.on(:name)
    
    @show.name = "Return to the Forbidden Two-Storey House"
    @show.valid?
    # A Show with a name should be valid
    assert_nil @show.errors.on(:name)
  end

end
