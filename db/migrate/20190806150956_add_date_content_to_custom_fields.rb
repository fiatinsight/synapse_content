class AddDateContentToCustomFields < ActiveRecord::Migration[5.2]
  def change
    add_column :fi_custom_fields, :date_content, :date
    add_column :fi_custom_fields, :datetime_content, :datetime
  end
end
