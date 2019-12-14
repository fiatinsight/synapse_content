module FiatPublication
  class Page < ApplicationRecord
    include Tokenable
    audited
    has_associated_audits

    self.table_name = "fi_pages"

    belongs_to :publisher, polymorphic: true, required: false
    has_many :content_blocks, as: :publishable
    has_many :custom_fields, as: :publishable, dependent: :destroy, inverse_of: :publishable
    accepts_nested_attributes_for :custom_fields, reject_if: :all_blank, allow_destroy: true
    has_many :content_label_assignments, as: :assignable, dependent: :destroy
    has_many :content_labels, through: :content_label_assignments

    has_one_attached :image
    # validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..5.megabytes }

    validates :title, presence: true

    attribute :remove_image, :boolean

    after_save :purge_image, if: :remove_image

    def purge_image
      image.purge
    end

    enum image_placement: {
      billboard: 0,
      right: 1
    }, _prefix: :image
  end
end
