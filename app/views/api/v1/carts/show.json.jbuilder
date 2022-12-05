json.success true
json.data @user.cart
json.cart_items @user.cart.line_items do |line|
  json.cart_quantity line.quantity
  json.cart_items @user.cart.items do |item|
    json.item item.name
    json.item_images item.images_url("#{request.protocol}#{request.host_with_port}") if item.item_image.present?
    json.item_price item.price
  end
end