require_relative 'base'

class AWSDnsRecord < Base
  @terraform = 'aws_route53_record'
  attribute :zone_id, String
  attribute :name, String
  attribute :type, String
  attribute :ttl, Integer
  attribute :records, Array[String]
end
