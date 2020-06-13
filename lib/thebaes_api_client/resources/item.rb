class ThebaesApiClient::Resouces::Item
  class InvalidAttributes < StandardError; end

  attr_accessor :item_id, :title, :price, :identifier, :list_order, :stock, :visible

  def initialize(context)
    @context = context
  end

  def self.find(item_id)
    @context.call_api do |oauth2_client|
      json = JSON.parse(
        @token.post("/1/items/detail/#{item_id}").body
      )
    end
  end

  def create!
    raise(ThebaesApiClient::Resouces::Item::InvalidAttributes) if invalid?
    @context.call_api do |oauth2_client|
      json = JSON.parse(
        oauth2_client.token.post(
          '/1/items/add', body: to_hash
        ).body
      )
    end
  end

  def delete
    @context.call_api do |oauth2_client|
      JSON.parse(
        oauth2_client.token.post(
          '/1/items/delete', body: { item_id: item_id }
        ).body
      )
    end
  end

  def soldout!
    call_api do |oauth2_client|
      JSON.parse(
        oauth2_client.token.post(
          '/1/items/update', body: { item_id: item_id, stock: 0 }
        ).body
      )
    end
  end

  def upload_image(item_id, url, position)
    call_api do |oauth2_client|
      json = JSON.parse(
        oauth2_client.token.post(
          '/1/image',
          body: { item_id: item_id, image_url: url, image_no: image_no}
        ).body
      )
    end
  end

  def fetch!
    self.class.find(item_id)
  end

  def valid?
    item_id && title && price
  end

  def invalid?
    !valid?
  end

  def to_hash
    { item_id: item_id,
      title: title,
      price: price,
      identifier: identifier,
      list_order: list_order,
      stock: stock,
      visible: visible,
    }
  end
end
