require File.dirname(__FILE__) + '/../spec_helper'

describe "Attachment" do
  fixtures :items, :attachments
  
  before do
    @book_page_2 = attachments(:book_page_2)
  end
  
  it "item file sanity" do
    assert_kind_of Attachment, @book_page_2
  end
  
  it "item file doc_id" do
    @book_page_2.doc_id.should == "page_2"
  end
  
  it "item file item" do
    @book_page_2.item.should == items(:book)
  end
  
  it "item file doc_id validation" do
    @attachment = Attachment.new
    
    @attachment.valid?
    # An Attachment with no doc_id should NOT be valid
    @attachment.errors.on(:doc_id).should == "can't be blank"
    
    @attachment.doc_id = "nonblank"
    @attachment.valid?
    # An Attachment with a doc_id should be valid
    @attachment.errors.on(:doc_id).should == nil
  end
  
end
