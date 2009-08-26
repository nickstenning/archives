require File.dirname(__FILE__) + '/../spec_helper'

describe "ItemLinking" do
  fixtures :items, :item_linkings, :organisations

  before do
    @footlights_flyer = item_linkings(:footlights_flyer)
  end
  
  it "item linking sanity" do
    assert_kind_of ItemLinking, @footlights_flyer
  end
  
  it "item linking item" do
    @footlights_flyer.item.should_not == nil
    assert_kind_of Item, @footlights_flyer.item
    @footlights_flyer.item.should == items(:flyer)
  end

  # Bonus points to he who thinks of a better name for this method:
  it "item linking item linking" do
    @footlights_flyer.item_linking.should_not == nil
    assert_kind_of Organisation, @footlights_flyer.item_linking
    @footlights_flyer.item_linking.should == organisations(:footlights)
  end
  
end
