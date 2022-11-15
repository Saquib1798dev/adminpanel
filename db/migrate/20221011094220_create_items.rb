class CreateItems < ActiveRecord::Migration[6.0]
  def change
    unless ActiveRecord::Base.connection.table_exists?('items')
      create_table :items
    end
    unless ActiveRecord::Base.connection.column_exists?(:items, :price)
      add_column :items, :price, :integer
    end
    unless ActiveRecord::Base.connection.column_exists?(:items, :name)
      add_column :items, :name, :string
    end
    unless ActiveRecord::Base.connection.column_exists?(:items, :availability)
      add_column :items, :availability, :boolean
    end
    unless ActiveRecord::Base.connection.column_exists?(:items, :description)
      add_column :items, :description, :text
    end
    unless ActiveRecord::Base.connection.column_exists?(:items, :category_id)
      add_reference :items, :category, index: true
    end
  end
end
