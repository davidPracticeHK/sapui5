# Value Help Patterns for SAP CAP Fields

Reference distilled from `InputWithValueHelp/inputValueHelp.cds`.

## 1) Basic Value Help

Use `Common.ValueList` with `InOut` + `DisplayOnly` parameters.

```cds
@(Common: {ValueList: {
  CollectionPath: 'BusinessPartnerAddress',
  Parameters    : [
    { $Type: 'Common.ValueListParameterInOut', LocalDataProperty: valueHelpField2_1, ValueListProperty: 'BusinessPartner' },
    { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'FullName' }
  ]
}})
valueHelpField2_1;
```

## 2) Fixed Values (Dropdown Style)

Use `Common.ValueListWithFixedValues: true`.

```cds
@(Common: {
  ValueListWithFixedValues: true,
  ValueList: {
    CollectionPath: 'BusinessPartnerAddress2',
    Parameters: [{
      $Type: 'Common.ValueListParameterInOut',
      LocalDataProperty: valueHelpField1_2,
      ValueListProperty: 'BusinessPartner'
    }]
  }
})
valueHelpField1_2;
```

## 3) Input Validation with Value Help

Use `Common.ValueListForValidation` to validate typed values.

```cds
@(Common: {
  ValueListForValidation: '',
  ValueList: {
    CollectionPath: 'BusinessPartnerAddress2',
    Parameters: [{
      $Type: 'Common.ValueListParameterInOut',
      LocalDataProperty: valueHelpField3_1,
      ValueListProperty: 'BusinessPartner'
    }]
  }
})
valueHelpField3_1;
```

## 4) Context-Dependent Value Help via Qualifiers

Use `ValueListRelevantQualifiers` to switch the active qualified value list by field context.

```cds
@(Common: {
  ValueListRelevantQualifiers: [ ... edmJson conditions ... ],
  ValueList: { ...default... },
  ValueList #qualifier2: { ...alternate source/columns... }
})
valueHelpField4_2;
```

## 5) In/Out/Display-Only Mapping

Use parameter types to copy values between source field and dialog columns.

- `InOut`: two-way key mapping.
- `In`: filter the value-help source by another local field.
- `Out`: write back additional fields.
- `DisplayOnly`: show column only.

## 6) Typeahead Toggle

Disable search/typeahead for a value-list entity via:

```cds
annotate BusinessPartnerAddress3 with @(Capabilities.SearchRestrictions.Searchable: false);
```

## 7) Hierarchical Value Help

For tree-style value help, combine hierarchy annotations and `PresentationVariantQualifier`.
