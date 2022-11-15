class Category < ApplicationRecord
  has_ancestry
  has_many :items, dependent: :destroy
  has_one_attached :category_image
end