json.data @items do |item|
  json.item item
  json.price item&.price
  json.item_image item&.images_url("#{request.protocol}#{request.host_with_port}") if item&.item_image&.present?
  json.category item&.category
  json.category_image item&.category&.images_url("#{request.protocol}#{request.host_with_port}") if item&.category&.category_image&.present?
  json.variants item&.variants 
end