unit BusObjEmployeeAllowances;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   10/08/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, BusObjAllowances, XMLDoc, XMLIntf;


type
   TEmployeeallowances = class(TMSBusObj)
   private
      fAllowances                       :TAllowance;
      Function GetEmployeeid            :Integer   ;
      Function GetAllowance             :String    ;
      Function GetAllowanceid           :Integer   ;
      Function GetQty                   :Double    ;
      Function GetBasedonid             :Integer   ;
      Function GetAmount                :Double    ;
      Function GetCalcby                :String   ;
      Function GetArea                  :String   ;
      Function GetSuperinc              :Boolean   ;
      Function GetTaxexempt             :Boolean   ;
      Function GetClientid              :Integer   ;
      Function GetClassID               :Integer   ;
      Function GetClassname             :String    ;
      Function GetUsestartenddates      :Boolean   ;
      Function GetStartdate             :TDatetime ;
      Function GetEnddate               :TDatetime ;
      Procedure SetEmployeeid            (Const Value :Integer   );
      Procedure SetAllowance             (Const Value :String    );
      Procedure SetAllowanceid           (Const Value :Integer   );
      Procedure SetQty                   (Const Value :Double    );
      Procedure SetBasedonid             (Const Value :Integer   );
      Procedure SetAmount                (Const Value :Double    );
      Procedure SetCalcby                (Const Value :String   );
      Procedure SetArea                  (Const Value :String   );
      Procedure SetSuperinc              (Const Value :Boolean   );
      Procedure SetTaxexempt             (Const Value :Boolean   );
      Procedure SetClientid              (Const Value :Integer   );
      Procedure setClassID               (Const Value :Integer   );
      Procedure SetClassname             (Const Value :String    );
      Procedure SetUsestartenddates      (Const Value :Boolean   );
      Procedure SetStartdate             (Const Value :TDatetime );
      Procedure SetEnddate               (Const Value :TDatetime );


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
      procedure   AddAllowanceDetails;

      Property Employeeid             :Integer      Read getEmployeeid          Write SetEmployeeid      ;
      Property Allowance              :String       Read getAllowance           Write SetAllowance       ;
      Property Allowanceid            :Integer      Read getAllowanceid         Write SetAllowanceid     ;
      Property Qty                    :Double       Read GetQty                 Write SetQty             ;
      Property Basedonid              :Integer      Read getBasedonid           Write SetBasedonid       ;
      Property Amount                 :Double       Read getAmount              Write SetAmount          ;
      Property Calcby                 :String       Read getCalcby              Write SetCalcby          ;
      Property Area                   :String       Read getArea                Write SetArea            ;
      Property Superinc               :Boolean      Read getSuperinc            Write SetSuperinc        ;
      Property Taxexempt              :Boolean      Read getTaxexempt           Write SetTaxexempt       ;
      Property Clientid               :Integer      Read getClientid            Write SetClientid        ;
      Property Classid                :Integer      Read GetClassID             Write setClassID         ;
      Property DepartmentName         :String       Read getClassname           Write SetClassname       ;
      Property Usestartenddates       :Boolean      Read getUsestartenddates    Write SetUsestartenddates;
      Property Startdate              :TDatetime    Read getStartdate           Write SetStartdate       ;
      Property Enddate                :TDatetime    Read getEnddate             Write SetEnddate         ;
   End;


implementation


uses BusObjConst,PayCommon,BusObjEmployeePay,SysUtils,AppEnvironment,DnMLib,
  CommonLib, tcDataUtils;


{========================================================
         TEmployeeallowances
========================================================}
constructor TEmployeeallowances.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblemployeeallowances';
   fallowances := TAllowance.Create(Self);
   fallowances.Connection := Self.Connection;
   fallowances.SilentMode := Self.SilentMode;
end;

procedure TEmployeeallowances.AddAllowanceDetails;
begin
  AllowanceID := PayCommon.GetAllowanceID(Allowance);
  fAllowances.Load(AllowanceID);
  Qty := 1;
  TaxExempt := fAllowances.Taxexempt;
  Amount := fAllowances.Amount;
  if CalcBy <> '%' then CalcBy := AppEnv.RegionalOptions.CurrencySymbol;
//  CalcBy := fAllowances.Calcby;
  BasedOnID := fAllowances.Basedonid;
//  DepartmentName := Temployeepay(Self.Owner).EmployeeDetails.Defaultclassname;
end;

