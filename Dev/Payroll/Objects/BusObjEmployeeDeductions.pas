unit BusObjEmployeeDeductions;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   02/07/07   1.00.01 RM     Initial Version.
   }

interface

uses BusObjBase, DB, Classes, BusObjDeductions, XMLDoc, XMLIntf;

type
   TEmployeedeductions = class(TMSBusObj)
   private
      fDeductions                       :TDeduction;

      Function GetEmployeeid            :Integer   ;
      Function GetDeduction             :String    ;
      Function GetDeductionid           :Integer   ;
      Function GetQty                   :Double    ;
      Function GetNotes                 :String    ;
      Function GetAmount                :Double    ;
      Function GetCalcby                :String    ;
      Function GetArea                  :String    ;
      Function GetPercentage            :Double    ;
      Function GetTaxexempt             :Boolean   ;
      Function GetTaxexemptFederal      :Boolean   ;
      Function GetTaxexemptState        :Boolean   ;
      Function GetTaxexemptSocial       :Boolean   ;
      Function GetTaxexemptMedicare     :Boolean   ;
      Function GetIsWorkPlacegiving     :Boolean   ;
      Function GetUnionfees             :Boolean   ;
      Function GetDisplayin             :String    ;
      Function GetBasedonid             :Integer   ;
      Function GetBox12CodeID           :Integer   ;
      Function GetClassname             :String    ;
      Function GetClassID               :Integer   ;
      Function GetUsestartenddates      :Boolean   ;
      Function GetStartdate             :TDatetime ;
      Function GetEnddate               :TDatetime ;
      Procedure SetEmployeeid            (Const Value :Integer   );
      Procedure SetDeduction             (Const Value :String    );
      Procedure SetDeductionid           (Const Value :Integer   );
      Procedure SetQty                   (Const Value :Double    );
      Procedure SetNotes                 (Const Value :String    );
      Procedure SetAmount                (Const Value :Double    );
      Procedure SetCalcby                (Const Value :String    );
      Procedure SetArea                  (Const Value :String    );
      Procedure SetPercentage            (Const Value :Double    );
      Procedure SetTaxexempt             (Const Value :Boolean   );
      Procedure SetTaxexemptFederal      (Const Value :Boolean   );
      Procedure SetTaxexemptState        (Const Value :Boolean   );
      Procedure SetTaxexemptSocial       (Const Value :Boolean   );
      Procedure SetTaxexemptMedicare     (Const Value :Boolean   );
      Procedure SetIsWorkPlacegiving     (Const Value :Boolean   );
      Procedure SetUnionfees             (Const Value :Boolean   );
      Procedure SetDisplayin             (Const Value :String    );
      Procedure SetBasedonid             (Const Value :Integer   );
      Procedure SetBox12CodeID           (Const Value :Integer   );
      Procedure SetClassname             (Const Value :String    );
      Procedure setClassID               (Const Value :Integer   );
      Procedure SetUsestartenddates      (Const Value :Boolean   );
      Procedure SetStartdate             (Const Value :TDatetime );
      Procedure SetEnddate               (Const Value :TDatetime );

   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : String;                                           Override;
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
      procedure    AddDeductionDetails;    

      Property Employeeid             :Integer      Read getEmployeeid          Write SetEmployeeid      ;
      Property Deduction              :String       Read getDeduction           Write SetDeduction       ;
      Property Deductionid            :Integer      Read getDeductionid         Write SetDeductionid     ;
      Property Qty                    :Double       Read GetQty                 Write SetQty             ;
      Property Notes                  :String       Read getNotes               Write SetNotes           ;
      Property Amount                 :Double       Read getAmount              Write SetAmount          ;
      Property Calcby                 :String       Read getCalcby              Write SetCalcby          ;
      Property Area                   :String       Read getArea                Write SetArea            ;
      Property Percentage             :Double       Read getPercentage          Write SetPercentage      ;
      Property Taxexempt              :Boolean      Read getTaxexempt           Write SetTaxexempt       ;
      Property TaxexemptFederal       :Boolean      Read getTaxexemptFederal    Write SetTaxexemptFederal  ;
      Property TaxexemptState         :Boolean      Read getTaxexemptState      Write SetTaxexemptState  ;
      Property TaxexemptSocial        :Boolean      Read getTaxexemptSocial     Write SetTaxexemptSocial  ;
      Property TaxexemptMedicare      :Boolean      Read getTaxexemptMedicare   Write SetTaxexemptMedicare  ;
      Property IsWorkPlacegiving      :Boolean      Read getIsWorkPlacegiving   Write SetIsWorkPlacegiving ;
      Property Unionfees              :Boolean      Read getUnionfees           Write SetUnionfees       ;
      Property Displayin              :String       Read getDisplayin           Write SetDisplayin       ;
      Property Basedonid              :Integer      Read getBasedonid           Write SetBasedonid       ;
      Property Box12CodeID            :Integer      Read getBox12CodeID         Write SetBox12CodeID     ;
      Property DepartmentName         :String       Read getClassname           Write SetClassname       ;
      Property Classid                :Integer      Read GetClassID             Write setClassID         ;
      Property Usestartenddates       :Boolean      Read getUsestartenddates    Write SetUsestartenddates;
      Property Startdate              :TDatetime    Read getStartdate           Write SetStartdate       ;
      Property Enddate                :TDatetime    Read getEnddate             Write SetEnddate         ;
   End;


