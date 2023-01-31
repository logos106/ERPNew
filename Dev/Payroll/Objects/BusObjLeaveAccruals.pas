unit BusObjLeaveAccruals;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   16/05/07   1.00.01   RM.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess;


type
   TLeaveAccruals = class(TMSBusObj)
   private
    //  fdYTDLeaveLoading   :double;
      Function GetDate                    :TDatetime ;
      Function GetEmployeeid              :Integer   ;
      Function GetPayid                   :Integer   ;
      Function GetLeavetype               :String    ;
      Function GetAccrualtype             :String    ;
      Function GetAccruedhours            :Double    ;
 {     Function GetYTDLeaveLoading         :Double    ;  }
      Function GetCurrenthourlyrate       :Double    ;
      Function GetEditedbyemployeeid      :Integer   ;
      Function GetLeavetypeid             :Integer   ;
      Function GetPaylineid               :Integer   ;
      Procedure SetDate                    (Const Value :TDatetime );
      Procedure SetEmployeeid              (Const Value :Integer   );
      Procedure SetPayid                   (Const Value :Integer   );
      Procedure SetLeavetype               (Const Value :String    );
      Procedure SetAccrualtype             (Const Value :String    );
      Procedure SetAccruedhours            (Const Value :Double    );
      Procedure SetCurrenthourlyrate       (Const Value :Double    );
      Procedure SetEditedbyemployeeid      (Const Value :Integer   );
      Procedure SetLeavetypeid             (Const Value :Integer   );
      Procedure SetPaylineid               (Const Value :Integer   );

      procedure CallBackUpdateLeaveTaken(const Sender: TBusObj; var Abort: Boolean);
   {   procedure CallbackYTDLeaveLoading(const Sender: TBusObj; var Abort: Boolean);  }
      procedure CallBackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
      procedure CallBackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
    function GetEmployeeName: string;
    function GetPayDeleted: boolean;
    function GetPayPaid: boolean;
    procedure SetEmployeeName(const Value: string);

   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;

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

      Function     GetYTDHrs(const LeaveType:string;AsOfDate:TDateTime):double;
      function     GetAccruedHrs(const LeaveType: string; AsOfDate: TDateTime = 0): double;
      function     GetTotalHrs(const LeaveType: string; AsOfDate: TDateTime): double;
      class function TotalAccruedHours(EmployeeID: integer; LeaveType: string; AsOfDate: TDateTime = 0; Connection: TCustomMyConnection = nil): double;
      function     GetAccruedHrsUpToThisPay(const LeaveType: string): double;
      function     GetThisPayAccruedHrs(const LeaveType: string): double;
      Function     GetLeaveTakenHrs(const LeaveType: string;const AsOfDate: TDateTime): double;
      procedure    UpdateLeaveTaken;
      procedure    PostToAccounts;
      procedure    UnPostToAccounts;
      procedure ZeroOutAccruals;

      Property EditedByEmployeeID       :Integer      Read getEditedbyemployeeid    Write SetEditedbyemployeeid;
      Property LeaveTypeID              :Integer      Read getLeavetypeid           Write SetLeavetypeid       ;
    published
      Property Date                     :TDatetime    Read getDate                  Write SetDate              ;
      property EmployeeName: string read GetEmployeeName write SetEmployeeName;
      Property EmployeeID               :Integer      Read getEmployeeid            Write SetEmployeeid        ;
      Property PayID                    :Integer      Read getPayid                 Write SetPayid             ;
      Property LeaveType                :String       Read getLeavetype             Write SetLeavetype         ;
      Property AccrualType              :String       Read getAccrualtype           Write SetAccrualtype       ;
      Property AccruedHours             :Double       Read getAccruedhours          Write SetAccruedhours      ;
      Property CurrentHourlyRate        :Double       Read getCurrenthourlyrate     Write SetCurrenthourlyrate ;
      Property PayLineID                :Integer      Read getPaylineid             Write SetPaylineid         ;

      property PayPaid: boolean read GetPayPaid;
      property PayDeleted: boolean read GetPayDeleted;
  {    Property YTDLeaveLoading          :double       Read GetYTDLeaveLoading;    }
   End;


