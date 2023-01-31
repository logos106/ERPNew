unit BusObjPayCommissionsBASE;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   16/04/07   1.00.01   A   Initial Version.
   }

               
interface
{$I ERP.inc}

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TPaysCommissionLines = class(TMSBusObj)
  private
    function GetPaycommissionID        : Integer   ;
    function GetSalesCommissionId      : Integer   ;
    function GetCommissionamount       : Double    ;
    procedure SetPaycommissionID        (const Value: Integer   );
    procedure SetSalesCommissionId      (const Value: Integer   );
    procedure SetCommissionamount       (const Value: Double    );
    function getDescription: String;
    procedure setDescription(const Value: String);
    function getDueAmount: Double;
    procedure SetDueAmount(const Value: Double);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterOpen(Sender:TDatasetBusObj) : Boolean;             override;
  public
    function Delete: boolean; override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property PaycommissionID         :Integer     read GetPaycommissionID       write SetPaycommissionID    ;
    property SalesCommissionId       :Integer     read GetSalesCommissionId     write SetSalesCommissionId  ;
    property Commissionamount        :Double      read GetCommissionamount      write SetCommissionamount   ;
    Property DueAmount               :Double      read getDueAmount             Write SetDueAmount;
    Property Description             :String      read getDescription           write setDescription;
  end;

   Tpayscommission = class(TMSBusObj)

   private
      Function GetPayid                  :Integer   ;
      Function GetCommissionid           :Integer   ;
      Function GetGross                  :Double    ;
      Function GetCommissionpercent      :Double    ;
      Function GetNet                    :Double    ;
      Function GetPeriodid               :Integer   ;
      Function GetSuperinc               :Boolean   ;
      Function GetTaxexempt              :Boolean   ;
      Function GetCommissiondesc         :String    ;
      Function GetEmployeeid             :Integer   ;
      Function GetClassID                :Integer   ;
      Function GetClassname              :String    ;
      Function GetTotalNet               :Double    ;
      Function GetTotalGross             :Double    ;
      Function GetTotalBeforeTax         :Double    ;
      Function GetTotalAfterTax          :Double    ;
      Function GetTotalIncludedInSuper   :Double;

      Procedure SetTotalNet               (const Value :Double    );
      Procedure SetTotalGross             (const Value :Double    );
      Procedure SetTotalBeforeTax         (const Value :Double    );
      Procedure SetTotalAfterTax          (const Value :Double    );


      Procedure SetPayid                  (Const Value :Integer   );
      Procedure SetCommissionid           (Const Value :Integer   );
      Procedure SetGross                  (Const Value :Double    );
      Procedure SetCommissionpercent      (Const Value :Double    );
      Procedure SetNet                    (Const Value :Double    );
      Procedure SetPeriodid               (Const Value :Integer   );
      Procedure SetSuperinc               (Const Value :Boolean   );
      Procedure SetTaxexempt              (Const Value :Boolean   );
      Procedure SetCommissiondesc         (Const Value :String    );
      Procedure SetEmployeeid             (Const Value :Integer   );
      Procedure setClassID                (Const Value :Integer   );
      Procedure SetClassname              (Const Value :String    );
      Function  GetTotalTaxable:double;
      Procedure TotalIncludedInSuperCalc(Const Sender: TBusObj; var Abort: boolean);
    function getPaysCommissionLines: TPaysCommissionLines;
    function GetIsManual: boolean;
    procedure SetIsManual(const Value: boolean);


   Protected
      fTotalNet                 :double;
      fTotalGross               :double;
      fTotalBeforeTax           :double;
      fTotalAfterTax            :double;
      fTotalTaxable             :double;
      fTotalIncludedInSuper     :double;

      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      procedure CallbackPostToAccounts(Const Sender: TBusObj; var Abort: boolean);
