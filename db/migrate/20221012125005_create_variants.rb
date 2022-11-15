class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    unless ActiveRecord::Base.connection.table_exists?('variants')
      create_table :variants
    end
    unless ActiveRecord::Base.connection.column_exists?(:variants, :price)
      add_column :variants, :price, :integer
    end
    unless ActiveRecord::Base.connection.column_exists?(:variants, :variant_type)
      add_column :variants, :variant_type, :string
    end
    unless ActiveRecord::Base.connection.column_exists?(:variants, :item_id)
      add_reference :variants, :item, index: true
    end
  end
end 
