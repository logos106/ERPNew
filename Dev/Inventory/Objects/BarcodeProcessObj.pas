unit BarcodeProcessObj;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 31/10/06  1.00.01 DSP  First version.

}

interface

uses
  Dialogs, Windows, Classes, Graphics, SysUtils, MyAccess,ERPdbComponents, StrUtils, Forms,
  QueryLoadObj, BaseBarcodeObj, MessageInterface;

type
  TPrefixType = (ptNone, ptEmployee, ptStart, ptStop, ptFinish, ptComplete, ptStep, ptPacking);
  TPrefixTypeSet = set of TPrefixType;


{$M+}
  TBarcodeProcessQueries = class(TObject)
  private
    FQuery: TERPQuery;
    FQueryLoad: TQueryLoad;
    FMsgHandler: TMsgHandler;
  public
    constructor Create;
    destructor Destroy; override;
    function GetProcessStepName(const ProcessStepID: Integer): string;
    function CheckEmployeeAndStep(const EmployeeID, ProcessStepID: Integer): Boolean;
    function GetProductName(const SaleLineID: Integer): string;
    function GetProcessID(const SaleLineID: Integer): Integer;
    function GetProcessLinesID(const ProcessID, ProcessStepID: Integer): Integer;
    function GetSaleID(const SaleLineID: Integer): Integer;
    function ExistingProcessRecord(const SaleLineID: Integer): Boolean;
    function ExistingProcessLinesRecord(const ProcessStepID, SaleLineID: Integer): Boolean;
    procedure InsertProcessRecord(const SaleLineID: Integer);
    procedure InsertProcessLinesRecord(const ProcessStepID, SaleLineID: Integer);
    procedure InsertProcessProgressRecord(const EmployeeID, ProcessStepID, SaleLineID: Integer);
    function IsEmployeeStarted(const EmployeeID, ProcessStepID, SaleLineID: Integer): Boolean;
    function IsProcessStepStarted(const ProcessStepID, SaleLineID: Integer): Boolean;
    procedure SetEmployeeState(const EmployeeID, ProcessStepID, SaleLineID: Integer; const State: TPrefixType);
    procedure SetCompletedIfRequired(const ProcessID, SaleLineID: Integer);
    procedure SetProcessCompleted(const ProcessID, SaleLineID: Integer);
    procedure SetAllEmployeesFinished(const EmployeeID, SaleLineID: Integer);
  published
    procedure SaveNewInvoiceID(MsgObj: TMsgObj);
  end;
{$M-}

  TBarcodeProcess = class(TBaseBarcode)
  private
    FExpectedPrefixTypes: TPrefixTypeSet;
    FCurrentEmployeeID: Integer;
    FCurrentSaleLineID: Integer;
    FEmployeeAction: TPrefixType;
    FBarcodeQueries: TBarcodeProcessQueries;
    FStatusForm: TForm;
  protected
    procedure HandleBarcodeEntry(const BarcodeText: string); override;
    function GetPrefixType(const Prefix: string): TPrefixType; 
    procedure DisplayScanMessage; 
    procedure RefreshStatus; 
    procedure PassBarcodeToAction(const BarcodeText: string);
    property CurrentEmployeeID: Integer read FCurrentEmployeeID write FCurrentEmployeeID;
    property CurrentSaleLineID: Integer read FCurrentSaleLineID write FCurrentSaleLineID;
    property EmployeeAction: TPrefixType read FEmployeeAction write FEmployeeAction;
    property BarcodeQueries: TBarcodeProcessQueries read FBarcodeQueries write FBarcodeQueries;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetupDisplay; override;
    property ExpectedPrefixTypes: TPrefixTypeSet read FExpectedPrefixTypes write FExpectedPrefixTypes;
  end;

implementation

uses
  DNMLib, CommonLib, CommonDbLib, MessageConst, FastFuncs;