Function  TEmployeeallowances.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
      if Self.Owner is Temployeepay then begin
        EmployeeId := Temployeepay(Self.Owner).EmployeeDetails.id;
        DepartmentName := Temployeepay(Self.Owner).EmployeeDetails.Defaultclassname;
        ClassID := GetDeptID(DepartmentName);
      end;
    Result := inherited DoAfterInsert(Sender);
end;

destructor TEmployeeallowances.Destroy;
begin
   inherited;
end;


procedure   TEmployeeallowances.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Employeeid');
  SetPropertyFromNode(Node,'Allowance');
  SetPropertyFromNode(Node,'Allowanceid');
  SetPropertyFromNode(Node,'Qty');
  SetPropertyFromNode(Node,'Basedonid');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Calcby');
  SetPropertyFromNode(Node,'Area');
  SetBooleanPropertyFromNode(Node,'Superinc');
  SetBooleanPropertyFromNode(Node,'Taxexempt');
  SetPropertyFromNode(Node,'Clientid');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'DepartmentName');
  SetBooleanPropertyFromNode(Node,'Usestartenddates');
  SetDateTimePropertyFromNode(Node,'Startdate');
  SetDateTimePropertyFromNode(Node,'Enddate');
end;


procedure   TEmployeeallowances.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'Allowance' ,Allowance);
  AddXMLNode(node,'Allowanceid' ,Allowanceid);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'Basedonid' ,Basedonid);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Calcby' ,Calcby);
  AddXMLNode(node,'Area' ,Area);
  AddXMLNode(node,'Superinc' ,Superinc);
  AddXMLNode(node,'Taxexempt' ,Taxexempt);
  AddXMLNode(node,'Clientid' ,Clientid);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'DepartmentName' ,DepartmentName);
  AddXMLNode(node,'Usestartenddates' ,Usestartenddates);
  AddXMLNode(node,'Startdate' ,Startdate);
  AddXMLNode(node,'Enddate' ,Enddate);
end;

function    TEmployeeallowances.ValidateData :Boolean ;
//var
//  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Allowance = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeAllowance_Err_NoAllowance,  'Allowance should not be blank');
        SendEvent(IntToStr(BOR_EmployeeAllowance_Err_NoAllowance),BusobjEventVal_FailedAllowancesValidateData);
        Exit;
     end;
     if Allowanceid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeAllowance_Err_NoAllowance,  'Allowanceid should not be 0');
        SendEvent(IntToStr(BOR_EmployeeAllowance_Err_NoAllowance),BusobjEventVal_FailedAllowancesValidateData);
        Exit;
     end;
     if Qty = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeAllowance_Err_NoQty,  'Allowance Qty should not be 0');
        SendEvent(IntToStr(BOR_EmployeeAllowance_Err_NoQty),BusobjEventVal_FailedAllowancesValidateData);
        Exit;
     end;
     if Basedonid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeAllowance_Err_NoCalcBy,  'Based On should not be blank');
        SendEvent(IntToStr(BOR_EmployeeAllowance_Err_NoCalcBy),BusobjEventVal_FailedAllowancesValidateData);
        Exit;
     end;
     if Amount = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeAllowance_Err_NoAmount,  'Amount should not be 0');
        SendEvent(IntToStr(BOR_EmployeeAllowance_Err_NoAmount),BusobjEventVal_FailedAllowancesValidateData);
        Exit;
     end;
     if Classid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeAllowance_Err_NoDepartment,  'Classid should not be 0');
        SendEvent(IntToStr(BOR_EmployeeAllowance_Err_NoDepartment),BusobjEventVal_FailedAllowancesValidateData);
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeAllowance_Err_NoDepartment,  'Department name should not be blank');
        SendEvent(IntToStr(BOR_EmployeeAllowance_Err_NoDepartment),BusobjEventVal_FailedAllowancesValidateData);
        Exit;
     end;
     Result := true;
   Finally
//    If not Result then Begin
//      tmpResultStatus := ResultStatus.GetLastStatusItem;
//      if Assigned(tmpResultStatus) then
//        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedAllowancesValidateData);
//    end;
   end;
end;


function    TEmployeeallowances.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TEmployeeallowances.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TEmployeeallowances.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName , 'Classname') then begin
    ClassID := tcDatautils.GetDeptID(DepartmentName);
  end;
