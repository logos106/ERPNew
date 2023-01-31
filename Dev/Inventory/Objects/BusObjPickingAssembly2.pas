unit BusObjPickingAssembly2;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  15/05/08  1.00.00  A  Initial Version.
  }


interface


uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjPickingAssemblyLine,
  BusObjEmployeeDetails, BusObjSales;


type

  TPickingEmployee2 = class(TEmployeeDetails)
  end;

  TPackingEmployee2 = class(TEmployeeDetails)
  end;

  TPickingAssembly2 = class(TMSBusObj)
  private
    function GetSaleID                 : Integer   ;
    function GetBarcode                : string    ;
    function GetPickingEmployeeID      : Integer   ;
    function GetStartPicking           : Boolean   ;
    function GetStartPickingTime       : TDateTime ;
    function GetFinishedPicking        : Boolean   ;
    function GetFinishedPickingTime    : TDateTime ;
    function GetPackingEmployeeID      : Integer   ;
    function GetStartPacking           : Boolean   ;
    function GetStartPackingTime       : TDateTime ;
    function GetFinishedPacking        : Boolean   ;
    function GetFinishedPackingTime    : TDateTime ;
    procedure SetSaleID                 (const Value: Integer   );
    procedure SetBarcode                (const Value: string    );
    procedure SetPickingEmployeeID      (const Value: Integer   );
    procedure SetStartPicking           (const Value: Boolean   );
    procedure SetStartPickingTime       (const Value: TDateTime );
    procedure SetFinishedPicking        (const Value: Boolean   );
    procedure SetFinishedPickingTime    (const Value: TDateTime );
    procedure SetPackingEmployeeID      (const Value: Integer   );
    procedure SetStartPacking           (const Value: Boolean   );
    procedure SetStartPackingTime       (const Value: TDateTime );
    procedure SetFinishedPacking        (const Value: Boolean   );
    procedure SetFinishedPackingTime    (const Value: TDateTime );
    function GetLines: TPickingAssemblyLine2;
    function GetStatusText: string;
    function GetPackingEmployee: TPackingEmployee2;
    function GetPickingEmployee: TPickingEmployee2;
    function GetSale: TSales;
    function ValidateLines: boolean;
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
    property Lines: TPickingAssemblyLine2 read GetLines;
    property Sale: TSales read GetSale;
    property PickingEmployee: TPickingEmployee2 read GetPickingEmployee;
    property PackinggEmployee: TPackingEmployee2 read GetPackingEmployee;
    class function IsComplete(const aSaleId: integer): boolean;
    function MaxLinePackNumber: integer;
    procedure Load(const fIsReadonly:boolean =False); override;
    function QtyPackedForProduct(const aProductId: integer): double;
    procedure Closedb; override;
  published
    property SaleID                  :Integer     read GetSaleID                write SetSaleID             ;
    property Barcode                 :string      read GetBarcode               write SetBarcode            ;
    property PickingEmployeeID       :Integer     read GetPickingEmployeeID     write SetPickingEmployeeID  ;
    property StartPicking            :Boolean     read GetStartPicking          write SetStartPicking       ;
    property StartPickingTime        :TDateTime   read GetStartPickingTime      write SetStartPickingTime   ;
    property FinishedPicking         :Boolean     read GetFinishedPicking       write SetFinishedPicking    ;
    property FinishedPickingTime     :TDateTime   read GetFinishedPickingTime   write SetFinishedPickingTime;
    property PackingEmployeeID       :Integer     read GetPackingEmployeeID     write SetPackingEmployeeID  ;
    property StartPacking            :Boolean     read GetStartPacking          write SetStartPacking       ;
    property StartPackingTime        :TDateTime   read GetStartPackingTime      write SetStartPackingTime   ;
    property FinishedPacking         :Boolean     read GetFinishedPacking       write SetFinishedPacking    ;
    property FinishedPackingTime     :TDateTime   read GetFinishedPackingTime   write SetFinishedPackingTime;
    property StatusText: string read GetStatusText;
  end;


