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
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|string|null: false|
|birth_month|string|null: false|
|birth_day|string|null: false|
|postal_code|integer|null: true|
|prefecture|integer|null: true|
|city|string|null: true|
|address|string|null: true|
|building_name|string|null: true|
|profile_content|text|null: true|
|deleted_at|datetime|null: true|
|mobile|string|null: false, unique: true, index: true|
### Association
 - has_many :items
 - has_one :shipping_destinations
 - has_one :profile
 - has_one :credit_card


## shipping_addresses テーブル
|Column|Type|Options|
|------|----|-------|
|shipping_family_name|string|null: false|
|shipping_first_name|string|null: false|
|shipping_family_name_kana|string|null: false|
|shipping_first_name_kana|string|null: false|
|post_code|integer(7)|null:false|
|prefecture|string|null:false|
|city|string|null :false|
|street_number|string|null :false|
|building_name|string|null :false|
|mobile|string|null :false|
|user_id|references|null: false, unique: true, index: true|
### Association
 - has_many :orders
 - belongs_to :user


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
|categories_id|references|foreign_key true,null:false|
|brand_id|references|foreign_key true,null:true|
|user_id|references|foreign_key true,null:false|
### Association
 - has_many: images
 - has_many :comments
 - has_one :order
 - belongs_to :user
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
 - has_many: images


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
|item_id|references|foreign_key true,null:false|
### Association
 - has_many: items


## orders テーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null :false, foreign_key: true|
|shipping_addresse_id|references|null :false, foreign_key: true|
|item_id|references|null :false, foreign_key: true|
### Association
 - belongs_to :user
 - belongs_to :shipping_addresse
 - belongs_to :item