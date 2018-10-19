module FiatPublication
  class ContentBlock < ApplicationRecord
    include Tokenable

    belongs_to :publishable, polymorphic: true
    # belongs_to :publisher, through: :publishable

    enum block_type: {
      text: 0,
      image: 1
    }
  end
end
