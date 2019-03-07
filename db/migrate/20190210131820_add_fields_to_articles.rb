class AddFieldsToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :fi_articles, :excerpt, :text
    add_column :fi_articles, :published_at, :datetime
    add_column :fi_articles, :image_placement, :integer
  end
end
