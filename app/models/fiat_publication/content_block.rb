module FiatPublication
  class ContentBlock < ApplicationRecord
    include Tokenable

    self.table_name = "fi_content_blocks"

    belongs_to :publishable, polymorphic: true

    has_one_attached :image
    validates :image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..5.megabytes }

    validates :publishable, presence: true
    validates :block_type, presence: true

    enum block_type: {
      text: 0,
      image: 1,
      buttons: 2,
      script: 3
    }
  end
end
