class CreateFiContentLabelAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_content_label_assignments do |t|
      t.string :token
      t.integer :content_label_id
      t.string :assignable_type
      t.integer :assignable_id

      t.timestamps
    end
  end
end
