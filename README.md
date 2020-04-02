# README


* データベース設計
## profileテーブル
|Column|Type|Options|
|------|----|-------|
|profile|text|null :true|
|prof_image|string|null :true|
|user_id|references|null :false, foreign_key :true|
### Association
 - belongs_to :user


## credit_card
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null :false|
|card_year|integer|null :false|
|card_month|integer|null :false|
|security_code|integer|null :false|
|user_id|references|null :false, foreign_key :true|
### Association
 - belongs_to :user


## users テーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|encrypted_password|string| null: false|
|reset_password_token|string|
|reset_password_sent_at|datetime
|remember_created_at|datetime|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|string|null: false|
|birth_month|string|null: false|
|birth_day|string|null: false|
|mobile|string|null: false, unique: true, index: true|
### Association
 - has_many :items, dependent: :destroy
 - has_many :buyer_items, class_name: 'Item', :foreign_key => 'buyer_id'
 - has_many :seller_items, class_name: 'Item', :foreign_key => 'seller_id'
 - has_one :ships, dependent: :destroy
 - has_one :profile, dependent: :destroy
 - has_one :credit_card, dependent: :destroy


## ships テーブル
|Column|Type|Options|
|------|----|-------|
|shipping_family_name|string|null: false|
|shipping_first_name|string|null: false|
|shipping_family_name_kana|string|null: false|
|shipping_first_name_kana|string|null: false|
|mobile|string|null :false|
|user_id|references|null: false, unique: true, index: true|
### Association
 - has_one :addresses, dependent: :destroy
 - belongs_to :user

## addresses テーブル
|post_code|integer(7)|null:false|
|prefecture|string|null:false|
|city|string|null :false|
|street_number|string|null :false|
|building_name|string|null :false|
### Association
 - belongs_to :ship


## items テーブル
|Column|Type|Options|
|------|----|-------|
|product_name|string|null: false|
|price|integer|null: false|
|condition|integer|null: false|
|description|text(1000)|null: false|
|delivery_fee|integer|null:false|
|shipping_origin|integer|null:false|
|days_to_ship|integer|null:false|
|category_id|references|foreign_key true,null:false|
|brand_id|references|foreign_key true,null:true|
|user_id|references|foreign_key true,null:false|
|buyer_id|references|foreign_key true,null:true|
|seller_id|references|foreign_key true,null:false|
### Association
 - has_many: images, dependent: :destroy
 - has_many :comments ,dependent: :destroy
 - belongs_to :user
 - belongs_to :buyer, class_name: 'User', :foreign_key => 'buyer_id'
 - belongs_to :seller, class_name: 'User', :foreign_key => 'seller_id'
 - belongs_to :brand
 - belongs_to :category

## comments テーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|null :false|
|user_id|references|foreign_key true,null:false|
|item_id|references|foreign_key true,null:false|
### Association
 - belongs_to :user
 - belongs_to :item


## images テーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null:false|
|item_id|references|foreign_key true,null:false|
### Association
 - belongs_to :item


## categories テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null :false|
### Association
 - has_many :items


## brands テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
### Association
 - has_many: items