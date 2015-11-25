require 'virtus'
require_relative 'tag'
require_relative 'base'

module Instance
  include Virtus.module(:coerce => true)

  attribute :instance_type, String
  attribute :key_name, String
end

class AWSInstance < TaggedBase
  include Instance
  @terraform = 'aws_instance'
  attribute :ami, String
  attribute :vpc_security_group_ids, Array[String]
  attribute :subnet_id, String
  attribute :associate_public_ip_address, Axiom::Types::Boolean, default: true
end

# NOTE on Security Groups and Security Group Rules: Terraform currently
# provides both a standalone Security Group Rule resource (a single ingress
# or egress rule), and a Security Group resource with ingress and egress
# rules defined in-line. At this time you cannot use a Security Group with
# in-line rules in conjunction with any Security Group Rule resources.
# Doing so will cause a conflict of rule settings and will overwrite rules.
class AWSSecurityGroup < TaggedBase
  @terraform = 'aws_security_group'

  attribute :vpc_id, String
  attribute :name, String
end

class AWSKeyPair < Base
  @terraform = 'aws_key_pair'
  attribute :public_key, String
  attribute :key_name, String
end

class AWSSecutiryGroupRule < Base
  @terraform = 'aws_security_group_rule'

  attribute :type, String
  attribute :security_group_id, String
  attribute :from_port, Integer, default: 0
  attribute :to_port, Integer, default: 0
  attribute :protocol, String, default: 'tcp'
  attribute :cidr_blocks, [String], default: ['0.0.0.0/0']
end
