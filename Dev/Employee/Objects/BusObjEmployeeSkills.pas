unit BusObjEmployeeSkills;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   19/07/07   1.00.01      Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLIntf;


type
   Temployeeskills = class(TMSBusObj)
   private
      Function GetEmployeeid           :Integer   ;
      Function GetSkillid              :Integer   ;
      Function GetSkillname            :String    ;
      Function GetSkilllevel           :Integer   ;
      Function GetSkillexpdate         :TDatetime ;
      Function GetSecuritylevel        :Integer   ;
      Function GetSecurityexpdate      :TDatetime ;
      Procedure SetEmployeeid           (Const Value :Integer   );
      Procedure SetSkillid              (Const Value :Integer   );
      Procedure SetSkillname            (Const Value :String    );
      Procedure SetSkilllevel           (Const Value :Integer   );
      Procedure SetSkillexpdate         (Const Value :TDatetime );
      Procedure SetSecuritylevel        (Const Value :Integer   );
      Procedure SetSecurityexpdate      (Const Value :TDatetime );
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;


      Property Employeeid            :Integer      Read getEmployeeid         Write SetEmployeeid     ;
      Property Skillid               :Integer      Read getSkillid            Write SetSkillid        ;
      Property Skillname             :String       Read getSkillname          Write SetSkillname      ;
      Property Skilllevel            :Integer      Read getSkilllevel         Write SetSkilllevel     ;
      Property Skillexpdate          :TDatetime    Read getSkillexpdate       Write SetSkillexpdate   ;
      Property Securitylevel         :Integer      Read getSecuritylevel      Write SetSecuritylevel  ;
      Property Securityexpdate       :TDatetime    Read getSecurityexpdate    Write SetSecurityexpdate;
   End;


implementation

uses
  BusObjEmployeePay;



{========================================================
         Temployeeskills
========================================================}
constructor Temployeeskills.Create(AOwner: TComponent);
begin
   inherited Create(AOwner)
end;


destructor Temployeeskills.Destroy;
begin
   inherited;
end;

Function  Temployeeskills.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is TEmployeePay then
                EmployeeId := Temployeepay(Self.Owner).EmployeeDetails.Id;  
    Result := inherited DoAfterInsert(Sender);
end;


procedure   Temployeeskills.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
      Employeeid            :=GetXMLNodeIntegerValue(Node,'Employeeid');
      Skillid               :=GetXMLNodeIntegerValue(Node,'Skillid');
      Skillname             :=GetXMLNodeStringValue(Node,'Skillname');
      Skilllevel            :=GetXMLNodeIntegerValue(Node,'Skilllevel');
      Skillexpdate          :=GetXMLNodeDatetimeValue(Node,'Skillexpdate');
      Securitylevel         :=GetXMLNodeIntegerValue(Node,'Securitylevel');
      Securityexpdate       :=GetXMLNodeDatetimeValue(Node,'Securityexpdate');
end;


procedure   Temployeeskills.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Employeeid' ,Employeeid);
      AddXMLNode(node,'Skillid' ,Skillid);
      AddXMLNode(node,'Skillname' ,Skillname);
      AddXMLNode(node,'Skilllevel' ,Skilllevel);
      AddXMLNode(node,'Skillexpdate' ,Skillexpdate);
      AddXMLNode(node,'Securitylevel' ,Securitylevel);
      AddXMLNode(node,'Securityexpdate' ,Securityexpdate);
end;


function    Temployeeskills.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Employeeid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Employeeid should not be 0' , False );
      Exit;
   end;
   if Skillid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Skillid should not be 0' , False );
      Exit;
   end;
   if Skillname = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Skillname should not be blank' , False );
      Exit;
   end;
   if Skilllevel = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Skilllevel should not be 0' , False );
      Exit;
   end;
   if Skillexpdate = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Skillexpdate should not be blank' , False );
      Exit;
   end;
   if Securitylevel = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Securitylevel should not be 0' , False );
      Exit;
   end;
   if Securityexpdate = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Securityexpdate should not be blank' , False );
      Exit;
   end;
   Result := true;
end;


function    Temployeeskills.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Temployeeskills.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Temployeeskills.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function Temployeeskills.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblemployeeskills';
   Result := Inherited getSQL;
end;

class function  Temployeeskills.GetIDField : String;
begin
   Result := 'Empskillid'
end;

class function Temployeeskills.GetBusObjectTableName: string;
begin
  Result := 'tblemployeeskills';
end;

Function  Temployeeskills.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Temployeeskills.GetEmployeeid     :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  Temployeeskills.GetSkillid        :Integer   ; begin Result := GetIntegerField('Skillid');End;
Function  Temployeeskills.GetSkillname      :String    ; begin Result := GetStringField('Skillname');End;
Function  Temployeeskills.GetSkilllevel     :Integer   ; begin Result := GetIntegerField('Skilllevel');End;
Function  Temployeeskills.GetSkillexpdate   :TDatetime ; begin Result := GetDatetimeField('Skillexpdate');End;
Function  Temployeeskills.GetSecuritylevel  :Integer   ; begin Result := GetIntegerField('Securitylevel');End;
Function  Temployeeskills.GetSecurityexpdate:TDatetime ; begin Result := GetDatetimeField('Securityexpdate');End;
Procedure Temployeeskills.SetEmployeeid     (Const Value :Integer   ); begin SetIntegerField('Employeeid'      , Value);End;
Procedure Temployeeskills.SetSkillid        (Const Value :Integer   ); begin SetIntegerField('Skillid'         , Value);End;
Procedure Temployeeskills.SetSkillname      (Const Value :String    ); begin SetStringField('Skillname'       , Value);End;
Procedure Temployeeskills.SetSkilllevel     (Const Value :Integer   ); begin SetIntegerField('Skilllevel'      , Value);End;
Procedure Temployeeskills.SetSkillexpdate   (Const Value :TDatetime ); begin SetDatetimeField('Skillexpdate'    , Value);End;
Procedure Temployeeskills.SetSecuritylevel  (Const Value :Integer   ); begin SetIntegerField('Securitylevel'   , Value);End;
Procedure Temployeeskills.SetSecurityexpdate(Const Value :TDatetime ); begin SetDatetimeField('Securityexpdate' , Value);End;


initialization
RegisterClass(Temployeeskills);


end.