const
  cAction = 'Action';
  cEmployee = 'Employee';
  cCompleteScanned = 'Complete Scanned';
  cEmployeeScanned = 'Employee Scanned';
  cFinishScanned = 'Finish Scanned';
  cPackingScanned = 'Packing Scanned';
  cProcess = 'Process';
  cResource = 'Resource';
  cScanEmployeeOrResource = 'Scan Employee, Resource or Packing';
  cScanStep = 'Scan Step';
  cScanStartStopFinish = 'Scan Start, Stop, Finish or Complete';
  cStartScanned = 'Start Scanned';
  cStatus = 'Status';
  cStopScanned = 'Stop Scanned';

{ TBarcodeProcessQueries }

constructor TBarcodeProcessQueries.Create;
begin
  inherited;
  FQuery := TERPQuery.Create(nil);
  FQuery.Connection := GetSharedMyDacConnection;
  FQueryLoad := TQueryLoad.Create;
  FQueryLoad.QueryGroup := 'BarcodeProcess';
  FMsgHandler := TMsgHandler.Create(Self);
end;

destructor TBarcodeProcessQueries.Destroy;
begin
  FreeandNil(FQuery);
  FreeandNil(FQueryLoad);
  FreeandNil(FMsgHandler);
  inherited;
end;

function TBarcodeProcessQueries.GetProcessStepName(const ProcessStepID: Integer): string;
begin
  FQuery.SQL.Text := AnsiReplaceText(FQueryLoad.GetQuery('GetProcessStepName'), ':ProcessStepID', IntToStr(ProcessStepID));
  FQuery.Open;

  if not FQuery.IsEmpty then
    Result := FQuery.FieldByName('Description').AsString
  else
    Result := '';

  FQuery.Close;
end;

function TBarcodeProcessQueries.CheckEmployeeAndStep(const EmployeeID, ProcessStepID: Integer): Boolean;
var
  QueryText: string;
begin
  QueryText := AnsiReplaceText(FQueryLoad.GetQuery('CheckEmployeeAndStep'), ':EmployeeID', IntToStr(EmployeeID));
  FQuery.SQL.Text := AnsiReplaceText(QueryText, ':ProcessStepID', IntToStr(ProcessStepID));
  FQuery.Open;

  if FQuery.IsEmpty then begin
    CommonLib.MessageDlgXP_Vista('This employee cannot perform the selected step. ' + #13#10 +
               'Please select another employee.', mtInformation, [mbOK], 0);
  end;

  Result := not FQuery.IsEmpty;
  FQuery.Close;
end;

function TBarcodeProcessQueries.GetProductName(const SaleLineID: Integer): string;
begin
  FQuery.SQL.Text := AnsiReplaceText(FQueryLoad.GetQuery('GetProductName'), ':SaleLineID', IntToStr(SaleLineID));
  FQuery.Open;

  if not FQuery.IsEmpty then
    Result := FQuery.FieldByName('ProductName').AsString
  else
    Result := '';

  FQuery.Close;
end;

function TBarcodeProcessQueries.GetProcessID(const SaleLineID: Integer): Integer;
begin
  FQuery.SQL.Text := AnsiReplaceText(FQueryLoad.GetQuery('GetProcessID'), ':SaleLineID', IntToStr(SaleLineID));
  FQuery.Open;

  if not FQuery.IsEmpty then
    Result := FQuery.FieldByName('ProcessID').AsInteger
  else
    Result := 0;

  FQuery.Close;
end;

function TBarcodeProcessQueries.GetProcessLinesID(const ProcessID, ProcessStepID: Integer): Integer;
var
  QueryText: string;
begin
  QueryText := AnsiReplaceText(FQueryLoad.GetQuery('GetProcessLinesID'), ':ProcessID', IntToStr(ProcessID));
  FQuery.SQL.Text := AnsiReplaceText(QueryText, ':ProcessStepID', IntToStr(ProcessStepID));
  FQuery.Open;

  if not FQuery.IsEmpty then
    Result := FQuery.FieldByName('ProcessLinesID').AsInteger
  else
    Result := 0;

  FQuery.Close;
end;

function TBarcodeProcessQueries.GetSaleID(const SaleLineID: Integer): Integer;
begin
  FQuery.SQL.Text := AnsiReplaceText(FQueryLoad.GetQuery('GetSaleID'), ':SaleLineID', IntToStr(SaleLineID));
  FQuery.Open;

  if not FQuery.IsEmpty then
    Result := FQuery.FieldByName('SaleID').AsInteger
  else
    Result := 0;

  FQuery.Close;
