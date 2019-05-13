class AddPositionToContentBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :fi_content_blocks, :position, :integer
  end
end
