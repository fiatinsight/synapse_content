class AddColorToLabels < ActiveRecord::Migration[5.2]
  def change
    add_column :synapse_content_labels, :hex_color, :string
    add_column :synapse_content_labels, :fa_icon, :string
  end
end
