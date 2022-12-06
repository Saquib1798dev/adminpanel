json.data @categories do |category|
  json.category category
  json.category_image category.category_image.service_url if category.category_image.present?
  json.category_items category.items
end