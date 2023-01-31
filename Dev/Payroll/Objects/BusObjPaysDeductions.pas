unit BusObjPaysDeductions;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   02/07/07   1.00.01  RM    Initial Version.
   }


interface


uses BusObjBase, DB, Classes, BusObjDeductions, XMLDoc, XMLIntf;


type
   Tpaysdeductions = class(TMSBusObj)
   private
      fDeductions                     :TDeduction;
      fTotalDeductions                :double;
      fTotalWPGiving                  :double;
      fTotalDeductionsBeforeTax       :Double;
      fTotalDeductionsAfterTax        :Double;
      fTotalWPGivingBeforeTax         :Double;
      fTotalWPGivingAfterTax          :Double;

      Function GetTotalDeductionsBeforeTax:double;
      Function GetTotalDeductionsAfterTax :double;
      Function GetTotalDeductions         :double;
      Function GetTotalWPGivingBeforeTax  :double;
      Function GetTotalWPGivingAfterTax   :double;
      Function GetTotalWPGiving           :double;

      Function GetPayid               :Integer   ;
      Function GetDeductionid         :Integer   ;
      Function GetNotes               :String    ;
      Function GetQty                 :Double    ;
      Function GetBasedonid           :Integer   ;
      Function GetBox12CodeID         :Integer   ;
      Function GetAmount              :Double    ;
      Function GetCalcby              :String    ;
      Function GetArea                :String    ;
      Function GetTaxexempt           :Boolean   ;
      Function GetTaxexemptFederal      :Boolean   ;
      Function GetTaxexemptState        :Boolean   ;
      Function GetTaxexemptSocial       :Boolean   ;
      Function GetTaxexemptMedicare     :Boolean   ;
      Function GetIsWorkPlacegiving   :Boolean   ;
      Function GetUnionfees           :Boolean   ;
      Function GetClassID             :Integer   ;
      Function GetClassname           :String    ;
      Function GetMoneyamount         :Double    ;
      Procedure SetPayid               (Const Value :Integer   );
      Procedure SetDeductionid         (Const Value :Integer   );
      Procedure SetNotes               (Const Value :String    );
      Procedure SetQty                 (Const Value :Double    );
      Procedure SetBasedonid           (Const Value :Integer   );
      Procedure SetBox12CodeID         (Const Value :Integer   );
      Procedure SetAmount              (Const Value :Double    );
      Procedure SetCalcby              (Const Value :String    );
      Procedure SetArea                (Const Value :String    );
      Procedure SetTaxexempt           (Const Value :Boolean   );
      Procedure SetTaxexemptFederal      (Const Value :Boolean   );
      Procedure SetTaxexemptState        (Const Value :Boolean   );
      Procedure SetTaxexemptSocial       (Const Value :Boolean   );
      Procedure SetTaxexemptMedicare     (Const Value :Boolean   );
      Procedure SetIsWorkPlacegiving   (Const Value :Boolean   );
      Procedure SetUnionfees           (Const Value :Boolean   );
      Procedure setClassID             (Const Value :Integer   );
      Procedure SetClassname           (Const Value :String    );
      Procedure SetMoneyamount         (Const Value :Double    );
      procedure CallbackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackTotalDeductions(const Sender: TBusObj; var Abort: Boolean);
      function GetDeductionDescription: string;
      procedure CalcTotalDeductions;

   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;

      procedure PostToAccounts;
      procedure UnPostToAccounts;
      procedure AddDeductionDetails;


      Property Payid                :Integer      Read getPayid             Write SetPayid         ;
      Property Deductionid          :Integer      Read getDeductionid       Write SetDeductionid   ;
      Property Notes                :String       Read getNotes             Write SetNotes         ;
      Property Qty                  :Double       Read GetQty               Write SetQty           ;
      Property Basedonid            :Integer      Read getBasedonid         Write SetBasedonid     ;
      Property Box12CodeID          :Integer      Read GetBox12CodeID       Write SetBox12CodeID   ;
      Property Amount               :Double       Read getAmount            Write SetAmount        ;
      Property Calcby               :String       Read getCalcby            Write SetCalcby        ;
      Property Area                 :String       Read getArea              Write SetArea          ;
      Property Taxexempt            :Boolean      Read getTaxexempt         Write SetTaxexempt     ;
      Property TaxexemptFederal       :Boolean      Read getTaxexemptFederal    Write SetTaxexemptFederal  ;
      Property TaxexemptState         :Boolean      Read getTaxexemptState      Write SetTaxexemptState  ;
      Property TaxexemptSocial        :Boolean      Read getTaxexemptSocial     Write SetTaxexemptSocial  ;
      Property TaxexemptMedicare      :Boolean      Read getTaxexemptMedicare   Write SetTaxexemptMedicare  ;
      Property IsWorkPlacegiving    :Boolean      Read getIsWorkPlacegiving Write SetIsWorkPlacegiving;
      Property Unionfees            :Boolean      Read getUnionfees         Write SetUnionfees     ;
      Property Classid              :Integer      Read GetClassID           Write setClassID       ;
      Property DepartmentName       :String       Read getClassname         Write SetClassname     ;
      Property Moneyamount          :Double       Read getMoneyamount       Write SetMoneyamount   ;

      property TotalDeductions          :double Read GetTotalDeductions    ;
      Property TotalDeductionsBeforeTax :double Read GetTotalDeductionsBeforeTax;
      Property TotalDeductionsAfterTax  :double Read GetTotalDeductionsAfterTax;
      property TotalWPGiving            :double Read GetTotalWPGiving      ;
      Property TotalWPGivingBeforeTax   :double Read GetTotalWPGivingBeforeTax;
      Property TotalWPGivingAfterTax    :double Read GetTotalWPGivingAfterTax;
      property DeductionDescription     :string read GetDeductionDescription;
      function YTDMoneyAmount(const aDate: TDateTime): double;
   End;


