class AttachmentsController < ApplicationController

  before_filter :get_item
  
  def get_item
    @item = Item.find(params[:item_id]) if params[:item_id]
  end

  def index
    @attachments = @item ? @item.attachments : Attachment.all
    @attachment = @attachments.first
  end

  def show
    @attachment = Attachment.find(params[:id])
    
    if @item
      @attachments = @item.attachments
      render :action => :index
    else
      respond_to do |wants|
        wants.pdf { send_file @attachment.pdf_path, :type => Mime::PDF, :disposition => 'inline' }
      end
    end
  end
  
end