//      procedure CallbackUnPostToAccounts(Const Sender: TBusObj; var Abort: boolean);

   Public
      procedure DoFieldOnChange(Sender: TField);                           Override;
      function Delete: boolean; override;
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      procedure    PostToAccounts;
//      procedure    UnPostToAccounts;

      Function     DoAfterInsert(Sender :TDatasetBusObj ):Boolean;         Override;
      function     CalcTax: double; virtual;


   Published
      Property Payid                   :Integer      Read getPayid                Write SetPayid            ;
      Property Commissionid            :Integer      Read getCommissionid         Write SetCommissionid     ;
      Property Gross                   :Double       Read getGross                Write SetGross            ;
      Property Commissionpercent       :Double       Read getCommissionpercent    Write SetCommissionpercent;
      Property Net                     :Double       Read getNet                  Write SetNet              ;
      Property Periodid                :Integer      Read getPeriodid             Write SetPeriodid         ;
      Property Superinc                :Boolean      Read getSuperinc             Write SetSuperinc         ;
      Property Taxexempt               :Boolean      Read getTaxexempt            Write SetTaxexempt        ;
      Property Commissiondesc          :String       Read getCommissiondesc       Write SetCommissiondesc   ;
      Property Employeeid              :Integer      Read getEmployeeid           Write SetEmployeeid       ;
      Property Classid                 :Integer      Read GetClassID              Write setClassID          ;
      Property DepartmentName          :String       Read getClassname            Write SetClassname        ;

      property TotalNet                 :double         read GetTotalNet        write SetTotalNet;
      property TotalGross               :double         read GetTotalGross      write SetTotalGross;
      property TotalBeforeTax           :double         read GetTotalBeforeTax  write SetTotalBeforeTax;
      property TotalAfterTax            :double         read GetTotalAfterTax   write SetTotalAfterTax;
      property TotalTaxableCommission   :double         read GetTotalTaxable    ;
      property TotalIncludedInSuper     :double         read GetTotalIncludedInSuper;
      Property PaysCommissionLines      : TPaysCommissionLines read getPaysCommissionLines;
      property IsManual: boolean read GetIsManual write SetIsManual;
   End;


implementation

uses
  BusObjPaybase,BusObjConst,AppEnvironment,SysUtils, CommonLib,
  tcDataUtils, BusobjSalesCommission, BusObjClass, PayPreferencesObj,
  PayAccounts, PayConst;


{TPaysCommissionLines}

constructor TPaysCommissionLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PaysCommissionLines';
  fSQL := 'SELECT * FROM tblpayscommissionlines';
end;


destructor TPaysCommissionLines.Destroy;
begin
  inherited;
end;


procedure TPaysCommissionLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PaycommissionID');
  SetPropertyFromNode(node,'SalesCommissionId');
  SetPropertyFromNode(node,'Commissionamount');
  SetPropertyFromNode(node,'DueAmount');
  SetPropertyFromNode(node, 'Description');
end;


procedure TPaysCommissionLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PaycommissionID' ,PaycommissionID);
  AddXMLNode(node,'SalesCommissionId' ,SalesCommissionId);
  AddXMLNode(node,'Commissionamount' ,Commissionamount);
  AddXMLNode(node,'DueAmount' ,DueAmount);
  AddXMLNode(node,'Description', Description);
end;


function TPaysCommissionLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if PaycommissionID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PaycommissionID should not be 0' , False );
    Exit;
  end;
  if SalesCommissionId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SalesCommissionId should not be 0' , False );
    Exit;
  end;
  if Commissionamount = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Commissionamount should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TPaysCommissionLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPaysCommissionLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPaysCommissionLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPaysCommissionLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPaysCommissionLines.GetIDField: string;
begin
  Result := 'PayCommissionLineID'
end;


class function TPaysCommissionLines.GetBusObjectTablename: string;
begin
  Result:= 'tblpayscommissionlines';
end;


function TPaysCommissionLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  SendEvent(BusObjEvent_Change,BusObjEvent_TotalsChanged, self);  
end;


