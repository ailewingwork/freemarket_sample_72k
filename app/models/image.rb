class Image < ApplicationRecord
  belongs_to :item_id
  mount_uploader :image, ImageUploader
end
