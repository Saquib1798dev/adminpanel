class CreateHelpPortal < ActiveRecord::Migration[6.0]
  def change
    create_table :help_portals do |t|
      t.string :title
      t.string :help_type
      t.text :description
    end
  end
end
