unit BusObjFxTrading;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  19/09/13  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TFXTradingLines = class(TMSBusObj)
  private
    function GetFxTradingID         : Integer   ;
    function GetTransDate           : TDateTime ;
    function GetAmount              : Double    ;
    function GetBuyCurrencyID       : Integer   ;
    function GetBuyCurrencyCode     : string    ;
    function GetBuyRate             : Double    ;
    function GetDeleted             : Boolean;
    function GetEmployeeID          : Integer   ;
    function GetEmployeeName        : string    ;
    procedure SetFxTradingID         (const Value: Integer   );
    procedure SetTransdate           (const Value: TDateTime );
    procedure SetAmount              (const Value: Double    );
    procedure SetBuyCurrencyID       (const Value: Integer   );
    procedure SetBuyCurrencyCode     (const Value: string    );
    procedure SetBuyRate             (const Value: Double    );
    Procedure SetDeleted             (const Value: Boolean   );
    procedure SetEmployeeID          (const Value: Integer   );
    procedure SetEmployeeName        (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
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
    property FxTradingID          :Integer     read GetFxTradingID        write SetFxTradingID     ;
    property Transdate            :TDateTime   read GetTransDate          write SetTransdate       ;
    property Amount               :Double      read GetAmount             write SetAmount          ;
    property BuyCurrencyID        :Integer     read GetBuyCurrencyID      write SetBuyCurrencyID   ;
    property BuyCurrencyCode      :string      read GetBuyCurrencyCode    write SetBuyCurrencyCode ;
    property BuyRate              :Double      read GetBuyRate            write SetBuyRate         ;
    Property Deleted              :Boolean     read GetDeleted            Write SetDeleted;
    property EmployeeID           :Integer     read GetEmployeeID         write SetEmployeeID      ;
    property EmployeeName         :string      read GetEmployeeName       write SetEmployeeName    ;
  end;

  TFXTrading = class(TMSBusObj)
  private
    AllRecordsValid:boolean;
    function GetCurrencyID          : Integer   ;
    function GetCurrencyCode        : string    ;
    function GetEmployeeID          : Integer   ;
    function GetEmployeeName        : string    ;
    procedure SetCurrencyID          (const Value: Integer   );
    procedure SetCurrencyCode        (const Value: string    );
    procedure SetEmployeeID          (const Value: Integer   );
    procedure SetEmployeeName        (const Value: string    );
    function getLines: TFXTradingLines;
    procedure LinesValidateDatacallback(const Sender: TBusObj; var Abort: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Procedure DeleteFlaggedLines;
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
    property CurrencyID           :Integer     read GetCurrencyID         write SetCurrencyID      ;
    property CurrencyCode         :string      read GetCurrencyCode       write SetCurrencyCode    ;
    property EmployeeID           :Integer     read GetEmployeeID         write SetEmployeeID      ;
    property EmployeeName         :string      read GetEmployeeName       write SetEmployeeName    ;
    Property Lines :TFXTradingLines read getLines;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils, AppEnvironment, ForeignExchangeObj, frmForeignExchangeRate;



  {TFXTrading}

constructor TFXTrading.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'FXTrading';
  fSQL := 'SELECT * FROM tblfxtrading';
end;


procedure TFXTrading.DeleteFlaggedLines;
var
  IsFiltered: boolean;
  TempAccessLevel: integer;
begin
  Lines.Dataset.DisableControls;
  IsFiltered := Lines.Dataset.Filtered;
  Lines.Dataset.Filtered := false;
  TempAccessLevel:= AccessManager.AccessLevel;
  if self.CleanID < 1 then
    AccessManager.AccessLevel:= 1;
  try
    if Lines.Count > 0 then begin
      Lines.First;
      while not Lines.Dataset.Eof do begin
        if Lines.Deleted then begin
          if not Lines.Delete then begin
            exit;
          end;
        end else begin
          Lines.Next;
        end;
      end;
    end;
  finally
    Lines.Dataset.Filtered := IsFiltered;
    Lines.Dataset.EnableControls;
    if self.CleanID < 1 then
      AccessManager.AccessLevel:= TempAccessLevel;
  end;
end;

destructor TFXTrading.Destroy;
begin
  inherited;
end;


procedure TFXTrading.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'CurrencyID');
  SetPropertyFromNode(node,'CurrencyCode');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'EmployeeName');
