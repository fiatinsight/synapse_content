module FiatPublication
  class Page < ApplicationRecord
    include Tokenable

    self.table_name = "fi_pages"

    belongs_to :publisher, polymorphic: true
    has_many :content_blocks, as: :publishable, class_name: 'FiatPublication::ContentBlock'

    has_one_attached :image

    validates :title, presence: true

    enum image_placement: {
      billboard: 0,
      right: 1
    }, _prefix: :image
  end
end
