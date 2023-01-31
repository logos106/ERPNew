unit BusObjPaySundriesBASE;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   16/04/07   1.00.01   RM   Initial Version.
   }


interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
   Tpayssundries = class(TMSBusObj)
   private
      fTotalTaxableSundries        :double;
      fTotalTaxExemptSundries      :double;
      fTotalSundries               :double;
      Function GetPayid            :Integer   ;
      Function GetSundryid         :Integer   ;
      Function GetSundry           :String    ;
      Function GetAmount           :Double    ;
      Function GetGst              :Double    ;
      Function GetSuperinc         :Boolean   ;
      Function GetTaxexempt        :Boolean   ;
      Function GetClientid         :Integer   ;
      Function GetClassID          :Integer   ;
      Function GetClassname        :String    ;
      Procedure SetPayid            (Const Value :Integer   );
      Procedure SetSundryid         (Const Value :Integer   );
      Procedure SetSundry           (Const Value :String    );
      Procedure SetAmount           (Const Value :Double    );
      Procedure SetGst              (Const Value :Double    );
      Procedure SetSuperinc         (Const Value :Boolean   );
      Procedure SetTaxexempt        (Const Value :Boolean   );
      Procedure SetClientid         (Const Value :Integer   );
      Procedure setClassID          (Const Value :Integer   );
      Procedure SetClassname        (Const Value :String    );

      Function GetTotalSundries:double;
      Function GetTaxableSundries:double;
      Function GetTaxExemptSundries:double;
      Procedure GetTotalTaxableCalc(Const Sender: TBusObj; var Abort: boolean);
      Procedure GetTotalCalc(Const Sender: TBusObj; var Abort: boolean); 
      Procedure GetTotalTaxExemptCalc(Const Sender: TBusObj; var Abort: boolean);
      procedure CallbackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;           Override;

   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      procedure PostToAccounts;
      procedure UnPostToAccounts;

      Property Payid             :Integer      Read getPayid          Write SetPayid      ;
      Property Sundryid          :Integer      Read getSundryid       Write SetSundryid   ;
      Property Sundry            :String       Read getSundry         Write SetSundry     ;
      Property Amount            :Double       Read getAmount         Write SetAmount     ;
      Property Gst               :Double       Read getGst            Write SetGst        ;
      Property Superinc          :Boolean      Read getSuperinc       Write SetSuperinc   ;
      Property Taxexempt         :Boolean      Read getTaxexempt      Write SetTaxexempt  ;
      Property Clientid          :Integer      Read getClientid       Write SetClientid   ;
      Property Classid           :Integer      Read GetClassID        Write setClassID    ;
      Property DepartmentName    :String       Read getClassname      Write SetClassname  ;

      Property TotalSundries     :double       Read GetTotalSundries;
      Property TaxableSundries   :double       Read GetTaxableSundries;
      Property TaxExemptSundries :double       Read GetTaxExemptSundries;
   End;

implementation

uses
  BusObjPaybase,BusObjConst,AppEnvironment,PayCommon,SysUtils,
  CommonLib, tcDataUtils, PayAccounts, PayConst, ERPDbComponents;

{========================================================
         Tpayssundries
========================================================}
constructor Tpayssundries.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblpayssundries';
end;

destructor Tpayssundries.Destroy;
begin
   inherited;
end;

procedure Tpayssundries.PostToAccounts;
begin
  Self.IterateRecords(CallbackPostToAccounts,False);
end;

procedure Tpayssundries.UnPostToAccounts;
begin
  Self.IterateRecords(CallbackUnPostToAccounts,False);
end;

procedure Tpayssundries.CallBackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID: integer;
  DebitAccID: integer;
  sMSType:string;
