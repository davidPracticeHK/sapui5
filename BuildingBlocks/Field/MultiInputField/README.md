# Multi-Input Field

## Introduction

The Field building block enables you to render multi-input fields, which allow users to input more than one value per field. A multi-input field visualizes 1:n relations by turning each related record into a token. It requires a ValueList annotation on the target property to resolve IDs into user-friendly texts and to open a selection dialog.

## Samples

### Multi-Input Field as Input Field

The property "Name" of the Booking entity is used as multi-input field to show multiple agencies per travel. The property has a ValueList annotation to provide value help and to resolve the agency IDs into user-friendly names.     Selecting agencies from the value help adds tokens referencing the selected agency IDs. The metaPath points to the navigation property to_Booking and the property "Name" within the target entity.

```CDS
Name @(Common: {
  Label    : 'Agencies',
  ValueList: {
    Label         : 'Travel Agency',
    CollectionPath: 'AgencyName',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'AgencyID'
      },
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: Name,
        ValueListProperty: 'Name'
      }
    ]
  }
});
```

### Multi-Input Field as ReadOnly Field
The multi-input field can be used with or without editing and the corresponding ValueHelp, depending on the attribute 'readOnly'.


### Multi-Input Field Target via Annotation
The MetaPath of the multi-input field points to a DataField within a FieldGroup annotation to demonstrate the reuse of annotation-defined DataField instead of direct property path.


### Multi-Input Field filled by JSON Model
Demonstrates filling the multi-input field with data from a JSON Model. The JSON Model is created and set to the view in the controller onInit method.


### Multi-Input Field in a Table 
The multi-input field used within a table column to show multiple agencies per travel in a tabular way. Due to performance reasons we strongly recommend adding the multi-input field as an annotation, instead of as a custom column. Adding a building block field or multi-input field to the table as a custom column will generate a ValueHelp for each row. This is only allowed for use cases with a defined and limited number of rows.
