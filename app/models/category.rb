class Category < ApplicationRecord
  self.table_name = "categories"
  has_ancestry
  has_many :items, dependent: :destroy
  has_one_attached :category_image

  def images_url(base_url = nil)
    image_path = Rails.application.routes.url_helpers.rails_blob_path(self.category_image, only_path: true)
    img = "#{base_url}#{image_path}"
  end

end
