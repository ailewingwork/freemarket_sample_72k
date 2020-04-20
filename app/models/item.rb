class Item < ApplicationRecord

  validates :product_name,:category_id,:price,:condition,:description,:delivery_fee,:shipping_origin,:days_to_ship, :images, presence: true

  has_many :images, dependent: :destroy
  # 子モデルへのレコード登録を可能にするための入力フォーム"field_for"メソッドを利用するために、以下記述を追加
  # 引数に"allow_destroy: true"を設定。
  #  -> itemを削除する時に紐づいたimagesも削除できるため記述
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :user
  belongs_to :category
  belongs_to :buyer, class_name:'User', foreign_key: "buyer_id", optional: true
  belongs_to :seller, class_name:'User', foreign_key: "seller_id"
  
    #配送元エリアを設定する際に利用する47都道府県のenumを実装
    enum ship_orign:{
      "---":0,
      北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
      茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
      新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
      岐阜県:21,静岡県:22,愛知県:23,三重県:24,
      滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
      鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
      徳島県:36,香川県:37,愛媛県:38,高知県:39,
      福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46, 
      沖縄県:47
    }
  
end
