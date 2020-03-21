module SynapseContent
  class Snooze < ApplicationRecord
    include Tokenable

    self.table_name = "synapse_snoozes"

    belongs_to :snoozable, polymorphic: true, touch: true
    belongs_to :snoozer, polymorphic: true, touch: true

    validates :snoozable, presence: true
    validates :snoozer, presence: true
    validates :unsnooze_date, presence: true
    validates :unsnooze_time, presence: true

    scope :past_due, lambda { where("unsnooze_date <= ? && unsnooze_time <= ?", Date.today, Time.now) }
  end
end
