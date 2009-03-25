class HomeController < ApplicationController
  def index
    @items = Item.all
  end
end
