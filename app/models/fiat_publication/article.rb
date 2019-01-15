module FiatPublication
  class Article < ApplicationRecord
    include Tokenable

    self.table_name = "fi_articles"

    belongs_to :publisher, polymorphic: true
    belongs_to :author
    has_many :content_blocks, as: :publishable
    has_many :custom_fields, as: :publishable, dependent: :destroy, inverse_of: :publishable
    accepts_nested_attributes_for :custom_fields, reject_if: :all_blank, allow_destroy: true
  end
end