implementation


uses
  CommonLib, FastFuncs, SalesConst, BusobjSaleBase, CommonDbLib,
  MyAccess,ERPdbComponents;

  {TPickingAssembly2}

constructor TPickingAssembly2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PickingAssembly';
  fSQL := 'SELECT * FROM tblpickingassembly';
end;


destructor TPickingAssembly2.Destroy;
begin
  inherited;
end;


procedure TPickingAssembly2.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SaleID');
  SetPropertyFromNode(node,'Barcode');
  SetPropertyFromNode(node,'PickingEmployeeID');
  SetBooleanPropertyFromNode(node,'StartPicking');
  SetDateTimePropertyFromNode(node,'StartPickingTime');
  SetBooleanPropertyFromNode(node,'FinishedPicking');
  SetDateTimePropertyFromNode(node,'FinishedPickingTime');
  SetPropertyFromNode(node,'PackingEmployeeID');
  SetBooleanPropertyFromNode(node,'StartPacking');
  SetDateTimePropertyFromNode(node,'StartPackingTime');
  SetBooleanPropertyFromNode(node,'FinishedPacking');
  SetDateTimePropertyFromNode(node,'FinishedPackingTime');
end;


procedure TPickingAssembly2.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'Barcode' ,Barcode);
  AddXMLNode(node,'PickingEmployeeID' ,PickingEmployeeID);
  AddXMLNode(node,'StartPicking' ,StartPicking);
  AddXMLNode(node,'StartPickingTime' ,StartPickingTime);
  AddXMLNode(node,'FinishedPicking' ,FinishedPicking);
  AddXMLNode(node,'FinishedPickingTime' ,FinishedPickingTime);
  AddXMLNode(node,'PackingEmployeeID' ,PackingEmployeeID);
  AddXMLNode(node,'StartPacking' ,StartPacking);
  AddXMLNode(node,'StartPackingTime' ,StartPackingTime);
  AddXMLNode(node,'FinishedPacking' ,FinishedPacking);
  AddXMLNode(node,'FinishedPackingTime' ,FinishedPackingTime);
end;


function TPickingAssembly2.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SaleID should not be 0' , False );
    Exit;
  end;
  if not ValidateLines then
    exit;
  Result := True;
end;


function TPickingAssembly2.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPickingAssembly2.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPickingAssembly2.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPickingAssembly2.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPickingAssembly2.GetIDField: string;
begin
  Result := 'PickingAssemblyID'
end;


class function TPickingAssembly2.GetBusObjectTablename: string;
begin
  Result:= 'tblpickingassembly';
end;


