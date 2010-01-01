require File.dirname(__FILE__) + '/../spec_helper'

describe "ItemLinking" do
  fixtures :items, :item_linkings, :organisations

  before do
    @footlights_flyer = item_linkings(:footlights_flyer)
  end
  
  it "should have an item" do
    assert_kind_of Item, @footlights_flyer.item
    @footlights_flyer.item.should == items(:flyer)
  end

  it "should have a linked object" do
    assert_kind_of Organisation, @footlights_flyer.linked_object
    @footlights_flyer.linked_object.should == organisations(:footlights)
  end
  
end
