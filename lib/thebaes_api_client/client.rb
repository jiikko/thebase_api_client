class ThebaesApiClient::Client
  class ServerError < StandardError; end

  include ThebaesApiClient::Auth
  include ThebaesApiClient::ApiCaller

  attr_accessor :thebase_account, :oauth2_client

  def initialize(thebase_account)
    @oauth2_client = TheBaseIn::OAuthClient.new(
      thebase_account.access_token,
      thebase_account.refresh_token,
      thebase_account.expires_at,
    )
  end

  def self.get_tokens(thebase_authorize_code)
    result = TheBaseIn::Authorization::FetchAccessTokenService.new(thebase_authorize_code).exec
    return {
      access_token: result[:access_token],
      refresh_token: result[:refresh_token],
      expires_at: result[:expires_at],
    }
  end
end
