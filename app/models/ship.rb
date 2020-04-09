class Ship < ApplicationRecord
  has_one :address
  belongs_to :user, optional: true

  VALID_MOBILE_REGEX = /\A\d{10}$|^\d{11}\z/
  VALID_KATAKANA_REGEX = /\A[\p{katakana}\p{blank}ー－]+\z/

  
  validates :shipping_family_name_kana, format: { with: VALID_KATAKANA_REGEX}
  validates :shipping_first_name_kana,  format: { with: VALID_KATAKANA_REGEX}
  validates :mobile, format: {with: VALID_MOBILE_REGEX}, if: Proc.new{|v| v.mobile.present?}

  validates :shipping_family_name,:shipping_first_name,presence: true
end
