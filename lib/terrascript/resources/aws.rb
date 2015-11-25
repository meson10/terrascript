require_relative 'provider'

class AWSProvider < Provider
  attribute :access_key, String
  attribute :secret_key, String
  attribute :region, String
end
