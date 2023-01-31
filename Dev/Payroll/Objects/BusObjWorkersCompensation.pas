unit BusObjWorkersCompensation;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   19/07/07   1.00.01      Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   TWorkerscompensation = class(TMSBusObj)
   private
      Function GetEmployeeid       :Integer   ;
      Function GetWcdate           :TDatetime ;
      Function GetDescription      :String    ;
      Function GetAmount           :Double    ;
      Function GetType             :String    ;
      Function GetClassID          :Integer   ;
      Function GetDepartmentName        :String    ;
      Procedure SetEmployeeid       (Const Value :Integer   );
      Procedure SetWcdate           (Const Value :TDatetime );
      Procedure SetDescription      (Const Value :String    );
      Procedure SetAmount           (Const Value :Double    );
      Procedure SetType             (Const Value :String    );
      Procedure setClassID          (Const Value :Integer   );
      Procedure SetDepartmentName   (Const Value :String    );
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


      Property Employeeid        :Integer      Read getEmployeeid     Write SetEmployeeid ;
      Property Wcdate            :TDatetime    Read getWcdate         Write SetWcdate     ;
      Property Description       :String       Read getDescription    Write SetDescription;
      Property Amount            :Double       Read getAmount         Write SetAmount     ;
      Property CompensationType  :String       Read getType           Write SetType       ;
      Property Classid           :Integer      Read GetClassID        Write setClassID    ;
      Property DepartmentName    :String       Read getDepartmentName      Write SetDepartmentname  ;
   End;


implementation

uses
  BusObjEmployeePay,BusObjConst,SysUtils, CommonLib;


{========================================================
         TWorkerscompensation
========================================================}
constructor TWorkerscompensation.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblworkerscompensation';
end;


destructor TWorkerscompensation.Destroy;
begin
   inherited;
end;

Function  TWorkerscompensation.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is TEmployeePay then
                EmployeeId := Temployeepay(Self.Owner).EmployeeDetails.Id;
    Result := inherited DoAfterInsert(Sender);
end;

procedure   TWorkerscompensation.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Employeeid');
  SetDateTimePropertyFromNode(Node,'Wcdate');
  SetPropertyFromNode(Node,'Description');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'CompensationType');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'DepartmentName');
end;


procedure   TWorkerscompensation.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'Wcdate' ,Wcdate);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'CompensationType' ,CompensationType);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'DepartmentName' ,DepartmentName);
end;


function    TWorkerscompensation.ValidateData :Boolean ;
begin
   if Self.Dataset.RecordCount = 0 then begin // don't force em to have a comp
     Result := True;
     exit;
   end;

   Result := False;
   Resultstatus.Clear;
   if Wcdate = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_WorkersComp_Err_NoDate,  'Date should not be blank' );
      self.SendEvent(IntToStr(BOR_WorkersComp_Err_NoDate),BusobjEventVal_FailedTaxationValidateData);
      Exit;
   end;
   if Description = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_WorkersComp_Err_NoDetails,  'Description should not be blank' );
      self.SendEvent(IntToStr(BOR_WorkersComp_Err_NoDetails),BusobjEventVal_FailedTaxationValidateData);
      Exit;
   end;
   if Amount = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_WorkersComp_Err_NoAmount,  'Amount should not be 0');
      self.SendEvent(IntToStr(BOR_WorkersComp_Err_NoAmount),BusobjEventVal_FailedTaxationValidateData);
      Exit;
   end;
   if CompensationType = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_WorkersComp_Err_NoType,  'Compensation Type should not be blank' );
      self.SendEvent(IntToStr(BOR_WorkersComp_Err_NoType),BusobjEventVal_FailedTaxationValidateData);
      Exit;
   end;
   if DepartmentName = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_WorkersComp_Err_NoDepartment,  'Department name should not be blank' );
      self.SendEvent(IntToStr(BOR_WorkersComp_Err_NoDepartment),BusobjEventVal_FailedTaxationValidateData);
      Exit;
   end;
   Result := true;
end;
 
function    TWorkerscompensation.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TWorkerscompensation.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TWorkerscompensation.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TWorkerscompensation.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TWorkerscompensation.GetIDField : String;
begin
   Result := 'Wcid'
end;
class function TWorkerscompensation.GetBusObjectTablename: string;
begin
  Result := 'tblworkerscompensation';
end;

Function  TWorkerscompensation.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TWorkerscompensation.GetEmployeeid :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  TWorkerscompensation.GetWcdate     :TDatetime ; begin Result := GetDatetimeField('Wcdate');End;
Function  TWorkerscompensation.GetDescription:String    ; begin Result := GetStringField('Description');End;
Function  TWorkerscompensation.GetAmount     :Double    ; begin Result := GetFloatField('Amount');End;
Function  TWorkerscompensation.GetType       :String    ; begin Result := GetStringField('Type');End;
Function  TWorkerscompensation.GetClassID    :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  TWorkerscompensation.GetDepartmentName  :String    ; begin Result := GetStringField('Classname');End;
Procedure TWorkerscompensation.SetEmployeeid (Const Value :Integer   ); begin SetIntegerField('Employeeid'  , Value);End;
Procedure TWorkerscompensation.SetWcdate     (Const Value :TDatetime ); begin SetDatetimeField('Wcdate'      , Value);End;
Procedure TWorkerscompensation.SetDescription(Const Value :String    ); begin SetStringField('Description' , Value);End;
Procedure TWorkerscompensation.SetAmount     (Const Value :Double    ); begin SetFloatField('Amount'      , Value);End;
Procedure TWorkerscompensation.SetType       (Const Value :String    ); begin SetStringField('Type'        , Value);End;
Procedure TWorkerscompensation.setClassID    (Const Value :Integer   ); begin SetIntegerField('Classid'     , Value);End;
Procedure TWorkerscompensation.SetDepartmentName  (Const Value :String    ); begin SetStringField('Classname'   , Value);End;


initialization
RegisterClassOnce(TWorkersCompensation);


end.
