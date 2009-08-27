class ItemsController < ApplicationController
  
  before_filter :login_required
  
  FORM_STAGES = [:choose_files, :description, :publication_date, :shows, :people, :organisations]

  def new
    @item = Item.new(:draft => true)
    @item.save_without_validation

    redirect_to edit_item_path @item
  end

  def edit
    if params[:stage].empty? or !(FORM_STAGES.include?(params[:stage].intern) rescue false)
      stage = FORM_STAGES.first
    else
      stage = params[:stage].intern
    end
    
    @stages = FORM_STAGES
    @item = Item.find(params[:id])

    @item.update_attribute(:stage, stage)
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      if @item.stage == FORM_STAGES.last
        redirect_to item_path(@item)
      else
        redirect_to edit_item_path @item, FORM_STAGES[FORM_STAGES.index(@item.stage.intern) + 1]
      end
    else
      render
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end

end
