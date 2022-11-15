ActiveAdmin.register Item do
  menu parent: ["Items"]
  permit_params :name, :description, :category_id, :item_image, :price, variants_attributes: [:price, :variant_type, :id]

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :price
    column :category do |obj|
      obj&.category
    end
    column :item_image do |obj|
      image_tag url_for(obj&.item_image), class: 'my_image_size' if obj.item_image.attached? 
    end
    column :variants do |obj|
      table_for obj&.variants do
        column "Price" do |variant|
          variant.price
        end
        column "Variant Type" do |variant|
          variant.variant_type
        end
      end
    end
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      sub_category = Category.where.not(ancestry: nil)
      f.input :category , :as => :select, collection: sub_category.collect{|product| [product.name, product.id] }
      f.input :price
      f.input :description, as: :quill_editor
      f.input :item_image, as: :file
      f.has_many :variants do |t|
        t.input :variant_type
        t.input :price
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :description
      row :item_image do |obj|
        image_tag url_for(obj&.item_image), class: 'my_image_size' if obj.item_image.attached? 
      end
    end
  end
end
