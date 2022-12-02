json.item @item
json.item_image @item.images_url("#{request.protocol}#{request.host_with_port}") if @item.item_image.present?
json.category @item.category
json.category_image @item.category.images_url("#{request.protocol}#{request.host_with_port}") if @item.category.category_image.present?
json.item&.variants