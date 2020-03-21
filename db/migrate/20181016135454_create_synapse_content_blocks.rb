class CreateSynapseContentBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :synapse_content_blocks do |t|
      t.string :publishable_type
      t.integer :publishable_id
      t.integer :block_type
      t.string :token
      t.text :text_content

      t.timestamps
    end
  end
end
