unit BusObjSuperannuation;
   {      Employee super
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   20/07/07   1.00.01      Initial Version.
   }


interface
{$I ERP.inc}

uses
  BusObjBase, DB, Classes, BusObjBenefitsBase, XMLDoc, XMLIntf;


type
   Tsuperannuation = class(TBenefitsBase)

   const
      _AccountNumber = 'AccountNo';
      _AccountName = 'BankAccountName';
      _ElectronicsServiceAddressAlias = '';
      _BSB = 'BankAccountBSB';

   private
      procedure UpdateStringField(const sField, sValue: String);

      Function GetSuperID           :integer;

      Function GetEmployeeid        :Integer   ;
      Function GetSupertypeid       :Integer   ;
      Function GetClientid          :Integer   ;
      Function GetAccountno         :String    ;
      Function GetDatejoined        :TDatetime ;
      Function GetAmount            :Double    ;
      Function GetCalcby            :String   ;
      Function GetArea              :String   ;
      Function GetTaxexempt         :Boolean   ;
      Function GetTaxrate           :Double    ;
      Function GetClassID           :Integer   ;
      Function GetClassname         :String    ;
      Function GetAllclasses        :Boolean   ;
      Function GetSuperfund         :String    ;
      Function GetAmounttopaid      :Double    ;
      function GetABN               :String    ;
      function GetAccountNumber     :String    ;
      function GetAccountName       :String    ;
      function GetESAA              :String    ;
      function GetBSB               :String    ;
      function GetActive            :Boolean   ;

      Procedure SetEmployeeid        (Const Value :Integer   );
      Procedure SetSupertypeid       (Const Value :Integer   );
      Procedure SetClientid          (Const Value :Integer   );
      Procedure SetAccountno         (Const Value :String    );
      Procedure SetDatejoined        (Const Value :TDatetime );
      Procedure SetAmount            (Const Value :Double    );
      Procedure SetCalcby            (Const Value :String    );
      Procedure SetArea              (Const Value :String    );
      Procedure SetTaxexempt         (Const Value :Boolean   );
      Procedure SetTaxrate           (Const Value :Double    );
      Procedure setClassID           (Const Value :Integer   );
      Procedure SetClassname         (Const Value :String    );
      Procedure SetAllclasses        (Const Value :Boolean   );
      Procedure SetSuperfund         (Const Value :String    );
      Procedure SetAmounttopaid      (Const Value :Double    );
      procedure SetABN               (const Value: String    );
      procedure SetAccountNumber     (const Value: String    );
      procedure SetAccountName       (const Value: String    );
      procedure SetESAA              (const Value: String    );
      procedure SetBSB               (const Value: String    );
      procedure SetActive            (const Value: Boolean   );

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

   Published
      Property Employeeid         :Integer      Read getEmployeeid      Write SetEmployeeid  ;
      Property Supertypeid        :Integer      Read getSupertypeid     Write SetSupertypeid ;
      Property Clientid           :Integer      Read getClientid        Write SetClientid    ;
      Property Accountno          :String       Read getAccountno       Write SetAccountno   ;
      Property Datejoined         :TDatetime    Read getDatejoined      Write SetDatejoined  ;
      Property Amount             :Double       Read getAmount          Write SetAmount      ;
      Property Calcby             :String       Read getCalcby          Write SetCalcby      ;
      Property Area               :String       Read getArea            Write SetArea      ;
      Property Taxexempt          :Boolean      Read getTaxexempt       Write SetTaxexempt   ;
      Property Taxrate            :Double       Read getTaxrate         Write SetTaxrate     ;
      Property Classid            :Integer      Read GetClassID         Write setClassID     ;
      Property DepartmentName     :String       Read getClassname       Write SetClassname   ;
      Property Allclasses         :Boolean      Read getAllclasses      Write SetAllclasses  ;
      Property Superfund          :String       Read getSuperfund       Write SetSuperfund   ;
      Property Amounttopaid       :Double       Read getAmounttopaid    Write SetAmounttopaid;

      property ABN: String read GetABN write SetABN;
      property AccountNumber: String read GetAccountNumber write SetAccountNumber;
      property AccountName: String read GetAccountName write SetAccountName;
      property ElectronicsServiceAddressAlias: String read GetESAA write SetESAA;
      property BSB: String read GetBSB write SetBSB;
      property Active: Boolean read GetActive write SetActive;

      Property SuperID            :integer      Read GetSuperID;
   End;

   (*
   TsuperannuationEx = class(Tsuperannuation)
   end;
   *)