begin
  DebitAccID := PayAccounts.BankAccountID(Tpaybase(Self.Owner).Employeeid);
  CreditAccID := PayAccounts.SundriesPaidAccountID(Tpaybase(Self.Owner).Employeeid);
  if TaxExempt then begin
    sMSType := MSType_SundriesTaxExempt;
  end else begin
    sMSType := MSType_Sundries;
  end;

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Sundries" AND MSType = ' + QuotedStr(sMSType) +
                                ' AND Description = '+ QuotedStr('Sundry - '+ GetSundryName(SundryID)) +
                                ' AND PayLineID = ' + IntToStr(ID));


  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(19,'Payroll Sundries',sMSType,
                                'Sundry - ' + GetSundryName(SundryID),CreditAccID,
                                DebitAccID,ClassID, ID,Amount, self);

end;


procedure Tpayssundries.CallBackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID: integer;
  DebitAccID: integer;
  sMSType:string;
begin
  DebitAccID := PayAccounts.BankAccountID(Tpaybase(Self.Owner).Employeeid);
  CreditAccID := PayAccounts.SundriesPaidAccountID(Tpaybase(Self.Owner).Employeeid);
  if TaxExempt then begin
    sMSType := MSType_SundriesTaxExempt;
  end else begin
    sMSType := MSType_Sundries;
  end;

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Sundries" AND MSType = ' + QuotedStr(sMSType) +
                                ' AND Description = '+ QuotedStr('Sundry - '+ GetSundryName(SundryID)) +
                                ' AND PayLineID = ' + IntToStr(ID));

  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(20,'Payroll Sundries',sMSType,
                                'Sundry - ' + GetSundryName(SundryID),CreditAccID,
                                DebitAccID,ClassID, ID,- Amount, self);


end;



Function  Tpayssundries.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is Tpaybase then begin
          PayId := Tpaybase(Self.Owner).ID;
          DepartmentName := Tpaybase(Self.Owner).EmployeeDetails.Defaultclassname;
        end;
    Result := True;
end;

Function Tpayssundries.GetTaxableSundries:double;
begin
  fTotalTaxableSundries :=  0;
  Self.IterateRecords(GetTotalTaxableCalc);
  result := fTotalTaxableSundries;
end;

Procedure Tpayssundries.GetTotalTaxableCalc(Const Sender: TBusObj; var Abort: boolean);
begin
  if not TaxExempt then fTotalTaxableSundries :=  fTotalTaxableSundries + TPayssundries(Sender).Amount;
end;

Function Tpayssundries.GetTaxExemptSundries:double;
begin
  fTotalTaxExemptSundries :=  0;
  Self.IterateRecords(GetTotalTaxExemptCalc);
  result := fTotalTaxExemptSundries;
end;

Procedure Tpayssundries.GetTotalTaxExemptCalc(Const Sender: TBusObj; var Abort: boolean);
begin
  if TaxExempt then fTotalTaxExemptSundries :=  fTotalTaxExemptSundries + TPayssundries(Sender).Amount;
end;


Function Tpayssundries.GetTotalSundries:double;
begin
  fTotalSundries :=  0;
  Self.IterateRecords(GetTotalCalc);
  result := fTotalSundries;
end;

Procedure Tpayssundries.GetTotalCalc(Const Sender: TBusObj; var Abort: boolean);
begin
  fTotalSundries :=  fTotalSundries + TPayssundries(Sender).Amount;
end;


procedure   Tpayssundries.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Payid');
  SetPropertyFromNode(Node,'Sundryid');
  SetPropertyFromNode(Node,'Sundry');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Gst');
  SetBooleanPropertyFromNode(Node,'Superinc');
  SetBooleanPropertyFromNode(Node,'Taxexempt');
  SetPropertyFromNode(Node,'Clientid');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'Classname');
end;


procedure   Tpayssundries.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Payid' ,Payid);
  AddXMLNode(node,'Sundryid' ,Sundryid);
  AddXMLNode(node,'Sundry' ,Sundry);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Gst' ,Gst);
  AddXMLNode(node,'Superinc' ,Superinc);
  AddXMLNode(node,'Taxexempt' ,Taxexempt);
  AddXMLNode(node,'Clientid' ,Clientid);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Classname' ,DepartmentName);
end;


