## [Unreleased]

## [0.7.0] - 2025-11-03

### Added

- New API Operation `DELETE`
- **New resource `Webhook`**
  - Available operations: `GET`, `POST`, `DELETE`

### Changed
- Improved `Brightpearl::RequestError` message to include error code when available
  - For example, `CMNC-404 - Resource not found` instead of just `Resource not found`

## [0.6.0] - 2025-08-28

- New resource `Customer`
- New resource `CustomerCustomField`
- Minor fixes on development libs

## [0.5.0] - 2025-03-27

- Add new resource OrderCustomField
- Improve test environment to use different bp credentials without breaking the cassettes

## [0.3.0] - 2022-02-03

- New resource TaxCode
- Fix minor typos
- New optional config `debug_mode`

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
