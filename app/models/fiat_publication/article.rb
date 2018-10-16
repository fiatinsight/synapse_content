module FiatPublication
  class Article < ApplicationRecord
    include Tokenable

    belongs_to :publisher, polymorphic: true
    has_many :content_blocks, as: :publishable
  end
end