implementation

uses SysUtils,BusObjEmployeePay,BusObjPayBase,PayCommon,BusObjpayspayratesBASE,
   CommonLib,DnMLib,AppEnvironment,tcDataUtils, BusObjLeaveTypes,
   ERPDbComponents, CommonDbLib, DateTimeUtils, PayAccounts, DbSharedObjectsObj,
   DateUtils, tcConst, BusObjEmployee, PayConst;


{========================================================
         TLeaveaccruals
========================================================}

procedure TLeaveaccruals.PostToAccounts;
begin
  Self.IterateRecords(CallbackPostToAccounts,False);
end;

procedure TLeaveaccruals.UnPostToAccounts;
begin
  Self.IterateRecords(CallbackUnPostToAccounts,False);
end;


procedure TLeaveaccruals.CallBackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID: integer;
  DebitAccID: integer;
  PostLeave: boolean;
  iDepartmentID:integer;
  Desc: string;
begin
  iDepartmentID := GetEmployeeClass(Tpaybase(Self.Owner).Employeeid);
  if iDepartmentID = 0 then iDepartmentID := Tpaybase(Self.Owner).EmployeeDetails.Defaultclassid;

  if TLeaveaccruals(Sender).Payid <> TpayBase(self.Owner).PayID then exit; //remember this object has ALL accumulations

  DebitAccID := PayAccounts.LeaveProvisionAccountID(Tpaybase(Self.Owner).Employeeid);
  CreditAccID := PayAccounts.LeaveLiabilityAccountID(Tpaybase(Self.Owner).Employeeid);
  if TLeaveaccruals(Sender).Accrualtype = 'Leave Reversal' then
    Desc := TLeaveaccruals(Sender).LeaveType + ' Reversal at ' + FloatToStr(TLeaveaccruals(Sender).Currenthourlyrate)+ ' Hr'
  else
    Desc := TLeaveaccruals(Sender).LeaveType + ' Accrued';
  PostLeave := true;
  if (AccruedHours < 0) and (TLeaveaccruals(Sender).Accrualtype <> 'Leave Reversal') then exit; {if leave taken don't post to accounts here}
  if PostLeave then begin
    Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Accrued Leave" AND MSType = "'+MSType_AccruedLeave+'"' +
                                ' AND Description = '+ QuotedStr(Desc {TLeaveaccruals(Sender).LeaveType + ' Accrued'}) +
                                ' AND PayLineID = ' + IntToStr(PayLineID));

    Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(1,'Payroll Accrued Leave',MSType_AccruedLeave,
                                  Desc{TLeaveaccruals(Sender).LeaveType + ' Accrued'},CreditAccID,
                                  DebitAccID,iDepartmentId,
                                  PayLineID, CommonLib.Round(AccruedHours * (Currenthourlyrate*
                                  (1+Tpaybase(Self.Owner).EmployeeLeave.GetTypeLeaveLoading(TLeaveaccruals(Sender).LeaveType,
                                  Tpaybase(Self.Owner).Employeeid)) ) ,self.CurrencyRoundPlaces), self);
  end;
end;

procedure TLeaveaccruals.CallBackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID: integer;
  DebitAccID: integer;
  PostLeave: boolean;
  iDepartmentID:integer;
  Desc: string;
