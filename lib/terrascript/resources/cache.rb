require_relative 'base'

class AWSElasticacheParameter
  include Virtus.model

  attribute :name, String
  attribute :value, String
end

class AWSElasticacheCluster < TaggedBase
  @terraform = 'aws_elasticache_cluster'

  attribute :cluster_id, String
  attribute :engine, String
  attribute :engine_version, String
  attribute :node_type, String
  attribute :port, Integer
  attribute :num_cache_nodes, Integer
  attribute :parameter_group_name, String
  attribute :subnet_group_name, String
  attribute :security_group_ids, Array[String]
  attribute :apply_immediately, Axiom::Types::Boolean, default: false
end

class AWSElasticacheParameterGroup < Base
  @terraform = 'aws_elasticache_parameter_group'

  attribute :name, String
  attribute :family, String
  attribute :description, String
  attribute :parameter, Array[AWSElasticacheParameter]
end

class AWSElasticacheSecurityGroup < Base
  @terraform = 'aws_elasticache_security_group'

  attribute :name, String
  attribute :description, String
  attribute :security_group_names, Array[String]
end

class AWSElasticacheSubentGroup < Base
  @terraform = 'aws_elasticache_subnet_group'

  attribute :name, String
  attribute :description, String
  attribute :subnet_ids, Array[String]
end
