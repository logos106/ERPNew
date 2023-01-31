unit BusObjLeavetypes;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   04/12/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   TLeavetypes = class(TMSBusObj)
   private
      Function GetLeavetype            :String    ;
      Function GetAccrueliability      :Boolean   ;
      Function GetActive               :Boolean   ;
      Function GetLeaveloading         :Double    ;
      Procedure SetLeavetype            (Const Value :String    );
      Procedure SetAccrueliability      (Const Value :Boolean   );
      Procedure SetActive               (Const Value :Boolean   );
      Procedure SetLeaveloading         (Const Value :Double    );
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;

   Public
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      class function  GetIDField : String;                                 Override;
      class function GetBusObjectTablename: string; override;
      class function AccreLiabilityForLeave(const aLeaveType: string): boolean;
      class function GetKeyStringField: string; override;
      class function GetKeyStringProperty: string; override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;

   published
      Property LeaveType             :String       Read getLeavetype            Write SetLeavetype      ;
      Property AccrueLiability       :Boolean      Read getAccrueliability      Write SetAccrueliability;
      Property Active                :Boolean      Read getActive               Write SetActive         ;
      Property LeaveLoading          :Double       Read getLeaveloading         Write SetLeaveloading   ;
   End;


implementation

uses
  CommonLib, CommonDbLib, ERPdbComponents, sysutils;

{========================================================
         TLeavetypes
========================================================}
constructor TLeavetypes.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblleavetypes';
end;


destructor TLeavetypes.Destroy;
begin
   inherited;
end;


procedure   TLeavetypes.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Leavetype');
  SetBooleanPropertyFromNode(Node,'Accrueliability');
  SetBooleanPropertyFromNode(Node,'Active');
  SetPropertyFromNode(Node,'Leaveloading');
end;


procedure   TLeavetypes.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Leavetype' ,Leavetype);
  AddXMLNode(node,'Accrueliability' ,Accrueliability);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Leaveloading' ,Leaveloading);
end;


function    TLeavetypes.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Leavetype = '' then begin
      AddResult(False , rssWarning , 0,  'Leave Type should not be blank');
      Exit;
   end;
//   if Leaveloading = 0 then begin
//      AddResult(False , rssWarning , 0,  'LeaveLoading should not be 0');
//      Exit;
//   end;
   Result := true;
end;


function    TLeavetypes.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TLeavetypes.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TLeavetypes.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
   inherited;

end;


Function TLeavetypes.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TLeavetypes.GetIDField : String;
begin
   Result := 'Leavetypeid'
end;

class function TLeavetypes.GetKeyStringField: string;
begin
  result:= 'LeaveType';
end;

class function TLeavetypes.GetKeyStringProperty: string;
begin
  result:= 'LeaveType';
end;

class function TLeavetypes.GetBusObjectTablename: string;
begin
  Result := 'tblleavetypes';
end;

Function  TLeavetypes.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TLeavetypes.GetLeavetype            :String    ; begin Result := GetStringField('Leavetype');End;
Function  TLeavetypes.GetAccrueliability      :Boolean   ; begin Result := GetBooleanField('Accrueliability');End;
Function  TLeavetypes.GetActive               :Boolean   ; begin Result := GetBooleanField('Active');End;
Function  TLeavetypes.GetLeaveloading         :Double    ; begin Result := GetFloatField('Leaveloading');End;
Procedure TLeavetypes.SetLeavetype            (Const Value :String    ); begin SetStringField('Leavetype'       , Value);End;
Procedure TLeavetypes.SetAccrueliability      (Const Value :Boolean   ); begin SetBooleanField('Accrueliability' , Value);End;
Procedure TLeavetypes.SetActive               (Const Value :Boolean   ); begin SetBooleanField('Active'          , Value);End;
Procedure TLeavetypes.SetLeaveloading         (Const Value :Double    ); begin SetFloatField('Leaveloading'    , Value);End;


class function TLeavetypes.AccreLiabilityForLeave(const aLeaveType: string): boolean;
var
  qry: TERPQuery;
begin
  result:= false;
  qry:= TempMyQuery;
  try
    qry.SQL.Text:= 'select * from ' + TLeavetypes.GetBusObjectTablename +
      ' where LeaveType = ' + QuotedStr(aLeaveType);
    qry.Open;
    if not qry.IsEmpty then
      result:= qry.FieldByName('AccrueLiability').AsBoolean;
  finally
    qry.Free;
  end;
end;

initialization
RegisterClassOnce(TLeaveTypes);


end.
