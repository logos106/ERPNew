unit ApprovalObj;

interface

uses
  BusObjBase, DB;

type

  TApprovalCheck = class(TObject)
  public
    class function Approved(obj: TMSBusObj; ChangedField: TField = nil): boolean;
  end;



implementation

uses
  SysUtils, CommonLib, BusObjApprovals, AppEnvironment, EmployeeAccesses,
  TypInfo, ERPDbComponents, DbSharedObjectsObj, CommonDbLib,
  BusObjTrans;

const
  NoRightsMessage = 'No rights to Approve Transactions in Approval Levels.';
  NoApprovalMessage = 'Insufficient Approval Level in Preferences > Payments to Approve This Amount.';
  NoApprovalChangeMessage = 'Insufficient Approval Level in Preferences > Payments to Approve This Transaction.';


{ TApprovalCheck }

class function TApprovalCheck.Approved(obj: TMSBusObj; ChangedField: TField): boolean;
var
  CleanTotal, Total, Variance: double;
  CleanApproved: boolean;
  XMLFieldNodeExists: boolean;
  ApprovalType: string;
  qry: TERPQuery;

  procedure SetApproved(const val: boolean);
  begin
    if not (ChangedField.DataSet.State in [dsInsert, dsEdit]) then begin
      try
        ChangedField.DataSet.Edit;
      except
      end;
    end;
    try
      ChangedField.AsBoolean := val;
    except
    end;
  end;


begin
  result := true;

  if (Obj is TTransBase) and TTransBase(Obj).UpdatingBo then
    exit;

  If (Not AppEnv.CompanyPrefs.UseApprovalLevels) or (Obj.ID < 1) Then
  exit;

  CleanApproved := true;

  { get basic info from busioness object }
  if Obj.ClassNameIs('TPurchaseOrder') or Obj.ClassNameIs('TPurchaseOrderEx') then begin
    ApprovalType := ApprovalTypePurchaseOrder;
    //CleanTotal := GetXMLNodeFloatValue(Obj.CleanXMLNode,'TotalEstimatedAmountInc',XMLFieldNodeExists);
    CleanApproved := GetXMLNodeBooleanValue(Obj.CleanXMLNode,'Approved',XMLFieldNodeExists);
    Total := GetFloatProp(Obj,'TotalEstimatedAmountInc');
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      qry.SQL.Add('Select Sum(PL.LineCostInc * PL.QtySold) as CleanTotal');
      qry.SQL.Add('from tblpurchaselines PL');
      qry.SQL.Add('where PL.PurchaseOrderId = ' + IntToStr(Obj.ID));
      qry.Open;
      CleanTotal := qry.FieldByName('CleanTotal').AsFloat;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end
  else if Obj.ClassNameIs('TBill') then begin
    ApprovalType := ApprovalTypeBill;
    CleanTotal := GetXMLNodeFloatValue(Obj.CleanXMLNode,'TotalAmountInc',XMLFieldNodeExists);
    CleanApproved := GetXMLNodeBooleanValue(Obj.CleanXMLNode,'Approved',XMLFieldNodeExists);
    Total := GetFloatProp(Obj,'TotalAmountInc');
  end
  else if Obj.ClassNameIs('TCredit') then begin
    ApprovalType := ApprovalTypeCredit;
    CleanTotal := GetXMLNodeFloatValue(Obj.CleanXMLNode,'TotalAmountInc',XMLFieldNodeExists);
    CleanApproved := GetXMLNodeBooleanValue(Obj.CleanXMLNode,'Approved',XMLFieldNodeExists);
    Total := GetFloatProp(Obj,'TotalAmountInc');
  end
  else if Obj.ClassNameIs('TExpenseClaim') then begin
    ApprovalType := ApprovalTypeExpenseClaim;
    CleanTotal := GetXMLNodeFloatValue(Obj.CleanXMLNode,'TotalAmountInc',XMLFieldNodeExists);
    { Expense Claim does not have Approved field }
    //CleanApproved := GetXMLNodeBooleanValue(Obj.CleanXMLNode,'Approved',XMLFieldNodeExists);
    Total := GetFloatProp(Obj,'TotalAmountInc');
  end
  else if Obj.ClassNameIs('TJournalEntry') then begin
    ApprovalType := ApprovalTypeJournalEntry;
    CleanTotal := GetXMLNodeFloatValue(Obj.CleanXMLNode,'TotDebitAmountInc',XMLFieldNodeExists);
    CleanApproved := GetXMLNodeBooleanValue(Obj.CleanXMLNode,'Approved',XMLFieldNodeExists);
    Total := GetFloatProp(Obj,'TotDebitAmountInc');
  end
  else if Obj.ClassNameIs('TStockAdjustEntry') then begin
    ApprovalType := ApprovalTypeStockAdjustment;
    CleanTotal := GetXMLNodeFloatValue(Obj.CleanXMLNode,'TotalCostEx',XMLFieldNodeExists);
    CleanApproved := GetXMLNodeBooleanValue(Obj.CleanXMLNode,'Approved',XMLFieldNodeExists);
    Total := GetFloatProp(Obj,'TotalCostEx');
  end
  else if Obj.ClassNameIs('TSmartOrder') then begin
    ApprovalType := ApprovalTypeSmartOrder;
    CleanTotal := GetXMLNodeFloatValue(Obj.CleanXMLNode,'TotalCostInc',XMLFieldNodeExists);
    CleanApproved := GetXMLNodeBooleanValue(Obj.CleanXMLNode,'Approved',XMLFieldNodeExists);
    Total := GetFloatProp(Obj,'TotalCostInc');
  end
  else begin
    raise Exception.Create(ClassName + ' - Object not handled for ' + obj.ClassName);
  end;


  if Assigned(ChangedField) and SameText(ChangedField.FieldName, 'Approved') then begin
    { Approved has been Checked or Unchecked ... }

    if ChangedField.AsBoolean and (not CleanApproved) then begin
      { user has ticked Approved and TRans was not previously Approved }

      if (not EmployeeAccesses.CanApproveTran) then begin
        { .. does user have access rigths to do this .. }
        result := false;
        Obj.ResultStatus.AddItem(False, rssWarning, 0 , ApprovalType+':' +NoRightsMessage);
        SetApproved(false);
      end else if not TApprovalLevels.CanApprove(ApprovalType,Total) then begin
        {  now check if they have sufficient approval level to do this .. }
          result := false;
          Obj.ResultStatus.AddItem(False, rssWarning, 0 , ApprovalType+':' +NoApprovalChangeMessage);
          SetApproved(false);
      end;
    end;

    if ChangedField.AsBoolean and (not CleanApproved) then begin
      { add to list ... }
      TApprovals.AddApproval(Obj, ApprovalType, AppEnv.Employee.EmployeeID, Obj.ID, Obj.GlobalRef);
    end
    else if (not ChangedField.AsBoolean) and  CleanApproved then begin
      { remove from list ... }
      TApprovals.Unapprove(Obj, ApprovalType, AppEnv.Employee.EmployeeID, Obj.ID);
    end

  end
  else begin
    { field that may result in total of transaction changing .. }
    Variance := Abs(Total - CleanTotal);
    if Variance = 0 then
      exit;

    if (not TApprovalLevels.CanApprove(ApprovalType,Total)) and (not TApprovalLevels.CanVary(ApprovalType, Variance)) then begin
      result := false;
      Obj.ResultStatus.AddItem(False, rssWarning, 0 , ApprovalType+':' +NoApprovalMessage);
    end;
  end;
end;

end.
