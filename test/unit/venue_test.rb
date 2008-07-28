require File.dirname(__FILE__) + '/../test_helper'

class VenueTest < ActiveSupport::TestCase

  def setup
    @adc_auditorium = venues(:adc_auditorium)
  end
  
  def test_venue_sanity
    assert_kind_of Venue, @adc_auditorium
  end
  
  def test_venue_name
    assert_not_nil @adc_auditorium.name
    assert_equal "ADC Theatre, Main Auditorium", @adc_auditorium.name
  end
  
  def test_venue_events
    assert_respond_to @adc_auditorium.events, :each
    assert_equal 2, @adc_auditorium.events.length
    assert @adc_auditorium.events.include?(events(:hamlet_at_adc))
    assert @adc_auditorium.events.include?(events(:rg_at_adc))
  end
  
  def test_venue_name_validation
    @venue = Venue.new
    
    @venue.valid?
    # A Venue without a name should NOT be valid
    assert_equal "can't be blank", @venue.errors.on(:name)
    
    @venue.name = "The Corpus Cupboard-under-the-stairs"
    @venue.valid?
    # A Venue with a name should be valid
    assert_nil @venue.errors.on(:name)
  end

end
