using TravelService as service from '../service/service';

annotate service.Travel {
  TravelStatus @Common.ValueListWithFixedValues;
  CurrencyCode @Common.ValueList: {
    CollectionPath: 'Currencies',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: CurrencyCode_code,
        ValueListProperty: 'code'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'descr'
      }
    ]
  };
}

annotate service.Travel with @UI.LineItem: [
  {Value: TravelID},
  {
    $Type : 'UI.DataFieldForAnnotation',
    Target: '@UI.ConnectedFields#TripDates'
  },
  {Value: to_Agency_AgencyID},
  {
    Value             : TravelStatus_code,
    Criticality       : TravelStatus.criticality,
    @UI.Importance    : #High,
    @HTML5.CssDefaults: {width: '10em'}
  },
  {Value: BookingFee},
  {Value: TotalPrice}
];

annotate service.Travel with @(UI: {SelectionFields: [
  TravelID,
  to_Agency_AgencyID,
  TravelStatus_code,
  BeginDate,
  EndDate
]});

annotate service.Travel with @Capabilities.FilterRestrictions.FilterExpressionRestrictions: [
  {
    Property          : 'BeginDate',
    AllowedExpressions: 'SingleRange'
  },
  {
    Property          : 'EndDate',
    AllowedExpressions: 'SingleRange'
  }
];

annotate service.Travel with @(UI: {
  FieldGroup #TravelData    : {Data: [
    {Value: TravelID},
    {Value: to_Agency_AgencyID},
    {Value: BeginDate},
    {Value: EndDate}
  ]},
  FieldGroup #ApprovalData  : {Data: [
    {
      $Type      : 'UI.DataField',
      Value      : TravelStatus_code,
      Criticality: TravelStatus.criticality,
      Label      : 'Status'
    },
    {Value: BookingFee},
    {Value: TotalPrice}
  ]},
  FieldGroup #HeaderMain    : {Data: [
    {Value: BeginDate},
    {Value: EndDate},
    {Value: TotalPrice}
  ]},
  ConnectedFields #TripDates: {
    Label   : 'Business Trip Dates',
    Template: '{BeginDate} / {EndDate}',
    Data    : {
      BeginDate: {
        $Type: 'UI.DataField',
        Value: BeginDate
      },
      EndDate  : {
        $Type: 'UI.DataField',
        Value: EndDate
      }
    }
  },
  Facets                    : [
    {
      $Type : 'UI.ReferenceFacet',
      ID    : 'TravelData',
      Label : 'Travel Information',
      Target: '@UI.FieldGroup#TravelData',
    },
    {
      $Type : 'UI.ReferenceFacet',
      ID    : 'ApprovalData',
      Label : 'Approval Data',
      Target: '@UI.FieldGroup#ApprovalData'
    },
    {
      $Type : 'UI.ReferenceFacet',
      ID    : 'BookingList',
      Label : 'Bookings',
      Target: 'to_Booking/@UI.LineItem'
    }
  ],
  HeaderFacets              : [{
    $Type : 'UI.ReferenceFacet',
    Target: '@UI.FieldGroup#HeaderMain'
  }],
  HeaderInfo                : {
    TypeName      : 'Travel',
    TypeNamePlural: 'Travels',
    Title         : {
      $Type: 'UI.DataField',
      Value: Description
    },
    Description   : {
      $Type: 'UI.DataField',
      Value: TravelID
    },
    TypeImageUrl  : 'sap-icon://header',
  }
});

annotate service.Travel {
  to_Agency @Common.ValueList: {
    CollectionPath: 'TravelAgency',
    Label         : '',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: to_Agency_AgencyID,
        ValueListProperty: 'AgencyID'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'Name'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'Street'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'PostalCode'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'City'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'CountryCode_code'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'PhoneNumber'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'EMailAddress'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'WebAddress'
      }
    ]
  };
}

annotate service.TravelAgency with @(UI: {
  DataPoint #Recommendation: {
    Value        : Recommendation,
    TargetValue  : 100.0,
    Title        : 'Recommendation',
    Visualization: #Progress
  },
  DataPoint #Rating        : {
    Value        : Rating,
    TargetValue  : 5.0,
    Title        : 'Rating',
    Visualization: #Rating
  },
  FieldGroup #Contact      : {Data: [{
    $Type : 'UI.DataFieldForAnnotation',
    Target: '@Communication.Contact',
    Label : 'Travel Agency'
  }]}
});

annotate service.TravelAgency with @(
  Communication.Contact : {
    email: [{
      type   : #work,
      address: EMailAddress
    }],
    fn   : Name,
    adr  : [{
      type    : #work,
      code    : PostalCode,
      country : CountryCode_code,
      locality: City
    }]
  },
  Common.IsNaturalPerson: false
);

annotate service.Booking {
  CurrencyCode @Common.ValueList: {
    CollectionPath: 'Currencies',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: CurrencyCode_code,
        ValueListProperty: 'code'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'descr'
      }
    ]
  };
}

annotate service.Booking with @(UI: {
  HeaderInfo: {
    TypeName      : 'Booking',
    TypeNamePlural: 'Bookings',
    TypeImageUrl  : 'sap-icon://alert',
    Title         : {
      $Type: 'UI.DataField',
      Value: BookingID
    }
  },
  Facets    : [{
    $Type : 'UI.ReferenceFacet',
    ID    : 'FacetIdentifier1',
    Target: '@UI.FieldGroup'
  }],
  LineItem  : [
    {Value: BookingID},
    {Value: BookingDate},
    {Value: ConnectionID},
    {Value: FlightDate},
    {Value: FlightPrice}
  ],
  FieldGroup: {Data: [
    {
      $Type: 'UI.DataField',
      Value: BookingID
    },
    {
      $Type: 'UI.DataField',
      Value: BookingDate
    },
    {
      $Type: 'UI.DataField',
      Value: FlightDate
    },
    {
      $Type: 'UI.DataField',
      Value: FlightPrice
    }
  ]}
});

annotate service.TravelAgency with @(UI: {FieldGroup #Link: {Data: [{
  $Type: 'UI.DataFieldWithUrl',
  Value: Name,
  Url  : WebAddress
}]}});