implementation

uses BusObjEmployeePay,SysUtils,Dialogs,PayCommon,BusObjConst,AppEnvironment,
  CommonLib, tcDataUtils;


{========================================================
         TEmployeedeductions
========================================================}
constructor TEmployeedeductions.Create(AOwner: TComponent);
begin
   inherited Create(AOwner) ;
   fSQL := 'SELECT * FROM tblemployeedeductions';
   fdeductions := TDeduction.Create(Self);
   fdeductions.Connection := Self.Connection;
   fdeductions.SilentMode := Self.SilentMode;
end;

destructor TEmployeedeductions.Destroy;
begin
   inherited;
end;

procedure TEmployeedeductions.AddDeductionDetails;
begin
  DeductionID := PayCommon.GetDeductionID(Deduction);
  fDeductions.Load(DeductionID);
  Qty := 1;
  TaxExempt := fDeductions.Taxexempt;
  TaxExemptFederal := fDeductions.TaxexemptFederal;
  TaxExemptState := fDeductions.TaxexemptState;
  TaxExemptSocial := fDeductions.TaxexemptSocial;
  TaxExemptMedicare := fDeductions.TaxexemptMedicare;
  IsWorkPlacegiving := fDeductions.IsWorkPlacegiving;
  UnionFees := fDeductions.Unionfees;
  Amount := fDeductions.Amount;
  if CalcBy <> '%' then CalcBy := AppEnv.RegionalOptions.CurrencySymbol;
 // CalcBy := fDeductions.Calcby;
  Percentage := fDeductions.Percentage;
  BasedOnID := fDeductions.Basedonid;
  Box12CodeID := fDeductions.Box12CodeId;
  DepartmentName := Temployeepay(self.Owner).EmployeeDetails.Defaultclassname;
end;

Function  TEmployeedeductions.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
      if Self.Owner is Temployeepay then begin
        EmployeeId := Temployeepay(Self.Owner).EmployeeDetails.id;
      end;
    Result := inherited DoAfterInsert(Sender);
end;

procedure   TEmployeedeductions.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Employeeid');
  SetPropertyFromNode(Node,'Deduction');
  SetPropertyFromNode(Node,'Deductionid');
  SetPropertyFromNode(Node,'Qty');
  SetPropertyFromNode(Node,'Notes');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Calcby');
  SetPropertyFromNode(Node,'Area');
  SetPropertyFromNode(Node,'Percentage');
  SetBooleanPropertyFromNode(Node,'Taxexempt');
  SetBooleanPropertyFromNode(Node,'IsWorkPlacegiving');
  SetBooleanPropertyFromNode(Node,'Unionfees');
  SetPropertyFromNode(Node,'Displayin');
  SetPropertyFromNode(Node,'Basedonid');
  SetPropertyFromNode(Node,'Box12CodeID');
  SetPropertyFromNode(Node,'Classname');
  SetPropertyFromNode(Node,'Classid');
  SetBooleanPropertyFromNode(Node,'Usestartenddates');
  SetDateTimePropertyFromNode(Node,'Startdate');
  SetDateTimePropertyFromNode(Node,'Enddate');
end;

procedure   TEmployeedeductions.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'Deduction' ,Deduction);
  AddXMLNode(node,'Deductionid' ,Deductionid);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Calcby' ,Calcby);
  AddXMLNode(node,'Area' ,Area);
  AddXMLNode(node,'Percentage' ,Percentage);
  AddXMLNode(node,'Taxexempt' ,Taxexempt);
  AddXMLNode(node,'IsWorkPlacegiving' ,IsWorkPlacegiving);
  AddXMLNode(node,'Unionfees' ,Unionfees);
  AddXMLNode(node,'Displayin' ,Displayin);
  AddXMLNode(node,'Basedonid' ,Basedonid);
  AddXMLNode(node,'Box12CodeID' ,Box12CodeID);
  AddXMLNode(node,'Classname' ,DepartmentName);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Usestartenddates' ,Usestartenddates);
  AddXMLNode(node,'Startdate' ,Startdate);
  AddXMLNode(node,'Enddate' ,Enddate);
