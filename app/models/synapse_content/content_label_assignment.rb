module SynapseContent
  class ContentLabelAssignment < ApplicationRecord
    include Tokenable

    self.table_name = "synapse_content_label_assignments"

    belongs_to :content_label
    belongs_to :assignable, polymorphic: true, touch: true

    validates :content_label, presence: true
    validates :assignable, presence: true
  end
end
