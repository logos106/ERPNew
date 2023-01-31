unit BusObjEmployeepayrates;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   08/05/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjPayrate;


type
   TEmployeepayrates = class(TMSBusObj)
   private
      fdStandardHrs                   :double;
  //    fEmployeeDetails:Temployeedetails;
      fdHighestStandardHourlyRate     :double;
      fbSuperOnStandardRate           :boolean;
      fdTotalWages                    :double;
      Function GetEmployeeid          :Integer   ;
      Function GetPayrateid           :Integer   ;
      Function GetTypeid              :Integer   ;
      Function GetQty                 :Double    ;
      Function GetAmount              :Double    ;
      Function GetSuper               :Boolean   ;
      Function GetClientid            :Integer   ;
      Function GetClassID             :Integer   ;
      Function GetHourlyrate          :Double    ;
      Function GetLinetotal           :Double    ;
      Function GetClassname           :String    ;
      Procedure SetEmployeeid          (Const Value :Integer   );
      Procedure SetPayrateid           (Const Value :Integer   );
      Procedure SetTypeid              (Const Value :Integer   );
      Procedure SetQty                 (Const Value :Double    );
      Procedure SetAmount              (Const Value :Double    );
      Procedure SetSuper               (Const Value :Boolean   );
      Procedure SetClientid            (Const Value :Integer   );
      Procedure setClassID             (Const Value :Integer   );
      Procedure SetHourlyrate          (Const Value :Double    );
      Procedure SetLinetotal           (Const Value :Double    );
      Procedure SetClassname           (Const Value :String    );

      Function GetTotalStandardHrs     :Double;
      function GetSuperOnStandardPayRate:Boolean;
      Function GetHighestStandardHourlyRate :Double;
      Function GetTotalWages :Double;

      procedure CallbackStandardHrs(const Sender: TBusObj; var Abort: Boolean);
      procedure CallBackStandardHourlyRate(const Sender: TBusObj; var Abort: Boolean);
      procedure CallBackHourlyRates(const Sender: TBusObj; var Abort: Boolean);
      procedure CallTotalWages(const Sender: TBusObj; var Abort: Boolean);
      procedure CallBackSuperOnStandardPayRate(const Sender: TBusObj; var Abort: Boolean);
      procedure UpdateHourlyRates;


   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
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


      Property Employeeid           :Integer      Read getEmployeeid        Write SetEmployeeid    ;
      Property Payrateid            :Integer      Read getPayrateid         Write SetPayrateid     ;
      Property Typeid               :Integer      Read getTypeid            Write SetTypeid        ;
      Property Qty                  :Double       Read GetQty               Write SetQty           ;
      Property Amount               :Double       Read getAmount            Write SetAmount        ;
      Property Super                :Boolean      Read getSuper             Write SetSuper         ;
      Property Clientid             :Integer      Read getClientid          Write SetClientid      ;
      Property Classid              :Integer      Read GetClassID           Write setClassID       ;
      Property Hourlyrate           :Double       Read getHourlyrate        Write SetHourlyrate    ;
      Property Linetotal            :Double       Read getLinetotal         Write SetLinetotal     ;
      Property DepartmentName       :String       Read getClassname         Write SetClassname     ;

      Property TotalStandardHrs     :Double       Read GetTotalStandardHrs;
      Property HighestStandardHourlyRate: Double  Read GetHighestStandardHourlyRate;
      Property TotalWages     :Double       Read GetTotalWages;
      property SuperOnStandardPayRate :boolean        Read GetSuperOnStandardPayRate ;
   End;


implementation


uses CommonLib,PayCommon,sysUtils,BusObjEmployeePay,BusObjConst,
  tcDataUtils,DnMLib;


{========================================================
         TEmployeepayrates
========================================================}
constructor TEmployeepayrates.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblemployeepayrates';
end;



destructor TEmployeepayrates.Destroy;
begin
   inherited;
end;

Function  TEmployeepayrates.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
  if Assigned(Self.Owner) then
    if Self.Owner is TEmployeePay then begin
      EmployeeId := Temployeepay(Self.Owner).EmployeeDetails.Id;  //EmployeePaySettings.Employeeid;
      DepartmentName := Temployeepay(Self.Owner).EmployeeDetails.Defaultclassname;
      ClassID := GetDeptID(DepartmentName);
    end;
    Result := inherited DoAfterInsert(Sender);
