require File.dirname(__FILE__) + '/../spec_helper'
require 'tempfile'

describe AttachmentsController do
  
  it "should return a PDF of the attachment" do
    mockpdf = Tempfile.new('mockpdf')
    mockpdf.write("This is not a PDF")
    
    att = mock_model(Attachment)
    Attachment.should_receive(:find).with('42').and_return(att)
    att.should_receive(:pdf_path).and_return(mockpdf.path)
    
    get :show, :id => 42
    response.header['Content-Type'].should == 'application/pdf'
    response.header['Content-Disposition'].should == "inline; filename=\"#{File.basename(mockpdf.path)}\""
  end
  
end