unit BusObjPaysBenefitsUK;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   18/06/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLIntf,BusObjBenefitsBase,BusObjUKNICs;


type
   Tpaysukbenefits = class(TBenefitsBase)
   private
      fNICsObj:TUKNICs;
      fTotalExpenses                     :double;
      fTotalBenefits                     :double;
      fTotalEmployeeNICsOther            :double;
      fTotalEmployerNICsOther            :double;
      fTotalEmployeeNICsExtraClass1      :double;
      fTotalEmployerNICsExtraClass1      :double;

      Function GetPayid                  :Integer   ;
      Function GetDescription            :String    ;
      Function GetIsnicspayable          :Boolean   ;
      Function GetNicsclass              :String    ;
      Function Getamount                 :Double    ;
      Function GetEmployeenicamount      :Double    ;
      Function GetEmployernicamount      :Double    ;

      Function GetBenefitReceivedFrom    :String    ;
      Function GetBenefitOrExpense       :String    ;

      Procedure SetPayid                  (Const Value :Integer   );
      Procedure SetDescription            (Const Value :String    );
      Procedure SetIsnicspayable          (Const Value :Boolean   );
      Procedure SetNicsclass              (Const Value :String    );
      Procedure Setamount                 (Const Value :Double    );
      Procedure SetEmployeenicamount      (Const Value :Double    );
      Procedure SetEmployernicamount      (Const Value :Double    );

      Procedure SetBenefitReceivedFrom    (Const Value :String    );
      Procedure SetBenefitOrExpense       (Const Value :String    );
    //  procedure Load; override;
      procedure CallBackCalcTotals(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
      Function  DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;           Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      procedure    Recalc;                                                 override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      procedure PostToAccounts; override;

      Property Payid                   :Integer      Read getPayid                Write SetPayid            ;
      Property Description             :String       Read getDescription          Write SetDescription      ;
      Property Isnicspayable           :Boolean      Read getIsnicspayable        Write SetIsnicspayable    ;
      Property Nicsclass               :String       Read getNicsclass            Write SetNicsclass        ;
      Property Amount                  :Double       Read getAmount               Write SetAmount    ;
      Property Employeenicamount       :Double       Read getEmployeenicamount    Write SetEmployeenicamount;
      Property Employernicamount       :Double       Read getEmployernicamount    Write SetEmployernicamount;
      Property BenefitReceivedFrom     :String       Read getBenefitReceivedFrom  Write SetBenefitReceivedFrom    ;
      Property BenefitOrExpense        :String       Read getBenefitOrExpense     Write SetBenefitOrExpense    ;

      property TotalExpenses           :double       Read fTotalExpenses          Write fTotalExpenses ;
      property TotalBenefits           :double       Read fTotalBenefits          Write fTotalBenefits;
      property TotalEmployeeNICsOther  :double       Read fTotalEmployeeNICsOther      Write fTotalEmployeeNICsOther;
      property TotalEmployerNICsOther  :double       Read fTotalEmployerNICsOther      Write fTotalEmployerNICsOther;
      property TotalEmployeeNICsExtraClass1  :double       Read fTotalEmployeeNICsExtraClass1      Write fTotalEmployeeNICsExtraClass1;
      property TotalEmployerNICsExtraClass1  :double       Read fTotalEmployerNICsExtraClass1      Write fTotalEmployerNICsExtraClass1;

      property NICsObj  :TUKNICs  read fNICsObj   write fNICsObj;
   End;


implementation


uses BusObjPaybase,BusObjConst,SysUtils,AppEnvironment,PayCommon;


{========================================================
         Tpaysukbenefits
========================================================}
constructor Tpaysukbenefits.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fNICsObj := TUKNICs.Create(Self);
   fNICsObj.Connection       := Self.Connection;
   fNICsObj.SilentMode       := Self.SilentMode;
end;

Function  Tpaysukbenefits.DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not ValidateData then begin
    SendEvent(BusobjEventVal_HandleIncompleteRecord,BusObjEvent_Change );
    Abort;
  end;
end;

//procedure Tpaysukbenefits.Load;
//begin
//  inherited Load;
//  fNICsObj.LoadSelect('PayID = ' + FastFuncs.IntToStr(Tpaybase(Self.Owner).PayID));
//end;

procedure Tpaysukbenefits.PostToAccounts;
begin
  Self.IterateRecords(CallbackPostToAccounts,False);
end;

procedure Tpaysukbenefits.CallBackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
//var
//  DebitAccID,CreditAccID :integer;
begin
   { TODO -orobin : finish }


 // DebitAccID := AppEnv.PayPrefs.BankAccountID;
//  CreditAccID :=AppEnv.PayPrefs.  NICsEmployeePayableAccountID;  //CREATE BENEFIT ACCOUNTS ETC
               //2008 START WORK HERE
 // PostToPaysTransactions('Payroll NICs','Employee Bene - '+FieldByName('MSType').AsString,'NICs - ' + FieldByName('Rate').AsString +
//          ' : ' + FieldByName('Type').AsString, TPaybase(Self.Owner),
//          CreditAccID,
//          DebitAccID,
//          FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
//          dAmount);
//    //NICs adjustment
//  DebitAccID := AppEnv.PayPrefs.BankAccountID;
//  CreditAccID :=AppEnv.PayPrefs.NICsEmployeePayableAccountID;
//
//  PostToPaysTransactions('Payroll NICs','Employee NICs - '+FieldByName('MSType').AsString,'NICs - ' + FieldByName('Rate').AsString +
//          ' : ' + FieldByName('Type').AsString, TPaybase(Self.Owner),
//          CreditAccID,
//          DebitAccID,
//          FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
//          dAmount);

end;

procedure Tpaysukbenefits.Recalc;
begin
  fTotalExpenses := 0;
  fTotalBenefits := 0;
  fTotalEmployeeNICsOther := 0;
  fTotalEmployerNICsOther := 0;
  fTotalEmployeeNICsExtraClass1 := 0;
  fTotalEmployerNICsExtraClass1 := 0;
  Self.IterateRecords(CallBackCalcTotals);
  TPaybase(Self.Owner).EmployeeNICsOther := TotalEmployeeNICsOther;  //set pay properties
  TPaybase(Self.Owner).EmployerNICsOther := TotalEmployerNICsOther;
  TPaybase(Self.Owner).EmployerNICsClass1 := TPaybase(Self.Owner).EmployerNICsClass1 + TotalEmployerNICsExtraClass1;
  
end;

procedure Tpaysukbenefits.CallBackCalcTotals(const Sender: TBusObj; var Abort: Boolean);
begin
  if Tpaysukbenefits(Sender).BenefitOrExpense = 'Expense' then
    fTotalExpenses := fTotalExpenses + Tpaysukbenefits(Sender).Amount
  else
    fTotalBenefits := fTotalBenefits + Tpaysukbenefits(Sender).Amount ;

  if Tpaysukbenefits(Sender).Isnicspayable then begin
    if Tpaysukbenefits(Sender).Nicsclass <> 'Class1' then begin
      fTotalEmployeeNICsOther := fTotalEmployeeNICsOther + Tpaysukbenefits(Sender).Employeenicamount;
      fTotalEmployerNICsOther := fTotalEmployerNICsOther + Tpaysukbenefits(Sender).Employernicamount;
    end else begin
      fTotalEmployeeNICsExtraClass1 := fTotalEmployeeNICsExtraClass1 + Tpaysukbenefits(Sender).Employeenicamount;
      fTotalEmployerNICsExtraClass1 := fTotalEmployerNICsExtraClass1 + Tpaysukbenefits(Sender).Employernicamount;
    end;
  end;
end;

destructor Tpaysukbenefits.Destroy;
begin
   inherited;
//   if Assigned(fNICsObj) then FreeAndNil(fNICsObj);
end;


procedure   Tpaysukbenefits.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
      Payid                   :=GetXMLNodeIntegerValue(Node,'Payid');
      Description             :=GetXMLNodeStringValue(Node,'Description');
      Isnicspayable           :=GetXMLNodeBooleanValue(Node,'Isnicspayable');
      Nicsclass               :=GetXMLNodeStringValue(Node,'Nicsclass');
      Amount                  :=GetXMLNodeFloatValue(Node,'Amount');
      Employeenicamount       :=GetXMLNodeFloatValue(Node,'Employeenicamount');
      Employernicamount       :=GetXMLNodeFloatValue(Node,'Employernicamount');

      BenefitReceivedFrom     :=GetXMLNodeStringValue(Node,'BenefitReceivedFrom');
      BenefitOrExpense        :=GetXMLNodeStringValue(Node,'BenefitOrExpense');
end;


procedure   Tpaysukbenefits.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Payid' ,Payid);
      AddXMLNode(node,'Description' ,Description);
      AddXMLNode(node,'Isnicspayable' ,Isnicspayable);
      AddXMLNode(node,'Nicsclass' ,Nicsclass);
      AddXMLNode(node,'Amount' ,Amount);
      AddXMLNode(node,'Employeenicamount' ,Employeenicamount);
      AddXMLNode(node,'Employernicamount' ,Employernicamount);
      AddXMLNode(node,'BenefitReceivedFrom' ,BenefitReceivedFrom);
      AddXMLNode(node,'BenefitOrExpense' ,BenefitOrExpense);
end;


function    Tpaysukbenefits.ValidateData :Boolean ;
begin
   if Self.Dataset.RecordCount = 0 then begin // don't force em to have a benefit
     Result := True;
     exit;
   end;

   Result := False;
   Resultstatus.Clear;
  // if Payid = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Payid should not be 0' , True );
//      Exit;
//   end;
   if Description = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_PayBenefit_Err_NoDescription,  'Description should not be blank' , True );
      Exit;
   end;
   //if Nicsclass = '' then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Nicsclass should not be blank' , True );
