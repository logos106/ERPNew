unit ApprovalClasses;

interface
uses
  SysUtils, stdctrls, CommonDBLib,wwcheckbox,
  ERPdbComponents, BusObjBase, EmployeeAccesses,
  AppEnvironment, BusObjApprovals;

type

  TGeneralApproval = class
  private
    fCleanApproval: boolean;
    fUseCleanApproval: boolean;
    fCleanPrice: double;
    fApprovalType: string;
    fKeyId: integer;
    fValueTo: double;
    procedure SetCleanApproval(const Value: boolean);
    procedure SetCleanPrice(const Value: double);
    function GetUseCleanApproval: boolean;
    function GetCleanApproval: boolean;
  protected
    procedure LoadCleanValues;
    function StrightValidateApproval(AValue : Double) : boolean;
    procedure SetupCheckBox(ACheckBox : TwwCheckBox);

    property ValueTo : double read fValueTo write fValueTo;

    property KeyId : integer read fKeyId write fKeyId;
  public

    constructor Create(const AApprovalType : string; AKeyId : integer; ACheckBox : TwwCheckBox);

    function ValidateApproval(aValue : double) : boolean;
//    function ValidateApprovalChecked(aValue : double) : boolean;

    property CleanPrice : double read fCleanPrice write SetCleanPrice;
    property CleanApproved : boolean read GetCleanApproval write SetCleanApproval;
    property ApprovalType : string read fApprovalType write fApprovalType;
    property UseCleanApproval : boolean read GetUseCleanApproval write fUseCleanApproval;
  end;

implementation

{ TGeneralApproval }


constructor TGeneralApproval.Create(const AApprovalType: string; AKeyId : integer; ACheckBox : TwwCheckBox);
begin
  inherited Create;
  ApprovalType := AApprovalType;

  KeyId := AKeyId;
  LoadCleanValues;
  SetupCheckBox(ACheckBox);
end;

function TGeneralApproval.GetCleanApproval: boolean;
begin
  if AppEnv.CompanyPrefs.UseApprovalLevels then
    Result := fCleanApproval
  else
    Result := true;
end;

function TGeneralApproval.GetUseCleanApproval: boolean;
begin
  Result := fUseCleanApproval;
end;

procedure TGeneralApproval.LoadCleanValues;
var
  qry : TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;

    if KeyId > 0 then
    begin
      if ApprovalType = ApprovalTypePurchaseOrder then
      begin
        qry.SQL.Add('Select P.Approved, Sum(PL.LineCostInc * PL.UnitOfMeasureShipped * Pl.UnitOfMeasureMultiplier) as CleanPrice');
        qry.SQL.Add('from tblPurchaseOrders P inner join tblpurchaselines PL on PL.PurchaseOrderID = P.PurchaseOrderId');
        qry.SQL.Add('where P.PurchaseOrderId = ' + IntToStr(KeyId));
      end
      else if ApprovalType = ApprovalTypeJournalEntry then
      begin
        qry.SQL.Add('select J.Approved, sum(L.DebitAmount) as CleanPrice');
        qry.SQL.Add('from tblgeneraljournal J inner join tblgeneraljournaldetails L on L.GJID = J.GJID');
        qry.SQL.Add('where J.GJID=' + IntToStr(KeyId));
      end
      else if ApprovalType = ApprovalTypeSmartOrder then
      begin
        qry.SQL.Add('select SO.Approved, sum(SL.LinePrice * (1 + LineTaxRate) * UnitOfMeasureQty * UnitOfMeasureMultiplier)  as CleanPrice');
        qry.SQL.Add('from tblSmartOrder SO inner join tblSmartOrderLines SL on SL.SmartOrderId = SO.SmartOrderId');
        qry.SQL.Add('where SO.SmartOrderID=' + IntToStr(KeyId));
      end;
//      else
//      exit;
(*
  ApprovalTypeBill          = 'Bill';
  ApprovalTypeCredit        = 'Credit';
  ApprovalTypeExpenseClaim  = 'Expense Claim';
  ApprovalTypeStockAdjustment  = 'Stock Adjustment';
*)
      qry.Open;
      CleanPrice := qry.Fields[1].AsFloat;
      CleanApproved := qry.Fields[0].AsBoolean;
      qry.Close;
    end;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT ValueTo from tblApprovalLevels where ApprovalType="' + ApprovalType + '"');
    qry.SQL.Add('AND EmployeeId=' + IntToStr(AppEnv.Employee.EmployeeID) + ' AND Active="T"');
    qry.Open;
    if qry.RecordCount = 0 then
      ValueTo := 0
    else
      ValueTo := qry.Fields[0].AsFloat;
  finally
    qry.Free;
  end;
end;

procedure TGeneralApproval.SetCleanApproval(const Value: boolean);
begin
  fCleanApproval := Value;
  UseCleanApproval := true;
end;

procedure TGeneralApproval.SetCleanPrice(const Value: double);
begin
  fCleanPrice := Value;
  UseCleanApproval := true;
end;

(*
function TGeneralApproval.SetupApproved(AExisting, ANew : boolean): boolean;
begin
  if not ValidateApproval( then

  if AExisting <> ANew then
    Result := ANew;
    if not JournalEntryObj.ValidateApproval then
      JournalEntryObj.Approved := JournalEntryObj.CleanApproved;
end;
*)

procedure TGeneralApproval.SetupCheckBox(ACheckBox: TwwCheckBox);
begin
  if not assigned(ACheckBox) then
    exit;
  If Not AppEnv.CompanyPrefs.UseApprovalLevels Then
    ACheckBox.visible := False
  Else If not(CanApproveTran) then
    ACheckBox.Enabled := False;
  if ACheckBox.Enabled then
  begin
    ACheckBox.Enabled := TApprovalLevels.CanApprove(ApprovalType, CleanPrice);
  end;
end;

function TGeneralApproval.StrightValidateApproval(AValue: Double): boolean;
begin
  Result := TRUE;

  if (not AppEnv.CompanyPrefs.UseApprovalLevels) then
    exit;


  if not CanApproveTran() then
  begin
    Result := false;
    exit;
  end;

  if (AValue < 0) then
  begin
    Result := true;
    Exit;
  end;

  if Self = nil then
    exit;

  Result := TApprovalLevels.CanApprove(ApprovalType, AValue);

end;

function TGeneralApproval.ValidateApproval(aValue: double): boolean;
begin
  result := true;
  if not AppEnv.CompanyPrefs.UseApprovalLevels then
    exit;

  Result := StrightValidateApproval(AValue);

  if Self = nil then
    exit;

  if not UseCleanApproval then
    exit;

  if Result then
    Exit;  // was

  if ValueTo = 0 then   // have no right to change approval
    Result := CleanApproved
  else
    Result := AValue <= ValueTo; //CleanPrice;
end;

(*
function TGeneralApproval.ValidateApprovalChecked(aValue : double): boolean;
begin
  result := true;
  if not AppEnv.CompanyPrefs.UseApprovalLevels then
    exit;

  Result := StrightValidateApproval(AValue);

  if Self = nil then
    exit;

  if not UseCleanApproval then
    exit;

  if Result then
    Exit;  // was

  if ValueTo = 0 then   // have no right to change approval
    Result := CleanApproved
  else
    Result := AValue <= ValueTo; //CleanPrice;
end;
*)
end.
