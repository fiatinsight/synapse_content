module SynapseContent
  class Article < ApplicationRecord
    include Tokenable
    # audited
    # has_associated_audits

    attr_accessor :edit_redirect_path, :edit_redirect_variable, :destroy_redirect_path, :destroy_redirect_variable

    self.table_name = "synapse_articles"

    belongs_to :publisher, polymorphic: true, required: false
    belongs_to :author, required: false
    has_many :content_blocks, as: :publishable
    has_many :custom_fields, as: :publishable, dependent: :destroy, inverse_of: :publishable
    accepts_nested_attributes_for :custom_fields, reject_if: :all_blank, allow_destroy: true
    has_many :content_label_assignments, as: :assignable, dependent: :destroy
    has_many :content_labels, through: :content_label_assignments

    has_one_attached :image
    # validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..5.megabytes }

    attribute :remove_image, :boolean

    validates :title, :image_placement, presence: true

    enum image_placement: {
      billboard: 0,
      right: 1
    }, _prefix: :image

    scope :published, lambda { where.not(published_at: nil).includes(:author) }
    scope :scheduled, lambda { where("published_at > ?", DateTime.now) }
    scope :visible, lambda { where("published_at <= ?", DateTime.now) }

    after_save :purge_image, if: :remove_image

    def purge_image
      image.purge
    end

    def is_published?
      if self.published_at
        true
      else
        false
      end
    end
  end
end