begin
  iDepartmentID := GetEmployeeClass(Tpaybase(Self.Owner).Employeeid);
  if iDepartmentID = 0 then iDepartmentID := Tpaybase(Self.Owner).EmployeeDetails.Defaultclassid;

  if TLeaveaccruals(Sender).Payid <> TpayBase(self.Owner).PayID then exit; //remember this object has ALL accumulations

  DebitAccID := PayAccounts.LeaveProvisionAccountID(Tpaybase(Self.Owner).Employeeid);
  CreditAccID := PayAccounts.LeaveLiabilityAccountID(Tpaybase(Self.Owner).Employeeid);

  if TLeaveaccruals(Sender).Accrualtype = 'Leave Reversal' then
    Desc := TLeaveaccruals(Sender).LeaveType + ' Reversal at ' + FloatToStr(TLeaveaccruals(Sender).Currenthourlyrate)+ ' Hr'
  else
    Desc := TLeaveaccruals(Sender).LeaveType + ' Accrued';
  PostLeave := true;
  if AccruedHours < 0 then exit; {if leave taken don't post to accounts here}
  if PostLeave then begin
    Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Accrued Leave" AND MSType = "'+MSType_AccruedLeave+'"' +
                                ' AND Description = '+ QuotedStr(Desc {TLeaveaccruals(Sender).LeaveType + ' Accrued'}) +
                                ' AND PayLineID = ' + IntToStr(PayLineID));

    Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(2,'Payroll Accrued Leave',MSType_AccruedLeave,
                                  Desc {TLeaveaccruals(Sender).LeaveType + ' Accrued'},CreditAccID,
                                  DebitAccID,iDepartmentId,
                                  PayLineID, CommonLib.Round(AccruedHours * -1 * (Currenthourlyrate*
                                  (1+Tpaybase(Self.Owner).EmployeeLeave.GetTypeLeaveLoading(TLeaveaccruals(Sender).LeaveType,
                                  Tpaybase(Self.Owner).Employeeid)) ),self.CurrencyRoundPlaces), self);
  end;
end;



Function  TLeaveaccruals.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then begin
      if Self.Owner is Temployeepay then begin
        EmployeeId := Temployeepay(Self.Owner).EmployeePaySettings.Employeeid;
      end;

      if Self.Owner is Tpaybase then begin
        EmployeeId := Tpaybase(Self.Owner).Employeeid;
        PayID := Tpaybase(Self.Owner).PayID;
      end;
    end;
    Result := inherited DoAfterInsert(Sender);
end;  


procedure TLeaveaccruals.UpdateLeaveTaken;
begin
 Tpaybase(Self.Owner).PaysPayRates.AllowRecalc := False;
 Tpaybase(Self.Owner).PaysPayRates.RefreshDB;
 Tpaybase(Self.Owner).PaysPayRates.IterateRecords(CallBackUpdateLeaveTaken,False);
 Tpaybase(Self.Owner).EmployeeLeave.VerifyEmployeeLeave;
 Tpaybase(Self.Owner).PaysPayRates.AllowRecalc := True;
end;

procedure TLeaveaccruals.ZeroOutAccruals;
var
  qry: TERPQuery;
  doReversal: boolean;
  OpeningBalanceYears: double;
begin
  qry := DbSharedObj.GetQuery(self.Connection.Connection);
  try
