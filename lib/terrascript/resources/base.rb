require 'virtus'
require_relative 'tag'

class Base
  include Virtus.model

  attr_accessor :env
  class << self; attr_reader :terraform end

  attribute :ident, String

  def id
    "#{self.class.terraform}.#{ident}.id"
  end
end

class TaggedBase < Base
  attribute :tags, Array[Tag]
end
