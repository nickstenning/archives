require File.dirname(__FILE__) + '/../spec_helper'

describe "Attachment" do
  fixtures :items, :attachments
  
  before do
    @book_page_2 = attachments(:book_page_2)
  end
  
  it "should have a document id" do
    @book_page_2.doc_id.should == "page_2"
  end
  
  it "can be associated with an item" do
    @book_page_2.item.should == items(:book)
  end
  
  it "should not allow blank doc_ids" do
    @attachment = Attachment.new
    
    @attachment.valid?
    # An Attachment with no doc_id should NOT be valid
    @attachment.errors.on(:doc_id).should == "can't be blank"
    
    @attachment.doc_id = "nonblank"
    @attachment.valid?
    # An Attachment with a doc_id should be valid
    @attachment.errors.on(:doc_id).should == nil
  end
  
  it "should not allow non-unique doc_ids" do
    @attachment = Attachment.new
    
    @attachment.doc_id = "page_2"
    @attachment.valid?
    @attachment.errors.on(:doc_id).should == "must be unique"
  end
  
  it "should provide a path to the original file" do
    archives_path = AppConfig.archives_path
    @book_page_2.original_path.should == "#{archives_path}/#{@book_page_2.doc_id}/#{@book_page_2.doc_id}.tif"
  end
  
  it "should provide a path to a PDF version" do
    archives_path = AppConfig.archives_path
    @book_page_2.pdf_path.should == "#{archives_path}/#{@book_page_2.doc_id}/#{@book_page_2.doc_id}.pdf"
  end
  
  it "should provide a path to a PNG thumbnail" do
    archives_path = AppConfig.archives_path
    @book_page_2.thumbnail_path.should == "#{archives_path}/#{@book_page_2.doc_id}/#{@book_page_2.doc_id}_H100.png"
  end
end
