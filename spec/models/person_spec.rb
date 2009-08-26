require File.dirname(__FILE__) + '/../spec_helper'

describe "Person" do
  fixtures :all
      
  before do
    @angus = people(:angus)
  end
  
  it "person sanity" do
    assert_kind_of Person, @angus
  end
  
  it "person name" do
    @angus.name.should_not == nil
    @angus.name.should == "Angus McPhee"
  end
  
  it "person organisation roles" do    
    assert_respond_to @angus.organisation_roles, :each
    @angus.organisation_roles.length.should == 1
    @angus.organisation_roles.first.should == organisation_roles(:angus_cuadc_member)
  end
  
  it "person organisations" do
    organisations_from_organisation_roles = @angus.organisation_roles.map do |o_r|
      o_r.organisation
    end.uniq
    
    assert_respond_to @angus.organisations, :each
    @angus.organisations.length.should == 1
    @angus.organisations.first.should == organisations(:cuadc)
    
    # This is the real functional mapping:
    @angus.organisations.should == organisations_from_organisation_roles
  end
  
  it "person show roles" do
    assert_respond_to @angus.show_roles, :each
    @angus.show_roles.length.should == 2
    @angus.show_roles.include?(show_roles(:angus_hamlet_td)).should_not == nil
    @angus.show_roles.include?(show_roles(:angus_rg_mc)).should_not == nil
  end
  
  it "person shows" do
    shows_from_show_roles = @angus.show_roles.map do |s_r|
      s_r.show
    end.uniq
    
    assert_respond_to @angus.shows, :each
    @angus.shows.length.should == 2
    @angus.shows.include?( shows(:hamlet) ).should_not == nil
    @angus.shows.include?( shows(:rosencrantz_and_guildenstern) ).should_not == nil
    
    @angus.shows.should == shows_from_show_roles
  end
  
  it "person items" do
    @jane = people(:jane)
    
    assert_respond_to @jane.items, :each
    @jane.items.length.should == 1
    @jane.items.first.should == items(:ancient_document)
  end
  
  it "person name validation" do
    @person = Person.new
    @person.valid?
    # A Person without a name should NOT be valid
    @person.errors.on(:name).should == "can't be blank"
    
    @person.name = "Rick Astley"
    @person.valid?
    # A Person with a name should be valid... yes, *even* if he's Rick Astley.
    @person.errors.on(:name).should == nil
  end
  
end
