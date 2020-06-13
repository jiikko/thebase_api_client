module ThebaesApiClient::API::Item
  # @raise [ThebaesApiClient::Resouces::Item::InvalidAttributes]
  def create_item(item_hash)
    item = ThebaesApiClient::Resouces::Item.new(self)
    item.item_id = item_hash[:item_id]
    item.title = item_hash[:title]
    item.price = item_hash[:price]
    item.create!
    item.fetch!
  end

  def delete_item(itme_id)
    ThebaesApiClient::Resouces::Item.find(item_id).delete
  end

  def soldout_item(itme_id)
    ThebaesApiClient::Resouces::Item.find(item_id).soldout!
  end

  def upload_item_image(item_id, url, position)
    ThebaesApiClient::Resouces::Item.find(item_id, url, position)
  end
end
