class CreateFiMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_messages do |t|
      t.string :publisher_type
      t.integer :publisher_id
      t.string :token
      t.string :subject
      t.text :body
      t.boolean :closed
      t.string :messageable_type
      t.integer :messageable_id
      t.string :authorable_type
      t.integer :authorable_id
      t.integer :parent_id
      t.string :name
      t.string :company
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