//    qry.SQL.Add('SELECT L.LeaveType,L.LeaveTypeID, L.CurrentHourlyRate,Sum(L.AccruedHours)+ OpenningBalanceHrs AS Hours');
    qry.SQL.Add('SELECT L.LeaveType,L.LeaveTypeID, L.CurrentHourlyRate,Sum(L.AccruedHours) AS Hours, OpenningBalanceHrs');
    qry.SQL.Add('FROM tblleaveaccruals AS L ');
    qry.SQL.Add('INNER JOIN tblleave AS EL on EL.EmployeeID = L.EmployeeID AND L.LeaveType = EL.Type ');
    qry.SQL.Add('INNER JOIN tblpays AS P on L.PayID = P.PayID ');
    qry.SQL.Add('WHERE P.Deleted = "F" AND L.EmployeeID = ' + IntToStr(TPayBase(Self.Owner).Employeeid));
    qry.SQL.Add('GROUP BY L.LeaveType, L.CurrentHourlyRate');
    qry.Open;
    while not qry.Eof do begin
      doReversal := true;
      if (SameText(qry.FieldByName('LeaveType').AsString, 'Annual Leave') or
          SameText(qry.FieldByName('LeaveType').AsString, 'RDO')) then
        doReversal := false;
      if SameText(qry.FieldByName('LeaveType').AsString, 'Long Service') then begin
        { only reverse long service if employee has not reached required number of years employment }
        OpeningBalanceYears := 0;
        if qry.FieldByName('OpenningBalanceHrs').AsFloat <> 0 then
          OpeningBalanceYears := qry.FieldByName('OpenningBalanceHrs').AsFloat / (24*365);
        if (DateUtils.YearsBetween(Tpaybase(Self.Owner).PayDate, Tpaybase(Self.Owner).EmployeeDetails.DateStarted) + OpeningBalanceYears) >= AppEnv.CompanyPrefs.LSLCommenceYears then
          doReversal := false;
      end;

      if doReversal then begin
        New;
        Accrualtype := 'Leave Reversal';
        Date := Tpaybase(Self.Owner).Paydate;
        Accruedhours := qry.FieldByName('Hours').AsFloat * -1;
        Leavetype := qry.FieldByName('LeaveType').AsString;
        Currenthourlyrate := qry.FieldByName('CurrentHourlyRate').AsFloat;
        Leavetypeid := qry.FieldByName('LeaveTypeID').AsInteger;
        PostDb;
        { update the leave balance .. }
        if TPayBase(Owner).EmployeeLeave.Dataset.Locate('Type',Leavetype,[loCaseInsensitive]) then begin
          TPayBase(Owner).EmployeeLeave.Accruedhours := Round(GetAccruedHrs(LeaveType), GeneralRoundPlaces);
          TPayBase(Owner).EmployeeLeave.PostDb;
        end;
      end;
      qry.Next;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TLeaveaccruals.CallBackUpdateLeaveTaken(const Sender: TBusObj; var Abort: Boolean);
begin
  try
    if IsLeave(TPaysPayRates(Sender).Payrateid) then begin
      New;
      Accrualtype := 'Leave Taken';
      Date := Tpaybase(Self.Owner).Paydate;
      Accruedhours := TPaysPayRates(Sender).Qty * -1;
      Leavetype := PayCommon.GetLeaveType(TPaysPayRates(Sender).PayRateID);
      Currenthourlyrate := Tpaybase(Self.Owner).PaysPayRates.HourlyRate;
      Leavetypeid :=   PayCommon.GetLeaveTypeID(PayCommon.GetLeaveType(TPaysPayRates(Sender).PayRateID));
      PostDb;
    end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;



function TLeaveaccruals.GetTotalHrs(const LeaveType: string;AsOfDate:TDateTime): double;
var
  strsql:string;
begin
  strsql := 'SELECT P.Deleted,P.PayID,L.LeaveType,' +
                ' L.AccruedHours,Sum(L.AccruedHours)+ OpenningBalanceHrs AS Amount ' +
                ' FROM tblleaveaccruals AS L '+
                ' INNER JOIN tblleave AS EL on  EL.EmployeeID =  L.EmployeeID AND L.LeaveType=EL.Type '+
                ' INNER JOIN tblpays AS P on L.PayID = P.PayID '+
                ' WHERE P.Deleted = "F" AND L.EmployeeID = ' + IntToStr({Self.Employeeid}TPayBase(Self.Owner).Employeeid) +                    ' AND P.PayDate <= ' + QuotedStr(DateTimeToMysqlDateStr(AsOfDate)) +
                ' AND L.LeaveType = ' + QuotedStr(LeaveType) +
                ' GROUP BY L.LeaveType';

  With GetNewDataSet(strsql, True) do try
    Result  := fieldByname('Amount').asFloat;
  finally
    if active then close;
    Free;
  end;
end;


function TLeaveaccruals.GetYTDHrs(const LeaveType: string;AsOfDate:TDateTime): double;
var
  strsql:string;         //Taken hours have negative values so will automatically calc
