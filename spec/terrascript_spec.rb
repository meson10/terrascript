require 'spec_helper'
require 'terrascript/env'

class CredsAgent < Agent
  def access_key
    'access_key'
  end

  def secret_key
    'secret_key'
  end
end

describe Terrascript do
  environment = 'local'

  let(:env) { Env.new environment }

  describe 'Environment' do
    it 'should make proper json' do
      expect(env.generate['resource']).to eq({})
    end

    it 'should create an agent' do
      creds = CredsAgent.new('creds')
      env.add_agent(creds)

      expect(env.get_agent('creds')).to eq creds
    end
  end
end
