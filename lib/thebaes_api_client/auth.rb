module ThebaesApiClient::Auth
  def refresh_tokens
    TheBaseIn::Authorization::RefreshAccessTokenService.new(oauth2_client).exec
  rescue OAuth2::Error => e
    revoke! if revoked?(e) || deleted_account?(e) || baned?(e)
    if /^5../ =~ e.response.status.to_s
      raise ServerError
    else
      raise
    end
  end

  def refresh!
    hash = refresh_tokens
    thebase_account.update!(
      access_token: hash[:access_token],
      refresh_token: hash[:refresh_token],
      expires_at: hash[:expires_at],
    )
  end
end