//  dOpenningBalance:double;
begin
//  dOpenningBalance := 0;

 // if Tpaybase(Self.Owner).EmployeeLeave.Dataset.Locate('Type',LeaveType,[loCaseInsensitive]) then
//      dOpenningBalance := Tpaybase(Self.Owner).EmployeeLeave.Openningbalancehrs;

  strsql := 'SELECT P.Deleted,P.PayID,L.LeaveType,L.AccruedHours,' +
                ' Sum(L.AccruedHours) + if(OpenningBalanceDate <= '+QuotedStr(DateTimeToMysqlDateStr(AsOfDate))+
                  ' and OpenningBalanceDate >= '+
                  QuotedStr(DateTimeToMysqlDateStr(datetimeUtils.FiscalYearStart(now , Appenv.CompanyPrefs.FiscalYearStarts)))+
                  ',OpenningBalanceHrs,0) AS Amount ' +
                ' FROM tblleaveaccruals AS L '+
                ' INNER JOIN tblleave AS EL on  EL.EmployeeID =  L.EmployeeID AND L.LeaveType=EL.Type '+
                ' INNER JOIN tblpays AS P on L.PayID = P.PayID '+
                ' WHERE P.Deleted = "F" AND L.EmployeeID = ' + IntToStr({Self.Employeeid}TPayBase(Self.Owner).Employeeid) +
                ' AND P.PayDate <= ' + QuotedStr(DateTimeToMysqlDateStr(AsOfDate)) +
                ' AND P.PayDate >= ' + QuotedStr(DateTimeToMysqlDateStr(datetimeUtils.FiscalYearStart(now , Appenv.CompanyPrefs.FiscalYearStarts))) +
                ' AND L.LeaveType = ' + QuotedStr(LeaveType) +
                ' GROUP BY L.LeaveType';

  With GetNewDataSet(strsql, True) do try
    Result  := fieldByname('Amount').asFloat;
  finally
    if active then close;
    Free;
  end;


//  dOpenningBalance := 0;
//
//  if Tpaybase(Self.Owner).EmployeeLeave.Dataset.Locate('Type',LeaveType,[loCaseInsensitive]) then
//      dOpenningBalance := Tpaybase(Self.Owner).EmployeeLeave.Openningbalancehrs;
//
//  strsql := 'SELECT EmployeeID, Sum(AccruedHours) AS totalAmount FROM tblleaveaccruals' +
//                ' WHERE EmployeeID = ' + IntToStr(Self.Employeeid) +
//                ' AND LeaveType = ' + QuotedStr(LeaveType) +
//                ' AND Date <= ' + QuotedStr(DateTimeToMysqlDateStr(AsOfDate)) +
//                ' GROUP BY EmployeeID;';
//  With GetNewDataSet(strsql, True) do try
//    Result  := fieldByname('totalAmount').asFloat + dOpenningBalance;
//  finally
//    if active then close;
//    Free;
//  end;
end;

Function    TLeaveaccruals.GetThisPayAccruedHrs(const LeaveType:String):double;
var
  strsql:string;
begin
//  strsql := 'SELECT Sum(AccruedHours) as TotalAccruedHrs,LeaveType FROM tblleaveaccruals ' +
//              'WHERE LeaveType = ' + QuotedStr(LeaveType) + ' AND PayID =  ' + IntToStr(Tpaybase(Self.Owner).PayID)  +
//              ' GROUP BY LeaveType';
  strsql:=
    ' SELECT Sum(la.AccruedHours) as TotalAccruedHrs, la.LeaveType' +
    ' FROM tblleaveaccruals la, tblPays p' +
    ' WHERE la.PayId = p.PayID AND p.Deleted = "F"' +
    ' AND la.LeaveType = ' + QuotedStr(LeaveType) +
    ' AND la.PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID)  +
    ' GROUP BY la.LeaveType';
  with GetNewDataSet(strsql, True) do try
    Result := FieldByName('TotalAccruedHrs').AsFloat;
  finally
    if active then close;
    Free;
  end;
