require "thebaes_api_client/version"

module ThebaesApiClient
  def self.new(model)
    Service.new(model)
  end

  def self.configure
    yield(Config.new)
  end
end
