module Slugable
  extend ActiveSupport::Concern

  included do
    after_commit :create_slug, on: :create
  end

  def create_slug
    if !self.slug? && self.title
      slug = "#{self.title.split.join('-').downcase}"
      self.update(slug: slug)
    end
  end
end
