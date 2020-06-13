class ThebaesApiClient::Resouces::Order
  def self.orders
    API.call(unique_key).map do |item|
      new(item)
    end
  end

  def self.order(unique_key)
    new(API.call(unique_key))
  end
end
