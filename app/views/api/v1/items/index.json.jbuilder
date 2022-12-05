json.data @items do |item|
  json.item item
  favourite  = Favourite.where(user_id: @user.id).first
  item = favourite&.items&.where(id: item.id)&.first
  if item.present?
    json.added_in_wishlist true
  else
    json.added_in_cart false
  end
  json.price item.price
  json.item_image item.images_url("#{request.protocol}#{request.host_with_port}") if item.item_image.present?
  json.category item.category
  json.category_image item.category.images_url("#{request.protocol}#{request.host_with_port}") if item.category.category_image.present?
  json.variants item&.variants 
end