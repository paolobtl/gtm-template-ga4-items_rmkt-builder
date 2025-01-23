# GA4 Items to Dynamic Remarketing Items Builder

## Overview

This Google Tag Manager (GTM) template is designed to map GA4 eCommerce `items` into a Google Ads Dynamic Remarketing object. It enables businesses to seamlessly translate GA4 eCommerce data into a format suitable for Google Ads remarketing campaigns.

[Template Gallery](https://tagmanager.google.com/gallery/#/owners/paolobtl/templates/gtm-template-ga4-items_rmkt-builder)
## Features

- Extracts GA4 `items` array from the **Data Layer** or **manual input**.
- Converts GA4 `items` into a **Google Ads Dynamic Remarketing**-compatible format.
- Supports multiple **business verticals**:
  - Retail
  - Education
  - Flights
  - Hotels and Rentals
  - Jobs
  - Local Deals
  - Real Estate
  - Travel
  - Custom
- Ensures compatibility with Google Ads Dynamic Remarketing specifications.

## Parameters

### **1. GA4 Items Array** (`items`)

- Type: `TEXT`
- Description: The array of items formatted according to GA4 eCommerce standards.
- Required when **`Use Data Layer`** is set to `false`.
- Reference: [GA4 eCommerce Documentation](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm)

### **2. Business Vertical** (`businessVertical`)

- Type: `SELECT`
- Default: `Retail`
- Options:
  - Retail
  - Education
  - Flights
  - Hotels and Rentals
  - Jobs
  - Local Deals
  - Real Estate
  - Travel
  - Custom
- Description: Specifies the business category to format the remarketing data accordingly.
- Reference: [Google Ads Dynamic Remarketing](https://support.google.com/google-ads/answer/7305793?hl=en)

### **3. Use Data Layer** (`useDataLayer`)

- Type: `CHECKBOX`
- Default: `true`
- Description: If checked, the template will automatically pull `ecommerce.items` from the Data Layer.

## How It Works

1. The template reads the `ecommerce.items` array either from the **Data Layer** or from a manually provided input.
2. It maps the relevant properties to a Google Ads Dynamic Remarketing-compatible structure.
3. Depending on the selected **Business Vertical**, additional fields such as `location_id`, `origin`, and `destination` are included.
4. The processed data is returned in the required format.

## Example Output

### Input (GA4 eCommerce Items):

```js
{
  "item_id": "SKU_12345",
  "item_name": "Stan and Friends Tee",
  "price": 10.01,
  "quantity": 3,
  "origin": "JFK",
  "destination": "LAX",
  "start_date": "2024-06-01",
  "end_date": "2024-06-07"
}
```

### Output (Google Ads Remarketing Format):

```js
[{
  "id": "SKU_12345",
  "google_business_vertical": "travel",
  "origin": "JFK",
  "destination": "LAX",
  "start_date": "2024-06-01",
  "end_date": "2024-06-07"
}]
```

## Permissions

- **Read Data Layer**: The template reads `ecommerce.items` from the Data Layer.
- **Logging (Debug Mode)**: Logs data for debugging when GTM is in Debug mode.

## Testing

The template includes multiple test scenarios to ensure functionality:

1. **Retail Vertical Test** - Ensures a valid output is generated.
2. **Travel Vertical Test** - Verifies inclusion of `origin`, `destination`, `start_date`, and `end_date`.
3. **Jobs Vertical Test** - Checks for `location_id` in the output.
4. **GA4 Items Undefined Test** - Ensures proper handling when no items are provided.

## Setup Instructions

1. Add this template to your **Google Tag Manager** container.
2. Configure the **Business Vertical** parameter according to your business type.
3. Set `Use Data Layer` to `true` if your GA4 eCommerce data is pushed into the Data Layer.
4. Test using GTM’s **Preview Mode** to ensure correct data mapping.

## Notes

- Created on: **10/11/2024**
- Maintained for Google Ads Dynamic Remarketing Integration.

## License
Apache License 2.0

