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
# destoroy内石崎が追記しました。リンク踏んだ後エラーが出てしまいます未解決です。
# 商品削除機能追加の時点で修正します。4/13
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def buy_confirm
  end


  private

  #プライベートメソッドにしたいので、private配下に記述
  def item_params
    params.require(:item).permit(:product_name, :price, :condition,:description, :delivery_fee, :shipping_origin, :days_to_ship,:buyer_id, images_attributes: [:image]).merge(user_id: current_user.id, seller_id: current_user.id)
  end

end