{Property Functions}
function  TPaysCommissionLines.GetPaycommissionID    : Integer   ; begin Result := GetIntegerField('PaycommissionID');end;
function  TPaysCommissionLines.GetSalesCommissionId  : Integer   ; begin Result := GetIntegerField('SalesCommissionId');end;
function  TPaysCommissionLines.GetCommissionamount   : Double    ; begin Result := GetFloatField('Commissionamount');end;
function  TPaysCommissionLines.GetDueAmount          : Double    ; begin Result := GetFloatField('DueAmount');end;
procedure TPaysCommissionLines.SetPaycommissionID    (const Value: Integer   ); begin SetIntegerField('PaycommissionID'     , Value);end;
procedure TPaysCommissionLines.SetSalesCommissionId  (const Value: Integer   ); begin SetIntegerField('SalesCommissionId'   , Value);end;
procedure TPaysCommissionLines.SetCommissionamount   (const Value: Double    ); begin SetFloatField('Commissionamount'    , Value);end;
procedure TPaysCommissionLines.SetDueAmount   (const Value: Double    ); begin SetFloatField('DueAmount'    , Value);end;


{========================================================
         Tpayscommission
========================================================}
constructor Tpayscommission.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblpayscommission';
end;


destructor Tpayscommission.Destroy;
begin
   inherited;
end;

function Tpayscommission.CalcTax:double;
begin
  Result := 0;  { virtual }
end;

Function  Tpayscommission.GetTotalIncludedInSuper:double;
begin
  fTotalIncludedInSuper := 0;
  Self.IterateRecords(TotalIncludedInSuperCalc);
  Result := fTotalIncludedInSuper;
end;


Procedure TPaysCommission.TotalIncludedInSuperCalc(Const Sender: TBusObj; var Abort: boolean);
begin
  if SuperInc then fTotalIncludedInSuper :=  fTotalIncludedInSuper + TPaysCommission(Sender).gross;
end;

Function  Tpayscommission.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    IsManual:= true;
    if Assigned(Self.Owner) then
        if Self.Owner is Tpaybase then begin
          PayId := Tpaybase(Self.Owner).ID;
          EmployeeID := Tpaybase(Self.Owner).Employeeid;
          DepartmentName := Tpaybase(Self.Owner).EmployeeDetails.Defaultclassname;
        end;
    Result := True;
end;

procedure Tpayscommission.CallbackPostToAccounts(Const Sender: TBusObj; var Abort: boolean);
var
  CreditAccID: integer;
  DebitAccID: integer;
begin
  DebitAccID := PayAccounts.CommissionPaidAccountID(Tpaybase(Self.Owner).Employeeid); //  GrossWagesAccountID;
  CreditAccID := PayAccounts.BankAccountID(Tpaybase(Self.Owner).Employeeid);

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Commissions" AND MSType = "'+MSType_Commissions+'"' +
                                ' AND Description = '+ QuotedStr('Commission - '+ Commissiondesc) +
                                ' AND PayLineID = ' + IntToStr(ID));

  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(5,'Payroll Commissions',MSType_Commissions,
                                'Commission - ' + Commissiondesc,CreditAccID,
                                DebitAccID,ClassID, ID,Gross - TPaybase(Self.Owner).PayTotals.TaxableTotals.TotalTaxForRateAndLineID('Commission',self.ID), self);

end;

procedure Tpayscommission.PostToAccounts;
begin
  Self.IterateRecords(CallbackPostToAccounts);
end;

//procedure Tpayscommission.UnPostToAccounts;
//begin
//  Self.IterateRecords(CallbackUnPostToAccounts);
//end;


procedure   Tpayscommission.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Payid');
  SetPropertyFromNode(Node,'Commissionid');
  SetPropertyFromNode(Node,'Gross');
  SetPropertyFromNode(Node,'Commissionpercent');
  SetPropertyFromNode(Node,'Net');
  SetPropertyFromNode(Node,'Periodid');
  SetBooleanPropertyFromNode(Node,'Superinc');
  SetBooleanPropertyFromNode(Node,'Taxexempt');
  SetPropertyFromNode(Node,'Commissiondesc');
  SetPropertyFromNode(Node,'Employeeid');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'Classname');
  SetBooleanPropertyFromNode(Node, 'IsManual');
