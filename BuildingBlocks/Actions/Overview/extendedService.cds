using {TravelService.Travel} from '../../../../service/service';
using from '../../../../service/annotations';

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

annotate TravelService.Travel with @UI.LineItem: [
  {Value: TravelID},
  {
    $Type : 'UI.DataFieldForAnnotation',
    Target: '@UI.ConnectedFields#TripDates'
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'Travel.AnnotationAction',
    Label : 'Action'
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'Travel.AnnotationAIAction',
    Label : 'AI Action'
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'Travel.AnnotationActionInline',
    Label : 'Inline Action',
    Inline: true
  },
  {
    $Type : 'UI.DataFieldWithAction',
    Value : TotalPrice,
    Action: 'Travel.AnnotationActionDataField',
    Label : 'Action on Total Price'
  },
  {
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
      }
    ]
  }
];

/*
annotate TravelService.Travel with @(UI: {FieldGroup #TravelData: {Data: [
  {Value: TravelID},
  {Value: to_Agency_AgencyID},
  {Value: BeginDate},
  {Value: EndDate},
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'TravelService.Travel.AnnotationAction',
    Label : 'Action'
  }
]}});
*/
