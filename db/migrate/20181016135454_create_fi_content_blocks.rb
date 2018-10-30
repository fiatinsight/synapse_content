class CreateFiContentBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_content_blocks do |t|
      t.string :publishable_type
      t.integer :publishable_id
      t.integer :block_type
      t.string :token
      t.text :text_content
      # TODO: Add all the various fields you can use...

      t.timestamps
    end
  end
end
