class ThebaesApiClient::ValueObject::Order
  attr_accessor :unique_key, :ordered_at, :cancelled_at, :modified_at, :payment, :dispatch_status, :orders

  def initialize(hash)
    instance = new
    instance.unique_key = hash['unique_key']
    instance.ordered_at = Time.at(hash['ordered'])
    instance.cancelled_at = Time.at(hash['cancelled']) if hash['cancelled'].present?
    instance.modified_at = Time.at(hash['modified']) if hash['modified'].present?
    instance.payment = hash['payment']
    instance.dispatch_status = hash['dispatch_status']
    instance
  end
end
