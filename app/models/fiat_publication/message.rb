module FiatPublication
  class Message < ApplicationRecord
    include Tokenable
    audited
    has_associated_audits

    self.table_name = "fi_messages"

    belongs_to :publisher, polymorphic: true
    belongs_to :authorable, polymorphic: true
    has_many :comments, as: :commentable, dependent: :destroy
    has_many :attachments, as: :attachable, dependent: :destroy
    has_many :content_label_assignments, as: :assignable, dependent: :destroy
    has_many :content_labels, through: :content_label_assignments
    has_many :snoozes, as: :snoozable, dependent: :destroy
    belongs_to :messageable, polymorphic: true
    belongs_to :owner, polymorphic: true
    has_many :custom_fields, as: :publishable, dependent: :destroy, inverse_of: :publishable
    accepts_nested_attributes_for :custom_fields, reject_if: :all_blank, allow_destroy: true

    validates :subject, presence: true

    # scope :priority, lambda { where(priority: 1).includes(:comments, :tasks) }
    # scope :unlabeled, lambda { where(label: ["",nil]).includes(:comments, :tasks) }
    scope :open, lambda { where(closed: [0,nil]) }
    scope :closed, lambda { where(closed: 1) }
    # scope :ticket, lambda { where(label: 1).includes(:comments, :tasks) }
    # scope :snoozed, lambda { where.not(snooze: [nil,0]).includes(:comments, :tasks) }
    # scope :excluded, lambda { where(excluded: 1) }
    # scope :included, lambda { where(excluded: [0,nil]) }

    # after_commit -> { Notification::MessageMentionJob.set(wait: 5.seconds).perform_later(self) }, on: :create

    def global_messageable
      self.messageable.to_global_id if self.messageable.present?
    end

    def global_messageable=(messageable)
      self.messageable = GlobalID::Locator.locate messageable
    end

    def global_owner
      self.owner.to_global_id if self.owner.present?
    end

    def global_owner=(owner)
      self.owner = GlobalID::Locator.locate owner
    end
  end
end
