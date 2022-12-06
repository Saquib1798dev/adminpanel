json.data @items do |item|
  json.item item
  json.price item&.price
  json.item_image item.item_image.service_url if item.item_image.present?
  json.category item&.category
  json.category_image item.category.category_image.service_url if item.category.category_image.present?
  json.variants item&.variants 
end