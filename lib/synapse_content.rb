# See: http://lizabinante.com/blog/creating-a-configurable-ruby-gem/
require 'synapse_content/configuration'
require "synapse_content/engine"

module SynapseContent
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
