require File.dirname(__FILE__) + '/../test_helper'

class ShowRoleTest < ActiveSupport::TestCase
  
  def setup
    @angus_hamlet_td = show_roles(:angus_hamlet_td)
  end 
  
  def test_show_role_sanity
    assert_kind_of ShowRole, @angus_hamlet_td
  end
  
  def test_show_role_name
    assert_not_nil @angus_hamlet_td.name
    assert_equal "Technical Director", @angus_hamlet_td.name
  end
  
  def test_show_role_show
    assert_not_nil @angus_hamlet_td.show
    assert_kind_of Show, @angus_hamlet_td.show
    assert_equal shows(:hamlet), @angus_hamlet_td.show
  end
  
  def test_show_role_person
    assert_not_nil @angus_hamlet_td.person
    assert_kind_of Person, @angus_hamlet_td.person
    assert_equal people(:angus), @angus_hamlet_td.person
  end

end
