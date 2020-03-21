class CreateSynapseContentLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :synapse_content_labels do |t|
      t.string :publisher_type
      t.integer :publisher_id
      t.string :token
      t.string :name

      t.timestamps
    end
  end
end
