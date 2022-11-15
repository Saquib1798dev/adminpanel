class AddAncestryToCategory < ActiveRecord::Migration[6.0]
  def change
    unless ActiveRecord::Base.connection.column_exists?(:categories, :ancestry)
      add_column :categories, :ancestry, :string
      add_index :categories, :ancestry
    end
  end
end
