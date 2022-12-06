json.data @items do |item|
  json.item item
  favourite  = Favourite.where(user_id: @user.id).first
  item2 = favourite&.items&.where(id: item.id)&.first
  if item.present?
    json.added_in_wishlist true
  else
    json.added_in_wishlist false
  end
  json.price item&.price
  json.item_image item.item_image.service_url if item.item_image.present?
  json.category item&.category
  json.category_image item.category.category_image.service_url if item.category.category_image.present?
  json.variants item&.variants 
end
