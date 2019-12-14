module FiatPublication
  class NavigationGroup < ApplicationRecord
    include Tokenable

    self.table_name = "fi_navigation_groups"

    belongs_to :publisher, polymorphic: true, touch: true, required: false
    has_many :navigation_items

    validates :title, presence: true
  end
end
