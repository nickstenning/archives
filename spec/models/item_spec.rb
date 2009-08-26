require File.dirname(__FILE__) + '/../spec_helper'

describe "Item" do
  fixtures :items, :item_files

  before do
    @book = items(:book)
  end
  
  it "item sanity" do
    assert_kind_of Item, @book
  end
  
  it "item description" do
    @book.description.should_not == nil
    @book.description.should == "A Book with Three Pages"
  end
  
  it "item item files" do
    assert_respond_to @book.item_files, :each
    @book.item_files.length.should == 3
    @book.item_files.include?(item_files(:book_page_1)).should_not == nil
    @book.item_files.include?(item_files(:book_page_2)).should_not == nil
    @book.item_files.include?(item_files(:book_page_3)).should_not == nil
  end
  
  it "item description validation" do
    @item = Item.new
    
    # Pretend we're on the page for updating the description.
    @item.stage = 'description'
    
    @item.valid?
    @item.errors.on(:description).should == "can't be blank"
    
    @item.description = "Return to the Forbidden Two-Storey House Flyer"
    @item.valid?
    @item.errors.on(:description).should == nil
  end

end
