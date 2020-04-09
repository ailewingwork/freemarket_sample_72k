class Item < ApplicationRecord

  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :buyer, class_name:'User', foreign_key: "buyer_id"
  belongs_to :seller, class_name:'User', foreign_key: "seller_id"
  belongs_to :brand
  belongs_to :category
  
end