end;

function TBarcodeProcessQueries.ExistingProcessRecord(const SaleLineID: Integer): Boolean;
begin
  FQuery.SQL.Text := AnsiReplaceText(FQueryLoad.GetQuery('ExistingProcessRecord'), ':SaleLineID', IntToStr(SaleLineID));
  FQuery.Open;
  Result := not FQuery.IsEmpty;
  FQuery.Close;
end;

function TBarcodeProcessQueries.ExistingProcessLinesRecord(const ProcessStepID, SaleLineID: Integer): Boolean;
var
  QueryText: string;
  ProcessID: Integer;
begin
  ProcessID := GetProcessID(SaleLineID);
  QueryText := AnsiReplaceText(FQueryLoad.GetQuery('ExistingProcessLinesRecord'), ':ProcessStepID', IntToStr(ProcessStepID));
  FQuery.SQL.Text := AnsiReplaceText(QueryText, ':ProcessID', IntToStr(ProcessID));
  FQuery.Open;
  Result := not FQuery.IsEmpty;
  FQuery.Close;
end;

procedure TBarcodeProcessQueries.InsertProcessRecord(const SaleLineID: Integer);
var
  SaleID: Integer;
  ProductID: Integer;
  Params: TStringList;
begin
  FQuery.SQL.Text := AnsiReplaceText(FQueryLoad.GetQuery('GetSaleIDAndPartID'), ':SaleLineID', IntToStr(SaleLineID));
  FQuery.Open;

  if not FQuery.IsEmpty then begin
    SaleID := FQuery.FieldByName('SaleID').AsInteger;
    ProductID := FQuery.FieldByName('ProductID').AsInteger;
    Params := TStringList.Create;

    try
      Params.Add('SaleID=' + IntToStr(SaleID));
      Params.Add('SaleLineID=' + IntToStr(SaleLineID));
      Params.Add('ProductID=' + IntToStr(ProductID));
      FQueryLoad.Execute('InsertProcessRecord', Params);
    finally
      FreeandNil(Params);
    end;
  end;

  FQuery.Close;
end;

procedure TBarcodeProcessQueries.InsertProcessLinesRecord(const ProcessStepID, SaleLineID: Integer);
var
  ProcessID: Integer;
  Params: TStringList;
begin
  ProcessID := GetProcessID(SaleLineID);

  if ProcessID > 0 then begin
    Params := TStringList.Create;

    try
      Params.Add('ProcessID=' + IntToStr(ProcessID));
      Params.Add('ProcessStepID=' + IntToStr(ProcessStepID));
      Params.Add('ProcessBegin=' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Now));
      FQueryLoad.Execute('InsertProcessLinesRecord', Params);
    finally
      FreeandNil(Params);
    end;
  end;
end;

procedure TBarcodeProcessQueries.InsertProcessProgressRecord(const EmployeeID, ProcessStepID, SaleLineID: Integer);
var
  ProcessID: Integer;
  ProcessLinesID: Integer;
  Params: TStringList;
begin
  ProcessID := GetProcessID(SaleLineID);

  if ProcessID > 0 then begin
    ProcessLinesID := GetProcessLinesID(ProcessID, ProcessStepID);

    if ProcessLinesID > 0 then begin
      Params := TStringList.Create;

      try
        Params.Add('ProcessLinesID=' + IntToStr(ProcessLinesID));
        Params.Add('EmployeeID=' + IntToStr(EmployeeID));
        Params.Add('EmployeeStart=' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Now));
        FQueryLoad.Execute('InsertProcessProgressRecord', Params);
      finally
        FreeandNil(Params);
      end;
    end;
  end;
end;

function TBarcodeProcessQueries.IsEmployeeStarted(const EmployeeID, ProcessStepID, SaleLineID: Integer): Boolean;
var
  QueryText: string;