//      Exit;
//   end;
//   if Amount = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Amount should not be 0' , True );
//      Exit;
//   end;
//   if BenefitReceivedFrom = '' then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Benefit Received From should not be blank' , True );
//      Exit;
//   end;
//   if BenefitOrExpense = '' then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Benefit Or Expense should not be blank' , True );
//      Exit;
//   end;
//   if Employeenicamount = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Employeenicamount should not be 0' , True );
//      Exit;
//   end;
//   if Employernicamount = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Employernicamount should not be 0' , True );
//      Exit;
//   end;
   Result := true;
end;


function    Tpaysukbenefits.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Self.PostDb;
   Result := Inherited Save;
end;


procedure Tpaysukbenefits.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Tpaysukbenefits.DoFieldOnChange(Sender: TField);
begin
   if not (Self.Dataset.State in [dsEdit, dsInsert]) then Exit;
   if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
     if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
   inherited;

   if (SameText(Sender.FieldName , 'EmployeeNICAmount'))
     or (SameText(Sender.FieldName , 'EmployerNICAmount'))
     or (SameText(Sender.FieldName , 'NICsClass'))then begin 
       if NicsClass = 'Class1' then
         if Tpaybase(Self.Owner).RecalcInProgress = False then Tpaybase(Self.Owner).RecalcAll;
   end;