implementation


uses BusObjPayBase,AppEnvironment,PayCommon,
  SysUtils,DnMLib, BusObjConst, CommonLib, tcDataUtils, PayAccounts,
  ERPDbComponents, DateTimeUtils, DateUtils, PayConst, BusObjDeletedItem, Dialogs;


{========================================================
         Tpaysdeductions
========================================================}
constructor Tpaysdeductions.Create(AOwner: TComponent);
begin
   inherited Create(AOwner) ;
   fSQL := 'SELECT * FROM tblpaysdeductions';
   fdeductions := TDeduction.Create(Self);
   fdeductions.Connection := Self.Connection;
   fdeductions.SilentMode := Self.SilentMode;
end;

destructor Tpaysdeductions.Destroy;
begin
   inherited;
end;
procedure Tpaysdeductions.PostToAccounts;
begin
  Self.IterateRecords(CallbackPostToAccounts,False);
end;

procedure Tpaysdeductions.UnPostToAccounts;
begin
  Self.IterateRecords(CallbackUnPostToAccounts,False);
end;

procedure Tpaysdeductions.CallBackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID: integer;
  DebitAccID: integer;
  sMSType:string;
begin
  CreditAccID := tcDataUtils.getDeductionAccountID(DeductionID);

  DebitAccID   := PayAccounts.BankAccountID(Tpaybase(Self.Owner).Employeeid);
  if TaxExempt then begin
    sMSType := MSType_DeductionsTaxExempt;
  end else begin
    sMSType := MSType_Deductions;
  end;

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Deductions" AND MSType = ' + QuotedStr(sMSType) +
                                ' AND Description = '+ QuotedStr('Deduction - '+ GetDeductionName(DeductionID)) +
                                ' AND PayLineID = ' + IntToStr(ID));

  (* The following has been changed because tax should not be calculated for
    deductions, the total deductions will either:
    (Pre-Tax) reduce the gross amount (therfore reducing tax and net, or
    (Post-Tax) reduce the net amout (gross and tax remain unchanged) }
    Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions('Payroll Deductions',sMSType,
                                'Deduction - ' + GetDeductionName(DeductionID),CreditAccID,
                                DebitAccID,ClassID, ID,MoneyAmount - TPaybase(Self.Owner).PayTotals.TaxForDeductionId(self.ID), self);

  *)
  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(9,'Payroll Deductions',sMSType,
                                'Deduction - ' + GetDeductionName(DeductionID),CreditAccID,
                                DebitAccID,ClassID, ID,MoneyAmount, self);
