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

  # @return [ThebaesApiClient::Resouces::Order]
  def get_orders(page: 0, option: {})
    call_api do |oauth2_client|
      list = ThebaesApiClient::Repositories::Order.new(oauth2_client).index(page, option)
      list.map do |hash|
        ThebaesApiClient::ValueObject::Order.parse(hash)
      end
    end
  end

  def get_order(unique_key)
    call_api do |oauth2_client|
      hash = ThebaesApiClient::Repositories::Order.new(oauth2_client).show(unique_key)
      ThebaesApiClient::ValueObject::Order.parse(hash)
    end
  end

  def create_item(item_hash)
    item = ThebaesApiClient::ValueObject::Item.new
    item.item_id = item_hash[:item_id]
    item.title = item_hash[:title]
    item.price = item_hash[:price]
    raise(ThebaesApiClient::ValueObject::Item::InvalidAttributes) if invalid?
    call_api do |oauth2_client|
      repo = ThebaesApiClient::Repositories::Item.new
      repo.new(oauth2_client).create(item.to_hash)
      ThebaesApiClient::ValueObject::Item.parse(
        repo.new(oauth2_client).show(item.to_hash)['item']
      )
    end
  end

  def delete_item(itme_id)
    call_api do |oauth2_client|
      ThebaesApiClient::Repositories::Item.new(item_id).delete(item_id)
    end
  end

  def soldout_item(itme_id)
    call_api do |oauth2_client|
      ThebaesApiClient::Repositories::Item.new(item_id).soldout(item_id)
    end
  end

  def upload_item_image(item_id, url, position)
    call_api do |oauth2_client|
      ThebaesApiClient::Repositories::Item.new(item_id).upload_image(item_id)
    end
  end
end
