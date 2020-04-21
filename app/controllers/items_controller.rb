class ItemsController < ApplicationController
  before_action :item_params, only: :create
  before_action :set_item, only: [:show, :destroy, :edit, :update]

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
    binding.pry
    if @item.save
      # 商品の投稿に成功したらindexに飛ばす処理
      redirect_to root_path, notice: '出品が完了しました。'
    else
      # 商品の投稿に失敗したらnewアクションを再度実行new.html.hamlを表示
      redirect_to new_item_path, notice: '入力した内容に誤りがあります。再度入力してください。'
    end
  end

  def edit
    #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    #DBから親カテゴリのみを抽出（親カテゴリはancestryカラムがnull）
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end


    # 子レコードのプルダウン用に配列で取得
    @category_children_array = Category.find_by(ancestry: nil).children

    #category_idに紐づいた子レコード（相対関係では親レコード）の取得
    # 遷移時の初期値設定のため
    @category_children = Category.find_by(id: @item.category_id).parent
    
    #孫レコートのプルダウン用に配列で取得
    @category_grandchildren_array = Category.find_by(id: @category_children.id).children

    #商品に紐づいている孫カテゴリーIDを取得
    # 遷移時の初期値設定のため
    @category_grandchildren = Category.find_by(id: @item.category_id)

    #商品の紐づいている親カテゴリーIDを取得
    # 遷移時の初期値設定のため
    @category_parent = Category.find_by(id: @category_children.id).parent

    # @item = Item.new
    # #itemテーブルの子テーブルimagesテーブルにもレコードを追加できるように以下もインスタンス化。
    # @item.images.new
    # binding.pry
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    # .update_attributesに書き換えてみたが、結局 undifine method
    redirect_to root_path, notice: '商品の編集が完了しました。'
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

  def select_category_index
    # カテゴリ名を取得するために@categoryにレコードをとってくる
    @category = Category.find_by(id: params[:id])

    # 親カテゴリーを選択していた場合の処理
    if @category.ancestry == nil
      # Categoryモデル内の親カテゴリーに紐づく孫カテゴリーのidを取得
      category = Category.find_by(id: params[:id]).indirect_ids
      # 孫カテゴリーに該当するitemsテーブルのレコードを入れるようの配列を用意
      @items = []
      # find_itemメソッドで処理
      find_item(category)

    # 孫カテゴリーを選択していた場合の処理
    elsif @category.ancestry.include?("/")
      # Categoryモデル内の親カテゴリーに紐づく孫カテゴリーのidを取得
      @items = Item.where(category_id: params[:id])

    # 子カテゴリーを選択していた場合の処理
    else
      category = Category.find_by(id: params[:id]).child_ids
      # 孫カテゴリーに該当するitemsテーブルのレコードを入れるようの配列を用意
      @items = []
      # find_itemメソッドで処理
      find_item(category)

    end
  end


  # 以下全て、formatはjsonのみ
  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリーが選択された後に動くアクション.
  # ajaxからハッシュで子要素のIDを受け取る{child_id: childId}
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
    params.require(:item).permit(:product_name, :price, :category_id, :condition_id,:description, :delivery_fee_id, :shipping_origin, :days_to_ship_id,:buyer_id, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id, seller_id: current_user.id)
  end

  # カテゴリー検索用にfind_itemメソッドを実装
  # select_category_indexアクションから呼び出すので、private配下に記述
  def find_item(category)
    category.each do |id|
      item_array = Item.includes(:images).where(category_id: id)
      # find_by()メソッドで該当のレコードがなかった場合、itemオブジェクトに空の配列を入れないようにするための処理
      if item_array.present?
        item_array.each do |item|
          if item_array.present?
            # find_by()メソッドで該当のレコードが見つかった場合、@item配列オブジェクトにそのレコードを追加する
            @items.push(item)
          end
        end
      end
    end
  end

end