class CreateFiNavigationGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_navigation_groups do |t|
      t.string :publisher_type
      t.integer :publisher_id
      t.string :title
      t.string :icon
      t.string :token
      t.integer :position

      t.timestamps
    end
  end
end
