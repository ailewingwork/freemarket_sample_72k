class Ship < ApplicationRecord
  belongs_to :user, optional: true
  validates :shipping_family_name, :shipping_first_name ,:shipping_family_name_kana,:shipping_first_name_kana,:mobile,presence: true
end
