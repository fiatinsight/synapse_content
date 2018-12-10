module FiatPublication
  class Comment < ApplicationRecord
    include Tokenable

    self.table_name = "fi_comments"

    belongs_to :publisher, polymorphic: true
    belongs_to :authorable, polymorphic: true
    belongs_to :commentable, polymorphic: true, touch: true

    # enum interaction: {
    #   email: 0,
    #   phone_call: 1,
    #   meeting: 2,
    #   left_message: 3
    # }

    # after_commit -> { Notification::CommentMentionJob.set(wait: 5.seconds).perform_later(self) }, on: :create

    # scope :internal, lambda { where(user_id: [User.internal.pluck(:id)]) }
  end
end