function    Tpayssundries.ValidateData :Boolean ;
var
  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Sundry = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PaySundries_Err_NoDescription,  'Sundry description should not be blank' );
        Exit;
     end;
     if Amount = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PaySundries_Err_NoAmount,  'Amount should not be 0' );
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PaySundries_Err_NoDepartment,  'Department name should not be blank'  );
        Exit;
     end;
     Result := true;
   Finally
    If not Result then Begin
      tmpResultStatus := ResultStatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedSundriesValidateData);
    end;
   end;
end;


function    Tpayssundries.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tpayssundries.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Tpayssundries.DoFieldOnChange(Sender: TField);
var
  qry: TERPQuery;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
   inherited;
  if Sysutils.SameText(Sender.FieldName , 'Classname') then begin
    ClassID := tcDatautils.GetDeptID(DepartmentName);
  end
  else if Sysutils.SameText(Sender.FieldName , 'Sundry') then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Connection.Connection;
      qry.SQL.Text := 'select SundryID from tblsundrytypes where SundryDesc = ' + QuotedStr(Sender.AsString);
      qry.Open;
      SundryID := qry.FieldByName('SundryID').AsInteger;
    finally
      qry.Free;
    end;

  end;

   if (Sysutils.SameText(Sender.FieldName , 'Amount'))
     or  (Sysutils.SameText(Sender.FieldName , 'GST'))
     or  (Sysutils.SameText(Sender.FieldName , 'TaxExempt'))
     then begin
     Tpaybase(Self.Owner).recalcAll;
   end; 
end;


Function Tpayssundries.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tpayssundries.GetIDField : String;
begin
   Result := 'Paysundryid'
end;

class function Tpayssundries.GetBusObjectTablename: string;
begin
  Result := 'tblpayssundries';
end;

Function  Tpayssundries.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Tpayssundries.GetPayid      :Integer   ; begin Result := GetIntegerField('Payid');End;
Function  Tpayssundries.GetSundryid   :Integer   ; begin Result := GetIntegerField('Sundryid');End;
Function  Tpayssundries.GetSundry     :String    ; begin Result := GetStringField('Sundry');End;
Function  Tpayssundries.GetAmount     :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tpayssundries.GetGst        :Double    ; begin Result := GetFloatField('Gst');End;
Function  Tpayssundries.GetSuperinc   :Boolean   ; begin Result := GetBooleanField('Superinc');End;
Function  Tpayssundries.GetTaxexempt  :Boolean   ; begin Result := GetBooleanField('Taxexempt');End;
Function  Tpayssundries.GetClientid   :Integer   ; begin Result := GetIntegerField('Clientid');End;
Function  Tpayssundries.GetClassID    :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  Tpayssundries.GetClassname  :String    ; begin Result := GetStringField('Classname');End;
Procedure Tpayssundries.SetPayid      (Const Value :Integer   ); begin SetIntegerField('Payid'       , Value);End;

Procedure Tpayssundries.SetSundryid   (Const Value :Integer   );
begin
  SetIntegerField('Sundryid'    , Value);
End;

Procedure Tpayssundries.SetSundry     (Const Value :String    );
begin
  SetStringField('Sundry'      , Value);
End;
Procedure Tpayssundries.SetAmount     (Const Value :Double    ); begin SetFloatField('Amount'      , Value);End;
Procedure Tpayssundries.SetGst        (Const Value :Double    ); begin SetFloatField('Gst'         , Value);End;
Procedure Tpayssundries.SetSuperinc   (Const Value :Boolean   ); begin SetBooleanField('Superinc'    , Value);End;
Procedure Tpayssundries.SetTaxexempt  (Const Value :Boolean   ); begin SetBooleanField('Taxexempt'   , Value);End;
Procedure Tpayssundries.SetClientid   (Const Value :Integer   ); begin SetIntegerField('Clientid'    , Value);End;
Procedure Tpayssundries.setClassID    (Const Value :Integer   ); begin SetIntegerField('Classid'     , Value);End;
Procedure Tpayssundries.SetClassname  (Const Value :String    ); begin SetStringField('Classname'   , Value);End;


initialization
RegisterClassOnce(Tpayssundries);


end.
