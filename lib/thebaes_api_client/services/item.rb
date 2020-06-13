module ThebaesApiClient::Services::Item
  def create_item(item_hash)
    item = ThebaesApiClient::ValueObject::Item.new
    item.item_id = item_hash[:item_id]
    item.title = item_hash[:title]
    item.price = item_hash[:price]
    raise(ThebaesApiClient::ValueObject::Item::InvalidAttributes) if invalid?
    call_api do |oauth2_client|
      repo = Repository.new
      repo.new(oauth2_client).create(item.to_hash)
      ThebaesApiClient::ValueObject::Item.parse(
        repo.new(oauth2_client).show(item.to_hash)['item']
      )
    end
  end

  def delete_item(itme_id)
    call_api do |oauth2_client|
      Repository.new(item_id).delete(item_id)
    end
  end

  def soldout_item(itme_id)
    call_api do |oauth2_client|
      Repository.new(item_id).soldout(item_id)
    end
  end

  def upload_item_image(item_id, url, position)
    call_api do |oauth2_client|
      Repository.new(item_id).upload_image(item_id)
    end
  end
end