end;


function TEmployeepayrates.GetTotalStandardHrs:double;
begin
  fdStandardHrs := 0;
  Self.Dataset.Filter := ForeignKeyFilter('PayRateID', 'RateID', 'tblpayrates', 'Multiplier:IsLeave', '1:F');
  Self.Dataset.Filtered := True;
  Self.IterateRecords(CallBackStandardHrs,False);
  Self.Dataset.Filtered := False;
  result := fdStandardHrs;
end;

function TEmployeepayrates.GetHighestStandardHourlyRate:double;
begin
  fdHighestStandardHourlyRate := 0;
  Self.IterateRecords(CallBackStandardHourlyRate,False);
  result := fdHighestStandardHourlyRate;
end;

function TEmployeepayrates.GetSuperOnStandardPayRate:Boolean;
begin
  fbSuperOnStandardRate := False;
  Self.IterateRecords(CallBackSuperOnStandardPayRate,False);
  result := fbSuperOnStandardRate;
end;

procedure TEmployeepayrates.CallBackSuperOnStandardPayRate(const Sender: TBusObj; var Abort: Boolean);
begin
  if (TypeID = GetPayRateTypeID('Hourly Rate')) or (TypeID = GetPayRateTypeID('CDEP')) then begin
    if PayRateID = PayCommon.GetPayRateID('Normal Hours') then begin
      if Super = True then fbSuperOnStandardRate := True;
    end;
  end;  
end;


procedure TEmployeepayrates.CallbackStandardHrs(const Sender: TBusObj; var Abort: Boolean);
begin
  fdStandardHrs := fdStandardHrs +  Qty;
end;

procedure TEmployeepayrates.CallBackStandardHourlyRate(const Sender: TBusObj; var Abort: Boolean);
begin
  if (TypeID = GetPayRateTypeID('Hourly Rate')) or (TypeID = GetPayRateTypeID('CDEP')) then begin
    if PayRateID = PayCommon.GetPayRateID('Normal Hours') then begin
      if HourlyRate > fdHighestStandardHourlyRate then fdHighestStandardHourlyRate := HourlyRate;
    end;
  end else begin  // salary or payout
    if DivZer(Amount,Qty) > fdHighestStandardHourlyRate then fdHighestStandardHourlyRate := DivZer(Amount,Qty);
  end;
end;

procedure TEmployeepayrates.CallBackHourlyRates(const Sender: TBusObj; var Abort: Boolean);
begin
  if (PayRateID <> PayCommon.GetPayRateID('Normal Hours'))
    and (TypeID <> GetPayRateTypeID('Salary'))
    and (TypeID <> GetPayRateTypeID('Annual Payment'))  then begin
      HourlyRate := RoundCurrency(GetPayRateMultiplier(PayRateID) *  HighestStandardHourlyRate);
      Amount := RoundCurrency(HourlyRate * Qty);
      LineTotal := Amount;
  end;
end;

procedure   TEmployeepayrates.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Employeeid');
  SetPropertyFromNode(Node,'Payrateid');
  SetPropertyFromNode(Node,'Typeid');
  SetPropertyFromNode(Node,'Qty');
  SetPropertyFromNode(Node,'Amount');
  SetBooleanPropertyFromNode(Node,'Super');
  SetPropertyFromNode(Node,'Clientid');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'Hourlyrate');
  SetPropertyFromNode(Node,'Linetotal');
  SetPropertyFromNode(Node,'Classname');
end;


procedure   TEmployeepayrates.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'Payrateid' ,Payrateid);
  AddXMLNode(node,'Typeid' ,Typeid);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Super' ,Super);
  AddXMLNode(node,'Clientid' ,Clientid);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Hourlyrate' ,Hourlyrate);
  AddXMLNode(node,'Linetotal' ,Linetotal);
  AddXMLNode(node,'Classname' ,DepartmentName);
end;

