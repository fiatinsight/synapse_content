class AddColorToContentLabels < ActiveRecord::Migration[5.2]
  def change
    add_column :synapse_content_labels, :font_color, :string
  end
end
