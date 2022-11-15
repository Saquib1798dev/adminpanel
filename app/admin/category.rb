ActiveAdmin.register Category do
  menu parent: ["Items"], label: 'Categories and Sub Cat.'
  permit_params :name, :description, :parent_id, :category_image

  index do
    selectable_column 
    column :id
    column :name
    column :description
    column :ancestry do |obj|
      obj.parent&.name
    end
    column :category_image do |obj|
      image_tag url_for(obj&.category_image), class: 'my_image_size' if obj.category_image.attached? 
    end
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      sub_category = Category.where.not(id: resource&.id)
      f.input :parent_id , :as => :select, collection: sub_category.collect {|product| [product.name, product.id] }
      f.input :description, as: :quill_editor
      f.input :category_image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :ancestry do |obj|
        obj.parent&.name
      end
      row :category_image do |obj|
        image_tag url_for(obj&.category_image), class: 'my_image_size' if obj.category_image.attached? 
      end
    end
  end
end
