require File.dirname(__FILE__) + '/../spec_helper'

describe "Event" do
  fixtures :events, :venues

  before do
    @hamlet_at_minack = events(:hamlet_at_minack)
  end
  
  it "event sanity" do
    assert_kind_of Event, @hamlet_at_minack
  end
  
  it "event start" do
    @hamlet_at_minack.start.should_not == nil
    assert_kind_of Time, @hamlet_at_minack.start
  end
  
  it "event end" do
    @hamlet_at_minack.end.should_not == nil
    assert_kind_of Time, @hamlet_at_minack.end
  end
  
  it "event start before end" do
    @hamlet_at_minack.start.should < @hamlet_at_minack.end #, "An Event should start before it ends"
  end
  
  it "event venue" do
    @hamlet_at_minack.venue.should_not == nil
    assert_kind_of Venue, @hamlet_at_minack.venue
    @hamlet_at_minack.venue.should == venues(:minack)
  end
  
  it "event start before end validation" do
    @ev = Event.new
    @ev.start = "2008-07-23 19:30:00"
    @ev.end = "2008-07-23 21:00:00"
    @ev.valid?
    # An Event that ends after it starts should be valid"
    @ev.errors.on(:start).should == nil
    @ev.errors.on(:end).should == nil

    @ev.start, @ev.end = @ev.end, @ev.start
    @ev.valid?
    # An Event that ends BEFORE it starts should NOT be valid
    @ev.errors.on(:start).should == "must be before the event end time"
  end
  
  it "event start and end not nil validation" do
    @ev = Event.new
    
    @ev.valid?
    # An Event with no start or end time should NOT be valid
    @ev.errors.on(:start).should == "is not a valid date/time"
    @ev.errors.on(:end).should == "is not a valid date/time"
    
    @ev.start = "2008-07-23 19:30:00"
    @ev.valid?
    # An Event with no end time should NOT be valid
    @ev.errors.on(:end).should == "is not a valid date/time"
    @ev.errors.on(:start).should == nil
    
    @ev.start = nil
    @ev.end = "2008-07-23 19:30:00"
    @ev.valid?
    # An Event with no start time should NOT be valid
    @ev.errors.on(:start).should == "is not a valid date/time"
    @ev.errors.on(:end).should == nil
  end
  
end