begin
  Result := False;
  QueryText := AnsiReplaceText(FQueryLoad.GetQuery('CheckEmployeeState'), ':EmployeeID', IntToStr(EmployeeID));
  QueryText := AnsiReplaceText(QueryText, ':ProcessStepID', IntToStr(ProcessStepID));
  FQuery.SQL.Text := AnsiReplaceText(QueryText, ':SaleLineID', IntToStr(SaleLineID));
  FQuery.Open;

  if not FQuery.IsEmpty then begin
    Result := (FQuery.FieldByName('EmployeeStart').AsDateTime > 0);
  end;

  FQuery.Close;
end;

procedure TBarcodeProcessQueries.SetEmployeeState(const EmployeeID, ProcessStepID, SaleLineID: Integer; const State: TPrefixType);
var
  ProcessID: Integer;
  ProcessLinesID: Integer;
  Params: TStringList;
begin
  ProcessID := GetProcessID(SaleLineID);

  if ProcessID > 0 then begin
    ProcessLinesID := GetProcessLinesID(ProcessID, ProcessStepID);

    if ProcessLinesID > 0 then begin
      Params := TStringList.Create;

      try
        Params.Add('ProcessLinesID=' + IntToStr(ProcessLinesID));
        Params.Add('EmployeeID=' + IntToStr(EmployeeID));
        Params.Add('EmployeeStop=' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Now));

        if State = ptFinish then
          Params.Add('EmployeeFinish=' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Now))
        else
          Params.Add('EmployeeFinish=NULL');

        if (State = ptStart) and (not IsEmployeeStarted(EmployeeID, ProcessStepID, SaleLineID)) then
          InsertProcessProgressRecord(EmployeeID, ProcessStepID, SaleLineID);

        FQueryLoad.Execute('SetEmployeeState', Params);

        if State = ptFinish then begin
          Params.Add('ProcessLinesID=' + IntToStr(ProcessLinesID));
          Params.Add('EmployeeStop=' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Now));
          FQueryLoad.Execute('SetAllEmployeesStop', Params);

          Params.Add('ProcessLinesID=' + IntToStr(ProcessLinesID));
          Params.Add('ProcessEnd=' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Now));
          FQueryLoad.Execute('SetProcessEnd', Params);

          SetCompletedIfRequired(ProcessID, SaleLineID);
        end;
      finally
        FreeandNil(Params);
      end;
    end;
  end;
end;

procedure TBarcodeProcessQueries.SetCompletedIfRequired(const ProcessID, SaleLineID: Integer);
var
  ProcessStepCount: Integer;
begin
  FQuery.SQL.Text := AnsiReplaceText(FQueryLoad.GetQuery('GetAllProcessSteps'), ':ProcessID', IntToStr(ProcessID));
  FQuery.Open;

  if not FQuery.IsEmpty then begin
    ProcessStepCount := FQuery.RecordCount;
    FQuery.Close;
    FQuery.SQL.Text := AnsiReplaceText(FQueryLoad.GetQuery('GetProcessLinesEnded'), ':ProcessID', IntToStr(ProcessID));
    FQuery.Open;

    if FQuery.RecordCount = ProcessStepCount then
      SetProcessCompleted(ProcessID, SaleLineID);
  end;

  FQuery.Close;
end;

procedure TBarcodeProcessQueries.SetProcessCompleted(const ProcessID, SaleLineID: Integer);
var
  SaleID: Integer;
  Params: TStringList;
  MsgObj: TMsgObj;
  Form: TForm;
begin
  Params := TStringList.Create;

  try
    Params.Add('ProcessID=' + IntToStr(ProcessID));
    FQueryLoad.Execute('SetProcessCompleted', Params);
    SaleID := GetSaleID(SaleLineID);
    Form := TForm(GetComponentByClassName('TSalesOrderGUI'));

    if Assigned(Form) then begin
      MsgObj := TMsgObj.Create;
      MsgObj.ClassStr := 'TSalesOrderGUI';
      MsgObj.MethodStr := 'PerformInvoiceConversion';
      MsgObj.IntValue := SaleID;
      FMsgHandler.Send(MsgObj);

      while FormStillOpen('TSalesOrderGUI') or FormStillOpen('TInvoiceGUI') do begin
         Application.ProcessMessages;
         Sleep(100);
      end;
    end;
  finally
    FreeandNil(Params);
  end;
end;

