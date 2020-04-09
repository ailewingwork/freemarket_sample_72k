class ItemsController < ApplicationController
  def index
    @items = Item.all.order("created_at DESC").limit(3)
  end


  def new

  end

  def show

  end
  
  def buy_confirm
  end

  
end