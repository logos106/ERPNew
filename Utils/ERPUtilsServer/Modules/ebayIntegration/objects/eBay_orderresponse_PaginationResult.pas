unit eBay_orderresponse_PaginationResult;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses eBayBaseObj, DB, Classes, XMLDoc, XMLIntf;


type
  Tebay_orderresponse_paginationresult = class(TeBayObjBase)
  private
    function GetOrderResponse_Id            : Integer   ;
    function GetTotalNumberOfPages          : Integer   ;
    function GetTotalNumberOfEntries        : Integer   ;
    procedure SetOrderResponse_Id            (const Value: Integer   );
    procedure SetTotalNumberOfPages          (const Value: Integer   );
    procedure SetTotalNumberOfEntries        (const Value: Integer   );
  protected
  public
    constructor Create(AOwner: TComponent); overload; override;
  published
    property OrderResponse_Id             :Integer     read GetOrderResponse_Id           write SetOrderResponse_Id        ;
    property TotalNumberOfPages           :Integer     read GetTotalNumberOfPages         write SetTotalNumberOfPages      ;
    property TotalNumberOfEntries         :Integer     read GetTotalNumberOfEntries       write SetTotalNumberOfEntries    ;
  end;


implementation


{Property Functions}
constructor Tebay_orderresponse_paginationresult.Create(AOwner: TComponent);
begin
  inherited;
  Tablename := 'tblebay_orderresponse_paginationresult';
end;

function  Tebay_orderresponse_paginationresult.GetOrderResponse_Id        : Integer   ; begin Result := GetfieldValue('OrderResponse_Id');end;
function  Tebay_orderresponse_paginationresult.GetTotalNumberOfPages      : Integer   ; begin Result := GetfieldValue('TotalNumberOfPages');end;
function  Tebay_orderresponse_paginationresult.GetTotalNumberOfEntries    : Integer   ; begin Result := GetfieldValue('TotalNumberOfEntries');end;
procedure Tebay_orderresponse_paginationresult.SetOrderResponse_Id        (const Value: Integer   ); begin SetfieldValue('OrderResponse_Id'         , Value);end;
procedure Tebay_orderresponse_paginationresult.SetTotalNumberOfPages      (const Value: Integer   ); begin SetfieldValue('TotalNumberOfPages'       , Value);end;
procedure Tebay_orderresponse_paginationresult.SetTotalNumberOfEntries    (const Value: Integer   ); begin SetfieldValue('TotalNumberOfEntries'     , Value);end;

initialization
  RegisterClass(Tebay_orderresponse_paginationresult);


end.
