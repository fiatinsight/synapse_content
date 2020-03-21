class CreateSynapseAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :synapse_authors do |t|
      t.string :name
      t.string :slug
      t.string :token

      t.timestamps
    end
  end
end
