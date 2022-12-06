json.item @item
json.item_image @item.item_image.service_url if @item.item_image.present?
json.category @item.category
json.category_image @item.category.category_image.service_url if @item.category.category_image.present?
json.item&.variants