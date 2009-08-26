require File.dirname(__FILE__) + '/../spec_helper'

describe "Show" do
  fixtures :all

  before do
    @rg = shows(:rosencrantz_and_guildenstern)
  end
  
  it "show sanity" do
    assert_kind_of Show, @rg
  end
  
  it "show show roles" do    
    assert_respond_to @rg.show_roles, :each
    @rg.show_roles.length.should == 4
    @rg.show_roles.include?(show_roles(:jane_rg_cast)).should_not == nil
    @rg.show_roles.include?(show_roles(:anna_rg_td)).should_not == nil
  end
  
  it "show people" do
    people_from_show_roles = @rg.show_roles.map do |s_r|
      s_r.person
    end.uniq
    
    assert_respond_to @rg.people, :each
    @rg.people.length.should == 4
    @rg.people.should == people_from_show_roles
    @rg.people.include?(people(:angus)).should_not == nil
    @rg.people.include?(people(:john)).should_not == nil
  end

  it "show organisations" do
    assert_respond_to @rg.organisations, :each
    @rg.organisations.length.should == 1
    
    @rg.organisations.first.name.should == "BATS"
  end
  
  it "show events" do    
    assert_respond_to @rg.events, :each
    @rg.events.length.should == 1
    @rg.events.first.should == events(:rg_at_adc)
  end
  
  it "show venues" do
    venues_from_events = @rg.events.map do |e|
      e.venue
    end.uniq
    
    assert_respond_to @rg.venues, :each
    @rg.venues.length.should == 1
    @rg.venues.should == venues_from_events
    @rg.venues.first.should == venues(:adc_auditorium)
  end
  
  it "show items" do
    @panto = shows(:panto)
    
    assert_respond_to @panto.items, :each
    @panto.items.length.should == 1
    @panto.items.first.should == items(:flyer)
  end
  
  it "show name validation" do
    @show = Show.new
    
    @show.valid?
    # A Show without a name should NOT be valid"
    @show.errors.on(:name).should == "can't be blank"
    
    @show.name = "Return to the Forbidden Two-Storey House"
    @show.valid?
    # A Show with a name should be valid
    @show.errors.on(:name).should == nil
  end

end
