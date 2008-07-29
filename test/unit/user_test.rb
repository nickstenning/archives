require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user_jane = users(:jane)
    @user_john = users(:john)
  end
  
  def test_user_sanity
    assert_kind_of User, @user_jane
  end
  
  def test_user_person
    assert_respond_to @user_jane, :person
    assert_equal people(:jane), @user_jane.person
  end
  
  def test_user_found_by_find_or_create_by_camdram_result
    result = {
      :status => "OK", 
      :number => "1234", 
      :loginname => "jor123", 
      :realname => "Jane O'Reilly from Camdram"
    }
    assert_equal @user_jane, User.find_or_create_by_camdram_result(result)
  end
  
  def test_user_created_by_find_or_create_by_camdram_result
    result = {
      :status => "OK", 
      :number => "9876", 
      :loginname => "abc987", 
      :realname => "Alan Cox"
    }
    user = User.find_or_create_by_camdram_result(result)
    assert_kind_of User, user
    assert_nil user.person
    assert_equal "abc987", user.camdram_loginname
    assert_equal "Alan Cox", user.camdram_realname
  end
  
  def test_user_name_from_person_if_person_specified
    assert_equal "Jane O'Reilly", @user_jane.name # Note this is NOT "Jane O'Reilly from Camdram"
  end
  
  def test_user_name_from_camdram_if_no_person
    result = {
      :status => "OK", 
      :number => "9876", 
      :loginname => "abc987", 
      :realname => "Alan Cox"
    }
    user = User.find_or_create_by_camdram_result(result)
    assert_equal "Alan Cox", user.name
  end

end
