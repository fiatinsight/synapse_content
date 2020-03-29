module Slugable
  extend ActiveSupport::Concern

  included do
    after_commit :create_slug, on: :create
    before_commit :clean_slug, on: :update
  end

  def create_slug
    if !self.slug? && self.title?
      # Remove non-alphanumeric, except hyphens
      cleaned_title = self.title.gsub(/[^a-z0-9\-._ ]/i, '')
      slug = "#{cleaned_title.split.join('-').downcase}"
      self.update(slug: slug)
    elsif !self.title?
      slug = "#{self.class.name.downcase}-#{self.id}"
      self.update(slug: slug)
    end
  end

  def clean_slug
    if self.slug?
      # Remove non-alphanumeric, except hyphens
      cleaned_slug = self.slug.gsub(/[^a-z0-9\-._ ]/i, '')
      self.update(slug: cleaned_slug)
    end
  end

  def pretty_link_extension
    if self.published_at
      "/#{self.published_at.strftime("%Y")}/#{self.published_at.strftime("%m")}/#{self.published_at.strftime("%d")}/#{self.slug}"
    end
  end
end