end;

Function    TLeaveaccruals.GetAccruedHrsUptoThisPay(const LeaveType:String):double;
var
  strsql:string;
begin
//  strsql := 'SELECT Sum(AccruedHours) as TotalAccruedHrs,LeaveType FROM tblleaveaccruals ' +
//             'WHERE LeaveType = ' + QuotedStr(LeaveType) +
//             ' AND EmployeeID = ' + IntToStr(Self.Employeeid) +
//             ' AND PayID < ' + IntToStr(TPayBase(Self.Owner).PayID) +
//             ' GROUP BY LeaveType';
  strsql:=
    ' SELECT Sum(la.AccruedHours) as TotalAccruedHrs, la.LeaveType' +
    ' FROM tblleaveaccruals la, tblPays p' +
    ' WHERE la.PayId = p.PayID AND p.Deleted = "F"' +
    ' AND la.LeaveType = ' + QuotedStr(LeaveType) +
    ' AND la.EmployeeID = ' + IntToStr(Self.Employeeid) +
    ' AND la.PayID < ' + IntToStr(Tpaybase(Self.Owner).PayID)  +
    ' GROUP BY la.LeaveType';
  with GetNewDataSet(strsql, True) do try
    Result := FieldByName('TotalAccruedHrs').AsFloat;
  finally
    if active then close;
    Free;
  end;
end;


Function    TLeaveaccruals.GetAccruedHrs(const LeaveType:String; AsOfDate: TDateTime = 0):double;
//var
//  strsql:string;
begin
//  strsql:=
//    ' SELECT Sum(la.AccruedHours) as TotalAccruedHrs, la.LeaveType' +
//    ' FROM tblleaveaccruals la, tblPays p' +
//    ' WHERE la.PayId = p.PayID AND p.Deleted = "F"' +
//    ' AND la.LeaveType = ' + QuotedStr(LeaveType) +
//    ' AND la.EmployeeID = ' + IntToStr(Self.Employeeid) +
//    ' GROUP BY la.LeaveType';
//  With GetNewDataSet(strsql, True) do try
//    Result := FieldByName('TotalAccruedHrs').AsFloat;
//  finally
//    if active then close;
//    Free;
//  end;
  result := TotalAccruedHours(Self.Employeeid, LeaveType, AsOfDate, self.Connection.Connection);
end;

class function TLeaveaccruals.TotalAccruedHours(EmployeeID: integer;
  LeaveType: string; AsOfDate: TDateTime = 0; Connection: TCustomMyConnection = nil): double;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection := Connection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text :=
      ' SELECT Sum(la.AccruedHours) as TotalAccruedHrs, la.LeaveType' +
      ' FROM tblleaveaccruals la, tblPays p' +
      ' WHERE la.PayId = p.PayID AND p.Deleted = "F"' +
      ' AND la.LeaveType = ' + QuotedStr(LeaveType) +
      ' AND la.EmployeeID = ' + IntToStr(Employeeid);
    if AsOfDate > 0 then
      qry.SQL.Add('AND P.PayDate <= ' + QuotedStr(DateTimeToMysqlDateStr(AsOfDate)));
    qry.SQL.Add(' GROUP BY la.LeaveType');
    qry.Open;
    result := qry.FieldByName('TotalAccruedHrs').AsFloat;
  finally
    qry.Free;
  end;
end;


Function    TLeaveaccruals.GetLeaveTakenHrs(const LeaveType:String;const AsOfDate: TDateTime):double;
var
  strsql:string;
