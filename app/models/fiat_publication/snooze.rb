module FiatPublication
  class Snooze < ApplicationRecord
    include Tokenable

    self.table_name = "fi_snoozes"

    belongs_to :snoozable, polymorphic: true, touch: true
    belongs_to :snoozer, polymorphic: true, touch: true

    validates :snoozable, presence: true
    validates :snoozer, presence: true
    validates :unsnooze_date, presence: true
    validates :unsnooze_time, presence: true
  end
end