implementation


uses
  BusObjEmployeePay,BusObjConst,SysUtils, CommonLib, PayCommon,
  tcDataUtils, BusObjEmployee, AppEnvironment, tcTypes, ErpDbComponents,
  BusObjPaysSuperannuation;


{========================================================
         Tsuperannuation
========================================================}
constructor Tsuperannuation.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblsuperannuation';

//   FSQL :=
//     ' SELECT ' +
//     '   S.*, ' +
//     '   C.ABN, ' +
//     '   C.AccountNo AccountNumber, ' +
//     '   C.BankAccountName AccountName, ' +
//     '   NULL ElectronicsServiceAddressAlias, ' +
//     '   C.BankAccountBSB BSB ' +
//     ' FROM tblsuperannuation S ' +
//     ' JOIN tblclients C USING (ClientID) ';
end;

Function  Tsuperannuation.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is TEmployeePay then begin
          EmployeeId := TemployeePay(Self.Owner).EmployeePaySettings.Employeeid;
          DepartmentName := Temployeepay(Self.Owner).EmployeeDetails.Defaultclassname;
        end
        else if Self.Owner is TEmployee then begin
          EmployeeId := Temployee(Self.Owner).Id;
          DepartmentName := Temployee(Self.Owner).DefaultClassName;
        end;

    Result := inherited DoAfterInsert(Sender);
end;

destructor Tsuperannuation.Destroy;
begin
   inherited;
end;


procedure   Tsuperannuation.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Employeeid');
  SetPropertyFromNode(Node,'Supertypeid');
  SetPropertyFromNode(Node,'Clientid');
  SetPropertyFromNode(Node,'Accountno');
  SetDateTimePropertyFromNode(Node,'Datejoined');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Calcby');
  SetPropertyFromNode(Node,'Area');
  SetBooleanPropertyFromNode(Node,'Taxexempt');
  SetPropertyFromNode(Node,'Taxrate');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'DepartmentName');
  SetBooleanPropertyFromNode(Node,'Allclasses');
  SetPropertyFromNode(Node,'Superfund');
  SetPropertyFromNode(Node,'Amounttopaid');

  SetPropertyFromNode(Node,'ABN');
  SetPropertyFromNode(Node,'AccountNumber');
  SetPropertyFromNode(Node,'AccountName');
  SetPropertyFromNode(Node,'ElectronicsServiceAddressAlias');
  SetPropertyFromNode(Node,'BSB');
end;


procedure   Tsuperannuation.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'Supertypeid' ,Supertypeid);
  AddXMLNode(node,'Clientid' ,Clientid);
  AddXMLNode(node,'Accountno' ,Accountno);
  AddXMLNode(node,'Datejoined' ,Datejoined);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Calcby' ,Calcby);
  AddXMLNode(node,'Area', Area);
  AddXMLNode(node,'Taxexempt' ,Taxexempt);
  AddXMLNode(node,'Taxrate' ,Taxrate);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'DepartmentName' ,DepartmentName);
  AddXMLNode(node,'Allclasses' ,Allclasses);
  AddXMLNode(node,'Superfund' ,Superfund);
  AddXMLNode(node,'Amounttopaid' ,Amounttopaid);

  AddXMLNode(Node,'ABN', ABN);
  AddXMLNode(Node,'AccountNumber', AccountNumber);
  AddXMLNode(Node,'AccountName', AccountName);
  AddXMLNode(Node,'ESAA', ElectronicsServiceAddressAlias);
  AddXMLNode(Node,'BSB', BSB);
end;


