module FiatPublication
  class Article < ApplicationRecord
    include Tokenable

    self.table_name = "fi_articles"

    belongs_to :publisher, polymorphic: true
    belongs_to :author
    has_many :content_blocks, as: :publishable
  end
end
