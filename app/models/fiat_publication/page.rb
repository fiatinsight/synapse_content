module FiatPublication
  class Page < ApplicationRecord
    include Tokenable

    self.table_name = "fi_pages"

    belongs_to :publisher, polymorphic: true
    has_many :content_blocks, as: :publishable
    has_many :custom_fields, as: :publishable, dependent: :destroy, inverse_of: :publishable
    accepts_nested_attributes_for :custom_fields, reject_if: :all_blank, allow_destroy: true

    has_one_attached :image

    validates :title, presence: true

    enum image_placement: {
      billboard: 0,
      right: 1
    }, _prefix: :image
  end
end