function Tsuperannuation.ValidateData :Boolean ;
//var
//  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Supertypeid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeSuper_Err_NoType,  'Super Type should not be blank'  );
        SendEvent(IntToStr(BOR_EmployeeSuper_Err_NoType),BusobjEventVal_FailedSuperannuationValidateData);
        Exit;
     end;

     //Super fund not mandatory but needs limited nagging.
     if AppEnv.RegionalOptions.RegionType <> rAUST then begin


     end
     else begin
       if Superfund = '' then begin
          Resultstatus.AddItem(False , rssError , BOR_EmployeeSuper_NoFund_Nagged,  'Superfund should not be blank for ' + quotedstr(GetSuperName(Supertypeid)) +'.',False);
          SendEvent(IntToStr(BOR_EmployeeSuper_NoFund_Nagged),BusobjEventVal_FailedSuperannuationValidateData);
       end;
     end;

     if Amount = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeSuper_Err_NoAmount,  'Amount should not be 0'  );
        SendEvent(IntToStr(BOR_EmployeeSuper_Err_NoAmount),BusobjEventVal_FailedSuperannuationValidateData);
        Exit;
     end;
     if Calcby = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeSuper_Err_NoCalcBy,  'CalcBy should not be blank'  );
        SendEvent(IntToStr(BOR_EmployeeSuper_Err_NoCalcBy),BusobjEventVal_FailedSuperannuationValidateData);
        Exit;
     end;

     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeSuper_Err_NoDepartment,  'Department should not be blank' );
        SendEvent(IntToStr(BOR_EmployeeSuper_Err_NoDepartment),BusobjEventVal_FailedSuperannuationValidateData);
        Exit;
     end;

     if GetSuperName(Supertypeid) = SUPER_TYPE_SALARY_SACRIFICE(*'Salary Sacrifice'*) then begin
      if (Amount > TEmployeepay(Self.Owner).EmployeePayRates.TotalWages) then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeSuper_Err_SalarySacrifice,  'Salary Sacrifice should not be Greater than Total Salary'  );
        SendEvent(IntToStr(BOR_EmployeeSuper_Err_SalarySacrifice),BusobjEventVal_FailedSuperannuationValidateData);
        Exit;
      end;
     end;
     Result := true;
   Finally
//    If not Result then Begin
//      tmpResultStatus := ResultStatus.GetLastStatusItem;
//      if Assigned(tmpResultStatus) then
//        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedSuperannuationValidateData);
//    end;
   end;
end;

function Tsuperannuation.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tsuperannuation.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Tsuperannuation.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName , 'Classname') then begin
    ClassID := tcDatautils.GetDeptID(DepartmentName);
  end;
end;


Function Tsuperannuation.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tsuperannuation.GetIDField : String;
begin
   Result := 'Superid'
end;


class function Tsuperannuation.GetBusObjectTablename: string;
begin
  Result := 'tblsuperannuation';
end;


Function  Tsuperannuation.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Tsuperannuation.GetSuperID     :Integer   ; begin Result := GetIntegerField('SuperID');End;
Function  Tsuperannuation.GetEmployeeid  :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  Tsuperannuation.GetSupertypeid :Integer   ; begin Result := GetIntegerField('Supertypeid');End;
Function  Tsuperannuation.GetClientid    :Integer   ; begin Result := GetIntegerField('Clientid');End;
Function  Tsuperannuation.GetAccountno   :String    ; begin Result := GetStringField('Accountno');End;
Function  Tsuperannuation.GetDatejoined  :TDatetime ; begin Result := GetDatetimeField('Datejoined');End;
Function  Tsuperannuation.GetAmount      :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tsuperannuation.GetCalcby      :String    ; begin Result := GetStringField('Calcby');End;
Function  Tsuperannuation.GetArea        :String    ; begin Result := GetStringField('Area');End;
Function  Tsuperannuation.GetTaxexempt   :Boolean   ; begin Result := GetBooleanField('Taxexempt');End;
Function  Tsuperannuation.GetTaxrate     :Double    ; begin Result := GetFloatField('Taxrate');End;
Function  Tsuperannuation.GetClassID     :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  Tsuperannuation.GetClassname   :String    ; begin Result := GetStringField('Classname');End;
Function  Tsuperannuation.GetAllclasses  :Boolean   ; begin Result := GetBooleanField('Allclasses');End;
Function  Tsuperannuation.GetSuperfund   :String    ; begin Result := GetStringField('Superfund');End;
Function  Tsuperannuation.GetAmounttopaid:Double    ; begin Result := GetFloatField('Amounttopaid');End;
function  Tsuperannuation.GetABN         :String    ; begin Result := GetStringField('ABN');end;
function  Tsuperannuation.GetAccountNumber         :String    ; begin Result := GetStringField('AccountNumber');end;
function  Tsuperannuation.GetAccountName           :String    ; begin Result := GetStringField('AccountName');end;
function  Tsuperannuation.GetESAA        :String    ; begin Result := GetStringField('ESAA');end;
function  Tsuperannuation.GetBSB         :String    ; begin Result := GetStringField('BSB');end;
function  Tsuperannuation.GetActive      :Boolean   ; begin Result := GetBooleanField('Active');end;

