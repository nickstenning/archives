require File.dirname(__FILE__) + '/../spec_helper'

describe "Organisation" do
  fixtures :all
      
  before do
    @cuadc = organisations(:cuadc)
  end
  
  it "organisation sanity" do
    assert_kind_of Organisation, @cuadc
  end
  
  it "organisation organisation roles" do    
    assert_respond_to @cuadc.organisation_roles, :each
    @cuadc.organisation_roles.length.should == 4
    @cuadc.organisation_roles.include?(organisation_roles(:angus_cuadc_member)).should_not == nil
  end
  
  it "organisation people" do
    people_from_organisation_roles = @cuadc.organisation_roles.map do |o_r|
      o_r.person
    end.uniq
    
    assert_respond_to @cuadc.people, :each
    @cuadc.people.length.should == 4
    @cuadc.people.should == people_from_organisation_roles
    @cuadc.people.include?(people(:angus)).should_not == nil
  end
  
  it "organisation shows" do
    assert_respond_to @cuadc.shows, :each
    @cuadc.shows.length.should == 2
    
    @cuadc.shows.first.name.should == 'Hamlet'
  end
  
  it "organisation items" do
    @adc = organisations(:adc_theatre)
    
    assert_respond_to @adc.items, :each
    @adc.items.length.should == 1
    @adc.items.first.should == items(:book)
  end
  
  it "organisation name validation" do
    @org = Organisation.new
    
    @org.valid?
    # An Organisation without a name should NOT be valid
    @org.errors.on(:name).should == "can't be blank"
    
    @org.name = "Pembroke College"
    @org.valid?
    # An Organisation with a name should be valid
    @org.errors.on(:name).should == nil
  end
    
end
