require File.dirname(__FILE__) + '/../spec_helper'

describe "Attachment" do
  fixtures :items, :attachments
  
  before do
    @book_page_2 = attachments(:book_page_2)
  end
  
  it "item file sanity" do
    assert_kind_of Attachment, @book_page_2
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
    @attachment = Attachment.new
    
    @attachment.valid?
    # An Attachment with no URL should NOT be valid
    @attachment.errors.on(:url).should == "can't be blank"
    
    @attachment.url = "file:///path/to/file"
    @attachment.valid?
    # An Attachment with a URL should be valid
    @attachment.errors.on(:url).should == nil
  end
  
end
