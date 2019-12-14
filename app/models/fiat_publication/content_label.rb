module FiatPublication
  class ContentLabel < ApplicationRecord
    include Tokenable

    self.table_name = "fi_content_labels"

    belongs_to :publisher, polymorphic: true, required: false
    has_many :content_label_assignments, dependent: :destroy
  end
end
