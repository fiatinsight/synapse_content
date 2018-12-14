class AddFieldsToContentBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :fi_content_blocks, :image_caption, :text
    add_column :fi_content_blocks, :button_title_1, :string
    add_column :fi_content_blocks, :button_title_2, :string
    add_column :fi_content_blocks, :button_title_3, :string
    add_column :fi_content_blocks, :button_link_1, :string
    add_column :fi_content_blocks, :button_link_2, :string
    add_column :fi_content_blocks, :button_link_3, :string
  end
end
