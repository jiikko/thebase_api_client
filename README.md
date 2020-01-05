# ThebaesApiClient
このgemは非公式です。
https://docs.thebase.in/docs/api/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thebaes_api_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thebaes_api_client

## Usage
モデルを作ります

```ruby
create_table :thebase_accounts do |t|
  t.bigint :user_id, null: false, index: true
  t.string, :access_token, null: false
  t.string, :refresh_token, null: false
  t.datetime :expires_at, null: false
  t.datetime :revoked_at, null: false
  t.timestamps null: false
end

class ThebaseAccount < ApplicationRecord
  belongs_to :user
end
```

### authorize_codeを使ってaccess_token, refresh_token, expires_atを取得する
```ruby
user = User.last
hash = ThebaesApiClient.get_tokens(thebase_authorize_code)
user.create_thebase_account!(
  access_token: auth_hash[:access_token],
  refresh_token: auth_hash[:refresh_token],
  expires_at: auth_hash[:expires_at],
  revoked_at: nil,
)
```

### Refreshトークンを使って access_token, refresh_token, expires_atを取得する
```ruby
thebase_account = ThebaseAccount.last
client = ThebaesApiClient.new(thebase_account)
hash = client.refresh_access_token
thebase_account.update!(
  access_token: hash[:access_token],
  refresh_token: hash[:refresh_token],
  expires_at: hash[:expires_at],
  revoked_at: nil,
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/thebaes_api_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
