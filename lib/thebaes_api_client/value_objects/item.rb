class ThebaesApiClient::ValueObject::Item
  class InvalidAttributes < StandardError; end

  attr_accessor :item_id, :title, :price, :identifier, :list_order, :stock, :visible

  def initialize(context)
    @context = context
  end

  def parse(hash)
    # TODO
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
