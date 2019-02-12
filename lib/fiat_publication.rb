require "fiat_publication/engine"

module FiatPublication

  # Pages
  mattr_accessor :pages_path
  mattr_accessor :new_page_path
  mattr_accessor :new_page_redirect_path
  mattr_accessor :view_page_path

  # Articles
  mattr_accessor :articles_path
  mattr_accessor :new_article_path
  mattr_accessor :new_article_redirect_path
  mattr_accessor :view_article_path

  # Attachments
  mattr_accessor :attachments_path
  mattr_accessor :new_attachment_redirect_path

  # Navigation Groups
  mattr_accessor :navigation_groups_path
  mattr_accessor :new_navigation_group_path
  mattr_accessor :new_navigation_group_redirect_path

  # Navigation Items
  mattr_accessor :navigation_items_path
  mattr_accessor :new_navigation_item_path
  mattr_accessor :new_navigation_item_redirect_path

  # Messages
  mattr_accessor :new_message_redirect_path
end
