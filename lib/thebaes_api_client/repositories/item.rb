module ThebaesApiClient::Repositories
  class Item < ::ThebaesApiClient::Repositories::Base
    def show(item_id)
      json = JSON.parse(
        @token.post("/1/items/detail/#{item_id}").body
      )
    end

    def create(hash)
      json = JSON.parse(
        @oauth2_client.token.post(
          '/1/items/add', body: hash
        ).body
      )
    end

    def delete(item_id)
      JSON.parse(
        @oauth2_client.token.post(
          '/1/items/delete', body: { item_id: item_id }
        ).body
      )
    end

    def soldout(item_id)
      JSON.parse(
        @oauth2_client.token.post(
          '/1/items/update', body: { item_id: item_id, stock: 0 }
        ).body
      )
    end

    def upload_image(item_id, url, position)
      json = JSON.parse(
        oauth2_client.token.post(
          '/1/image',
          body: { item_id: item_id, image_url: url, image_no: image_no}
        ).body
      )
    end
  end
end
