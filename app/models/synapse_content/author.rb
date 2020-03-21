module SynapseContent
  class Author < ApplicationRecord
    include Tokenable

    self.table_name = "synapse_authors"

    belongs_to :publisher, polymorphic: true, required: false
    has_many :articles
    # TODO: Include link to user-type ownership
  end
end