end;


Function TEmployeeallowances.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TEmployeeallowances.GetIDField : String;
begin
   Result := 'Eaid'
end;

class function TEmployeeallowances.GetBusObjectTablename: string;
begin
  Result := 'tblemployeeallowances';
end;

Function  TEmployeeallowances.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TEmployeeallowances.GetEmployeeid      :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  TEmployeeallowances.GetAllowance       :String    ; begin Result := GetStringField('Allowance');End;
Function  TEmployeeallowances.GetAllowanceid     :Integer   ; begin Result := GetIntegerField('Allowanceid');End;
Function  TEmployeeallowances.GetQty             :Double    ; begin Result := GetFloatField('Qty');End;
Function  TEmployeeallowances.GetBasedonid       :Integer   ; begin Result := GetIntegerField('Basedonid');End;
Function  TEmployeeallowances.GetAmount          :Double    ; begin Result := GetFloatField('Amount');End;
Function  TEmployeeallowances.GetCalcby          :String    ; begin Result := GetStringField('Calcby');End;
Function  TEmployeeallowances.GetArea            :String    ; begin Result := GetStringField('Area');End;
Function  TEmployeeallowances.GetSuperinc        :Boolean   ; begin Result := GetBooleanField('Superinc');End;
Function  TEmployeeallowances.GetTaxexempt       :Boolean   ; begin Result := GetBooleanField('Taxexempt');End;
Function  TEmployeeallowances.GetClientid        :Integer   ; begin Result := GetIntegerField('Clientid');End;
Function  TEmployeeallowances.GetClassID         :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  TEmployeeallowances.GetClassname       :String    ; begin Result := GetStringField('Classname');End;
Function  TEmployeeallowances.GetUsestartenddates:Boolean   ; begin Result := GetBooleanField('Usestartenddates');End;
Function  TEmployeeallowances.GetStartdate       :TDatetime ; begin Result := GetDatetimeField('Startdate');End;
Function  TEmployeeallowances.GetEnddate         :TDatetime ; begin Result := GetDatetimeField('Enddate');End;
Procedure TEmployeeallowances.SetEmployeeid      (Const Value :Integer   ); begin SetIntegerField('Employeeid'       , Value);End;
Procedure TEmployeeallowances.SetAllowance       (Const Value :String    ); begin SetStringField('Allowance'        , Value);End;
Procedure TEmployeeallowances.SetAllowanceid     (Const Value :Integer   ); begin SetIntegerField('Allowanceid'      , Value);End;
Procedure TEmployeeallowances.SetQty             (Const Value :Double    ); begin SetFloatField('Qty'              , Value);End;
Procedure TEmployeeallowances.SetBasedonid       (Const Value :Integer   ); begin SetIntegerField('Basedonid'        , Value);End;
Procedure TEmployeeallowances.SetAmount          (Const Value :Double    ); begin SetFloatField('Amount'           , Value);End;
Procedure TEmployeeallowances.SetCalcby          (Const Value :String    ); begin SetStringField('Calcby'           , Value);End;
Procedure TEmployeeallowances.SetArea            (Const Value :String    ); begin SetStringField('Area'             , Value);End;
Procedure TEmployeeallowances.SetSuperinc        (Const Value :Boolean   ); begin SetBooleanField('Superinc'         , Value);End;
Procedure TEmployeeallowances.SetTaxexempt       (Const Value :Boolean   ); begin SetBooleanField('Taxexempt'        , Value);End;
Procedure TEmployeeallowances.SetClientid        (Const Value :Integer   ); begin SetIntegerField('Clientid'         , Value);End;
Procedure TEmployeeallowances.setClassID         (Const Value :Integer   ); begin SetIntegerField('Classid'          , Value);End;
Procedure TEmployeeallowances.SetClassname       (Const Value :String    ); begin SetStringField('Classname'        , Value);End;
Procedure TEmployeeallowances.SetUsestartenddates(Const Value :Boolean   ); begin SetBooleanField('Usestartenddates' , Value);End;
Procedure TEmployeeallowances.SetStartdate       (Const Value :TDatetime ); begin SetDatetimeField('Startdate'        , Value);End;
Procedure TEmployeeallowances.SetEnddate         (Const Value :TDatetime ); begin SetDatetimeField('Enddate'          , Value);End;


initialization
RegisterClassOnce(TEmployeeAllowances);


end.