begin
//  strsql := 'SELECT Sum(AccruedHours) as TotalAccruedHrs,LeaveType FROM tblleaveaccruals ' +
//              'WHERE LeaveType = ' + QuotedStr(LeaveType) + ' AND AccrualType = "Leave Taken" ' +
//              ' AND EmployeeID = ' + IntToStr(Self.Employeeid) +
//              ' GROUP BY AccrualType';
  strsql:=
    ' SELECT Sum(la.AccruedHours) as TotalAccruedHrs, la.LeaveType' +
    ' FROM tblleaveaccruals la, tblPays p' +
    ' WHERE la.PayId = p.PayID AND p.Deleted = "F"' +
    ' AND la.LeaveType = ' + QuotedStr(LeaveType) +
    ' AND AccrualType = "Leave Taken"' +
    ' AND la.EmployeeID = ' + IntToStr(Self.Employeeid) +
    ' AND p.PayDate <= ' + QuotedStr(DateTimeToMysqlDateStr(AsOfDate)) +
    ' GROUP BY la.LeaveType';
  With GetNewDataSet(strsql, True) do try
    Result := FieldByName('TotalAccruedHrs').AsFloat;
  finally
    if active then close;
    Free;    
  end;
end;  


constructor TLeaveaccruals.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblleaveaccruals';
end;


destructor TLeaveaccruals.Destroy;
begin
   inherited;
end;


procedure   TLeaveaccruals.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(Node,'Date');
  SetPropertyFromNode(Node,'Employeeid');
  SetPropertyFromNode(Node,'Payid');
  SetPropertyFromNode(Node,'Leavetype');
  SetPropertyFromNode(Node,'Accrualtype');
  SetPropertyFromNode(Node,'Accruedhours');
  SetPropertyFromNode(Node,'Currenthourlyrate');
  SetPropertyFromNode(Node,'Editedbyemployeeid');
  SetPropertyFromNode(Node,'Leavetypeid');
  SetPropertyFromNode(Node,'Paylineid');
end;


procedure   TLeaveaccruals.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Date' ,Date);
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'Payid' ,Payid);
  AddXMLNode(node,'Leavetype' ,Leavetype);
  AddXMLNode(node,'Accrualtype' ,Accrualtype);
  AddXMLNode(node,'Accruedhours' ,Accruedhours);
  AddXMLNode(node,'Currenthourlyrate' ,Currenthourlyrate);
  AddXMLNode(node,'Editedbyemployeeid' ,Editedbyemployeeid);
  AddXMLNode(node,'Leavetypeid' ,Leavetypeid);
  AddXMLNode(node,'Paylineid' ,Paylineid);
end;


function    TLeaveaccruals.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Date = 0 then begin
      AddResult(False , rssError , 0,  'Date should not be blank' , False );
      Exit;
   end;
   if Employeeid = 0 then begin
      AddResult(False , rssError , 0,  'Employeeid should not be 0' , False );
      Exit;
   end;
   if Payid = 0 then begin
      AddResult(False , rssError , 0,  'Payid should not be 0' , False );
      Exit;
   end;
   if Leavetype = '' then begin
      AddResult(False , rssError , 0,  'Leavetype should not be blank' , False );
      Exit;
   end;
   if Accrualtype = '' then begin
      AddResult(False , rssError , 0,  'Accrualtype should not be blank' , False );
      Exit;
   end;
   if Accruedhours = 0 then begin
      AddResult(False , rssError , 0,  'Accruedhours should not be 0' , False );
      Exit;
   end;
   if Currenthourlyrate = 0 then begin
      AddResult(False , rssError , 0,  'Currenthourlyrate should not be 0' , False );
      Exit;
   end;
   if Leavetypeid = 0 then begin
      AddResult(False , rssError , 0,  'Leavetypeid should not be 0' , False );
      Exit;
   end;
   Result := true;
end;


function    TLeaveaccruals.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TLeaveaccruals.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TLeaveaccruals.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sender.FieldName = 'LeaveType' then begin
    Leavetypeid:= TLeaveTypes.IDToggle(sender.AsString);
  end
  else if Sender.FieldName = 'LeaveTypeID' then begin
    Leavetype:= TLeaveTypes.IDToggle(sender.AsInteger);
  end;
end;


Function TLeaveaccruals.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TLeaveaccruals.GetIDField : String;
begin
   Result := 'Accrualid'
