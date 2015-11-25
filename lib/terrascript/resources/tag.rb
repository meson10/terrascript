require 'virtus'

class Tag
  include Virtus.model

  attribute :key, String
  attribute :value, String
end