end;

function    TEmployeedeductions.ValidateData :Boolean ;
//var
//  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Employeeid = 0 then begin
        Resultstatus.AddItem(False , rssError , 0,  'Employeeid should not be 0');
        Exit;
     end;
     if Deduction = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_EmpNoDeduction,  'Deduction should not be blank');
        SendEvent(IntToStr(BOR_EmployeePay_Err_EmpNoDeduction),BusobjEventVal_FailedDeductionsValidateData);
        Exit;
     end;
     if Deductionid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_EmpNoDeduction,  'Deductionid should not be 0');
        SendEvent(IntToStr(BOR_EmployeePay_Err_EmpNoDeduction),BusobjEventVal_FailedDeductionsValidateData);
        Exit;
     end;
     if Qty = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_EmpDeductionNoQty,  'Deduction Qty should not be 0');
        SendEvent(IntToStr(BOR_EmployeePay_Err_EmpDeductionNoQty),BusobjEventVal_FailedDeductionsValidateData);
        Exit;
     end;
     if Amount = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_EmpNoAmount,  'Amount should not be 0');
        SendEvent(IntToStr(BOR_EmployeePay_Err_EmpNoAmount),BusobjEventVal_FailedDeductionsValidateData);
        Exit;
     end;
     if Basedonid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_EmpDeductionNoBasedOn,  'Basedonid should not be Blank');
        SendEvent(IntToStr(BOR_EmployeePay_Err_EmpDeductionNoBasedOn),BusobjEventVal_FailedDeductionsValidateData);
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_EmpDeductionNoDepartment,  'Department name should not be blank');
        SendEvent(IntToStr(BOR_EmployeePay_Err_EmpDeductionNoDepartment),BusobjEventVal_FailedDeductionsValidateData);
        Exit;
     end;
     if Classid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_EmpDeductionNoDepartment,  'Classid should not be 0');
        SendEvent(IntToStr(BOR_EmployeePay_Err_EmpDeductionNoDepartment),BusobjEventVal_FailedDeductionsValidateData);
        Exit;
     end;
     Result := true;
   Finally
//    If not Result then Begin
//      tmpResultStatus := ResultStatus.GetLastStatusItem;
//      if Assigned(tmpResultStatus) then
//        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedDeductionsValidateData);
//    end;
   end;
end;

function    TEmployeedeductions.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;

procedure TEmployeedeductions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;

procedure TEmployeedeductions.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'Classname') then begin
    ClassID := tcDatautils.GetDeptID(DepartmentName);
  end;
end;

Function TEmployeedeductions.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;

class function  TEmployeedeductions.GetIDField : String;
begin
   Result := 'Edid'
end;

class function TEmployeedeductions.GetBusObjectTablename: string;
begin
  Result := 'tblemployeedeductions';
end;

Function  TEmployeedeductions.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