end;

procedure Tpaysdeductions.CallBackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID: integer;
  DebitAccID: integer;
  sMSType:string;
begin
  CreditAccID := tcDataUtils.getDeductionAccountID(DeductionID);

  DebitAccID   := PayAccounts.BankAccountID(Tpaybase(Self.Owner).Employeeid)  ;
  if TaxExempt then begin
    sMSType := MSType_DeductionsTaxExempt;
  end else begin
    sMSType := MSType_Deductions;
  end;

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Deductions" AND MSType = ' + QuotedStr(sMSType) +
                                ' AND Description = '+ QuotedStr('Deduction - '+ GetDeductionName(DeductionID)) +
                                ' AND PayLineID = ' + IntToStr(ID));


  (* The following has been changed because tax should not be calculated for
    deductions, the total deductions will either:
    (Pre-Tax) reduce the gross amount (therfore reducing tax and net, or
    (Post-Tax) reduce the net amout (gross and tax remain unchanged) }
    Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions('Payroll Deductions',sMSType,
                                'Deduction - ' + GetDeductionName(DeductionID),CreditAccID,
                                DebitAccID,ClassID, ID,(MoneyAmount - TPaybase(Self.Owner).PayTotals.TaxForDeductionId(self.ID)) * -1, self);

  *)
  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(10,'Payroll Deductions',sMSType,
                                'Deduction - ' + GetDeductionName(DeductionID),CreditAccID,
                                DebitAccID,ClassID, ID,MoneyAmount * -1, self);

end;

procedure Tpaysdeductions.AddDeductionDetails;
begin
  fDeductions.Load(DeductionID);
  Qty := 1;
  TaxExempt     := fDeductions.Taxexempt;
  TaxExemptFederal    := fDeductions.TaxexemptFederal;
  TaxExemptState      := fDeductions.TaxexemptState;
  TaxExemptSocial     := fDeductions.TaxexemptSocial;
  TaxExemptMedicare   := fDeductions.TaxexemptMedicare;
  UnionFees     := fDeductions.Unionfees;
  Amount        := fDeductions.Amount;
  CalcBy        := fDeductions.Calcby;
  Area          := fDeductions.Area;
  BasedOnID     := fDeductions.Basedonid;
  Box12CodeID   := fDeductions.Box12CodeId;
  DepartmentName := Tpaybase(Self.Owner).EmployeeDetails.Defaultclassname;
end;

Function Tpaysdeductions.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is Tpaybase then
                PayId := Tpaybase(Self.Owner).ID;
    Result := inherited DoAfterInsert(Sender);
end;

procedure Tpaysdeductions.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Payid');
  SetPropertyFromNode(Node,'Deductionid');
  SetPropertyFromNode(Node,'Notes');
  SetPropertyFromNode(Node,'Qty');
  SetPropertyFromNode(Node,'Basedonid');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Calcby');
  SetPropertyFromNode(Node,'Area');
  SetBooleanPropertyFromNode(Node,'Taxexempt');
  SetBooleanPropertyFromNode(Node,'IsWorkPlacegiving');
  SetBooleanPropertyFromNode(Node,'Unionfees');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'Classname');
  SetPropertyFromNode(Node,'Moneyamount');
end;

procedure Tpaysdeductions.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Payid' ,Payid);
  AddXMLNode(node,'Deductionid' ,Deductionid);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'Basedonid' ,Basedonid);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Calcby' ,Calcby);
  AddXMLNode(node,'Area' ,Area);
  AddXMLNode(node,'Taxexempt' ,Taxexempt);
  AddXMLNode(node,'IsWorkPlacegiving' ,IsWorkPlacegiving);
  AddXMLNode(node,'Unionfees' ,Unionfees);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Classname' ,DepartmentName);
  AddXMLNode(node,'Moneyamount' ,Moneyamount);
end;

