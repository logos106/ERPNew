unit BusObjTransGroup;

interface

uses BusObjBase, classes, BusObjTrans, BusObjSales, UserLockObj;

type

  TTransBaseGroup = class(TMSBusObj)
  private
  protected
    fTransBase: TTransBase;
    fLoadedGlobalRef: string;
    fLoadedId: integer;
//    procedure SetConnection(const Value: TMyDacDataConnection); override;
    function GetMsUpdateSiteCode: string; override;
    procedure SetMsUpdateSiteCode(const Value: string); override;
    function GetCount: integer; override;
//    function GetUserLock: TUSerLock; override;
    function GetGlobalRef: string; override;
    function GetId: integer; override;
    procedure SetGlobalRef(const Value: string); override;
    function GetMsTimeStamp: TDateTime; override;
    function GetTransBase: TTransBase; virtual;
    property TransBase: TTransBase read GetTransBase;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Cancel; override;
    procedure PostDb; override;
    function Lock: Boolean; override;
    function UnLock: Boolean;
    procedure New; override;
    procedure Edit; override;
    function Delete: boolean; override;
    procedure FlagAsUpdated(aTimeStamp: TDateTime = 0); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure Load(const aId: integer; const fIsReadonly: Boolean = False); overload; override;
    procedure Load(Const aGlobalRef: string; const fIsReadonly: boolean = False); overload; override;
    procedure Load(const fIsReadonly: boolean = False); overload; override;
  end;


  TInvoiceGroup = class(TTransBaseGroup)
  private
    function GetLines: TInvoice;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetBusObjectTablename: string; override;
    class Function GetIDField :String ; override;
    procedure Load(const aId: integer; const fIsReadonly: Boolean = False); overload; override;
    procedure Load(Const aGlobalRef: string; const fIsReadonly: boolean = False); overload; override;
    function GetTransBase: TTransBase; override;
  published
    property Lines: TInvoice read GetLines;
  end;

  TSalesOrderGroup = class(TTransBaseGroup)
  private
    function GetLines: TSalesOrder;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetBusObjectTablename: string; override;
    class Function GetIDField :String ; override;
    procedure Load(const aId: integer; const fIsReadonly: Boolean = False); overload; override;
    procedure Load(Const aGlobalRef: string; const fIsReadonly: boolean = False); overload; override;
//    procedure Load(const fIsReadonly: boolean = False); overload; override;
    function GetTransBase: TTransBase; override;
  published
    property Lines: TSalesOrder read GetLines;
  end;

implementation

uses sysutils, DB;

{ TTransBaseGroup }

procedure TTransBaseGroup.Cancel;
begin

end;

constructor TTransBaseGroup.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'select * from ' + GetBusObjectTablename;
  fLoadedGlobalRef := '';
  fLoadedId := 0;
end;

function TTransBaseGroup.Delete: boolean;
begin
  result:= false;
end;

destructor TTransBaseGroup.Destroy;
begin

  inherited;
end;

procedure TTransBaseGroup.Edit;
begin

end;

procedure TTransBaseGroup.FlagAsUpdated(aTimeStamp: TDateTime);
var
  bm: TBookmark;
begin
  if TransBase.Count > 0 then begin
    bm := TransBase.Dataset.GetBookmark;
    try
      TransBase.Dataset.First;
      while not TransBase.EOF do begin
        TransBase.PostDb;
        TransBase.FlagAsUpdated(aTimeStamp);
        TransBase.Next;
      end;
    finally
      TransBase.Dataset.FreeBookmark(bm);
    end;
  end;
end;

function TTransBaseGroup.GetCount: integer;
begin
  if TransBase.Count > 0 then
    result := 1
  else
    result:= 0;
end;

function TTransBaseGroup.GetGlobalRef: string;
var
  bm: TBookmark;
begin
  result := '';
  if (fLoadedId = 0) and (fLoadedGlobalRef = '') then begin
    result := inherited;
  end
  else if TransBase.Count > 0 then begin
    if TransBase.BOF then result := TransBase.GlobalRef
    else begin
      bm := TransBase.Dataset.GetBookmark;
      try
        TransBase.Dataset.First;
        result := TransBase.GlobalRef;
        TransBase.Dataset.GotoBookmark(bm);
      finally TransBase.Dataset.FreeBookmark(bm);
      end;
    end;
  end;
end;

