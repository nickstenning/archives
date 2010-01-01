class ItemsController < ApplicationController
  
  before_filter :login_required
  before_filter :get_stage, :only => :edit
  
  FORM_STAGES = [:documents, :description, :references]

  def new
    @item = Item.new(:draft => true)
    @item.save_without_validation

    redirect_to edit_item_path(@item)
  end

  def edit
    @item = Item.find(params[:id])
    @item.update_attribute(:stage, @stage)
  end
  
  def update
    @item = Item.find(params[:id])
    
    if ids = params[:item][:shows]
      @item.item_linkings |= ids.map do |id| 
        ItemLinking.new(:item_linking => Show.find(id))
      end
      params[:item].delete(:shows)
    end
    
    if @item.update_attributes(params[:item])
      if increment_stage(@item) 
        redirect_to edit_item_path(@item, @item.stage)
      else
        redirect_to item_path(@item)
      end
    else
      render :action => :edit
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end

  private

  def increment_stage( item )
    idx = FORM_STAGES.index(item.stage)

    if idx >= FORM_STAGES.length - 1
      false
    elsif idx
      item.stage = FORM_STAGES[idx + 1]
    else
      item.stage = FORM_STAGES.first
    end
  end
  
  def get_stage
    @stages = FORM_STAGES
    
    if params[:stage].empty? or !(FORM_STAGES.include?(params[:stage].intern) rescue false)
      @stage = FORM_STAGES.first
    else
      @stage = params[:stage].intern
    end
  end

end
