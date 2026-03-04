# SAP CAP + FE Action Patterns (Reference)

This reference distills the patterns implemented in `Overview/extendedService.cds` and `Overview/Actions.controller.js`.

## 1) Declare actions on an entity

```cds
extend TravelService.Travel with actions {
  action AnnotationAction();
  action AnnotationActionInline();
  action AnnotationActionDataField();
  @UI.IsAIOperation: true
  action AnnotationAIAction();
  action AnnotationMenuAction1();
  action AnnotationMenuAction2();
  action AnnotationActionWithParameters(TotalPrice : Decimal(10, 2));
};
```

## 2) Expose actions in line items

### Toolbar button

```cds
{
  $Type : 'UI.DataFieldForAction',
  Action: 'Travel.AnnotationAction',
  Label : 'Action'
}
```

### AI toolbar button

```cds
{
  $Type : 'UI.DataFieldForAction',
  Action: 'Travel.AnnotationAIAction',
  Label : 'AI Action'
}
```

### Inline table-row action

```cds
{
  $Type : 'UI.DataFieldForAction',
  Action: 'Travel.AnnotationActionInline',
  Label : 'Inline Action',
  Inline: true
}
```

### Action bound to a value field

```cds
{
  $Type : 'UI.DataFieldWithAction',
  Value : TotalPrice,
  Action: 'Travel.AnnotationActionDataField',
  Label : 'Action on Total Price'
}
```

### Action menu group

```cds
{
  $Type  : 'UI.DataFieldForActionGroup',
  Label  : 'Menu Action',
  Actions: [
    { $Type: 'UI.DataFieldForAction', Action: 'Travel.AnnotationMenuAction1', Label: 'Menu Action 1' },
    { $Type: 'UI.DataFieldForAction', Action: 'Travel.AnnotationMenuAction2', Label: 'Menu Action 2' }
  ]
}
```

## 3) Invoke a parameterized action from extension controller

```js
this.editFlow
  .invokeAction("TravelService.Travel.AnnotationActionWithParameters", {
    contexts: selectedContexts.length > 0 ? selectedContexts : undefined,
    parameterValues: [{ name: "TotalPrice", value: context.getObject("TotalPrice") }],
    skipParameterDialog: !extensionAPI.getModel("ui")?.getProperty("/isEditable")
  })
  .then(() => MessageToast.show("Extension action successfully called."));
```

## 4) Common pitfalls

- Namespace mismatches between CDS declaration and `Action` annotation path.
- Missing action parameter names/types alignment with `parameterValues`.
- Not handling empty row selection before reading context values.
- Forgetting to bind the app route/view/context path to the same entity set.
