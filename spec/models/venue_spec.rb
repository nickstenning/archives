require File.dirname(__FILE__) + '/../spec_helper'

describe "Venue" do
  fixtures :venues, :events

  before do
    @adc_auditorium = venues(:adc_auditorium)
  end
  
  it "venue sanity" do
    assert_kind_of Venue, @adc_auditorium
  end
  
  it "venue name" do
    @adc_auditorium.name.should_not == nil
    @adc_auditorium.name.should == "ADC Theatre, Main Auditorium"
  end
  
  it "venue events" do
    assert_respond_to @adc_auditorium.events, :each
    @adc_auditorium.events.length.should == 2
    @adc_auditorium.events.include?(events(:hamlet_at_adc)).should_not == nil
    @adc_auditorium.events.include?(events(:rg_at_adc)).should_not == nil
  end
  
  it "venue name validation" do
    @venue = Venue.new
    
    @venue.valid?
    # A Venue without a name should NOT be valid
    @venue.errors.on(:name).should == "can't be blank"
    
    @venue.name = "The Corpus Cupboard-under-the-stairs"
    @venue.valid?
    # A Venue with a name should be valid
    @venue.errors.on(:name).should == nil
  end

end
