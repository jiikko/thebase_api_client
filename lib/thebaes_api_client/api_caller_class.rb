class ThebaesApiClient::ApiCallerClass
  def initialize(context)
    @context = context
  end

  def resource=(klass)
    @resource = klass
  end

  def resource
  end
end