function TTransBaseGroup.GetId: integer;
var
  bm: TBookmark;
begin
  result := 0;
  if (fLoadedId = 0) and (fLoadedGlobalRef = '') then begin
    result := inherited;
  end
  else if TransBase.Count > 0 then begin
    if TransBase.BOF then result := TransBase.ID
    else begin
      bm := TransBase.Dataset.GetBookmark;
      try
        TransBase.Dataset.First;
        result := TransBase.ID;
        TransBase.Dataset.GotoBookmark(bm);
      finally TransBase.Dataset.FreeBookmark(bm);
      end;
    end;
  end;
end;

function TTransBaseGroup.GetMsTimeStamp: TDateTime;
var
  bm: TBookmark;
begin
  result := 0;
  if (fLoadedId = 0) and (fLoadedGlobalRef = '') then begin
    result := inherited;
  end
  else if TransBase.Count > 0 then begin
    bm := TransBase.Dataset.GetBookmark;
    try
      TransBase.Dataset.First;
      while not TransBase.EOF do begin
        if TransBase.MsTimeStamp > result then
          result := TransBase.MsTimeStamp;
        TransBase.Next;
      end;
      TransBase.Dataset.GotoBookmark(bm);
    finally
      TransBase.Dataset.FreeBookmark(bm);
    end;
  end;
end;

function TTransBaseGroup.GetMsUpdateSiteCode: string;
var
  bm: TBookmark;
  dt: TDateTime;
begin
  result := '';
  dt:= 0;
  if (fLoadedId = 0) and (fLoadedGlobalRef = '') then begin
    result := inherited;
  end
  else if TransBase.Count > 0 then begin
    bm := TransBase.Dataset.GetBookmark;
    try
      TransBase.Dataset.First;
      while not TransBase.EOF do begin
        if TransBase.MsTimeStamp > dt then begin
          dt := TransBase.MsTimeStamp;
          result:= TransBase.MsUpdateSiteCode;
        end;
        TransBase.Next;
      end;
      TransBase.Dataset.GotoBookmark(bm);
    finally
      TransBase.Dataset.FreeBookmark(bm);
    end;
  end;
end;

function TTransBaseGroup.GetTransBase: TTransBase;
begin
  result:= nil;
end;

//function TTransBaseGroup.GetUserLock: TUSerLock;
//begin
//  result:= TransBase.UserLock;
//end;

procedure TTransBaseGroup.Load(const aId: integer; const fIsReadonly: Boolean);
begin
  inherited Load(aId,fIsReadOnly);
  fLoadedGlobalRef := '';
  fLoadedId := aId;
end;

procedure TTransBaseGroup.Load(const aGlobalRef: string;
  const fIsReadonly: boolean);
begin
  inherited Load(aGlobalRef, fIsReadOnly);
  fLoadedGlobalRef := aGlobalRef;
  fLoadedId := 0;
end;

function TTransBaseGroup.Lock: Boolean;
var
  bm: TBookmark;
begin
  result:= false;
  if TransBase.Count > 0 then begin
    if TransBase.BOF then result := TransBase.Lock
    else begin
      bm := TransBase.Dataset.GetBookmark;
      try
        TransBase.Dataset.First;
        result := TransBase.Lock;
        TransBase.Dataset.GotoBookmark(bm);
      finally TransBase.Dataset.FreeBookmark(bm);
      end;
    end;
  end;
end;

procedure TTransBaseGroup.New;
begin

end;

procedure TTransBaseGroup.PostDb;
begin
  TransBase.PostDb;
end;

function TTransBaseGroup.Save: Boolean;
var
  bm: TBookmark;
begin
  result:= true;
  if TransBase.Count > 0 then begin
    TransBase.PostDb;
    bm := TransBase.Dataset.GetBookmark;
    try
      TransBase.Dataset.First;
      while not TransBase.EOF do begin
        result := TransBase.Save;
        if not result  then
          exit;
        TransBase.Next;
      end;
    finally
      TransBase.Dataset.FreeBookmark(bm);
    end;
  end;
end;

//procedure TTransBaseGroup.SetConnection(const Value: TMyDacDataConnection);
//begin
//  inherited;
//  TransBase.Connection := Value;
//end;