function TPickingAssembly2.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TPickingAssembly2.GetSaleID             : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  TPickingAssembly2.GetBarcode            : string    ; begin Result := GetStringField('Barcode');end;
function  TPickingAssembly2.GetPickingEmployeeID  : Integer   ; begin Result := GetIntegerField('PickingEmployeeID');end;
function  TPickingAssembly2.GetStartPicking       : Boolean   ; begin Result := GetBooleanField('StartPicking');end;
function  TPickingAssembly2.GetStartPickingTime   : TDateTime ; begin Result := GetDateTimeField('StartPickingTime');end;
function  TPickingAssembly2.GetFinishedPicking    : Boolean   ; begin Result := GetBooleanField('FinishedPicking');end;
function  TPickingAssembly2.GetFinishedPickingTime: TDateTime ; begin Result := GetDateTimeField('FinishedPickingTime');end;
function  TPickingAssembly2.GetPackingEmployeeID  : Integer   ; begin Result := GetIntegerField('PackingEmployeeID');end;
function  TPickingAssembly2.GetStartPacking       : Boolean   ; begin Result := GetBooleanField('StartPacking');end;
function  TPickingAssembly2.GetStartPackingTime   : TDateTime ; begin Result := GetDateTimeField('StartPackingTime');end;
function  TPickingAssembly2.GetFinishedPacking    : Boolean   ; begin Result := GetBooleanField('FinishedPacking');end;
function  TPickingAssembly2.GetFinishedPackingTime: TDateTime ; begin Result := GetDateTimeField('FinishedPackingTime');end;
procedure TPickingAssembly2.SetSaleID             (const Value: Integer   ); begin SetIntegerField('SaleID'              , Value);end;
procedure TPickingAssembly2.SetBarcode            (const Value: string    ); begin SetStringField('Barcode'             , Value);end;
procedure TPickingAssembly2.SetPickingEmployeeID  (const Value: Integer   ); begin SetIntegerField('PickingEmployeeID'   , Value);end;
procedure TPickingAssembly2.SetStartPicking       (const Value: Boolean   ); begin SetBooleanField('StartPicking'        , Value);end;
procedure TPickingAssembly2.SetStartPickingTime   (const Value: TDateTime ); begin SetDateTimeField('StartPickingTime'    , Value);end;
procedure TPickingAssembly2.SetFinishedPicking    (const Value: Boolean   ); begin SetBooleanField('FinishedPicking'     , Value);end;
procedure TPickingAssembly2.SetFinishedPickingTime(const Value: TDateTime ); begin SetDateTimeField('FinishedPickingTime' , Value);end;
procedure TPickingAssembly2.SetPackingEmployeeID  (const Value: Integer   ); begin SetIntegerField('PackingEmployeeID'   , Value);end;
procedure TPickingAssembly2.SetStartPacking       (const Value: Boolean   ); begin SetBooleanField('StartPacking'        , Value);end;
procedure TPickingAssembly2.SetStartPackingTime   (const Value: TDateTime ); begin SetDateTimeField('StartPackingTime'    , Value);end;
procedure TPickingAssembly2.SetFinishedPacking    (const Value: Boolean   ); begin SetBooleanField('FinishedPacking'     , Value);end;
procedure TPickingAssembly2.SetFinishedPackingTime(const Value: TDateTime ); begin SetDateTimeField('FinishedPackingTime', Value);end;


function TPickingAssembly2.GetLines: TPickingAssemblyLine2;
begin
  Result:= TPickingAssemblyLine2(getContainerComponent(TPickingAssemblyLine2, 'PickingAssemblyID = '+ IntToStr(Self.Id)));
end;

function TPickingAssembly2.GetStatusText: string;
begin
  if self.FinishedPacking then
    result:= 'Packing Finished'
  else if self.StartPacking then
    result:= 'Packing Started'
  else if self.FinishedPicking then
    result:= 'Picking Finished'
  else if self.StartPicking then
    result:= 'Picking Started'
  else
    result:= 'Not Started';
end;

function TPickingAssembly2.GetPackingEmployee: TPackingEmployee2;
begin
  if self.PackingEmployeeID > 0 then begin
    Result:= TPackingEmployee2(getContainerComponent(TPackingEmployee2, 'EmployeeID = 0'));
    if result.Id <> self.PackingEmployeeID then
      result.Load(PackingEmployeeID);
  end
  else begin
    result:= nil;
  end;
end;

function TPickingAssembly2.GetPickingEmployee: TPickingEmployee2;
begin
  if self.PickingEmployeeID > 0 then begin
    Result:= TPickingEmployee2(getContainerComponent(TPickingEmployee2, 'EmployeeID = 0'));
    if result.Id <> self.PickingEmployeeID then
      result.Load(PickingEmployeeID);
  end
  else begin
    result:= nil;
  end;
end;

function TPickingAssembly2.GetSale: TSales;
var
  SaleType: TSaleType;
