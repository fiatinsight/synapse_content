module FiatPublication
  class Page < ApplicationRecord
    include Tokenable

    self.table_name = "fi_pages"

    belongs_to :publisher, polymorphic: true
    has_many :content_blocks, as: :publishable

    validates :title, presence: true
  end
end
