# Actions

## Introduction

Actions enable users to trigger operations on your data. You can add actions to tables, charts, and other UI elements using annotations or by defining custom actions through extension points.

## Implementation

### Toolbar Actions
You can place actions in table or chart toolbars by adding a UI.DataFieldForAction to UI.LineItem.
```CDS
$Type : 'UI.DataFieldForAction',
Action: 'Travel.AnnotationAction',
Label : 'Action'

### AI Actions
To indicate an AI action with the AI icon on the button, add a @UI.IsAIOperation annotation to your action.
```CDS
@UI.IsAIOperation: true
action AnnotationAIAction();

### Inline Actions For Tables
You can place actions inside table cells by adding an Inline property to UI.DataFieldForAction.
```CDS
Action: 'Travel.AnnotationActionInline',
Label : 'Inline Action',
Inline: true


### Data Fields Triggering Actions
You can define a data field that can trigger an action by using a UI.DataFieldWithAction annotation.
```CDS
$Type : 'UI.DataFieldWithAction',
Value : TotalPrice,
Action: 'Travel.AnnotationActionDataField',
Label : 'Action on Total Price'

### Menu Actions
You can group actions by defining a UI.DataFieldForActionGroup containing UI.DataFieldForAction definitions.
```CDS
$Type  : 'UI.DataFieldForActionGroup',
Label  : 'Menu Action',
Actions: [
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'Travel.AnnotationMenuAction1',
    Label : 'Menu Action 1'
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'Travel.AnnotationMenuAction2',
    Label : 'Menu Action 2'

### Extension Actions
You can define extension actions that invoke OData actions in your controller extension. If the action has parameters, a dialog is displayed to the user to enter the parameters. You can also pass the parameters and skip the dialog by using the skipParameterDialog property.

```JavaScript
this.editFlow
	.invokeAction("TravelService.Travel.AnnotationActionWithParameters", {
		contexts: selectedContexts.length > 0 ? selectedContexts : undefined,
		parameterValues: [{ name: "TotalPrice", value: context.getObject("TotalPrice") }],
		// Show the dialog in edit mode only
		skipParameterDialog: !extensionAPI.getModel("ui")?.getProperty("/isEditable")
	})
	.then(() => {
		MessageToast.show("Extension action successfully called.");
	});