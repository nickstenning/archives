require File.dirname(__FILE__) + '/../test_helper'

class ItemLinkingTest < ActiveSupport::TestCase

  def setup
    @footlights_flyer = item_linkings(:footlights_flyer)
  end
  
  def test_item_linking_sanity
    assert_kind_of ItemLinking, @footlights_flyer
  end
  
  def test_item_linking_item
    assert_not_nil @footlights_flyer.item
    assert_kind_of Item, @footlights_flyer.item
    assert_equal items(:flyer), @footlights_flyer.item
  end

  # Bonus points to he who thinks of a better name for this method:
  def test_item_linking_item_linking
    assert_not_nil @footlights_flyer.item_linking
    assert_kind_of Organisation, @footlights_flyer.item_linking
    assert_equal organisations(:footlights), @footlights_flyer.item_linking
  end
  
end
