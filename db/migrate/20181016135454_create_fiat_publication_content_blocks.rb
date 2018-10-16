class CreateFiatPublicationContentBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :fiat_publication_content_blocks do |t|
      t.string :publishable_type
      t.integer :publishable_id
      t.integer :block_type
      t.string :token
      # TODO: Add all the various fields you can use...

      t.timestamps
    end
  end
end
