class ItemsController < ApplicationController
  before_action :item_params, only: :create
  before_action :set_item, only: [:show, :destroy]

  def index
    @items = Item.includes(:images).order('created_at DESC').limit(3)
  end

  def new
    #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    #DBから親カテゴリのみを抽出（親カテゴリはancestryカラムがnull）
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end

    @item = Item.new
    #itemテーブルの子テーブルimagesテーブルにもレコードを追加できるように以下もインスタンス化。
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # 商品の投稿に成功したらindexに飛ばす処理
      redirect_to root_path, notice: '出品が完了しました。'
    else
      # 商品の投稿に失敗したらnewアクションを再度実行new.html.hamlを表示
      redirect_to new_item_path, notice: '入力した内容に誤りがあります。再度入力してください。'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if @item.destroy
      # 登録している商品の削除に成功したら
      redirect_to root_path, notice: "削除に成功しました。"
    else
      # 登録している商品の削除に失敗したら
      redirect_to item_path, notice: "削除に失敗しました、もう一度削除ボタンを押してください。"
    end
  end

  def show
    # カテゴリーのモデルを導入したらコメントアウト解除
    # @category = Category.where(id: @item.category_id)
    @parents = Category.where(ancestry:nil)
  end
  
  def buy_confirm
  end

  # 以下全て、formatはjsonのみ
  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリーが選択された後に動くアクション。 ajaxからハッシュで子要素のIDを受け取る{child_id: childId}
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  #プライベートメソッドにしたいので、private配下に記述
  def item_params
    params.require(:item).permit(:product_name, :price, :category_id, :condition,:description, :delivery_fee, :shipping_origin, :days_to_ship,:buyer_id, images_attributes: [:image]).merge(user_id: current_user.id, seller_id: current_user.id)
  end

end