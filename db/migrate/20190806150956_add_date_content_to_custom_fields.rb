class AddDateContentToCustomFields < ActiveRecord::Migration[5.2]
  def change
    add_column :synapse_custom_fields, :date_content, :date
    add_column :synapse_custom_fields, :datetime_content, :datetime
  end
end
