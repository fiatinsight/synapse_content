module SynapseContent
  class Configuration
    attr_accessor :pages_path, :new_page_path, :new_page_redirect_path, :view_page_path, :articles_path, :new_article_path, :new_article_redirect_path, :view_article_path, :attachments_path, :new_attachment_redirect_path, :navigation_groups_path, :new_navigation_group_path, :new_navigation_group_redirect_path, :navigation_items_path, :new_navigation_item_path, :new_navigation_item_redirect_path, :new_message_redirect_path

    def initialize
      @pages_path = nil
      @new_page_path = nil
      @new_page_redirect_path = nil
      @view_page_path = nil
      @articles_path = nil
      @new_article_path = nil
      @new_article_redirect_path = nil
      @view_article_path = nil
      @attachments_path = nil
      @new_attachment_redirect_path = nil
      @navigation_groups_path = nil
      @new_navigation_group_path = nil
      @new_navigation_group_redirect_path = nil
      @navigation_items_path = nil
      @new_navigation_item_path = nil
      @new_navigation_item_redirect_path = nil
      @new_message_redirect_path = nil
    end
  end
end
