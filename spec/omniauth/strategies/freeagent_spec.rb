require 'spec_helper'
require 'omniauth-freeagent'

describe OmniAuth::Strategies::FreeAgent do
  subject do
    OmniAuth::Strategies::FreeAgent.new(nil, @options || {})
  end

  describe '#client' do
    it 'should have the correct site' do
      subject.client.site.should == 'https://api.freeagent.com'
    end

    it 'should have the correct auth URL' do
      subject.client.options[:authorize_url].should == '/v2/approve_app'
    end

    it 'should have the correct token URL' do
      subject.client.options[:token_url].should == '/v2/token_endpoint'
    end
  end

  describe '#callback_path' do
    it 'should have the correct callback path' do
      subject.callback_path.should == '/auth/freeagent/callback'
    end
  end
end