end;


procedure   Tpayscommission.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Payid' ,Payid);
  AddXMLNode(node,'Commissionid' ,Commissionid);
  AddXMLNode(node,'Gross' ,Gross);
  AddXMLNode(node,'Commissionpercent' ,Commissionpercent);
  AddXMLNode(node,'Net' ,Net);
  AddXMLNode(node,'Periodid' ,Periodid);
  AddXMLNode(node,'Superinc' ,Superinc);
  AddXMLNode(node,'Taxexempt' ,Taxexempt);
  AddXMLNode(node,'Commissiondesc' ,Commissiondesc);
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Classname' ,DepartmentName);
  AddXMLNode(node,'IsManual' ,IsManual);
end;


function    Tpayscommission.ValidateData :Boolean ;
var
  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Commissiondesc = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PayCommissions_Err_NoDescription,  'Description should not be blank'  );
        Exit;
     end;
     if Gross = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayCommissions_Err_NoGross,  'Gross should not be 0'  );
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PayCommissions_Err_NoDepartment,  'Department name should not be blank' );
        Exit;
     end;
     Result := true;
   Finally
    If not Result then Begin
      tmpResultStatus := ResultStatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedCommissionValidateData);
    end;
   end;
end;

function    Tpayscommission.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;

procedure Tpayscommission.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
   //PaysCommissionLines;
end;

procedure Tpayscommission.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
   inherited;
  if Sysutils.SameText(Sender.FieldName , 'ClassName') then begin
    //ClassID := tcDatautils.GetDeptID(DepartmentName);
    ClassID:= TDeptClass.IDToggle(DepartmentName);
  end
  else if Sysutils.SameText(Sender.FieldName , 'ClassID') then begin
    DepartmentName:= TDeptClass.IDToggle(ClassID);
  end
  else if (Sysutils.SameText(Sender.FieldName , 'Gross'))
    or  (Sysutils.SameText(Sender.FieldName , 'CommPeriod'))
    or  (Sysutils.SameText(Sender.FieldName , 'PeriodID'))
    or  (Sysutils.SameText(Sender.FieldName , 'SuperInc'))
    or  (Sysutils.SameText(Sender.FieldName , 'TaxExempt')) then begin
    if PeriodID = 0 then exit;
    PostDb;
    Tpaybase(Self.Owner).recalcAll;
  end;
end;

Function Tpayscommission.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;

class function  Tpayscommission.GetIDField : String;
begin
   Result := 'Paycommissionid'
end;

class function Tpayscommission.GetBusObjectTablename: string;
begin
  Result := 'tblpayscommission';
end;

Function  Tpayscommission.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

