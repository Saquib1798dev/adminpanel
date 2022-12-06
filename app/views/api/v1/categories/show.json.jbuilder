json.data @category
json.category_image @category.category_image.service_url if @category.category_image.present?
#json.category_image @item.category.images_url("#{request.protocol}#{request.host_with_port}") if @item.category.category_image.present?