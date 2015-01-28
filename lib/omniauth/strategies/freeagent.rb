require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class FreeAgent < OmniAuth::Strategies::OAuth2
      option :name, 'freeagent'

      args [:client_id, :client_secret, :environment]
      
      option :client_options, {
        :site => 'https://api.freeagent.com',
        :authorize_url => '/v2/approve_app',
        :token_url => '/v2/token_endpoint'
      }

      option :environment, :live

      uid do
        raw_info['url'].split('/').last.to_i
      end

      info do
        {
          'email' => raw_info['email'],
          'first_name' => raw_info['first_name'],
          'last_name' => raw_info['last_name'],
          'url' => raw_info['url']
        }
      end

      extra do
        {
          "raw_info" => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/v2/users/me').parsed['user']
      end

      def client
        client_options = options.client_options
        client_options.merge!(site: 'https://api.sandbox.freeagent.com') if options.environment == :sandbox
        ::OAuth2::Client.new(options.client_id, options.client_secret, deep_symbolize(client_options))
      end
    end
  end
end

OmniAuth.config.add_camelization 'freeagent', 'FreeAgent'
