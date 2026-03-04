# Multi-Input Field (MultiValueField) Patterns

Reference distilled from `MultiInputField/*` files.

## 1) Service-side setup for token text resolution

Define a field on the child entity and annotate it with `Common.ValueList`.

```cds
extend entity TravelService.Booking with {
  Name : String;
};

annotate TravelService.Booking with {
  Name @(Common: {
    Label    : 'Agencies',
    ValueList: {
      CollectionPath: 'AgencyName',
      Parameters    : [
        { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'AgencyID' },
        { $Type: 'Common.ValueListParameterInOut', LocalDataProperty: Name, ValueListProperty: 'Name' }
      ]
    }
  });
};
```

## 2) Basic MultiValueField

```xml
<macros:MultiValueField metaPath="to_Booking/Name" readOnly="{= !${ui>/isEditable} }" />
```

## 3) Read-only mode

```xml
<macros:MultiValueField metaPath="to_Booking/Name" readOnly="true" />
```

## 4) MetaPath to annotation DataField

```xml
<macros:MultiValueField
  metaPath="to_Booking/@com.sap.vocabularies.UI.v1.FieldGroup#Default/Data/0"
  readOnly="{= !${ui>/isEditable} }"
/>
```

## 5) Fill from JSON model (demo/testing)

```xml
<macros:MultiValueField
  metaPath="to_Booking/Name"
  items="{jsonModel>/Agencies}"
  readOnly="{= !${ui>/isEditable} }"
/>
```

Controller demo pattern initializes JSON model and toggles edit mode.

## 6) Table usage caution

Embedding `MultiValueField` as a custom table column can create per-row value helps. Prefer annotation-driven table rendering for performance unless row counts are limited.