{Property functions}
Function  Tpayscommission.GetPayid            :Integer   ; begin Result := GetIntegerField('Payid');End;
Function  Tpayscommission.GetCommissionid     :Integer   ; begin Result := GetIntegerField('Commissionid');End;
Function  Tpayscommission.GetGross            :Double    ; begin Result := GetFloatField('Gross');End;
Function  Tpayscommission.GetCommissionpercent:Double    ; begin Result := GetFloatField('Commissionpercent');End;
Function  Tpayscommission.GetNet              :Double    ; begin Result := GetFloatField('Net');End;
Function  Tpayscommission.GetPeriodid         :Integer   ; begin Result := GetIntegerField('Periodid');End;
Function  Tpayscommission.GetSuperinc         :Boolean   ; begin Result := GetBooleanField('Superinc');End;
Function  Tpayscommission.GetTaxexempt        :Boolean   ; begin Result := GetBooleanField('Taxexempt');End;
Function  Tpayscommission.GetCommissiondesc   :String    ; begin Result := GetStringField('Commissiondesc');End;
Function  Tpayscommission.GetEmployeeid       :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  Tpayscommission.GetClassID          :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  Tpayscommission.GetClassname        :String    ; begin Result := GetStringField('Classname');End;
Procedure Tpayscommission.SetPayid            (Const Value :Integer   ); begin SetIntegerField('Payid'             , Value);End;
Procedure Tpayscommission.SetCommissionid     (Const Value :Integer   ); begin SetIntegerField('Commissionid'      , Value);End;
Procedure Tpayscommission.SetGross            (Const Value :Double    ); begin SetFloatField('Gross'             , Value);End;
Procedure Tpayscommission.SetCommissionpercent(Const Value :Double    ); begin SetFloatField('Gross'             , Value);End;
Procedure Tpayscommission.SetNet              (Const Value :Double    ); begin SetFloatField('Net'               , Value);End;
Procedure Tpayscommission.SetPeriodid         (Const Value :Integer   ); begin SetIntegerField('Periodid'          , Value);End;
Procedure Tpayscommission.SetSuperinc         (Const Value :Boolean   ); begin SetBooleanField('Superinc'          , Value);End;
Procedure Tpayscommission.SetTaxexempt        (Const Value :Boolean   ); begin SetBooleanField('Taxexempt'         , Value);End;
Procedure Tpayscommission.SetCommissiondesc   (Const Value :String    ); begin SetStringField('Commissiondesc'    , Value);End;
Procedure Tpayscommission.SetEmployeeid       (Const Value :Integer   ); begin SetIntegerField('Employeeid'        , Value);End;
Procedure Tpayscommission.setClassID          (Const Value :Integer   ); begin SetIntegerField('Classid'           , Value);End;
Procedure Tpayscommission.SetClassname        (Const Value :String    ); begin SetStringField('Classname'         , Value);End;



Procedure TPaysCommission.SetTotalNet(const Value:double);
begin
  fTotalNet := Value;
end;

//Procedure TPaysCommission.GetTotalNetCalc(Const Sender: TBusObj; var Abort: boolean);
//begin
//  fTotalNet :=  fTotalNet +TPaysCommission(Sender).net;
//end;

//Procedure TPaysCommission.GetTotalTaxableCalc(Const Sender: TBusObj; var Abort: boolean);
//begin
//  if not TaxExempt then fTotalTaxable :=  fTotalTaxable + TPaysCommission(Sender).gross;
//end;

//Procedure TPaysCommission.GetTotalGrossCalc(Const Sender: TBusObj; var Abort: boolean);
//begin
//  fTotalGross :=  fTotalGross +TPaysCommission(Sender).gross;
//end;

//Procedure TPaysCommission.GetTotalBeforeTaxCalc(Const Sender: TBusObj; var Abort: boolean);
//begin
//  fTotalBeforeTax :=  fTotalBeforeTax +TPaysCommission(Sender).gross;
//end;

//Procedure TPaysCommission.GetTotalAfterTaxCalc(Const Sender: TBusObj; var Abort: boolean);
//begin
//  fTotalAfterTax :=  fTotalAfterTax + TPaysCommission(Sender).net;
//end;



Function TPaysCommission.GetTotalTaxable:double;
var
  strsql:string;
begin
  fTotalTaxable :=  0;
  strsql := 'SELECT PayID,TaxExempt, Sum(Gross) AS totalAmount FROM tblpaysCommission' +
            ' WHERE PayID = ' + IntToStr(PayID) +
            ' AND TaxExempt = "F" ' +
            ' GROUP BY PayID;';
  With GetNewDataSet(strsql, True) do try
    fTotalTaxable  := fieldByname('totalAmount').asFloat;
  finally
    if active then close;
    Free;
  end;
  result := fTotalTaxable;
end;

function TPaysCommission.GetTotalNet:double;
var
  strsql:string;