procedure TBarcodeProcessQueries.SetAllEmployeesFinished(const EmployeeID, SaleLineID: Integer);
var
  TmpEmployeeID: Integer;
  ProcessID: Integer;
  ProcessStepID: Integer;
  Query: TERPQuery;
begin
  ProcessID := GetProcessID(SaleLineID);;
  Query := TERPQuery.Create(nil);

  try
    Query.Connection := GetSharedMyDacConnection;
    Query.SQL.Text := AnsiReplaceText(FQueryLoad.GetQuery('GetAllProcessSteps'), ':ProcessID', IntToStr(ProcessID));
    Query.Open;
    Query.First;

    while not Query.Eof do begin
      ProcessStepID := Query.FieldByName('ProcessStepID').AsInteger;

      if not IsProcessStepStarted(ProcessStepID, SaleLineID) then
        InsertProcessProgressRecord(EmployeeID, ProcessStepID, SaleLineID);

      Query.Next;  
    end;

    Query.Close;
    Query.SQL.Text := AnsiReplaceText(FQueryLoad.GetQuery('GetAllEmployeesNotFinished'), ':SaleLineID', IntToStr(SaleLineID));
    Query.Open;
    Query.First;

    if not Query.IsEmpty then begin
      while not Query.Eof do begin
        TmpEmployeeID := Query.FieldByName('EmployeeID').AsInteger;
        ProcessStepID := Query.FieldByName('ProcessStepID').AsInteger;
        SetEmployeeState(TmpEmployeeID, ProcessStepID, SaleLineID, ptFinish);
        Query.Next;
      end;

      Query.Close;
    end;
  finally
    FreeandNil(Query);
  end;
end;

function TBarcodeProcessQueries.IsProcessStepStarted(const ProcessStepID, SaleLineID: Integer): Boolean;
var
  QueryText: string;
begin
  Result := False;
  QueryText := AnsiReplaceText(FQueryLoad.GetQuery('IsProcessStepStarted'), ':ProcessStepID', IntToStr(ProcessStepID));
  FQuery.SQL.Text := AnsiReplaceText(QueryText, ':SaleLineID', IntToStr(SaleLineID));
  FQuery.Open;

  if not FQuery.IsEmpty then begin
    Result := (FQuery.FieldByName('EmployeeStart').AsDateTime > 0);
  end;

  FQuery.Close;
end;

procedure TBarcodeProcessQueries.SaveNewInvoiceID(MsgObj: TMsgObj);
var
  Params: TStringList;
begin
  Params := TStringList.Create;

  try
    Params.Add('SaleID=' + MsgObj.StrValue);
    Params.Add('InvoiceID=' + IntToStr(MsgObj.IntValue));
    FQueryLoad.Execute('SetInvoiceID', Params);
  finally
    FreeandNil(Params);
    FreeAndNil(MsgObj);
  end;
end;

{ TBarcodeProcess }

constructor TBarcodeProcess.Create(AOwner: TComponent);
begin
  inherited;
  FExpectedPrefixTypes := [ptNone];
  FCurrentEmployeeID := 0;
  FCurrentSaleLineID := 0;
  FEmployeeAction := ptNone;
  FBarcodeQueries := TBarcodeProcessQueries.Create;
  FStatusForm := TForm(FindExistingComponent('TWorkOrderStatusListGUI'));
end;

destructor TBarcodeProcess.Destroy;
begin
  FreeandNil(FBarcodeQueries);
  inherited;
end;

procedure TBarcodeProcess.HandleBarcodeEntry(const BarcodeText: string);
var
  Prefix: string;
  PrefixType: TPrefixType;
  BarcodeValue: string;
  ProcessStepID: Integer;
