module FiatPublication
  class Message < ApplicationRecord
    include Tokenable

    self.table_name = "fi_messages"

    belongs_to :publisher, polymorphic: true
    belongs_to :authorable, polymorphic: true
    has_many :comments, as: :commentable, dependent: :destroy
    has_many :attachments, as: :attachable, dependent: :destroy
    has_many :content_label_assignments, as: :assignable, dependent: :destroy
    has_many :content_labels, through: :content_label_assignments
    belongs_to :messageable, polymorphic: true
    # has_many :tasks, :dependent => :destroy
    # has_many :feeds, as: :trackable, :dependent => :destroy

    validates :subject, presence: true
    validates :body, presence: true
    # validates :authorable, presence: true

    # enum label: {
    #   prospect: 0,
    #   ticket: 1,
    #   deliverable: 2,
    #   review: 3,
    #   discussion: 4
    # }

    # scope :priority, lambda { where(priority: 1).includes(:comments, :tasks) }
    # scope :unlabeled, lambda { where(label: ["",nil]).includes(:comments, :tasks) }
    # scope :open, lambda { where(closed: [0,nil]) }
    # scope :closed, lambda { where(closed: 1) }
    # scope :ticket, lambda { where(label: 1).includes(:comments, :tasks) }
    # scope :snoozed, lambda { where.not(snooze: [nil,0]).includes(:comments, :tasks) }
    # scope :excluded, lambda { where(excluded: 1) }
    # scope :included, lambda { where(excluded: [0,nil]) }

    # after_commit -> { Notification::MessageMentionJob.set(wait: 5.seconds).perform_later(self) }, on: :create

    # def global_messageable
    #   self.messageable.to_global_id if self.messageable.present?
    # end
    #
    # def global_messageable=(messageable)
    #   self.messageable = GlobalID::Locator.locate messageable
    # end
  end
end
