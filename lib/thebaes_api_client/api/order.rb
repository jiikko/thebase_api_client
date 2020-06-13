module ThebaesApiClient::API::Order
  def orders(page: 0)
    call_api do
      ThebaesApiClient::API::Order.new(oauth2_client).get_orders
    end
  end

  def order(unique_key)
    call_api do
      # return ThebaesApiClient::Resouces::Order
      ThebaesApiClient::API::Order.new(oauth2_client).get_order(unique_key)
    end
  end
end
