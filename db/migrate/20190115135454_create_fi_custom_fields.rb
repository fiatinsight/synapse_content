class CreateFiCustomFields < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_custom_fields do |t|
      t.string :publishable_type
      t.integer :publishable_id
      t.integer :field_type
      t.string :token
      t.string :name
      t.string :string_content
      t.text :text_content
      t.decimal :numeric_content, precision: 10, scale: 2

      t.timestamps
    end
  end
end
