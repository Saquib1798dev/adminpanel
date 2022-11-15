class Item < ApplicationRecord
  belongs_to :category, foreign_key: "category_id"
  has_one_attached :item_image
  has_many :variants
  accepts_nested_attributes_for :variants, :allow_destroy => true
end