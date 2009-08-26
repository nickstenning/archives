require File.dirname(__FILE__) + '/../spec_helper'

describe "User" do
  fixtures :users, :people

  before do
    @user_jane = users(:jane)
    @user_john = users(:john)
  end
  
  it "user sanity" do
    assert_kind_of User, @user_jane
  end
  
  it "user person" do
    assert_respond_to @user_jane, :person
    @user_jane.person.should == people(:jane)
  end
  
  it "user found by find or create by camdram result" do
    result = {
      :status => "OK", 
      :number => "1234", 
      :loginname => "jor123", 
      :realname => "Jane O'Reilly from Camdram"
    }
    User.find_or_create_by_camdram_result(result).should == @user_jane
  end
  
  it "user created by find or create by camdram result" do
    result = {
      :status => "OK", 
      :number => "9876", 
      :loginname => "abc987", 
      :realname => "Alan Cox"
    }
    user = User.find_or_create_by_camdram_result(result)
    assert_kind_of User, user
    user.person.should == nil
    user.camdram_loginname.should == "abc987"
    user.camdram_realname.should == "Alan Cox"
  end
  
  it "user name from person if person specified" do
    @user_jane.name # Note this is NOT "Jane O'Reilly from Camdram".should == "Jane O'Reilly"
  end
  
  it "user name from camdram if no person" do
    result = {
      :status => "OK", 
      :number => "9876", 
      :loginname => "abc987", 
      :realname => "Alan Cox"
    }
    user = User.find_or_create_by_camdram_result(result)
    user.name.should == "Alan Cox"
  end

end
