class AttachmentsController < ApplicationController

  def show
    @attachment = Attachment.find(params[:id])
    
    respond_to do |wants|
      wants.pdf { send_file @attachment.pdf_path, :type => Mime::PDF, :disposition => 'inline' }
    end
  end
  
end
