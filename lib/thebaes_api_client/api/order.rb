module ThebaesApiClient::API::Order
  # @return [Hash]
  def orders(page: 0, option: {})
    list = nil
    call_api do
      uri = URI.parse('/1/items')
      uri.query = option.to_query if option.present?
      list = JSON.parse(@oauth2_client.token.get(uri.to_s).body)['order']
    end
    list.map do |hash|
      ThebaesApiClient::Resouces::ListOrder.parse(hash)
    end
  end

  def order(unique_key)
    hash = nil
    call_api do
      hash = JSON.parse(
        @oauth2_client.token.get("/1/items/detail/#{unique_key}").body
      )['order']
    end
    ThebaesApiClient::Resouces::Order.parse(hash)
  end
end