begin
  inherited;
  ExtractPrefixAndValue(BarcodeText, Prefix, BarcodeValue);
  PrefixType := GetPrefixType(Prefix);

  if PrefixType in ExpectedPrefixTypes then begin
    case PrefixType of
      ptEmployee:
      begin
        EmployeeAction := ptEmployee;
        CurrentEmployeeID := StrToIntDef(BarcodeValue, 0);
        AssignValue(cEmployee, GetEmployeeName(CurrentEmployeeID));
        AssignValue(cProcess, '');
        AssignValue(cStatus, cEmployeeScanned);
        AssignValue(cAction, cScanStartStopFinish);
        ExpectedPrefixTypes := [ptStart, ptStop, ptFinish, ptComplete];
      end;

      ptStart:
      begin
        EmployeeAction := ptStart;
        CurrentSaleLineID := StrToIntDef(BarcodeValue, 0);
        AssignValue(cProcess, BarcodeQueries.GetProductName(CurrentSaleLineID));
        AssignValue(cStatus, cStartScanned);
        AssignValue(cAction, cScanStep);
        ExpectedPrefixTypes := [ptStep];
      end;

      ptStop:
      begin
        EmployeeAction := ptStop;
        CurrentSaleLineID := StrToIntDef(BarcodeValue, 0);
        AssignValue(cProcess, BarcodeQueries.GetProductName(CurrentSaleLineID));
        AssignValue(cStatus, cStopScanned);
        AssignValue(cAction, cScanStep);
        ExpectedPrefixTypes := [ptStep];
      end;

      ptFinish:
      begin
        EmployeeAction := ptFinish;
        CurrentSaleLineID := StrToIntDef(BarcodeValue, 0);
        AssignValue(cProcess, BarcodeQueries.GetProductName(StrToIntDef(BarcodeValue, 0)));
        AssignValue(cStatus, cFinishScanned);
        AssignValue(cAction, cScanStep);
        ExpectedPrefixTypes := [ptStep];
      end;

      ptComplete:
      begin
        EmployeeAction := ptComplete;
        CurrentSaleLineID := StrToIntDef(BarcodeValue, 0);
        AssignValue(cProcess, BarcodeQueries.GetProductName(StrToIntDef(BarcodeValue, 0)));
        AssignValue(cStatus, cCompleteScanned);
        BarcodeQueries.SetAllEmployeesFinished(CurrentEmployeeID, CurrentSaleLineID);
        AssignValue(cAction, cScanEmployeeOrResource);
        ExpectedPrefixTypes := [ptEmployee, ptPacking];
        RefreshStatus;
      end;

      ptStep:
      begin
        ProcessStepID := StrToIntDef(BarcodeValue, 0);

        if FEmployeeAction = ptStart then begin
          if not BarcodeQueries.IsEmployeeStarted(CurrentEmployeeID, ProcessStepID, CurrentSaleLineID) then begin
            if BarcodeQueries.CheckEmployeeAndStep(CurrentEmployeeID, ProcessStepID) then begin
              AssignValue(cStatus, 'Step ' + BarcodeQueries.GetProcessStepName(ProcessStepID) + ' scanned');

              if not BarcodeQueries.ExistingProcessRecord(CurrentSaleLineID) then
                BarcodeQueries.InsertProcessRecord(CurrentSaleLineID);

              if not BarcodeQueries.ExistingProcessLinesRecord(ProcessStepID, CurrentSaleLineID) then
                BarcodeQueries.InsertProcessLinesRecord(ProcessStepID, CurrentSaleLineID);

              BarcodeQueries.InsertProcessProgressRecord(CurrentEmployeeID, ProcessStepID, CurrentSaleLineID);
            end;
          end
          else if DisplayMessages then begin
            CommonLib.MessageDlgXP_Vista('This employee has already started on this step.' + #13#10 +
                       'Please scan another employee.', mtInformation, [mbOK], 0);
          end;

          AssignValue(cAction, cScanEmployeeOrResource);
          ExpectedPrefixTypes := [ptEmployee, ptPacking];
        end
        else begin
          if (EmployeeAction = ptFinish) or BarcodeQueries.IsEmployeeStarted(CurrentEmployeeID, ProcessStepID, CurrentSaleLineID) then begin
            if BarcodeQueries.CheckEmployeeAndStep(CurrentEmployeeID, ProcessStepID) then begin
              AssignValue(cStatus, 'Step ' + BarcodeQueries.GetProcessStepName(ProcessStepID) + ' scanned');
              BarcodeQueries.SetEmployeeState(CurrentEmployeeID, ProcessStepID, CurrentSaleLineID, EmployeeAction);
            end;

            AssignValue(cAction, cScanEmployeeOrResource);
            ExpectedPrefixTypes := [ptEmployee, ptPacking];
          end
          else begin
            if DisplayMessages then begin
              CommonLib.MessageDlgXP_Vista('This employee has not started on step ' +
                         BarcodeQueries.GetProcessStepName(ProcessStepID), mtInformation, [mbOK], 0);
            end;

            AssignValue(cAction, cScanEmployeeOrResource);
            ExpectedPrefixTypes := [ptEmployee, ptPacking];
          end;
        end;

        RefreshStatus;
      end;

      ptPacking:
      begin
        AssignValue(cStatus, cPackingScanned);
        PassBarcodeToAction(BarcodeText);
        AssignValue(cStatus, '');
      end;
    end;
  end
  else begin
    if DisplayMessages then
      DisplayScanMessage;
  end;
