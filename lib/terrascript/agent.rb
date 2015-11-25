module Ident
  @ident = ''
  attr_accessor :ident
end

class Agent
  include Ident

  attr_accessor :env

  def initialize(name)
    fail("#{name} should be a String") if name.nil? || name.empty?
    @ident = name
  end
end