function TEmployeepayrates.ValidateData :Boolean ;
//var
//  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Employeeid = 0 then begin
        Resultstatus.AddItem(False , rssError , 0,  'Employeeid should not be 0'  );
        Exit;
     end;
     if Payrateid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_NoRate,  'Pay rate should not be blank');
        SendEvent(IntToStr(BOR_EmployeePay_Err_NoRate),BusobjEventVal_FailedHoursValidateData);
        Exit;
     end;
     if Typeid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_NoType,  'Type should not be blank');
        SendEvent(IntToStr(BOR_EmployeePay_Err_NoType),BusobjEventVal_FailedHoursValidateData);
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_NoDepartment,  'Department name should not be blank' );
        SendEvent(IntToStr(BOR_EmployeePay_Err_NoDepartment),BusobjEventVal_FailedHoursValidateData);
        Exit;
     end;
     Result := true;
   Finally
//    If not Result then Begin
//      tmpResultStatus := ResultStatus.GetLastStatusItem;
//      if Assigned(tmpResultStatus) then
//        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedHoursValidateData);
//    end;
   end;
end;


function TEmployeepayrates.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
   PostDb;   
end;


procedure TEmployeepayrates.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;

procedure TEmployeepayrates.UpdateHourlyRates;
begin
  Self.IterateRecords(CallbackHourlyRates);
end;


procedure TEmployeepayrates.DoFieldOnChange(Sender: TField);
var
  iPeriod:integer;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if TemployeePay(Self.Owner).AddingAwardRate then exit;
  if PayRateID = 0 then exit;
  if TypeID = 0 then exit;

  if Sysutils.SameText(Sender.FieldName , 'Classname') then begin
    ClassID := tcDatautils.GetDeptID(DepartmentName);
  end;
  if (Sysutils.SameText(Sender.FieldName , 'Qty')) or (Sysutils.SameText(Sender.FieldName , 'PayRateID'))
    or (Sysutils.SameText(Sender.FieldName , 'TypeID')) or (Sysutils.SameText(Sender.FieldName , 'HourlyRate')) then begin
      if  TypeID = GetPayRateTypeID('Annual Payment') then begin
        if Temployeepay(Self.Owner).EmployeeDetails.Payperiod = 'Weekly' then begin
          iPeriod := 52;
        end else if Temployeepay(Self.Owner).EmployeeDetails.Payperiod = 'Fortnightly' then begin
          iPeriod := 26;
        end else if Temployeepay(Self.Owner).EmployeeDetails.Payperiod = 'Monthly' then begin
          iPeriod := 12;
        end else if Temployeepay(Self.Owner).EmployeeDetails.Payperiod = 'Bi-Monthly' then begin
          iPeriod := 24;
        end else begin
          iPeriod := 52;
        end;
        HourlyRate := RoundCurrency(Divzer(Amount,iPeriod));
        LineTotal  := RoundCurrency(Amount);
      end else if (TypeID = GetPayRateTypeID('Salary')) then begin
//        if Sysutils.SameText(Sender.FieldName , 'HourlyRate') then Amount := HourlyRate;
        Amount := HourlyRate;

        LineTotal := RoundCurrency(Amount * Qty);
        Amount := LineTotal;
      end else begin
        if (PayRateID = (PayCommon.GetPayRateID('Normal Hours')))
          and (TypeID = GetPayRateTypeID('Hourly Rate'))
          or (TypeID = GetPayRateTypeID('CDEP'))   then begin
            LineTotal := RoundCurrency(HourlyRate * Qty);
            Amount    := LineTotal;
            if Sysutils.SameText(Sender.FieldName , 'HourlyRate') then UpdateHourlyRates ; 
        end else begin
          if (TypeID <> GetPayRateTypeID('Piece-Rate')) then begin   
            if PayRateID <> 2 then begin  //unless normal hrs, set the hourly rate back to normal rate by multiplier
              HourlyRate := GetPayRateMultiplier(PayRateID) *  HighestStandardHourlyRate;
            end;
          end;
          Amount := RoundCurrency(HourlyRate * Qty) ;
          LineTotal := RoundCurrency(HourlyRate * Qty);
        end;
      end;
  end;

  if (Sysutils.SameText(Sender.FieldName , 'Amount')) then begin
    if  TypeID = GetPayRateTypeID('Annual Payment') then begin
      if Temployeepay(Self.Owner).EmployeeDetails.Payperiod = 'Weekly' then begin
        iPeriod := 52;
      end else if Temployeepay(Self.Owner).EmployeeDetails.Payperiod = 'Fortnightly' then begin
        iPeriod := 26;
      end else if Temployeepay(Self.Owner).EmployeeDetails.Payperiod = 'Monthly' then begin
        iPeriod := 12;
      end else if Temployeepay(Self.Owner).EmployeeDetails.Payperiod = 'Bi-Monthly' then begin
        iPeriod := 24;
      end else begin
        iPeriod := 52;
      end;

      HourlyRate := RoundCurrency(Divzer(Amount,iPeriod));
    end else if (TypeID = GetPayRateTypeID('Salary')) then begin
     // HourlyRate := Amount;
    end else begin
      HourlyRate := RoundCurrency(Divzer(Amount,Qty));
    end;
  end;
