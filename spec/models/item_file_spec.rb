require File.dirname(__FILE__) + '/../spec_helper'

describe "ItemFile" do
  fixtures :items, :item_files
  
  before do
    @book_page_2 = item_files(:book_page_2)
  end
  
  it "item file sanity" do
    assert_kind_of ItemFile, @book_page_2
  end
  
  it "item file url" do
    @book_page_2.url.should_not == nil
    @book_page_2.url.should == "http://scanstore/book/page_2.pdf"
  end
  
  it "item file item" do
    @book_page_2.item.should_not == nil
    @book_page_2.item.should == items(:book)
  end
  
  it "item file url validation" do
    @item_file = ItemFile.new
    
    @item_file.valid?
    # An ItemFile with no URL should NOT be valid
    @item_file.errors.on(:url).should == "can't be blank"
    
    @item_file.url = "file:///path/to/file"
    @item_file.valid?
    # An ItemFile with a URL should be valid
    @item_file.errors.on(:url).should == nil
  end
  
end