end;

procedure TBarcodeProcess.SetupDisplay;
var
  CaptionList: TStringList;
begin
  inherited;
  FormCaption := 'Barcode Process';
  PanelCaption := 'Barcode Process';
  CaptionList := TStringList.Create;

  try
    ColumnWidth := 150;
    CaptionList.Add(cEmployee);
    CaptionList.Add(cResource);
    CaptionList.Add(cProcess);
    CaptionList.Add(cStatus);
    CaptionList.Add(cAction);
    AssignCaptions(CaptionList);
    AssignValue(cAction, cScanEmployeeOrResource);
    ExpectedPrefixTypes := [ptEmployee, ptPacking];
    ShowForm;
  finally
    FreeandNil(CaptionList);
  end;
end;

function TBarcodeProcess.GetPrefixType(const Prefix: string): TPrefixType;
begin
  if Sysutils.SameText(Prefix, 'EMP') then
    Result := ptEmployee
  else if Sysutils.SameText(Prefix, 'START') then
    Result := ptStart
  else if Sysutils.SameText(Prefix, 'STOP') then
    Result := ptStop
  else if Sysutils.SameText(Prefix, 'FINISH') then
    Result := ptFinish
  else if Sysutils.SameText(Prefix, 'COMPLETE') then
    Result := ptComplete
  else if Sysutils.SameText(Prefix, 'STEP') then
    Result := ptStep
  else if Sysutils.SameText(Prefix, 'SHIP') then
    Result := ptPacking
  else
    Result := ptNone;
end;

procedure TBarcodeProcess.DisplayScanMessage;
var
  DisplayText: string;
begin
  DisplayText := 'Scan ';

  if ptEmployee in ExpectedPrefixTypes then
    DisplayText := DisplayText + 'Employee, Resource or ';

  if ptStart in ExpectedPrefixTypes then
    DisplayText := DisplayText + 'Start, ';

  if ptStop in ExpectedPrefixTypes then
    DisplayText := DisplayText + 'Stop, ';

  if ptFinish in ExpectedPrefixTypes then
    DisplayText := DisplayText + 'Finish or ';

  if ptComplete in ExpectedPrefixTypes then
    DisplayText := DisplayText + 'Complete';

  if ptPacking in ExpectedPrefixTypes then
    DisplayText := DisplayText + 'Packing ';

  if ptStep in ExpectedPrefixTypes then
    DisplayText := DisplayText + 'Step ';

  CommonLib.MessageDlgXP_Vista(DisplayText, mtInformation, [mbOK], 0);
end;

procedure TBarcodeProcess.RefreshStatus;
begin
  if Assigned(FStatusForm) then
    PostMessage(FStatusForm.Handle, TX_PerformRefresh, 0, 0);
end;

procedure TBarcodeProcess.PassBarcodeToAction(const BarcodeText: string);
var
  BarcodeAction: TBaseBarcode;
begin
  BarcodeAction := TBaseBarcode(GetComponentByClassName('TBarcodeAction'));

  try
    if Assigned(BarcodeAction) then
      BarcodeAction.EnterBarcode(BarcodeText);
  finally
    FreeandNil(BarcodeAction);
  end;
end;

initialization
  RegisterClassOnce(TBarcodeProcess);
finalization
  UnRegisterClass(TBarcodeProcess);
end.
