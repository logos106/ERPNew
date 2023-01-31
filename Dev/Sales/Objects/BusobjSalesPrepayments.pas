unit BusobjSalesPrepayments;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/07/11  1.00.00  bs  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLIntf;


type
  TSalesPrepayments = class(TMSBusObj)
  private
    function GetSalesRef        : string    ;
    function GetSalesOriginalRef: string    ;
    function GetPrepayRef       : string    ;
    function GetIsQuote         : Boolean   ;
    function GetIsSalesOrder    : Boolean   ;
    function GetIsInvoice       : Boolean   ;
    procedure SetSalesRef        (const Value: string    );
    procedure SetSalesOriginalRef(const Value: string    );
    procedure SetPrepayRef       (const Value: string    );
    procedure SetIsQuote         (const Value: Boolean   );
    procedure SetIsSalesOrder    (const Value: Boolean   );
    procedure SetIsInvoice       (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property SalesRef         :string      read GetSalesRef       write SetSalesRef    ;
    property SalesOriginalRef :string      read GetSalesOriginalRef write SetSalesOriginalRef ;
    property PrepayRef        :string      read GetPrepayRef      write SetPrepayRef   ;
    property IsQuote          :Boolean     read GetIsQuote        write SetIsQuote     ;
    property IsSalesOrder     :Boolean     read GetIsSalesOrder   write SetIsSalesOrder;
    property IsInvoice        :Boolean     read GetIsInvoice      write SetIsInvoice   ;
  end;

  TQuotePrepayment = class(TSalesPrepayments)
  public
    constructor Create(AOwner: TComponent); override;
    function Save: Boolean; override;
  end;

  TSalesOrderPrepayment = class(TSalesPrepayments)
  public
    constructor Create(AOwner: TComponent); override;
    function Save: Boolean; override;
  end;

  TInvoicePrepayment = class(TSalesPrepayments)
  public
    constructor Create(AOwner: TComponent); override;
    function Save: Boolean; override;
  end;

implementation


uses
  tcDataUtils, CommonLib, ERPDbComponents, SysUtils;


  {TSalesPrepayments}

constructor TSalesPrepayments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesPrepayments';
  fSQL := 'SELECT * FROM tblsalesprepayments';
end;


destructor TSalesPrepayments.Destroy;
begin
  inherited;
end;


procedure TSalesPrepayments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SalesRef');
  SetPropertyFromNode(node,'SalesOriginalRef');
  SetPropertyFromNode(node,'PrepayRef');
  SetBooleanPropertyFromNode(node,'IsQuote');
  SetBooleanPropertyFromNode(node,'IsSalesOrder');
  SetBooleanPropertyFromNode(node,'IsInvoice');
end;


procedure TSalesPrepayments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SalesRef' ,SalesRef);
  AddXMLNode(node,'SalesOriginalRef' ,SalesOriginalRef);
  AddXMLNode(node,'PrepayRef' ,PrepayRef);
  AddXMLNode(node,'IsQuote' ,IsQuote);
  AddXMLNode(node,'IsSalesOrder' ,IsSalesOrder);
  AddXMLNode(node,'IsInvoice' ,IsInvoice);
end;


function TSalesPrepayments.ValidateData: Boolean ;
var
  qry: TERPQuery;
begin
  Resultstatus.Clear;
  Result := false;
  if SalesRef = '' then begin
    AddResult(false,rssWarning,0,'SalesRef is blank');
    exit;
  end;
  if PrepayRef = '' then begin
    AddResult(false,rssWarning,0,'PrepayRef is blank');
    exit;
  end;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Self.Connection.Connection;
    qry.SQL.Text := 'select * from tblsales where GlobalRef = ' + QuotedStr(SalesRef);
    qry.Open;
    if qry.IsEmpty then begin
      AddResult(false,rssWarning,0,'Sale not found for SalesRef');
      exit;
    end;
    if IsQuote and (not qry.FieldByName('IsQuote').AsBoolean) then begin
      AddResult(false,rssWarning,0,'IsQuote is set but Sale for SalesRef is not a Quote');
      exit;
    end;
    if IsSalesOrder and (not qry.FieldByName('IsSalesOrder').AsBoolean) then begin
      AddResult(false,rssWarning,0,'IsSalesOrder is set but Sale for SalesRef is not a Sales Order');
      exit;
    end;
    if IsInvoice and (not qry.FieldByName('IsInvoice').AsBoolean) then begin
      AddResult(false,rssWarning,0,'IsInvoice is set but Sale for SalesRef is not an Invoice');
      exit;
    end;
    if SalesOriginalRef = '' then
      SalesOriginalRef := qry.FieldByName('OriginalNo').AsString;

    qry.Close;
    qry.SQL.Text := 'select * from tblPrePayments where GlobalRef = ' + QuotedStr(PrepayRef);
    qry.Open;
    if qry.IsEmpty then begin
      AddResult(false,rssWarning,0,'Prepayment not found for PrepayRef');
      exit;
    end;
    qry.Close;
    qry.SQL.Text :=
      'select * from tblsalesprepayments where PrepayRef = ' + QuotedStr(PrepayRef) +
      ' and ID <> '+ IntToStr(ID);
    qry.Open;
    if not qry.IsEmpty then begin
      AddResult(false,rssWarning,0,'This PrepayRef is already linked to a different Sale');
      exit;
    end;
    qry.SQL.Text :=
      'select * from tblsalesprepayments where SalesRef = ' + QuotedStr(SalesRef) +
      ' and ID <> '+ IntToStr(ID);
    qry.Open;
    if not qry.IsEmpty then begin
      AddResult(false,rssWarning,0,'This SalesRef is already linked to a different Prepayment');
      exit;
    end;

  finally
    qry.Free;
  end;
  if SalesOriginalRef = '' then begin
    AddResult(false,rssWarning,0,'SalesOriginalRef is blank');
    exit;
  end;
  if (not IsQuote) and (not IsSalesOrder) and (not IsInvoice) then begin
    AddResult(false,rssWarning,0,'One of IsQuote, IsSalesOrder or IsInvoice must be set, none are currently set');
    exit;
  end;
  Result := true;
end;


function TSalesPrepayments.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesPrepayments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesPrepayments.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSalesPrepayments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesPrepayments.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSalesPrepayments.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesprepayments';
end;


function TSalesPrepayments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSalesPrepayments.GetSalesRef    : string    ; begin Result := GetStringField('SalesRef');end;
function  TSalesPrepayments.GetSalesOriginalRef : string    ; begin Result := GetStringField('SalesOriginalRef');end;
function  TSalesPrepayments.GetPrepayRef   : string    ; begin Result := GetStringField('PrepayRef');end;
function  TSalesPrepayments.GetIsQuote     : Boolean   ; begin Result := GetBooleanField('IsQuote');end;
function  TSalesPrepayments.GetIsSalesOrder: Boolean   ; begin Result := GetBooleanField('IsSalesOrder');end;
function  TSalesPrepayments.GetIsInvoice   : Boolean   ; begin Result := GetBooleanField('IsInvoice');end;
procedure TSalesPrepayments.SetSalesRef    (const Value: string    ); begin SetStringField('SalesRef'     , Value);end;
procedure TSalesPrepayments.SetSalesOriginalRef (const Value: string    ); begin SetStringField('SalesOriginalRef'     , Value);end;
procedure TSalesPrepayments.SetPrepayRef   (const Value: string    ); begin SetStringField('PrepayRef'    , Value);end;

procedure TSalesPrepayments.SetIsQuote     (const Value: Boolean   );
begin
  SetBooleanField('IsQuote'      , Value);
end;

procedure TSalesPrepayments.SetIsSalesOrder(const Value: Boolean   );
begin
  SetBooleanField('IsSalesOrder' , Value);
end;

procedure TSalesPrepayments.SetIsInvoice   (const Value: Boolean   );
begin
  SetBooleanField('IsInvoice'    , Value);
end;


{ TQuotePrepayment }

constructor TQuotePrepayment.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := fSQL + ' where IsQuote = "T"';
end;

function TQuotePrepayment.Save: Boolean;
begin
  IsQuote := true;
  IsSalesOrder := false;
  IsInvoice := false;

  result := inherited;
end;

{ TSalesOrderPrepayment }

constructor TSalesOrderPrepayment.Create(AOwner: TComponent);
begin
  inherited;
  IsSalesOrder := true;
  fSQL := fSQL + ' where IsSalesOrder = "T"';
end;

function TSalesOrderPrepayment.Save: Boolean;
begin
  IsQuote := false;
  IsSalesOrder := true;
  IsInvoice := false;

  result := inherited;
end;

{ TInvoicePrepayment }

constructor TInvoicePrepayment.Create(AOwner: TComponent);
begin
  inherited;
  IsInvoice := true;
  fSQL := fSQL + ' where IsInvoice = "T"';
end;

function TInvoicePrepayment.Save: Boolean;
begin
  IsQuote := false;
  IsSalesOrder := false;
  IsInvoice := true;

  result := inherited;
end;

initialization
  RegisterClass(TSalesPrepayments);
  RegisterClass(TQuotePrepayment);
  RegisterClass(TSalesOrderPrepayment);
  RegisterClass(TInvoicePrepayment);

end.
