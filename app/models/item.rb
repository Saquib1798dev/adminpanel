class Item < ApplicationRecord
  self.table_name = "items"
  belongs_to :category, foreign_key: "category_id"
  has_one_attached :item_image
  has_many :variants
  has_many :line_items, dependent: :destroy
  has_and_belongs_to_many :favourites

  accepts_nested_attributes_for :variants, :allow_destroy => true
  scope :by_item_name, ->(value){ where('name ILIKE ?', "#{ value }%")}
  scope :by_item_description, ->(value){ where('lower(description) ILIKE ?', "#{ value }%")}
  scope :by_item_availability, ->(value){ where('CAST(availability AS TEXT) ILIKE ?', "#{ value }%")}
  scope :by_item_price, ->(value){ where("CAST(price AS TEXT) LIKE ?", "#{ value }%")}
  
  
  def images_url(base_url = nil)
    image_path = Rails.application.routes.url_helpers.rails_blob_path(self.item_image, only_path: true)
    img = "#{base_url}#{image_path}"
  end
end
