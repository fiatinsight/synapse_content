class CreateFiComments < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_comments do |t|
      t.string :publisher_type
      t.integer :publisher_id
      t.string :token
      t.integer :commentable_type
      t.integer :commentable_id
      t.text :body
      t.string :authorable_type
      t.integer :authorable_id

      t.timestamps
    end
  end
end
