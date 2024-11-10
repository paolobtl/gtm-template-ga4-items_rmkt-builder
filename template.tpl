___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "GA4 Items to Dynamic Remarketing Items builder",
  "categories": ["UTILITY", "REMARKETING"],
  "description": "Maps GA4 Items into a Google Ads Dynamic Remarketing object. \nReference \u003ca href\u003d\"https://support.google.com/google-ads/answer/7305793?hl\u003den\u0026sjid\u003d14873146135060433884-EU\"\u003ehere\u003c/a\u003e",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "items",
    "displayName": "GA4 Items Array",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "useDataLayer",
        "paramValue": false,
        "type": "EQUALS"
      }
    ],
    "help": "Use a GA4 formatted \u003ca target\u003d\"_blank\" href\u003d\"https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type\u003dgtag\"\u003eitems\u003c/a\u003e array"
  },
  {
    "type": "SELECT",
    "name": "businessVertical",
    "displayName": "Business Vertical",
    "macrosInSelect": true,
    "selectItems": [
      {
        "value": "retail",
        "displayValue": "Retail"
      },
      {
        "value": "education",
        "displayValue": "Education"
      },
      {
        "value": "flights",
        "displayValue": "Flights"
      },
      {
        "value": "hotel_rental",
        "displayValue": "Hotels and rentals"
      },
      {
        "value": "jobs",
        "displayValue": "Jobs"
      },
      {
        "value": "local",
        "displayValue": "Local deals"
      },
      {
        "value": "real_estate",
        "displayValue": "Real Estate"
      },
      {
        "value": "travel",
        "displayValue": "Travel"
      },
      {
        "value": "custom",
        "displayValue": "Custom"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "retail",
    "alwaysInSummary": true,
    "help": "Consult the \u003ca href\u003d\"https://support.google.com/google-ads/answer/7305793?hl\u003den\u0026sjid\u003d14873146135060433884-EU\"\u003edocumentation\u003c/a\u003e to properly add and format additional parameters. \u003c/br\u003eRemember to add the keys named as in the article cited above to your array of \u003ci\u003eitems\u003c/i\u003e."
  },
  {
    "type": "CHECKBOX",
    "name": "useDataLayer",
    "checkboxText": "Use Data Layer",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "defaultValue": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromDataLayer = require('copyFromDataLayer');
const ecommerce = copyFromDataLayer('ecommerce');
const ga4Items = data.useDataLayer ? ecommerce.items : data.items;
const log = require('logToConsole');
const businessVertical = data.businessVertical;

if (!ga4Items) return;

const rmktItems = (ga4items) => {
  return ga4items.map(item => {
    const baseItem = {
      id: item.item_id,
      google_business_vertical: businessVertical
    };

    switch(businessVertical) {
      case 'education':
      case 'jobs':
        baseItem.location_id = item.location_id;
        return baseItem;
      case 'flights':
      case 'hotel_rental':
      case 'travel':
          baseItem.origin= item.origin;
          baseItem.destination= item.destination;
          baseItem.start_date= item.start_date;
          baseItem.end_date= item.end_date;
        return baseItem;
      default:
        return baseItem;
    }
  });
};

return rmktItems(ga4Items);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ecommerce"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Retail - is not undefined
  code: |-
    mockData.businessVertical= 'retail';

    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: Travel - is not undefined
  code: "mockData.businessVertical= 'travel';\n\nmockData.items[0] = {\n      item_id:\
    \ \"SKU_12346\",\n      item_name: \"Google Grey Women's Tee\",\n      origin:\
    \ 'KRK',\t\n      destination: 'LON',\n      start_date: '2019-04-20',\n     \
    \ end_date: '2019-04-21',\n      price: 21.01,\n      quantity: 2,\n    };\n\n\
    // Call runCode to run the template's code.\nlet variableResult = runCode(mockData);\n\
    \n// Verify that the variable returns a result.\nassertThat(variableResult).isNotEqualTo(undefined);"
- name: Jobs - is not undefined
  code: "mockData.businessVertical= 'jobs';\n\nmockData.items[0] = {\n      item_id:\
    \ \"SKU_12346\",\n      location_id: 'KRK',\n      item_name: \"Google Grey Women's\
    \ Tee\",\n      origin: 'KRK',\t\n      destination: 'LON',\n      start_date:\
    \ '2019-04-20',\n      end_date: '2019-04-21',\n      price: 21.01,\n      quantity:\
    \ 2,\n    };\n\n// Call runCode to run the template's code.\nlet variableResult\
    \ = runCode(mockData);\n\n// Verify that the variable returns a result.\nassertThat(variableResult).isNotEqualTo(undefined);"
- name: GA4 Items is undefined
  code: |-
    mockData = {};

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(undefined);
setup: |-
  let mockData = {
    useDataLayer: false,
    items:  [
      {
        item_id: "SKU_12345",
        item_name: "Stan and Friends Tee",
        affiliation: "Google Merchandise Store",
        coupon: "SUMMER_FUN",
        discount: 2.22,
        index: 0,
        item_brand: "Google",
        item_category: "Apparel",
        item_category2: "Adult",
        item_category3: "Shirts",
        item_category4: "Crew",
        item_category5: "Short sleeve",
        item_list_id: "related_products",
        item_list_name: "Related Products",
        item_variant: "green",
        location_id: "ChIJIQBpAG2ahYAR_6128GcTUEo",
        price: 10.01,
        quantity: 3
      },
      {
        item_id: "SKU_12346",
        item_name: "Google Grey Women's Tee",
        affiliation: "Google Merchandise Store",
        coupon: "SUMMER_FUN",
        discount: 3.33,
        index: 1,
        item_brand: "Google",
        item_category: "Apparel",
        item_category2: "Adult",
        item_category3: "Shirts",
        item_category4: "Crew",
        item_category5: "Short sleeve",
        item_list_id: "related_products",
        item_list_name: "Related Products",
        item_variant: "gray",
        location_id: "ChIJIQBpAG2ahYAR_6128GcTUEo",
        price: 21.01,
        quantity: 2
      }
    ]
  };


___NOTES___

Created on 10/11/2024, 14:25:08


