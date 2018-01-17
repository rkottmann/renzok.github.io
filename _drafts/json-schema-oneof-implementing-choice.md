---
title: "Implementing choice in JSON Schema using oneOf"
layout: post
date: 2017-10-31
---

The document:

```
{
  "test": "ff",
  "item-list": [
    {
      "item-id": "submitted_to_insdc",
      "label": "submitted to insdc",
      "expected-value": "booleaccn",
      "syntax": "{boolean}",
      "example": "xc",
      "occurrence": "1",
      "section": "investigation"
    }
  ]
}
```




Wrong:
```
{
  "$schema": "http://json-schema.org/draft-06/schema#",
  "definitions": {
    "checklist-item": {
      "title": "Most general definition of a checklist item",
      "type": "object",
      "additionalProperties": true,
      "required": [
        "item-id",
        "label",
        "expected-value",
        "syntax",
        "example",
        "occurrence",
        "section"
      ],
      "properties": {
        "item-id": {
          "type": "string"
        },
        "label": {
          "type": "string"
        },
        "definition": {
          "type": "string"
        },
        "expected-value": {
          "type": "string"
        }
      }
    },
    "item-list": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "object"
      }
    },
    "checklist": {
      "type": "object"
    },
    "env-package": {
      "type": "object"
    },
    "profile": {
      "type": "object"
    }
  },
  "type": "object",
  "required": [
    "test"
  ],
  "properties": {
    "test": {
      "type": "string"
    }
  },
  "oneOf": [
    {
      "properties": {
        "item-list": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/checklist-item"
          }
        }
      }
    },
    {
      "properties": {
        "checklist": {
          "$ref": "#/definitions/checklist"
        }
      }
    },
    {
      "properties": {
        "env-package": {
          "$ref": "#/definitions/env-package"
        }
      }
    },
    {
      "properties": {
        "profile": {
          "$ref": "#/definitions/profile"
        }
      }
    }
  ]
}

```
with error `should match exactly one schema in oneOf`




It helps to be clear about the fact that each JSON Schema keyword expresses a contraint which be placed on a JSON element

Solution found by https://stackoverflow.com/questions/41545722/represent-xschoice-as-json-schema
```
{
  "$schema": "http://json-schema.org/draft-06/schema#",
  "definitions": {
    "checklist-item": {
      "title": "Most general definition of a checklist item",
      "type": "object",
      "required": [
        "item-id",
        "label",
        "expected-value",
        "syntax",
        "example",
        "occurrence",
        "section"
      ],
      "properties": {
        "item-id": {
          "type": "string"
        },
        "label": {
          "type": "string"
        },
        "definition": {
          "type": "string"
        },
        "expected-value": {
          "type": "string"
        },
        "syntax": {
          "type": "string"
        },
        "example": {
          "type": "string"
        },
        "occurrence": {
          "type": "string"
        },
        "section": {
          "type": "string"
        }
      }
    },
    "checklist": {
      "type": "string"
    },
    "env-package": {
      "type": "number"
    },
    "profile": {
      "type": "boolean"
    }
  },
  "type": "object",
  "required": [
    "test"
  ],
  "properties": {
    "test": {
      "type": "string"
    },
    "item-list": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/checklist-item"
      }
    },
    "checklist": {
      "$ref": "#/definitions/checklist"
    },
    "env-package": {
      "$ref": "#/definitions/env-package"
    },
    "profile": {
      "$ref": "#/definitions/profile"
    }
  },
  "oneOf": [
    {
      "required": [
        "item-list"
      ]
    },
    {
      "required": [
        "checklist"
      ]
    },
    {
      "required": [
        "env-package"
      ]
    },
    {
      "required": [
        "profile"
      ]
    }
  ]
}
```