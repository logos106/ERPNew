unit ebay_orderresponse_ordererrors;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj;


type
  Tebay_orderresponse_ordererrors = class(TeBayObjBase)
  private
    function GetOrderResponse_Id            : Integer   ;
    function GetShortMessage                : string    ;
    function GetLongMessage                 : string    ;
    function GetErrorCode                   : string    ;
    function GetUserDisplayHint             : string    ;
    function GetSeverityCode                : string    ;
    function GetErrorClassification         : string    ;
    procedure SetOrderResponse_Id            (const Value: Integer   );
    procedure SetShortMessage                (const Value: string    );
    procedure SetLongMessage                 (const Value: string    );
    procedure SetErrorCode                   (const Value: string    );
    procedure SetUserDisplayHint             (const Value: string    );
    procedure SetSeverityCode                (const Value: string    );
    procedure SetErrorClassification         (const Value: string    );
  Protected
  public
    constructor Create(AOwner: TComponent); overload; override;
  published
    property OrderResponse_Id             :Integer     read GetOrderResponse_Id           write SetOrderResponse_Id        ;
    property ShortMessage                 :string      read GetShortMessage               write SetShortMessage            ;
    property LongMessage                  :string      read GetLongMessage                write SetLongMessage             ;
    property ErrorCode                    :string      read GetErrorCode                  write SetErrorCode               ;
    property UserDisplayHint              :string      read GetUserDisplayHint            write SetUserDisplayHint         ;
    property SeverityCode                 :string      read GetSeverityCode               write SetSeverityCode            ;
    property ErrorClassification          :string      read GetErrorClassification        write SetErrorClassification     ;
  end;


implementation

uses eBay_orderresponse;







{Property Functions}
function  Tebay_orderresponse_ordererrors.GetOrderResponse_Id        : Integer   ; begin Result := GetfieldValue('OrderResponse_Id');end;
function  Tebay_orderresponse_ordererrors.GetShortMessage            : string    ; begin Result := GetfieldValue('ShortMessage');end;
function  Tebay_orderresponse_ordererrors.GetLongMessage             : string    ; begin Result := GetfieldValue('LongMessage');end;
function  Tebay_orderresponse_ordererrors.GetErrorCode               : string    ; begin Result := GetfieldValue('ErrorCode');end;
function  Tebay_orderresponse_ordererrors.GetUserDisplayHint         : string    ; begin Result := GetfieldValue('UserDisplayHint');end;

function  Tebay_orderresponse_ordererrors.GetSeverityCode            : string    ; begin Result := GetfieldValue('SeverityCode');end;
constructor Tebay_orderresponse_ordererrors.Create(AOwner: TComponent);
begin
  inherited;
  Tablename := 'tbleBay_OrderResponse_OrderErrors';
end;

function  Tebay_orderresponse_ordererrors.GetErrorClassification     : string    ; begin Result := GetfieldValue('ErrorClassification');end;
procedure Tebay_orderresponse_ordererrors.SetOrderResponse_Id        (const Value: Integer   ); begin SetfieldValue('OrderResponse_Id'         , Value);end;
procedure Tebay_orderresponse_ordererrors.SetShortMessage            (const Value: string    ); begin SetfieldValue('ShortMessage'             , Value);end;
procedure Tebay_orderresponse_ordererrors.SetLongMessage             (const Value: string    ); begin SetfieldValue('LongMessage'              , Value);end;
procedure Tebay_orderresponse_ordererrors.SetErrorCode               (const Value: string    ); begin SetfieldValue('ErrorCode'                , Value);end;
procedure Tebay_orderresponse_ordererrors.SetUserDisplayHint         (const Value: string    ); begin SetfieldValue('UserDisplayHint'          , Value);end;
procedure Tebay_orderresponse_ordererrors.SetSeverityCode            (const Value: string    ); begin SetfieldValue('SeverityCode'             , Value);end;
procedure Tebay_orderresponse_ordererrors.SetErrorClassification     (const Value: string    ); begin SetfieldValue('ErrorClassification'      , Value);end;



end.
