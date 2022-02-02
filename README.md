# Brightpearl

The Brightpearl gem allows Ruby developers to access the Brightpearl API resources for instance confidential apps.

The Brightpearl API is implemented as a REST API JSON interface, using various HTTP verbs such as: GET/POST/PUT/PATCH/OPTIONS/DELETE. Each resource, like Order, Product, or Contact, has different operations available.

To read more, follow the link to the official documentation: https://api-docs.brightpearl.com/
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-brightpearl'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ruby-brightpearl

## Usage

### Requirements

All API usage happens through brightpearl applications, created by developers for private usage or for use by other brightpearl site owners:

A brightpearl developer account is required to begin the development of apps, to read more info about the account creation refer to: https://help.brightpearl.com/hc/en-us/articles/211124886-Register-as-a-Brightpearl-developer

Once an account is provided, developers can create applications through the official portal of brightpearl applications: https://developer.brightpearl.com/

### Usage

#### 1) Create an app

Using the official portal create a new application, the type must be `instance`, once the app has been created an "application ID" and "secret" should be provided.

#### 2) Requesting access for a brightpearl account

Start by setting up the initial configuration for the client:
```ruby
require 'brightpearl'

Brightpearl.config.account =      ACCOUNT # Account to request API access
Brightpearl.config.dev_ref =      DEV_REF # From developer account creation

Brightpearl.config.app_ref =      APP_REF # Brightpearl app ID
Brightpearl.config.app_secret =   APP_REF # Brightpearl app secret
```

Before the API calls can be performed you will need to get a token, to get one the authentication flow must be followed as per brightpearl documentation: https://help.brightpearl.com/hc/en-us/articles/360032240811-Set-up-the-Authorization-Code-Grant-flow

The oauth URL can be then generated with:
```ruby
Brightpearl::Auth.oauth_url(state: "random-passcode", redirect_uri: "https://www.something.io/oauth") # => "https://oauth.brightpearl.com/authorize/testAccount?response_type=code&client_id=testAppName&redirect_uri=https://www.something.io/oauth&state=random-passcode
```
NOTE: The state argument on `oauth_url` method is a string defined by yourself, this should be a non guessable string that the authorization server will pass back to you on redirection which you should check against to prevent CSRF attacks

#### 3) Trading your `code` for an access token.

The oauth process will redirect to your `redirect_uri` with a param called `code`, the value of this parameter is a temporary token that the app can exchange for an access token.

This process be done by:

```ruby
Brightpearl::Auth.request_token(auth_token: AUTH_TOKEN, redirect_uri: "https://www.something.io/oauth") # => { payload: { "access_token" => "XXX", "refresh_token" => "XYZ", "api_domain" => "ws-use.brightpearl.com" } }
```

After the token is obtained it can be added to client by setting it on the config:
```ruby
Brightpearl.config.api_domain = API_DOMAIN # Such as ws-use.brightpearl.com
Brightpearl.config.token = TOKEN
Brightpearl.config.refresh_token = REFRESH_TOKEN
```

NOTES: 
* The token has a expiration time, when the token has expired a new one can be obtained using a refresh token.
* The redirect_uri used on `request_token` should be the same used on `oauth_url`

#### 3A) Using the refresh token to get a new access token

When the token has expired, the `use_refresh_token` method can be used:
```ruby
Brightpearl::Auth.use_refresh_token(refresh_token: "XXX")
# If refresh_token is loaded on config just call the method
Brightpearl::Auth.use_refresh_token()
```

The return value is the same as `request_token`, additionally by default the new `token` and `refresh_token` are loaded on `Brightpearl.config`, if for some reason this is undesired it can be turned off by calling the method as `Brightpearl::Auth.use_refresh_token(autoupdate: false)`

 #### 4) Making requests
Responses to REST requests are parsed into a hash with the keys `:payload` with the actual response from brightpearl API and `:quota_remaining` with the value of the current quota.

NOTE: Search operations returns a Ruby object for the resource as well for easier access to the attributes, this is returned in the `:records` key on the result.

```ruby
result = Brightpearl::Order.get(1)

order = result[:payload]["response"].first
puts order["id"] # => 1
puts order["orderTypeCode"] # => "SO"
```

Brightpearl API allows for multiple items to be requested at once on most resources:
```ruby
product_ids = [1, 2, 3]
result = Brightpearl::Product.get(product_ids.join(","))
puts result[:payload]["response"].size # => 3
```

NOTE: For more information about brightpearl API syntax refer to: https://help.brightpearl.com/hc/en-us/articles/212645003-URI-syntax


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruby-brightpearl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ruby-brightpearl/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Brightpearl project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ruby-brightpearl/blob/master/CODE_OF_CONDUCT.md).
