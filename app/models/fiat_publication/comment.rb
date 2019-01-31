module FiatPublication
  class Comment < ApplicationRecord
    include Tokenable
    include ActionView::Helpers
    audited associated_with: :commentable

    self.table_name = "fi_comments"

    belongs_to :publisher, polymorphic: true
    belongs_to :authorable, polymorphic: true
    belongs_to :commentable, polymorphic: true, touch: true

    validates :authorable, presence: true
    validates :commentable, presence: true
    validates :body, presence: true

    # enum interaction: {
    #   email: 0,
    #   phone_call: 1,
    #   meeting: 2,
    #   left_message: 3
    # }

    # scope :internal, lambda { where(user_id: [User.internal.pluck(:id)]) }

    after_commit :mention_users, on: :create # Ideally, this would be polymorphic-enabled

    def mention_users
      mentions ||= begin
                     regex = /@([\w]+)/
                     self.body.scan(regex).flatten
                   end
      mentioned_users ||= User.where(username: mentions)

      if mentioned_users.any?
        mentioned_users.each do |i|
          FiatNotifications::Notification::CreateNotificationJob.set(wait: 5.seconds).perform_later(
            self,
            self.authorable,
            i,
            action: "mentioned",
            notified_type: "User",
            notified_ids: [i.id],
            email_template_id: FiatNotifications.email_template_id,
            email_subject: "You were mentioned: '#{self.commentable.subject}' on #{l self.created_at, format: :complete}",
            email_body: "#{self.body}",
            reply_to_address: FiatNotifications.reply_to_email_address
          )
        end
      end
    end
  end
end
