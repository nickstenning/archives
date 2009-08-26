require File.dirname(__FILE__) + '/../spec_helper'

describe "ShowRole" do
  fixtures :show_roles, :shows, :people
  
  before do
    @angus_hamlet_td = show_roles(:angus_hamlet_td)
  end 
  
  it "show role sanity" do
    assert_kind_of ShowRole, @angus_hamlet_td
  end
  
  it "show role name" do
    @angus_hamlet_td.name.should_not == nil
    @angus_hamlet_td.name.should == "Technical Director"
  end
  
  it "show role show" do
    @angus_hamlet_td.show.should_not == nil
    assert_kind_of Show, @angus_hamlet_td.show
    @angus_hamlet_td.show.should == shows(:hamlet)
  end
  
  it "show role person" do
    @angus_hamlet_td.person.should_not == nil
    assert_kind_of Person, @angus_hamlet_td.person
    @angus_hamlet_td.person.should == people(:angus)
  end
  
  it "show role name validation" do
    @sr = ShowRole.new
    
    @sr.valid?
    # A ShowRole without a name should NOT be valid
    @sr.errors.on(:name).should == "can't be blank"
    
    @sr.name = "Master Carpenter"
    @sr.valid?
    # A ShowRole with a name should be valid
    @sr.errors.on(:name).should == nil
  end

end
