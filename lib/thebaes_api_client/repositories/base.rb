class ThebaesApiClient::Repositories::Base
  attr_reader :oauth2_client

  def initialize(oauth2_client)
    @oauth2_client = oauth2_client
  end
end