{Property functions}
Function  TEmployeedeductions.GetEmployeeid      :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  TEmployeedeductions.GetDeduction       :String    ; begin Result := GetStringField('Deduction');End;
Function  TEmployeedeductions.GetDeductionid     :Integer   ; begin Result := GetIntegerField('Deductionid');End;
Function  TEmployeedeductions.GetQty             :Double    ; begin Result := GetFloatField('Qty');End;
Function  TEmployeedeductions.GetNotes           :String    ; begin Result := GetStringField('Notes');End;
Function  TEmployeedeductions.GetAmount          :Double    ; begin Result := GetFloatField('Amount');End;
Function  TEmployeedeductions.GetCalcby          :String    ; begin Result := GetStringField('Calcby');End;
Function  TEmployeedeductions.GetArea            :String    ; begin Result := GetStringField('Area');End;
Function  TEmployeedeductions.GetPercentage      :Double    ; begin Result := GetFloatField('Percentage');End;
Function  TEmployeedeductions.GetTaxexempt       :Boolean   ; begin Result := GetBooleanField('Taxexempt');End;
Function  TEmployeedeductions.GetTaxexemptFederal  :Boolean   ; begin Result := GetBooleanField('TaxexemptFederal');End;
Function  TEmployeedeductions.GetTaxexemptState    :Boolean   ; begin Result := GetBooleanField('TaxexemptState');End;
Function  TEmployeedeductions.GetTaxexemptSocial   :Boolean   ; begin Result := GetBooleanField('TaxexemptSocial');End;
Function  TEmployeedeductions.GetTaxexemptMedicare :Boolean   ; begin Result := GetBooleanField('TaxexemptMedicare');End;
Function  TEmployeedeductions.GetIsWorkPlacegiving       :Boolean   ; begin Result := GetBooleanField('IsWorkPlacegiving');End;
Function  TEmployeedeductions.GetUnionfees       :Boolean   ; begin Result := GetBooleanField('Unionfees');End;
Function  TEmployeedeductions.GetDisplayin       :String    ; begin Result := GetStringField('Displayin');End;
Function  TEmployeedeductions.GetBasedonid       :Integer   ; begin Result := GetIntegerField('Basedonid');End;
Function  TEmployeedeductions.GetBox12CodeID     :Integer   ; begin Result := GetIntegerField('Box12CodeID');End;
Function  TEmployeedeductions.GetClassname       :String    ; begin Result := GetStringField('Classname');End;
Function  TEmployeedeductions.GetClassID         :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  TEmployeedeductions.GetUsestartenddates:Boolean   ; begin Result := GetBooleanField('Usestartenddates');End;
Function  TEmployeedeductions.GetStartdate       :TDatetime ; begin Result := GetDatetimeField('Startdate');End;
Function  TEmployeedeductions.GetEnddate         :TDatetime ; begin Result := GetDatetimeField('Enddate');End;
Procedure TEmployeedeductions.SetEmployeeid      (Const Value :Integer   ); begin SetIntegerField('Employeeid'       , Value);End;
Procedure TEmployeedeductions.SetDeduction       (Const Value :String    ); begin SetStringField('Deduction'        , Value);End;
Procedure TEmployeedeductions.SetDeductionid     (Const Value :Integer   ); begin SetIntegerField('Deductionid'      , Value);End;
Procedure TEmployeedeductions.SetQty             (Const Value :Double    ); begin SetFloatField('Qty'              , Value);End;
Procedure TEmployeedeductions.SetNotes           (Const Value :String    ); begin SetStringField('Notes'            , Value);End;
Procedure TEmployeedeductions.SetAmount          (Const Value :Double    ); begin SetFloatField('Amount'           , Value);End;
Procedure TEmployeedeductions.SetCalcby          (Const Value :String    ); begin SetStringField('Calcby'           , Value);End;
Procedure TEmployeedeductions.SetArea            (Const Value :String    ); begin SetStringField('Area'           , Value);End;
Procedure TEmployeedeductions.SetPercentage      (Const Value :Double    ); begin SetFloatField('Percentage'       , Value);End;
Procedure TEmployeedeductions.SetTaxexempt       (Const Value :Boolean   ); begin SetBooleanField('Taxexempt'        , Value);End;
Procedure TEmployeedeductions.SetTaxexemptFederal  (Const Value :Boolean   ); begin SetBooleanField('TaxexemptFederal'   , Value);End;
Procedure TEmployeedeductions.SetTaxexemptState    (Const Value :Boolean   ); begin SetBooleanField('TaxexemptState'   , Value);End;
Procedure TEmployeedeductions.SetTaxexemptSocial   (Const Value :Boolean   ); begin SetBooleanField('TaxexemptSocial'   , Value);End;
Procedure TEmployeedeductions.SetTaxexemptMedicare (Const Value :Boolean   ); begin SetBooleanField('TaxexemptMedicare'   , Value);End;
Procedure TEmployeedeductions.SetIsWorkPlacegiving       (Const Value :Boolean   ); begin SetBooleanField('IsWorkPlacegiving'        , Value);End;
Procedure TEmployeedeductions.SetUnionfees       (Const Value :Boolean   ); begin SetBooleanField('Unionfees'        , Value);End;
Procedure TEmployeedeductions.SetDisplayin       (Const Value :String    ); begin SetStringField('Displayin'        , Value);End;
Procedure TEmployeedeductions.SetBasedonid       (Const Value :Integer   ); begin SetIntegerField('Basedonid'        , Value);End;
Procedure TEmployeedeductions.SetBox12CodeID     (Const Value :Integer   ); begin SetIntegerField('Box12CodeID', Value);End;
Procedure TEmployeedeductions.SetClassname       (Const Value :String    ); begin SetStringField('Classname'        , Value);End;
Procedure TEmployeedeductions.setClassID         (Const Value :Integer   ); begin SetIntegerField('Classid'          , Value);End;
Procedure TEmployeedeductions.SetUsestartenddates(Const Value :Boolean   ); begin SetBooleanField('Usestartenddates' , Value);End;
Procedure TEmployeedeductions.SetStartdate       (Const Value :TDatetime ); begin SetDatetimeField('Startdate'        , Value);End;
Procedure TEmployeedeductions.SetEnddate         (Const Value :TDatetime ); begin SetDatetimeField('Enddate'          , Value);End;

initialization
RegisterClassOnce(TEmployeeDeductions);

end.
