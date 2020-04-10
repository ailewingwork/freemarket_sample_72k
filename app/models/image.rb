class Image < ApplicationRecord

  #画像をアップロードする為に必要なmount_uplodaerを追記
  mount_uploader :image, ImageUploader

  belongs_to :item
end
