module SynapseContent
  class CustomField < ApplicationRecord
    include Tokenable
    # audited associated_with: :publishable

    self.table_name = "synapse_custom_fields"

    belongs_to :publishable, polymorphic: true, touch: true

    has_one_attached :image

    validates :publishable, presence: true
    validates :name, presence: true
    validates :field_type, presence: true

    enum field_type: {
      default: 0,
      currency: 1
    }

    def content
      if self.string_content?
        self.string_content
      elsif self.text_content?
        self.text_content
      elsif self.numeric_content?
        self.numeric_content
      end
    end
  end
end
