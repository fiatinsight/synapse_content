class AddFieldsToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :synapse_articles, :excerpt, :text
    add_column :synapse_articles, :published_at, :datetime
    add_column :synapse_articles, :image_placement, :integer
  end
end
