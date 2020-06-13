module ThebaesApiClient::API::Order
  # @return [ThebaesApiClient::Resouces::Order]
  def get_orders(page: 0, option: {})
    ThebaesApiClient::Resouces::Order.all(page, option)
  end

  def get_order(unique_key)
    ThebaesApiClient::Resouces::Order.find(unique_key)
  end
end
