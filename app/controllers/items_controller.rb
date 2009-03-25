class ItemsController < ApplicationController
  
  before_filter :login_required
  
  def new
    @item = Item.new(:draft => true)
    @item.save_without_validation
  end

  def form
    @item = Item.find(params[:id])
    @item.update_attribute(:stage, params[:stage] || @item.stage)
    
    render_form_part_from_item
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      respond_to do |wants|
        wants.html { redirect_to item_path(@item) }
        wants.js { render :text => "OK" }
      end
    else
      render_form_part_from_item
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  private
  
  def render_form_part_from_item
    respond_to do |wants|
      template = "items/form/#{@item.stage}"
      wants.html { render :template => template }
      wants.js { render :template => template, :layout => false }
    end
  end
  
end
