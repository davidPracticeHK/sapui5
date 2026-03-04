using {
  sap,
  managed,
  Currency,
  Country
} from '@sap/cds/common';

using from '../service/annotations';

@cds.autoexpose  @readonly
aspect MasterData {}

service TravelService {
  @odata.draft.enabled
  @Common.SemanticKey: [TravelID]

  entity Travel : managed {
    key TravelUUID    : UUID;

        @Common.Label          : 'ID'
        @Common.Text           : Description
        TravelID      : Integer default 0                         @readonly;

        @Common.Label          : 'Begin Date'
        BeginDate     : Date;

        @Common.Label          : 'End Date'
        EndDate       : Date;

        @Common.Label          : 'Booking Fee'
        BookingFee    : Decimal(10, 2) default 0                  @Measures.ISOCurrency: CurrencyCode_code;

        @Common.Label          : 'Total Price'
        TotalPrice    : Decimal(10, 2)                            @readonly  @Measures.ISOCurrency: CurrencyCode_code;

        @Common.Label          : 'Currency'
        CurrencyCode  : Association to CurrencyCode default 'EUR' @mandatory;

        @Common.Label          : 'Description'
        Description   : String(1024);

        @Common.Label          : 'Travel Details'
        @UI.MultiLineText
        TravelDetails : String(1024);

        @title                 : 'Status'
        @Common.Text           : TravelStatus.name
        @Common.TextArrangement: #TextOnly
        TravelStatus  : Association to TravelStatus default 'O'   @readonly;

        @title                 : 'Agency'
        @Common.Text           : to_Agency.Name
        @Common.TextArrangement: #TextFirst
        to_Agency     : Association to TravelAgency               @mandatory;

        to_Booking    : Composition of many Booking
                          on to_Booking.to_Travel = $self;
  };

  entity Booking : managed {
    key BookingUUID   : UUID;

        @Common.Label: 'Booking ID'
        BookingID     : Integer                                  @Core.Computed;

        @Common.Label: 'Booking Date'
        BookingDate   : Date;

        @Common.Label: 'Connection'
        ConnectionID  : String(4)                                @mandatory;

        @Common.Label: 'Flight Date'
        FlightDate    : Date                                     @mandatory;

        @Common.Label: 'Flight Price'
        FlightPrice   : Decimal(10, 2)                           @Measures.ISOCurrency: CurrencyCode_code;

        @Common.Label: 'Currency'
        CurrencyCode  : Currency default 'EUR'                   @mandatory;

        @Common.Label: 'Status'
        BookingStatus : Association to BookingStatus default 'N' @mandatory;
        to_Travel     : Association to Travel                    @mandatory;

        PaymentMethod : String(1) default 'B'                    @Common              : {
          Label                   : 'Payment Method',
          Text                    : _Payment.Method,
          TextArrangement         : #TextOnly,
          ValueListWithFixedValues: true,
          ValueList               : {
            Label         : 'Payment Method',
            CollectionPath: 'Payment',
            Parameters    : [{
              $Type            : 'Common.ValueListParameterInOut',
              LocalDataProperty: PaymentMethod,
              ValueListProperty: 'code'
            }]
          }
        };
        _Payment      : Association to one Payment
                          on _Payment.code = PaymentMethod;
  };

  entity Payment {
    key code   : String(1) @(Common: {
          Label          : 'Payment Code',
          Text           : Method,
          TextArrangement: #TextFirst
        });
        Method : String    @(
          Core.Immutable: true,
          Common.Label  : 'Payment Method'
        );
  }

  entity TravelStatus : sap.common.CodeList {
    key code        : String(1) @Common.Text: descr;
        name        : String(255);
        descr       : String(1000);
        criticality : Int16     @odata.Type : 'Edm.Byte' enum {
          Neutral  = 0;
          Negative = 1;
          Critical = 2;
          Positive = 3;
          NewItem  = 5
        };
  };

  entity CurrencyCode : sap.common.CodeList {
        @Common.Label: 'Currency Code'
    key code  : String(3);

        @Common.Label: 'Currency Description'
        descr : String(255);
  };

  entity BookingStatus : sap.common.CodeList {
    key code : BookingStatusCode
  };

  entity TravelAgency : MasterData {
        @Common.Label: 'Agency ID'
        @Common.Text : Name
    key AgencyID       : String(6);

        @Common.Label: 'Agency Name'
        Name           : String(80);
        Street         : String(60);

        @Common.Label: 'Postal Code'
        PostalCode     : String(10);

        @Common.Label: 'City'
        City           : String(40);

        @Common.Label: 'Country Code'
        CountryCode    : Country;

        @Common.Label: 'Phone Number'
        PhoneNumber    : String(30);

        @Common.Label: 'Email Address'
        EMailAddress   : String(256);

        @Common.Label: 'Web Address'
        WebAddress     : String(256);
        Rating         : Integer;
        Recommendation : Integer;
  };

  type TravelStatusCode  : String(1) enum {
    Open     = 'O';
    Accepted = 'A';
    Canceled = 'X';
  };

  type BookingStatusCode : String(1) enum {
    New      = 'N';
    Booked   = 'B';
    Canceled = 'X';
  };
}
