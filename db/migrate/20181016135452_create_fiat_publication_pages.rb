class CreateFiatPublicationPages < ActiveRecord::Migration[5.2]
  def change
    create_table :fiat_publication_pages do |t|
      t.string :publisher_type
      t.integer :publisher_id
      t.string :slug
      t.string :token
      t.string :title

      t.timestamps
    end
  end
end
