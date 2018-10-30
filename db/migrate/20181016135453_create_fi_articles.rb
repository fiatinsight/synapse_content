class CreateFiArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_articles do |t|
      t.string :publisher_type
      t.integer :publisher_id
      t.integer :author_id
      t.string :slug
      t.string :token
      t.string :title

      t.timestamps
    end
  end
end
