class CreateFiPages < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_pages do |t|
      t.string :publisher_type
      t.integer :publisher_id
      t.string :slug
      t.string :token
      t.string :title
      t.text :excerpt
      t.integer :image_placement

      t.timestamps
    end
  end
end
