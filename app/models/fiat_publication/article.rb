module FiatPublication
  class Article < ApplicationRecord
    include Tokenable

    self.table_name = "fi_articles"

    belongs_to :publisher, polymorphic: true
    has_many :content_blocks, as: :publishable
  end
end
