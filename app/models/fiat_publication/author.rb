module FiatPublication
  class Author < ApplicationRecord
    include Tokenable

    belongs_to :publisher, polymorphic: true
    has_many :articles
    # TODO: Include link to user-type ownership
  end
end
