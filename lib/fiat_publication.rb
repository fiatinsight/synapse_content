require "fiat_publication/engine"

module FiatPublication
  mattr_accessor :new_message_redirect_path
  mattr_accessor :new_page_redirect_path
  mattr_accessor :new_article_redirect_path
end
