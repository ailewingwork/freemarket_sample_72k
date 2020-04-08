class Profile < ApplicationRecord
  belongs_to :user, optional: true

  VALID_MOBILE_REGEX = /\A\d{10}$|^\d{11}\z/
  VALID_KATAKANA_REGEX = /\A[\p{katakana}\p{blank}ー－]+\z/

  
  validates :family_name_kana, format: { with: VALID_KATAKANA_REGEX}
  validates :first_name_kana,  format: { with: VALID_KATAKANA_REGEX}
  validates :profile, length: {maximum: 1000}, if: Proc.new{|v| v.profile.present?}
  validates :mobile, format: { with: VALID_MOBILE_REGEX}
  validates :family_name, :first_name ,:family_name_kana,:first_name_kana,:birth_day,presence: true


end
