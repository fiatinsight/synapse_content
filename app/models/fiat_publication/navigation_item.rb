module FiatPublication
  class NavigationItem < ApplicationRecord
    include Tokenable

    self.table_name = "fi_navigation_items"

    belongs_to :publisher, polymorphic: true, touch: true, required: false
    belongs_to :navigation_group, required: false
    belongs_to :navigable, polymorphic: true, required: false

    validates :title, presence: true

    def global_navigable
      self.navigable.to_global_id if self.navigable.present?
    end

    def global_navigable=(navigable)
      self.navigable = GlobalID::Locator.locate navigable
    end
  end
end
