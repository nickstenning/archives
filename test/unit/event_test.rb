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
    assert (@hamlet_at_minack.start < @hamlet_at_minack.end), "An Event should start before it ends"
  end
  
  def test_event_venue
    assert_not_nil @hamlet_at_minack.venue
    assert_kind_of Venue, @hamlet_at_minack.venue
    assert_equal venues(:minack), @hamlet_at_minack.venue
  end
  
  def test_event_start_before_end_validation
    @ev = Event.new
    @ev.start = "2008-07-23 19:30:00"
    @ev.end = "2008-07-23 21:00:00"
    @ev.valid?
    # An Event that ends after it starts should be valid"
    assert_nil @ev.errors.on(:start)
    assert_nil @ev.errors.on(:end)

    @ev.start, @ev.end = @ev.end, @ev.start
    @ev.valid?
    # An Event that ends BEFORE it starts should NOT be valid
    assert_equal "must be before the event end time", @ev.errors.on(:start)
  end
  
  def test_event_start_and_end_not_nil_validation
    @ev = Event.new
    
    @ev.valid?
    # An Event with no start or end time should NOT be valid
    assert_equal "is not a valid date/time", @ev.errors.on(:start)
    assert_equal "is not a valid date/time", @ev.errors.on(:end)
    
    @ev.start = "2008-07-23 19:30:00"
    @ev.valid?
    # An Event with no end time should NOT be valid
    assert_equal "is not a valid date/time", @ev.errors.on(:end)
    assert_nil @ev.errors.on(:start)
    
    @ev.start = nil
    @ev.end = "2008-07-23 19:30:00"
    @ev.valid?
    # An Event with no start time should NOT be valid
    assert_equal "is not a valid date/time", @ev.errors.on(:start)
    assert_nil @ev.errors.on(:end)
  end
  
end