end;
class function TLeaveaccruals.GetBusObjectTablename: string;
begin
  Result := 'tblleaveaccruals';
end;

Function  TLeaveaccruals.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TLeaveaccruals.GetDate              :TDatetime ; begin Result := GetDatetimeField('Date');End;
Function  TLeaveaccruals.GetEmployeeid        :Integer   ; begin Result := GetIntegerField('Employeeid');End;
function TLeaveaccruals.GetEmployeeName: string;
begin
  result := TEmployee.IDToggle(EmployeeID, Connection.Connection);
end;

function TLeaveaccruals.GetPayDeleted: boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(Connection.Connection);
  try
    qry.SQL.Add('select Deleted from tblpays');
    qry.SQL.Add('where PayID = ' + IntToStr(PayID));
    qry.Open;
    result := qry.FieldByName('Deleted').AsBoolean;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

Function  TLeaveaccruals.GetPayid             :Integer   ; begin Result := GetIntegerField('Payid');End;
Function  TLeaveaccruals.GetLeavetype         :String    ; begin Result := GetStringField('Leavetype');End;
Function  TLeaveaccruals.GetAccrualtype       :String    ; begin Result := GetStringField('Accrualtype');End;
Function  TLeaveaccruals.GetAccruedhours      :Double    ; begin Result := GetFloatField('Accruedhours');End;
Function  TLeaveaccruals.GetCurrenthourlyrate :Double    ; begin Result := GetFloatField('Currenthourlyrate');End;
Function  TLeaveaccruals.GetEditedbyemployeeid:Integer   ; begin Result := GetIntegerField('Editedbyemployeeid');End;
Function  TLeaveaccruals.GetLeavetypeid       :Integer   ; begin Result := GetIntegerField('Leavetypeid');End;
Function  TLeaveaccruals.GetPaylineid         :Integer   ; begin Result := GetIntegerField('Paylineid');End;
function TLeaveaccruals.GetPayPaid: boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(Connection.Connection);
  try
    qry.SQL.Add('select Paid from tblpays');
    qry.SQL.Add('where PayID = ' + IntToStr(PayID));
    qry.Open;
    result := qry.FieldByName('Paid').AsBoolean;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

Procedure TLeaveaccruals.SetDate              (Const Value :TDatetime ); begin SetDatetimeField('Date'               , Value);End;
Procedure TLeaveaccruals.SetEmployeeid        (Const Value :Integer   ); begin SetIntegerField('Employeeid'         , Value);End;
procedure TLeaveaccruals.SetEmployeeName(const Value: string);
begin
  EmployeeID := TEmployee.IDToggle(Value,Connection.Connection);
end;

Procedure TLeaveaccruals.SetPayid             (Const Value :Integer   ); begin SetIntegerField('Payid'              , Value);End;
Procedure TLeaveaccruals.SetLeavetype         (Const Value :String    ); begin SetStringField('Leavetype'          , Value);End;
Procedure TLeaveaccruals.SetAccrualtype       (Const Value :String    ); begin SetStringField('Accrualtype'        , Value);End;
Procedure TLeaveaccruals.SetAccruedhours      (Const Value :Double    ); begin SetFloatField('Accruedhours'       , Value);End;
Procedure TLeaveaccruals.SetCurrenthourlyrate (Const Value :Double    ); begin SetFloatField('Currenthourlyrate'  , Value);End;
Procedure TLeaveaccruals.SetEditedbyemployeeid(Const Value :Integer   ); begin SetIntegerField('Editedbyemployeeid' , Value);End;
Procedure TLeaveaccruals.SetLeavetypeid       (Const Value :Integer   ); begin SetIntegerField('Leavetypeid'        , Value);End;
Procedure TLeaveaccruals.SetPaylineid         (Const Value :Integer   ); begin SetIntegerField('Paylineid'          , Value);End;


initialization
RegisterClassOnce(TLeaveAccruals);


end.
