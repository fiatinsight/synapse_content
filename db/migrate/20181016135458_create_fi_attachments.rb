class CreateFiAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_attachments do |t|
      t.string :publisher_type
      t.integer :publisher_id
      t.string :token
      t.string :title
      t.integer :attachable_type
      t.integer :attachable_id
      t.string :authorable_type
      t.integer :authorable_id

      t.timestamps
    end
  end
end
