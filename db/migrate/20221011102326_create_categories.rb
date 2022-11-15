class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    unless ActiveRecord::Base.connection.table_exists?('categories')
      create_table :categories
    end
    unless ActiveRecord::Base.connection.column_exists?(:categories, :name)
      add_column :categories, :name, :string
    end
    unless ActiveRecord::Base.connection.column_exists?(:categories, :description)
      add_column :categories, :description, :text
    end
  end
end