function Tpaysdeductions.ValidateData :Boolean ;
var
  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Deductionid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayDeductions_Err_NoDescription,  'Deduction should not be blank'  );
        Exit;
     end;

     if Qty = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayDeductions_Err_NoQty,  'Deduction Qty should not be 0'  );
        Exit;
     end;
     if Amount = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayDeductions_Err_NoAmount,  'Amount should not be 0'  );
        Exit;
     end;
     if CalcBy = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PayDeductions_Err_NoCalcBy,  'Calc By should not be blank'  );
        Exit;
     end;
     if Basedonid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayDeductions_Err_NoBasedOnID,  'Based on should not be blank'  );
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PayDeductions_Err_NoDepartment,  'Department name should not be blank'  );
        Exit;
     end;
     Result := true;
   Finally
    If not Result then Begin
      tmpResultStatus := ResultStatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedDeductionsValidateData);
    end;
   end;
end;

function Tpaysdeductions.YTDMoneyAmount(const aDate: TDateTime): double;
var
  strFrom, strTo: string;
  dtFrom: TDateTime;
  qry: TERPQuery;
begin
  dtFrom := FiscalYearStart(aDate, AppEnv.CompanyPrefs.FiscalYearStarts);
  strFrom := FormatDateTime('yyyy-mm-dd',dtFrom);
  strTo := FormatDateTime('yyyy-mm-dd',IncYear(dtFrom,1)-1);
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection.Connection;
    qry.SQL.Add('select sum(pd.MoneyAmount) as Amount from tblpaysdeductions pd');
    qry.SQL.Add('inner join tblpays p on p.PayID = pd.PayID and p.Paid = "T"');
    qry.SQL.Add('and p.Deleted = "F"');
    qry.SQL.Add('and p.PayDate between ' + QuotedStr(strFrom) + ' and ' + QuotedStr(strTo));
    qry.SQL.Add('where pd.DeductionID = ' + IntToStr(DeductionID));
    qry.Open;
    result := qry.FieldByName('Amount').AsFloat;
  finally
    qry.Free;
  end;
end;

function    Tpaysdeductions.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;

procedure Tpaysdeductions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;

procedure Tpaysdeductions.DoFieldOnChange(Sender: TField);
var
  sBasedOn:string;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName , 'Classname') then begin
    ClassID := tcDatautils.GetDeptID(DepartmentName);
  end;
   if (Sysutils.SameText(Sender.FieldName , 'DeductionID'))
     or (Sysutils.SameText(Sender.FieldName , 'Qty'))
     or (Sysutils.SameText(Sender.FieldName , 'Amount'))
     or (Sysutils.SameText(Sender.FieldName , 'CalcBy'))
     or (Sysutils.SameText(Sender.FieldName , 'BasedOnID'))
     or (Sysutils.SameText(Sender.FieldName , 'TaxExempt'))
     or (Sysutils.SameText(Sender.FieldName , 'IsWorkPlacegiving'))
    then begin
      sBasedOn := PayCommon.GetBasedOnName(BasedOnID);
      if FindInSet(sBasedOn,'None,Km,Items,Day,Week,Hours') then CalcBy := AppEnv.RegionalOptions.CurrencySymbol;  //'$';
      if CalcBy = '%' then begin
        if sBasedOn = 'Pays' then
          MoneyAmount := Amount *  Tpaybase(Self.Owner).Gross/100
        else if sBasedOn = 'Wages' then
          MoneyAmount := Amount * Tpaybase(Self.Owner).Wages/100 ;
      end else begin
        if sBasedOn = 'Pays' then
          MoneyAmount := Amount
        else if sBasedOn = 'Wages' then
          MoneyAmount := Amount
        else if sBasedOn = 'Hours' then
          MoneyAmount := Amount * Tpaybase(Self.Owner).payspayrates.totalhours
        else if sBasedOn = 'Day' then
          MoneyAmount := Amount * (DaysBetweenSigned(Tpaybase(Self.Owner).PayDate, Tpaybase(Self.Owner).PayFromDate) + 1)
        else if sBasedOn = 'Week' then
          MoneyAmount := Amount * (WeeksBetweenSigned(Tpaybase(Self.Owner).PayDate, Tpaybase(Self.Owner).PayFromDate) + 1)
        else
          MoneyAmount := Amount; //none,Km,Items
      end;     

      MoneyAmount := MoneyAmount * Qty;
      Tpaybase(Self.Owner).RecalcAll;
   end;
end;

Function Tpaysdeductions.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;

