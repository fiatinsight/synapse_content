module Slugable
  extend ActiveSupport::Concern

  included do
    after_commit :create_slug, on: :create
    before_commit :clean_slug, on: :update
  end

  def create_slug
    if !self.slug? && self.title
      # Remove non-alphanumeric, except hyphens
      cleaned_title = self.title.gsub(/[^0-9a-z- ]/i, '')
      slug = "#{cleaned_title.split.join('-').downcase}"
      self.update(slug: slug)
    else
      slug = "article-#{self.id}"
      self.update(slug: slug)
    end
  end

  def clean_slug
    if self.slug?
      # Remove non-alphanumeric, except hyphens
      cleaned_slug = self.slug.gsub(/[^0-9a-z- ]/i, '')
      self.update(slug: cleaned_slug)
    end
  end
end