end;


Function Tpaysukbenefits.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblpaysukbenefits';
   Result :=  Inherited getSQL;
end;


class function  Tpaysukbenefits.GetIDField : String;
begin
   Result := 'Benefitid'
end;

class function Tpaysukbenefits.GetBusObjectTableName: string;
begin
  Result := 'tblpaysukbenefits';
end;


Function  Tpaysukbenefits.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);


End;

Function  Tpaysukbenefits.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is TPaybase then
                PayId := TPaybase(Self.Owner).ID;
    Result := inherited DoAfterInsert(Sender);            
end;

{Property functions}
Function  Tpaysukbenefits.GetPayid            :Integer   ; begin Result := GetIntegerField('Payid');End;
Function  Tpaysukbenefits.GetDescription      :String    ; begin Result := GetStringField('Description');End;
Function  Tpaysukbenefits.GetIsnicspayable    :Boolean   ; begin Result := GetBooleanField('Isnicspayable');End;
Function  Tpaysukbenefits.GetNicsclass        :String    ; begin Result := GetStringField('Nicsclass');End;
Function  Tpaysukbenefits.GetAmount           :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tpaysukbenefits.GetEmployeenicamount:Double    ; begin Result := GetFloatField('Employeenicamount');End;
Function  Tpaysukbenefits.GetEmployernicamount:Double    ; begin Result := GetFloatField('Employernicamount');End;

Function  Tpaysukbenefits.GetBenefitReceivedFrom :String    ; begin Result := GetStringField('BenefitReceivedFrom');End;
Function  Tpaysukbenefits.GetBenefitOrExpense    :String    ; begin Result := GetStringField('BenefitOrExpense');End;

Procedure Tpaysukbenefits.SetPayid            (Const Value :Integer   ); begin SetIntegerField('Payid'             , Value);End;
Procedure Tpaysukbenefits.SetDescription      (Const Value :String    ); begin SetStringField('Description'       , Value);End;
Procedure Tpaysukbenefits.SetIsnicspayable    (Const Value :Boolean   ); begin SetBooleanField('Isnicspayable'     , Value);End;
Procedure Tpaysukbenefits.SetNicsclass        (Const Value :String    ); begin SetStringField('Nicsclass'         , Value);End;
Procedure Tpaysukbenefits.SetAmount           (Const Value :Double    ); begin SetFloatField('Amount'     , Value);End;
Procedure Tpaysukbenefits.SetEmployeenicamount(Const Value :Double    ); begin SetFloatField('Employeenicamount' , Value);End;
Procedure Tpaysukbenefits.SetEmployernicamount(Const Value :Double    ); begin SetFloatField('Employernicamount' , Value);End;

Procedure Tpaysukbenefits.SetBenefitReceivedFrom (Const Value :String    ); begin SetStringField('BenefitReceivedFrom'       , Value);End;
Procedure Tpaysukbenefits.SetBenefitOrExpense     (Const Value :String    ); begin SetStringField('BenefitOrExpense'       , Value);End;


initialization
RegisterClass(Tpaysukbenefits);


end.
