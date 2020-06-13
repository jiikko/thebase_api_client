module ThebaesApiClient::Repositories::AccessToken
  attr_accessor :thebase_account

  def initialize(thebase_account)
    oauth2_client = TheBaseIn::OAuthClient.new(
      thebase_account.access_token,
      thebase_account.refresh_token,
      thebase_account.expires_at,
    )

    # 期限を見るのではなくて403が返ってきたらrefreshしたい
    refresh! if thebase_account.expired?
    begin
      yield(oauth2_client)
    rescue OAuth2::Error => e
      # アクセストークンが無効になった時にrefreshAPIのレスポンスで判断する
      # TODO refresh後はoauth2_clientを作り直さないといけない
      refresh! if invalid_access_token?(e)
      raise
    end
  end

  def expired?
    thebase_account.expires_at.feature?
  end

  def revoke!
    Rails.logger.info("#{user.slice(:id, :display_name, :email)}のBASE連携を無効化しました")
    thebase_account.update!(revoked_at: Time.current)
  end

  def revoked?(e)
    # BASE連携解除すると`invalid_request: 不正なリフレッシュトークンです。`が返ってくる
    # https://github.com/baseinc/api-docs/blob/master/base_api_v1_oauth_refresh_token.md
    /invalid_request/ =~ e.code && \
      /不正なリフレッシュトークンです/ =~ e.description
  end

  # https://github.com/monolink-corp/monolink-server/issues/3247
  def deleted_account?(e)
    /access_denied/ =~ e.code && \
      /ユーザーが存在しません/ =~ e.description
  end

  def invalid_access_token?(e)
    /invalid_request/ =~ e.code && \
      /アクセストークンが無効です/ =~ e.description
  end

  # https://github.com/monolink-corp/monolink-server/issues/3459
  def baned?(e)
    /access_denied/ =~ e.code && \
      /利用が制限されているユーザーです/ =~ e.description
  end
end
