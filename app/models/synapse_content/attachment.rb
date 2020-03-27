module SynapseContent
  class Attachment < ApplicationRecord
    include Tokenable

    attr_accessor :edit_redirect_path, :edit_redirect_variable, :destroy_redirect_path, :destroy_redirect_variable

    self.table_name = "synapse_attachments"

    belongs_to :publisher, polymorphic: true, required: false
    belongs_to :attachable, polymorphic: true, required: false
    belongs_to :authorable, polymorphic: true, required: false
    # has_many :navigation_items, as: :navigable

    has_one_attached :file

    validates :title, presence: true
    validates :file, presence: true
  end
end
