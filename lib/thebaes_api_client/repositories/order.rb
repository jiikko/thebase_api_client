module ThebaesApiClient::Repositories
  class Order < ::ThebaesApiClient::Repositories::Base
    def index(page, option)
      uri = URI.parse('/1/items')
      uri.query = option.to_query if option.present?
      JSON.parse(oauth2_client.token.get(uri.to_s).body)['order']
    end

    def show(unique_key)
      JSON.parse(
        oauth2_client.token.get("/1/items/detail/#{unique_key}").body
      )['order']
    end
  end
end