begin
  result:= nil;
  if self.SaleID < 1 then exit;

  SaleType:= TSales.GetSaleType(SaleId);
  result:= TSales(container.ItemByClass(TSales,false));
  if Assigned(result) then begin
    if ((SaleType = stSalesOrder) and (not result.IsSalesOrder)) or
       ((SaleType = stInvoice) and (not result.IsInvoice)) then begin
      container.Clear(TSales);
      result:= nil;
    end;
  end;


  if not Assigned(result) then begin
    if SaleType = stInvoice then begin
      result:= TInvoice.Create(nil);
      Container.Add(result);
    end
    else if SaleType = stSalesOrder then begin
      result:= TSalesOrder.Create(nil);
      Container.Add(result);
    end;
    if Assigned(result) then begin
      result.LockGroupName:= self.LockGroupName;
//      if Self.ConnectionAssigned then
//        result.Connection := Self.Connection;
      result.Connection := TMyDacDataConnection.Create(result);
      result.Connection.Connection:= self.Dataset.Connection;
      if Self.SilentMode then
        result.SilentMode := True;
    end;
  end;

  if Assigned(result) and (result.Id <> SaleId) then begin
    result.Load(SaleId);
    //if Result is TSales then TSales(Result).InstantiateAllTrees; // load the trees to copy
  end;
end;

class function TPickingAssembly2.IsComplete(const aSaleId: integer): boolean;
var
  qry: TERPQuery;
begin
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('select FinishedPicking, FinishedPacking from tblPickingAssembly');
    qry.SQL.Add('where SaleId = ' + IntToStr(aSaleId));
    qry.Open;
    result:= qry.FieldByName('FinishedPicking').AsBoolean and
             qry.FieldByName('FinishedPacking').AsBoolean;
  finally
    qry.Free;
  end;
end;

function TPickingAssembly2.ValidateLines: boolean;
var
  bm: TBookMark;
begin
  result:= true;
  if Lines.Count > 0 then begin
    Lines.Dataset.DisableControls;
    bm:= Lines.Dataset.GetBookmark;
    try
      Lines.Dataset.First;
      while not Lines.Dataset.Eof do begin
        if not Lines.ValidateData then begin
          result:= false;
          break;
        end;
        Lines.Dataset.Next;
      end;
    finally
      Lines.Dataset.GotoBookmark(bm);
      Lines.Dataset.FreeBookmark(bm);
      Lines.Dataset.EnableControls;
    end;
  end;
end;

function TPickingAssembly2.MaxLinePackNumber: integer;
var
  bm: TBookMark;
begin
  result:= 0;
  if Lines.Count > 0 then begin
    Lines.Dataset.DisableControls;
    bm:= Lines.Dataset.GetBookmark;
    try
      Lines.Dataset.First;
      while not Lines.Dataset.Eof do begin
        if Lines.PackNumber > result then
          result:= Lines.PackNumber;
        Lines.Dataset.Next;
      end;
    finally
      Lines.Dataset.GotoBookmark(bm);
      Lines.Dataset.FreeBookmark(bm);
      Lines.Dataset.EnableControls;
    end;
  end;
end;

procedure TPickingAssembly2.Load(const fIsReadonly:boolean =False);
begin
  inherited;
  Lines.LoadSelect('PickingAssemblyID = ' + IntToStr(ID));
end;

function TPickingAssembly2.QtyPackedForProduct(const aProductId: integer): double;
var
  bm: TbookMark;
begin
  Result := 0;
  if self.Lines.Count > 0 then begin
    self.Lines.DataSet.DisableControls;
    try
      bm:= self.Lines.DataSet.getBookMark;
      try
        Lines.First;
        while not Lines.Eof do begin
          if Lines.ProductID = aProductId then
            result:= result + (Lines.Qty * Lines.QtyMultiplier);
          Lines.Next;
        end;
        Lines.Dataset.gotoBookMark(bm);
      finally
        Lines.Dataset.FreeBookmark(bm);
      end;
    finally
      Lines.DataSet.enableControls;
    end;
  end;
end;

procedure TPickingAssembly2.Closedb;
begin
//  Lines.Closedb;
  Container.Clear;
  inherited;
end;

initialization
  RegisterClassOnce(TPickingAssembly2);
  RegisterClassOnce(TPickingEmployee2);
  RegisterClassOnce(TPackingEmployee2);


end.

