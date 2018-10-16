class CreateFiatPublicationAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :fiat_publication_authors do |t|
      t.string :name
      t.string :slug
      t.string :token

      t.timestamps
    end
  end
end
