json.items @categories do |category|
  json.category category
  json.category_image category.images_url("#{request.protocol}#{request.host_with_port}") if category.category_image.present?
  json.category_items category.items
end