class function  Tpaysdeductions.GetIDField : String;
begin
   Result := 'Paydeductionid'
end;
class function Tpaysdeductions.GetBusObjectTablename: string;
begin
  Result := 'tblpaysdeductions';
end;

Function  Tpaysdeductions.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

Procedure Tpaysdeductions.CalcTotalDeductions;
begin
  fTotalDeductions          := 0;
  fTotalDeductionsBeforeTax := 0;
  fTotalDeductionsAfterTax  := 0;
  fTotalWPGiving          := 0;
  fTotalWPGivingBeforeTax := 0;
  fTotalWPGivingAfterTax  := 0;
  Self.IterateRecords(CallbackTotalDeductions, False);
end;

procedure Tpaysdeductions.CallBackTotalDeductions(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(IsWorkPlacegiving)                    then fTotalDeductions          := fTotalDeductions         + TPaysDeductions(Sender).Moneyamount;
  if not(IsWorkPlacegiving) and TaxExempt      then fTotalDeductionsBeforeTax := fTotalDeductionsBeforeTax+ TPaysDeductions(Sender).Moneyamount;
  if not(IsWorkPlacegiving) and not(TaxExempt) then fTotalDeductionsAfterTax  := fTotalDeductionsAfterTax + TPaysDeductions(Sender).Moneyamount;

  if (IsWorkPlacegiving)                    then fTotalWPGiving          := fTotalWPGiving         + TPaysDeductions(Sender).Moneyamount;
  if (IsWorkPlacegiving) and TaxExempt      then fTotalWPGivingBeforeTax := fTotalWPGivingBeforeTax+ TPaysDeductions(Sender).Moneyamount;
  if (IsWorkPlacegiving) and not(TaxExempt) then fTotalWPGivingAfterTax  := fTotalWPGivingAfterTax + TPaysDeductions(Sender).Moneyamount;

end;

{Property functions}
Function Tpaysdeductions.GetPayid         :Integer   ; begin Result := GetIntegerField('Payid');End;
Function Tpaysdeductions.GetDeductionid   :Integer   ; begin Result := GetIntegerField('Deductionid');End;
Function Tpaysdeductions.GetNotes         :String    ; begin Result := GetStringField('Notes');End;
Function Tpaysdeductions.GetQty           :Double    ; begin Result := GetFloatField('Qty');End;
Function Tpaysdeductions.GetBasedonid     :Integer   ; begin Result := GetIntegerField('Basedonid');End;
Function Tpaysdeductions.GetBox12CodeID   :Integer   ; begin Result := GetIntegerField('Box12CodeID');End;
function Tpaysdeductions.GetDeductionDescription: string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection.Connection;
    qry.SQL.Text := 'select Description from tbldeductions where PayDeductionID = ' + IntToStr(self.DeductionID);
    qry.Open;
    result := qry.FieldByName('Description').AsString;
  finally
    qry.Free;
  end;
end;
Function Tpaysdeductions.GetAmount        :Double    ; begin Result := GetFloatField('Amount');End;
Function Tpaysdeductions.GetCalcby        :String    ; begin Result := GetStringField('Calcby');End;
Function Tpaysdeductions.GetArea          :String    ; begin Result := GetStringField('Area');End;
Function Tpaysdeductions.GetTaxexempt     :Boolean   ; begin Result := GetBooleanField('Taxexempt');End;
Function Tpaysdeductions.GetTaxexemptFederal  :Boolean   ; begin Result := GetBooleanField('TaxexemptFederal');End;
Function Tpaysdeductions.GetTaxexemptState    :Boolean   ; begin Result := GetBooleanField('TaxexemptState');End;
Function Tpaysdeductions.GetTaxexemptSocial   :Boolean   ; begin Result := GetBooleanField('TaxexemptSocial');End;
Function Tpaysdeductions.GetTaxexemptMedicare :Boolean   ; begin Result := GetBooleanField('TaxexemptMedicare');End;
Function Tpaysdeductions.GetIsWorkPlacegiving     :Boolean   ; begin Result := GetBooleanField('IsWorkPlacegiving');End;
Function Tpaysdeductions.GetUnionfees     :Boolean   ; begin Result := GetBooleanField('Unionfees');End;
Function Tpaysdeductions.GetClassID       :Integer   ; begin Result := GetIntegerField('Classid');End;
Function Tpaysdeductions.GetClassname     :String    ; begin Result := GetStringField('Classname');End;
Function Tpaysdeductions.GetMoneyamount   :Double    ; begin Result := GetFloatField('Moneyamount');End;
Function Tpaysdeductions.GetTotalDeductions         :double;begin  CalcTotalDeductions;  Result := fTotalDeductions         ;end;
Function Tpaysdeductions.GetTotalDeductionsBeforeTax:double;begin  CalcTotalDeductions;  Result := fTotalDeductionsBeforeTax;end;
Function Tpaysdeductions.GetTotalDeductionsAfterTax :double;begin  CalcTotalDeductions;  Result := fTotalDeductionsAfterTax ;end;
Function Tpaysdeductions.GetTotalWPGiving           :double;begin  CalcTotalDeductions;  Result := fTotalWPGiving           ;end;
Function Tpaysdeductions.GetTotalWPGivingBeforeTax  :double;begin  CalcTotalDeductions;  Result := fTotalWPGivingBeforeTax  ;end;
Function Tpaysdeductions.GetTotalWPGivingAfterTax   :double;begin  CalcTotalDeductions;  Result := fTotalWPGivingAfterTax   ;end;

Procedure Tpaysdeductions.SetPayid         (Const Value :Integer   ); begin SetIntegerField('Payid'          , Value);End;
Procedure Tpaysdeductions.SetDeductionid   (Const Value :Integer   ); begin SetIntegerField('Deductionid'    , Value); End;

Procedure Tpaysdeductions.SetNotes         (Const Value :String    ); begin SetStringField('Notes'          , Value);End;
Procedure Tpaysdeductions.SetQty           (Const Value :Double    ); begin SetFloatField('Qty'            , Value);End;
Procedure Tpaysdeductions.SetBasedonid     (Const Value :Integer   ); begin SetIntegerField('Basedonid'      , Value);End;
Procedure Tpaysdeductions.SetBox12CodeID   (Const Value :Integer   ); begin SetIntegerField('Box12CodeID'      , Value);End;
Procedure Tpaysdeductions.SetAmount        (Const Value :Double    ); begin SetFloatField('Amount'         , Value);End;
Procedure Tpaysdeductions.SetCalcby        (Const Value :String    ); begin SetStringField('Calcby'         , Value);End;
Procedure Tpaysdeductions.SetArea          (Const Value :String    ); begin SetStringField('Area'         , Value);End;
Procedure Tpaysdeductions.SetTaxexempt     (Const Value :Boolean   ); begin SetBooleanField('Taxexempt'      , Value);End;
Procedure Tpaysdeductions.SetTaxexemptFederal  (Const Value :Boolean   ); begin SetBooleanField('TaxexemptFederal'   , Value);End;
Procedure Tpaysdeductions.SetTaxexemptState    (Const Value :Boolean   ); begin SetBooleanField('TaxexemptState'   , Value);End;
Procedure Tpaysdeductions.SetTaxexemptSocial   (Const Value :Boolean   ); begin SetBooleanField('TaxexemptSocial'   , Value);End;
Procedure Tpaysdeductions.SetTaxexemptMedicare (Const Value :Boolean   ); begin SetBooleanField('TaxexemptMedicare'   , Value);End;
Procedure Tpaysdeductions.SetIsWorkPlacegiving     (Const Value :Boolean   ); begin SetBooleanField('IsWorkPlacegiving'      , Value);End;
Procedure Tpaysdeductions.SetUnionfees     (Const Value :Boolean   ); begin SetBooleanField('Unionfees'      , Value);End;
Procedure Tpaysdeductions.setClassID       (Const Value :Integer   ); begin SetIntegerField('Classid'        , Value);End;
Procedure Tpaysdeductions.SetClassname     (Const Value :String    ); begin SetStringField('Classname'      , Value);End;
Procedure Tpaysdeductions.SetMoneyamount   (Const Value :Double    ); begin SetFloatField('Moneyamount'    , Value);End;

initialization
RegisterClassOnce(Tpaysdeductions);


end.
