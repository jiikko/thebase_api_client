class ThebaesApiClient::Resouces::Order
  attr_accessor :unique_key, :ordered_at, :cancelled_at, :modified_at, :payment, :dispatch_status, :orders

  def initialize(context)
    @context = context
  end

  def self.parse(hash)
    instance = new
    instance.unique_key = hash['unique_key']
    instance.ordered_at = Time.at(hash['ordered'])
    instance.cancelled_at = Time.at(hash['cancelled']) if hash['cancelled'].present?
    instance.modified_at = Time.at(hash['modified']) if hash['modified'].present?
    instance.payment = hash['payment']
    instance.dispatch_status = hash['dispatch_status']
    instance
  end

  def find(unique_key)
    @context.call_api do |oauth2_client|
      hash = JSON.parse(
        oauth2_client.token.get("/1/items/detail/#{unique_key}").body
      )['order']
      ThebaesApiClient::Resouces::Order.parse(hash)
    end
  end

  def all(page, option)
    call_api do |oauth2_client|
      uri = URI.parse('/1/items')
      uri.query = option.to_query if option.present?
      list = JSON.parse(oauth2_client.token.get(uri.to_s).body)['order']
      list.map do |hash|
        ThebaesApiClient::Resouces::Order.parse(hash)
      end
    end
  end

  def fetch!
    order(unique_key)
  end
end
