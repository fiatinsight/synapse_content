module FiatPublication
  class CustomField < ApplicationRecord
    include Tokenable

    self.table_name = "fi_custom_fields"

    belongs_to :publishable, polymorphic: true

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