begin
  fTotalNet := 0;
  strsql := 'SELECT PayID, Sum(Net) AS totalAmount FROM tblpaysCommission' +
            ' WHERE PayID = ' + IntToStr(PayID) +
            ' GROUP BY PayID;';
  With GetNewDataSet(strsql, True) do try
    fTotalNet  := fieldByname('totalAmount').asFloat;
  finally
    if active then close;
    Free;
  end;
  result :=fTotalNet ;
end;

Function TPaysCommission.GetTotalGross :Double ;
var
  strsql:string;
begin
  fTotalGross := 0;
  strsql := 'SELECT PayID, Sum(Gross) AS totalAmount FROM tblpaysCommission' +
            ' WHERE PayID = ' + IntToStr(PayID) +
            ' GROUP BY PayID;';
  With GetNewDataSet(strsql, True) do try
    fTotalGross  := fieldByname('totalAmount').asFloat;
  finally
    if active then close;
    Free;
  end;
  result := fTotalGross;
end;

Function TPaysCommission.GetTotalBeforeTax :Double ;
var
  strsql:string;
begin
  fTotalBeforeTax := 0;
  strsql := 'SELECT PayID, Sum(Gross) AS totalAmount FROM tblpaysCommission' +
            ' WHERE PayID = ' + IntToStr(PayID) +
            ' AND TaxExempt = "F" ' +
            ' GROUP BY PayID;';
  With GetNewDataSet(strsql, True) do try
    fTotalBeforeTax  := fieldByname('totalAmount').asFloat;
  finally
    if active then close;
    Free;
  end;
  Result := fTotalBeforeTax;
end;

Function TPaysCommission.GetTotalAfterTax :Double ;
var
  strsql:string;
begin
  fTotalAfterTax := 0;
  strsql := 'SELECT PayID, Sum(Gross) AS totalAmount FROM tblpaysCommission' +
            ' WHERE PayID = ' + IntToStr(PayID) +
            ' AND TaxExempt = "T" ' +
            ' GROUP BY PayID;';
  With GetNewDataSet(strsql, True) do try
    fTotalAfterTax  := fieldByname('totalAmount').asFloat;
  finally
    if active then close;
    Free;
  end;
  Result := fTotalAfterTax;
end;




//Function TPaysCommission.GetTotalTaxable:double;
//begin
//  fTotalTaxable :=  0;
//  Self.IterateRecords(GetTotalTaxableCalc);
//  result := fTotalTaxable;
//end;
//
//function TPaysCommission.GetTotalNet:double;
//begin
//  fTotalNet := 0;
//  Self.IterateRecords(GetTotalNetCalc);
//  result :=fTotalNet ;
//end;
//
//Function TPaysCommission.GetTotalGross :Double ;
//begin
//  fTotalGross := 0;
//  Self.IterateRecords(GetTotalGrossCalc);
//  result := fTotalGross;
//end;
//
//Function TPaysCommission.GetTotalBeforeTax :Double ;
//begin
//  fTotalBeforeTax := 0;
//  Self.IterateRecords(GetTotalBeforeTaxCalc);
//  Result := fTotalBeforeTax;
//end;
//
//Function TPaysCommission.GetTotalAfterTax :Double ;
//begin
//  fTotalAfterTax := 0;
//  Self.IterateRecords(GetTotalAfterTaxCalc);
//  Result := fTotalAfterTax;
//end;

Procedure TPaysCommission.SetTotalAfterTax(const Value:double);
begin
  fTotalAfterTax := Value;
end;

Procedure TPaysCommission.SetTotalBeforeTax(const Value:double);
begin
  fTotalBeforeTax := Value;
end;

Procedure TPaysCommission.SetTotalGross(const Value:double);
begin
  fTotalGross := Value;
end;


//Procedure TPaysCommission.GetTotalNetCalc(Const Sender: TBusObj; var Abort: boolean);
//begin
//  fTotalNet :=  fTotalNet +TPaysCommission(Sender).net;
//end;

