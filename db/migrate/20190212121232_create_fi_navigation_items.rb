class CreateFiNavigationItems < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_navigation_items do |t|
      t.string :publisher_type
      t.integer :publisher_id
      t.string :title
      t.string :token
      t.integer :navigation_group_id
      t.integer :navigable_id
      t.string :navigable_type
      t.string :url
      t.integer :position
      t.string :icon
      t.boolean :button
      t.integer :button_position

      t.timestamps
    end
  end
end