procedure TTransBaseGroup.SetGlobalRef(const Value: string);
begin
  { don't set anything }
end;

procedure TTransBaseGroup.SetMsUpdateSiteCode(const Value: string);
begin
  { don't set anything }
end;

function TTransBaseGroup.UnLock: Boolean;
var
  bm: TBookmark;
begin
  result:= false;
  if TransBase.Count > 0 then begin
    if TransBase.BOF then result := TransBase.UnLock
    else begin
      bm := TransBase.Dataset.GetBookmark;
      try
        TransBase.Dataset.First;
        result := TransBase.UnLock;
        TransBase.Dataset.GotoBookmark(bm);
      finally
        TransBase.Dataset.FreeBookmark(bm);
      end;
    end;
  end;
end;

function TTransBaseGroup.ValidateData: Boolean;
var
  bm: TBookmark;
begin
  result:= false;
  if TransBase.Count > 0 then begin
    bm := TransBase.Dataset.GetBookmark;
    try
      TransBase.Dataset.First;
      while not TransBase.EOF do begin
        result := TransBase.ValidateData;
        if not result  then
          exit;
        TransBase.Next;
      end;
    finally
      TransBase.Dataset.FreeBookmark(bm);
    end;
  end;
end;

procedure TTransBaseGroup.Load(const fIsReadonly: boolean);
begin
  inherited;
  fLoadedGlobalRef := '';
  fLoadedId := 0;
end;

{ TInvoiceGroup }

constructor TInvoiceGroup.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TInvoiceGroup.Destroy;
begin

  inherited;
end;

class function TInvoiceGroup.GetBusObjectTablename: string;
begin
  result := 'vInvoiceGroup';
end;

class function TInvoiceGroup.GetIDField: String;
begin
  result:= 'SaleID';
end;

function TInvoiceGroup.GetLines: TInvoice;
begin
  result:= TInvoice(TransBase);
end;

function TInvoiceGroup.GetTransBase: TTransBase;
begin
  if not Assigned(fTransBase) then begin
    fTransBase:= TInvoice.Create(self);
    fTransBase.Connection := self.Connection;
    fTransBase.IsList:= true;
  end;
  result:= fTransBase;
end;

procedure TInvoiceGroup.Load(const aId: integer; const fIsReadonly: Boolean);
begin
  TransBase.LoadSelect('originalno = (select globalref from tblsales where saleid = ' + IntToStr(aID) + ')', fIsReadonly);
  fLoadedGlobalRef := '';
  fLoadedId := aId;
end;

procedure TInvoiceGroup.Load(const aGlobalRef: string;
  const fIsReadonly: boolean);
begin
  TransBase.LoadSelect('originalno = ' + QuotedStr(aGlobalRef), fIsReadonly);
  fLoadedGlobalRef := aGlobalRef;
  fLoadedId := 0;
end;

{ TSalesOrderGroup }

constructor TSalesOrderGroup.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TSalesOrderGroup.Destroy;
begin

  inherited;
end;

class function TSalesOrderGroup.GetBusObjectTablename: string;
begin
  result := 'vSalesOrderGroup';
end;

class function TSalesOrderGroup.GetIDField: String;
begin
  result:= 'SaleID';
end;

function TSalesOrderGroup.GetLines: TSalesOrder;
begin
  result:= TSalesOrder(TransBase);
end;

function TSalesOrderGroup.GetTransBase: TTransBase;
begin
  if not Assigned(fTransBase) then begin
    fTransBase:= TSalesOrder.Create(self);
    fTransBase.Connection := self.Connection;
    fTransBase.IsList:= true;
  end;
  result:= fTransBase;
end;

//procedure TSalesOrderGroup.Load(const fIsReadonly: boolean);
//begin
//  TransBase.Load(fIsReadonly);
//end;

procedure TSalesOrderGroup.Load(const aGlobalRef: string;
  const fIsReadonly: boolean);
begin
  TransBase.LoadSelect('originalno = ' + QuotedStr(aGlobalRef), fIsReadonly);
  fLoadedGlobalRef := aGlobalRef;
  fLoadedId := 0;
end;

procedure TSalesOrderGroup.Load(const aId: integer; const fIsReadonly: Boolean);
begin
  TransBase.LoadSelect('originalno = (select globalref from tblsales where saleid = ' + IntToStr(aID) + ')', fIsReadonly);
  fLoadedGlobalRef := '';
  fLoadedId := aId;
end;

initialization
  RegisterClass(TInvoiceGroup);
  RegisterClass(TSalesOrderGroup);

end.
