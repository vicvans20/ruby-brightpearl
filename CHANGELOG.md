## [Unreleased]

## [0.13.0] - 2026-06-03

### Added

- New contact reference resources `ContactTag`, `ContactGroup`, and `LeadSource`
  - Available operations: `GET`
  - Supports fetching the full list (no argument) or a specific record by id-set
  - Note: `ContactTag` response is a Hash keyed by tag id, not an Array
- New order reference resources `OrderType` and `OrderStockStatus`
  - Available operations: `GET`
  - Supports fetching the full list (no argument) or a specific record by id-set
- New accounting reference resources `NominalCode` and `PaymentMethod`
  - Available operations: `GET`
  - Supports fetching the full list (no argument) or a specific record by id-set
- New warehouse reference resource `ShippingMethod`
  - Available operations: `GET`
  - Supports fetching the full list (no argument) or a specific record by id-set

## [0.12.0] - 2026-06-02

### Added

- New catalog resources `Brand`, `Channel`, `ProductCategory`, `ProductType`, and `Warehouse`
  - Available operations: `GET`
  - Supports fetching the full list (no argument) or a specific record by id-set

## [0.11.0] - 2026-05-08

### Added

- New resources `ContactCustomFieldMetadata`, `OrderCustomFieldMetadata`, and `ProductCustomFieldMetadata`
  - Available operations: `GET`
  - Useful to get the available custom fields for a contact, order, or product and their metadata (name, type, list of values, etc.)

## [0.10.0] - 2026-04-17

### Added

- New resource `CustomerPayment`
  - Available operations: `SEARCH`, `POST`, `DELETE`

## [0.9.0] - 2025-12-10

### Changed

- **Renamed `Customer` resources to `Contact` to match Brightpearl API documentation**
  - Renamed `Customer` to `Contact`
  - Renamed `CustomerCustomField` to `ContactCustomField`

## [0.8.0] - 2025-11-05

### Added

- **New resource `GoodsOutNote`**
  - Available operations: `GET`, `POST`, `PUT`, `DELETE`
  - Search is still pending to be implemented

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
