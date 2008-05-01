require File.dirname(__FILE__) + '/../test_helper'

class EventTest < ActiveSupport::TestCase

  def setup
    @hamlet_at_minack = events(:hamlet_at_minack)
  end
  
  def test_event_sanity
    assert_kind_of Event, @hamlet_at_minack
  end
  
  def test_event_start
    assert_not_nil @hamlet_at_minack.start
    assert_kind_of Time, @hamlet_at_minack.start
  end
  
  def test_event_end
    assert_not_nil @hamlet_at_minack.end
    assert_kind_of Time, @hamlet_at_minack.end
  end
  
  def test_event_start_before_end
    assert (@hamlet_at_minack.start < @hamlet_at_minack.end)
  end
  
  def test_event_venue
    assert_not_nil @hamlet_at_minack.venue
    assert_kind_of Venue, @hamlet_at_minack.venue
    assert_equal venues(:minack), @hamlet_at_minack.venue
  end
  
end
