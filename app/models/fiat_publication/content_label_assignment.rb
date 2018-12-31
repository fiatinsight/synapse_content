module FiatPublication
  class ContentLabelAssignment < ApplicationRecord
    include Tokenable

    self.table_name = "fi_content_label_assignments"

    belongs_to :content_label
    belongs_to :assignable, polymorphic: true
  end
end
