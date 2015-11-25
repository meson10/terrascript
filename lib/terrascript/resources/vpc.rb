require 'virtus'

require_relative 'base'

class AWSVPC < TaggedBase
  @terraform = 'aws_vpc'

  attribute :cidr_block, String, default: '10.0.0.0/16'
  attribute :enable_dns_support, Axiom::Types::Boolean, default: true
  attribute :enable_dns_hostnames, Axiom::Types::Boolean, default: true
end

class AWSSubnet < TaggedBase
  @terraform = 'aws_subnet'

  attribute :vpc_id, String
  attribute :cidr_block, String
  attribute :map_public_ip_on_launch, Axiom::Types::Boolean, default: true
  attribute :availability_zone, String
end

class AWSInternetGateway < TaggedBase
  @terraform = 'aws_internet_gateway'

  attribute :vpc_id, String
end

class AWSRoute
  include Virtus.model

  attribute :cidr_block, String, default: '0.0.0.0/0'
  attribute :gateway_id, String
end

class AWSRouteTable < TaggedBase
  @terraform = 'aws_route_table'

  attribute :vpc_id, String
  attribute :route, AWSRoute
end

class AWSRouteTableAssociation < Base
  @terraform = 'aws_route_table_association'
  attribute :subnet_id, String
  attribute :route_table_id, String
end
