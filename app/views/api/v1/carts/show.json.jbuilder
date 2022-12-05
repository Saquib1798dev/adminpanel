json.success true
json.data @user.cart
json.cart_items @user.cart.line_items do |line|
  json.cart_item_id line.id
  json.cart_quantity line.quantity
  item = Item.find_by_id(line.item_id)
  json.item_name item.name
  json.item_images item.images_url("#{request.protocol}#{request.host_with_port}") if item.item_image.present?
  json.item_price item.price
end