end;


Function TEmployeepayrates.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TEmployeepayrates.GetIDField : String;
begin
   Result := 'Employeerateid'
end;

class function TEmployeepayrates.GetBusObjectTablename: string;
begin
  Result := 'tblemployeepayrates';
end;

function TEmployeepayrates.GetTotalWages: Double;
begin
  fdTotalWages := 0;
  Self.IterateRecords(CallTotalWages,False);
  result := fdTotalWages;
end;

procedure TEmployeepayrates.CallTotalWages(const Sender: TBusObj;  var Abort: Boolean);
begin
  fdTotalWages := fdTotalWages + LineTotal;
end;

{Property functions}
Function  TEmployeepayrates.GetEmployeeid    :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  TEmployeepayrates.GetPayrateid     :Integer   ; begin Result := GetIntegerField('Payrateid');End;
Function  TEmployeepayrates.GetTypeid        :Integer   ; begin Result := GetIntegerField('Typeid');End;
Function  TEmployeepayrates.GetQty           :Double    ; begin Result := GetFloatField('Qty');End;
Function  TEmployeepayrates.GetAmount        :Double    ; begin Result := GetFloatField('Amount');End;
Function  TEmployeepayrates.GetSuper         :Boolean   ; begin Result := GetBooleanField('Super');End;
Function  TEmployeepayrates.GetClientid      :Integer   ; begin Result := GetIntegerField('Clientid');End;
Function  TEmployeepayrates.GetClassID       :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  TEmployeepayrates.GetHourlyrate    :Double    ; begin Result := GetFloatField('Hourlyrate');End;
Function  TEmployeepayrates.GetLinetotal     :Double    ; begin Result := GetFloatField('Linetotal');End;
Function  TEmployeepayrates.GetClassname     :String    ; begin Result := GetStringField('Classname');End;
Procedure TEmployeepayrates.SetEmployeeid    (Const Value :Integer   ); begin SetIntegerField('Employeeid'     , Value);End;
Procedure TEmployeepayrates.SetPayrateid     (Const Value :Integer   ); begin SetIntegerField('Payrateid'      , Value);End;
Procedure TEmployeepayrates.SetTypeid        (Const Value :Integer   ); begin SetIntegerField('Typeid'         , Value);End;
Procedure TEmployeepayrates.SetQty           (Const Value :Double    ); begin SetFloatField('Qty'            , Value);End;
Procedure TEmployeepayrates.SetAmount        (Const Value :Double    ); begin SetFloatField('Amount'         , Value);End;
Procedure TEmployeepayrates.SetSuper         (Const Value :Boolean   ); begin SetBooleanField('Super'          , Value);End;
Procedure TEmployeepayrates.SetClientid      (Const Value :Integer   ); begin SetIntegerField('Clientid'       , Value);End;
Procedure TEmployeepayrates.setClassID       (Const Value :Integer   ); begin SetIntegerField('Classid'        , Value);End;
Procedure TEmployeepayrates.SetHourlyrate    (Const Value :Double    ); begin SetFloatField('Hourlyrate'     , Value);End;
Procedure TEmployeepayrates.SetLinetotal     (Const Value :Double    ); begin SetFloatField('Linetotal'      , Value);End;
Procedure TEmployeepayrates.SetClassname     (Const Value :String    ); begin SetStringField('Classname'      , Value);End;

initialization
RegisterClassOnce(TEmployeePayRates);


end.
