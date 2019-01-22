module FiatPublication
  class ContentBlock < ApplicationRecord
    include Tokenable

    self.table_name = "fi_content_blocks"

    belongs_to :publishable, polymorphic: true
    # belongs_to :publisher, through: :publishable

    has_one_attached :image

    validates :publishable, presence: true
    validates :block_type, presence: true

    enum block_type: {
      text: 0,
      image: 1,
      buttons: 2
    }
  end
end
