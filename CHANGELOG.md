## [Unreleased]

## [0.3.0] - 2022-02-03
- New resource ProductAvailability
## [0.2.0] - 2022-02-02
- Add refresh token mechanic with method `use_refresh_token`
- Change config values
  - Add refresh_token to allow automatic update of tokens when calling the new method `use_refresh_token`
  - Remove `oauth_redirect_url` in favor of keyword arguments on `oauth_url` and `request_token`
- Create a temp method for Client to use a token per request
- Add error handling on auth request_token method and tests for some common errors.

## [0.1.0] - 2022-01-21

- Initial release
