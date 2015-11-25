require 'virtus'

require_relative 'agent'
require_relative 'resources/provider'

class Env
  @resources = nil
  @agents = nil
  @provider = nil

  attr_reader :providers
  attr_reader :resources

  include Ident

  def initialize(name)
    @ident = name
    @agents = {}
    @resources = {}
    @providers = {}
  end

  def get_agent(name)
    @agents[name.downcase]
  end

  def add_agent(m)
    fail('argument must be of type agent') unless m.is_a? Agent
    fail "agent #{m.ident} already exists" if @agents.key? m.ident
    m.env = self
    @agents[m.ident] = m
  end

  def add_provider(p)
    fail('argument must be a type Provider') unless p.is_a? Provider
    fail "Provider #{p.ident} already exists" if @providers.key? p.ident
    @providers[p.ident] = p
  end

  def add_resource(resource)
    fail("#{resource} is not a valid terraform resource") unless \
      resource.class.respond_to?(:terraform)

    name = resource.ident

    fail("#{name} should be a String") if name.nil? || name.empty?

    rtype = resource.class.terraform
    fail('resource must have a valid @terraform identifier') if \
      rtype.nil? || rtype.empty?

    @resources[rtype] = {} unless @resources.key? rtype
    fail "Resource #{name} already exists for #{rtype}" if \
      @resources[rtype].key? name

    resource.env = self

    if resource.attributes.key? :tags
      resource.tags << Tag.new(key: 'environment', value: ident)
      resource.tags << Tag.new(key: 'Name', value: name)
    end

    @resources[rtype][name] = resource
  end

  def generate
    config = { 'resource' => {} }

    if providers.length > 0
      config['provider'] = {}
      providers.each do |k, p|
        config['provider'][k] = serialize(p)
      end
    end

    @resources.each do |k, m|
      config['resource'][k] = {}
      m.each do |name, r|
        config['resource'][k][name] = serialize(r)
      end
    end
    config
  end

  private

  def serialize(o)
    if o.is_a? Hash
      ret = {}
      o.each_pair do |k, v|
        val = serialize(v)
        ret[k] = val unless val.nil?
      end
      return ret
    elsif o.is_a? Array
      ret = o.map { |v| serialize(v) }
    elsif o.class.respond_to?(:serialize)
      return o.serialize
    elsif o.class.respond_to?(:attributes)
      ret = {}
      o.attributes.each_pair do |k, v|
        next if k == 'ident' || k == :ident
        val = serialize(v)
        ret[k] = val unless val.nil?
      end
      return ret
    else
      return o
    end
  end
end
