class AddPositionToContentBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :synapse_content_blocks, :position, :integer
  end
end