Procedure Tsuperannuation.SetEmployeeid  (Const Value :Integer   ); begin SetIntegerField('Employeeid'   , Value);End;
Procedure Tsuperannuation.SetSupertypeid (Const Value :Integer   ); begin SetIntegerField('Supertypeid'  , Value);End;
Procedure Tsuperannuation.SetClientid    (Const Value :Integer   ); begin SetIntegerField('Clientid'     , Value);End;
Procedure Tsuperannuation.SetAccountno   (Const Value :String    ); begin SetStringField('Accountno'    , Value);End;
Procedure Tsuperannuation.SetDatejoined  (Const Value :TDatetime ); begin SetDatetimeField('Datejoined'   , Value);End;
Procedure Tsuperannuation.SetAmount      (Const Value :Double    ); begin SetFloatField('Amount'       , Value);End;
Procedure Tsuperannuation.SetCalcby      (Const Value :String    ); begin SetStringField('Calcby'       , Value);End;
Procedure Tsuperannuation.SetArea        (Const Value :String    ); begin SetStringField('Area'       , Value);End;
Procedure Tsuperannuation.SetTaxexempt   (Const Value :Boolean   ); begin SetBooleanField('Taxexempt'    , Value);End;
Procedure Tsuperannuation.SetTaxrate     (Const Value :Double    ); begin SetFloatField('Taxrate'      , Value);End;
Procedure Tsuperannuation.setClassID     (Const Value :Integer   ); begin SetIntegerField('Classid'      , Value);End;
Procedure Tsuperannuation.SetClassname   (Const Value :String    ); begin SetStringField('Classname'    , Value);End;
Procedure Tsuperannuation.SetAllclasses  (Const Value :Boolean   ); begin SetBooleanField('Allclasses'   , Value);End;
Procedure Tsuperannuation.SetSuperfund   (Const Value :String    ); begin SetStringField('Superfund'    , Value);End;
Procedure Tsuperannuation.SetAmounttopaid(Const Value :Double    ); begin SetFloatField('Amounttopaid' , Value);End;
procedure Tsuperannuation.SetABN         (const Value :String    ); begin SetStringField('ABN',           Value);end;
procedure Tsuperannuation.SetAccountNumber(const Value:String    ); begin SetStringField('AccountNumber', Value);end;
procedure Tsuperannuation.SetAccountName(const   Value:String    ); begin SetStringField('AccountName',   Value);end;
procedure Tsuperannuation.SetESAA        (const Value :String    ); begin SetStringField('ESAA',          Value);end;
procedure Tsuperannuation.SetBSB         (const Value :String    ); begin SetStringField('BSB',           Value);end;
procedure Tsuperannuation.SetActive      (const Value :Boolean   ); begin SetBooleanField('Active',       Value);end;

procedure Tsuperannuation.UpdateStringField(const sField, sValue: String);
var
  qry: TERPQuery;
  iClientID: Integer;
  sGlobalRef: String;
begin
  qry := TERPQuery.Create(Self);
  try
    qry.Connection := Connection.Connection;

    // Insert client record if it doesn't exist
    iClientID := GetIntegerField('ClientID');
    if (iClientID = 0) then
    begin
      Randomize;
      sGlobalRef := QuotedStr('__REF__' + IntToStr(10000 + Random(9000)));
      qry.SQL.Text := 'INSERT tblClients (GlobalRef) VALUES (' + sGlobalRef + ');' +
        'SELECT ClientID FROM tblClients WHERE GlobalRef = ' + sGlobalRef;
      qry.Open;
      iClientID := qry.Fields[0].AsInteger;
      qry.Close;
      SetIntegerField('ClientId', iClientID);
      qry.SQL.Text :=
        'UPDATE tblClients SET GlobalRef = ' + QuotedStr('DEF' + IntToStr(iClientID)) +
        ' WHERE GlobalRef = ' + sGlobalRef;
      qry.ExecSQL;
    end;

    // Update client record field
    qry.SQL.Text := 'UPDATE tblClients SET ' +
      sField + ' = ' + QuotedStr(sValue) +
      ' WHERE ClientID = ' + IntToStr(iClientID);
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

initialization
  RegisterClassOnce(TSuperannuation);
  // RegisterClassOnce(TSuperannuationEx);

end.
