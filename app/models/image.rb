class Image < ActiveRecord::Base
  has_many :tags, through: :image_tags
  has_many :image_tags
end

