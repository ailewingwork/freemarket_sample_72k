class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC').limit(3)
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # 商品の投稿に成功したらindexに飛ばす処理
      redirect_to root_path
    else
      # 商品の投稿に失敗したらnewアクションを再度実行new.html.hamlを表示
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show

  end
  
  def buy_confirm
  end


  private

  #プライベートメソッドにしたいので、private配下に記述
  def item_params
    params.permit(:product_name, :price, :condition,:description, :delivery_fee, :shipping_origin, :days_to_ship, images_attributes: [:image]).merge(user_id: current_user.id, seller_id: current_user.id)
  end

end