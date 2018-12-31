module FiatPublication
  class ContentLabel < ApplicationRecord
    include Tokenable

    self.table_name = "fi_content_labels"

    belongs_to :publisher, polymorphic: true
    has_many :content_label_assignments, dependent: :destroy
  end
end