end;


procedure TFXTrading.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CurrencyID' ,CurrencyID);
  AddXMLNode(node,'CurrencyCode' ,CurrencyCode);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
end;

procedure TFXTrading.LinesValidateDatacallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if not (sender is TFXTradingLines) then exit;
  if not TFXTradingLines(Sender).ValidateData then begin
    Abort := True;
    AllRecordsValid := False;
  end;
end;
function TFXTrading.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if CurrencyCode ='' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Currency code should not be blank' , true );
    Exit;
  end;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee should not be blank' , true );
    Exit;
  end;

  AllRecordsValid := true;
  Lines.IterateRecords(LinesValidateDatacallback);
  Result := AllRecordsValid;
end;


function TFXTrading.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if result then
    DeleteFlaggedLines;
end;


procedure TFXTrading.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TFXTrading.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sameTExt(Sender.FieldName , 'EmployeeName') then begin
    EmployeeId := tcdatautils.getemployeeID(EmployeeName);
  end else if sameTExt(Sender.FieldName , 'Currencycode') then begin
    currencyId := tcdatautils.getCurrencyID(CurrencyCode);
  end;
end;


function TFXTrading.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TFXTrading.GetIDField: string;
begin
  Result := 'ID'
end;


function TFXTrading.getLines: TFXTradingLines;
begin
  Result := TFXTradingLines(getContainerComponent(TFXTradingLines, 'FxTradingID = '+ IntToStr(Self.Id)));
end;

class function TFXTrading.GetBusObjectTablename: string;
begin
  Result:= 'tblfxtrading';
end;


function TFXTrading.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  EmployeeName := Appenv.Employee.EmployeeName;
  CurrencyCode := appenv.RegionalOptions.ForeignExDefault;
end;

function TFXTrading.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TFXTrading.GetCurrencyID      : Integer   ; begin Result := GetIntegerField('CurrencyID');end;
function  TFXTrading.GetCurrencyCode    : string    ; begin Result := GetStringField('CurrencyCode');end;
function  TFXTrading.GetEmployeeID      : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TFXTrading.GetEmployeeName    : string    ; begin Result := GetStringField('EmployeeName');end;
procedure TFXTrading.SetCurrencyID      (const Value: Integer   ); begin SetIntegerField('CurrencyID'       , Value);end;
procedure TFXTrading.SetCurrencyCode    (const Value: string    ); begin SetStringField('CurrencyCode'     , Value);end;
procedure TFXTrading.SetEmployeeID      (const Value: Integer   ); begin SetIntegerField('EmployeeID'       , Value);end;
procedure TFXTrading.SetEmployeeName    (const Value: string    ); begin SetStringField('EmployeeName'     , Value);end;


  {TFXTradingLines}

constructor TFXTradingLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'FXTradingLines';
  fSQL := 'SELECT * FROM tblfxtradinglines';
end;


destructor TFXTradingLines.Destroy;
begin
  inherited;
end;


procedure TFXTradingLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FxTradingID');
  SetDateTimePropertyFromNode(node,'Transdate');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'BuyCurrencyID');
  SetPropertyFromNode(node,'BuyCurrencyCode');
  SetPropertyFromNode(node,'BuyRate');
  SetPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'EmployeeName');
end;


procedure TFXTradingLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FxTradingID' ,FxTradingID);
  AddXMLNode(node,'Transdate' ,Transdate);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'BuyCurrencyID' ,BuyCurrencyID);
  AddXMLNode(node,'BuyCurrencyCode' ,BuyCurrencyCode);
  AddXMLNode(node,'BuyRate' ,BuyRate);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
end;


function TFXTradingLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if deleted then begin
    result:= True;
    exit;
  end;
  if Transdate = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Transdate should not be blank' , true );
    Exit;
  end;
  if Amount = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Amount should not be 0' , true );
    Exit;
  end;
  Result := True;
end;


function TFXTradingLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TFXTradingLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TFXTradingLines.DoFieldOnChange(Sender: TField);
var
  fdSellRate, fdBuyRate:Double;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sameTExt(Sender.FieldName , 'EmployeeName') then begin
    EmployeeId := tcdatautils.getemployeeID(EmployeeName);
  end else if sameTExt(Sender.FieldName , 'BuyCurrencyCode') then begin
    BuyCurrencyID := tcdatautils.getCurrencyID(BuyCurrencyCode);
        With TForeignExchangeObj.Create do try
            GetForeignExchangeRatesForDate(BuyCurrencyCode, TRansDate , fdBuyRate, fdSellRate);
            BuyRate := fdBuyRate;
        Finally
            Free;
        end;
  end else if sameTExt(Sender.FieldName , 'Amount') then begin
  end else if sameTExt(Sender.FieldName , 'Amount') then begin
  end;
end;


function TFXTradingLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TFXTradingLines.GetIDField: string;
begin
  Result := 'ID'
end;


class function TFXTradingLines.GetBusObjectTablename: string;
begin
  Result:= 'tblfxtradinglines';
end;


function TFXTradingLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  if Assigned(Owner) then
    if owner is TFXTrading then
      FxTradingID := TFXTrading(Owner).ID;
  Transdate := Date;
  EmployeeName := Appenv.Employee.EmployeeName;
end;

function TFXTradingLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
var
  fdBuyRate, fdSellRate:Double;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;

        With TForeignExchangeObj.Create do Try
            GetForeignExchangeRatesForDate(BuyCurrencyCode, transdate, fdBuyRate, fdSellRate);
            if BuyRate <> fdBuyRate then
                    AddForeignExchangeRateHistory(tcdatautils.getCurrencyID(BuyCurrencyCode),BuyRate, fdSellRate, transDate);
        finally
          Free;
        end;
end;


function TFXTradingLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoBeforePost(Sender);
  if not result then exit;
  if (Amount =0) and (BuyCurrencyID=0) and (BuyRate =0) then
    Deleted := True;

end;

{Property Functions}
function  TFXTradingLines.GetFxTradingID     : Integer   ; begin Result := GetIntegerField('FxTradingID');end;
function  TFXTradingLines.GetTransDate       : TDateTime ; begin Result := GetDateTimeField('Transdate');end;
function  TFXTradingLines.GetAmount          : Double    ; begin Result := GetFloatField('Amount');end;
function  TFXTradingLines.GetBuyCurrencyID   : Integer   ; begin Result := GetIntegerField('BuyCurrencyID');end;
function  TFXTradingLines.GetBuyCurrencyCode : string    ; begin Result := GetStringField('BuyCurrencyCode');end;
function  TFXTradingLines.GetBuyRate         : Double    ; begin Result := GetFloatField('BuyRate');end;
function  TFXTradingLines.GetDeleted         : Boolean   ; begin Result := GetBooleanField('deleted');end;

function  TFXTradingLines.GetEmployeeID      : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TFXTradingLines.GetEmployeeName    : string    ; begin Result := GetStringField('EmployeeName');end;
procedure TFXTradingLines.SetFxTradingID     (const Value: Integer   ); begin SetIntegerField('FxTradingID'      , Value);end;
procedure TFXTradingLines.SetTransdate       (const Value: TDateTime ); begin SetDateTimeField('Transdate'        , Value);end;
procedure TFXTradingLines.SetAmount          (const Value: Double    ); begin SetFloatField('Amount'           , Value);end;
procedure TFXTradingLines.SetBuyCurrencyID   (const Value: Integer   ); begin SetIntegerField('BuyCurrencyID'    , Value);end;
procedure TFXTradingLines.SetBuyCurrencyCode (const Value: string    ); begin SetStringField('BuyCurrencyCode' , Value);end;
procedure TFXTradingLines.SetBuyRate         (const Value: Double    ); begin SetFloatField('BuyRate'          , Value);end;
procedure TFXTradingLines.SetDeleted         (Const Value: Boolean   ); begin SetBooleanField('deleted' , Value);end;
procedure TFXTradingLines.SetEmployeeID      (const Value: Integer   ); begin SetIntegerField('EmployeeID'       , Value);end;
procedure TFXTradingLines.SetEmployeeName    (const Value: string    ); begin SetStringField('EmployeeName'     , Value);end;


initialization
  RegisterClass(TFXTradingLines);
  RegisterClass(TFXTrading);


end.