//Procedure TPaysCommission.GetTotalGrossCalc(Const Sender: TBusObj; var Abort: boolean);
//begin
//  fTotalGross :=  fTotalGross +TPaysCommission(Sender).gross;
//end;

//Procedure TPaysCommission.GetTotalBeforeTaxCalc(Const Sender: TBusObj; var Abort: boolean);
//begin
//  fTotalBeforeTax :=  fTotalBeforeTax +TPaysCommission(Sender).gross;
//end;

//Procedure TPaysCommission.GetTotalAfterTaxCalc(Const Sender: TBusObj; var Abort: boolean);
//begin
//  fTotalAfterTax :=  fTotalAfterTax +TPaysCommission(Sender).net;
//end;

//function TPaysCommission.GetTotalNet:double;
//begin
//  fTotalNet := 0;
//  Self.IterateRecords(GetTotalNetCalc);
//  result :=fTotalNet ;
//end;

//Function TPaysCommission.GetTotalGross :Double ;
//begin
//  fTotalGross := 0;
//  Self.IterateRecords(GetTotalGrossCalc);
//  result := fTotalGross;
//end;

//Function TPaysCommission.GetTotalBeforeTax :Double ;
//begin
//  fTotalBeforeTax := 0;
//  Self.IterateRecords(GetTotalBeforeTaxCalc);
//  Result := fTotalBeforeTax;
//end;
//
//Function TPaysCommission.GetTotalAfterTax :Double ;
//begin
//  fTotalAfterTax := 0;
//  Self.IterateRecords(GetTotalAfterTaxCalc);
//  Result := fTotalAfterTax;
//end;
//
//Procedure TPaysCommission.SetTotalAfterTax(const Value:double);
//begin
//  fTotalAfterTax := Value;
//end;
//
//Procedure TPaysCommission.SetTotalBeforeTax(const Value:double);
//begin
//  fTotalBeforeTax := Value;
//end;
//
//Procedure TPaysCommission.SetTotalGross(const Value:double);
//begin
//  fTotalGross := Value;
//end;
//
//
//
//



function Tpayscommission.getPaysCommissionLines: TPaysCommissionLines;
begin
    Result := TPaysCommissionLines(getContainerComponent(TPaysCommissionLines , 'PaycommissionID = ' + IntToStr(ID)))
end;

function Tpayscommission.Delete: boolean;
begin
  PaysCommissionLines.deleteall;
  result := inherited Delete;
end;

function TPaysCommissionLines.Delete: boolean;
begin
  result :=   inherited delete ;
  (*With Tsalescommission.create(Self) do try
    connection :=self.connection;
    Load(SalesCommissionId);
    if count = 0 then exit; {this shouldn't happen as the commission is always comming from the sales commission table }
    AmountPaid := AmountPaid -Commissionamount;
    PostDB;
  finally
    Free;
  end;*)
end;

function TPaysCommissionLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Self.Owner) then
    if self.owner is Tpayscommission then
      PaycommissionID :=Tpayscommission(Self.Owner).ID;
end;

function TPaysCommissionLines.getDescription: String;
begin
  Result := GetStringField('Description');
end;

procedure TPaysCommissionLines.setDescription(const Value: String);
begin
  SetStringField('Description', value);
end;

function TPaysCommissionLines.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then exit;
  if Dataset.findfield('Commissionamount') <> nil then
    TFloatField(Dataset.findfield('Commissionamount')).currency := True;
  if Dataset.findfield('DueAmount') <> nil then
    TFloatField(Dataset.findfield('DueAmount')).currency := True;
end;


function Tpayscommission.GetIsManual: boolean;
begin
  result:= GetBooleanField('IsManual');
end;

procedure Tpayscommission.SetIsManual(const Value: boolean);
begin
  SetBooleanField('IsManual',Value);
end;

initialization
RegisterClassOnce(Tpayscommission);
RegisterClass(TPaysCommissionLines);

end.
