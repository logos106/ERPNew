unit BusObjProspectFollowUps;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  30/12/08  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TProspectFollowup = class(TMSBusObj)
  private
    function GetOtherContactID     : Integer   ;
    function GetRepairID           : Integer   ;
    function GetEmployeeID         : Integer   ;
    function GetClientID           : Integer   ;
    function GetFollowUpDate       : TDateTime ;
    function GetNotes              : string    ;
    function GetDone               : Boolean   ;
    function GetAppearDays         : Integer   ;
    function GetCreationDate       : TDateTime ;
    function GetUpdateDate         : TDateTime ;
    function GetIsSupplier         : Boolean   ;
    function GetIsOtherContact     : Boolean   ;
    function GetIsCustomer         : Boolean   ;
    function GetHours              : Double    ;
    function GetTypeId             : Integer   ;
    function GetResultTypeId       : Integer   ;
    function GetIsPhoneFollowUp    : Boolean   ;
    function GetCustomField1       : string    ;
    function GetCustomField2       : string    ;
    function GetCustomField3       : string    ;
    function GetCustomField4       : string    ;
    function GetCustomField5       : string    ;
    function GetCustomField6       : string    ;
    function GetCustomField7       : string    ;
    function GetCustomField8       : string    ;
    function GetCustomField9       : string    ;
    function GetCustomField10      : string    ;
    function GetLeadLineID         : Integer   ;
    procedure SetOtherContactID     (const Value: Integer   );
    procedure SetRepairID           (const Value: Integer   );
    procedure SetEmployeeID         (const Value: Integer   );
    procedure SetClientID           (const Value: Integer   );
    procedure SetFollowUpDate       (const Value: TDateTime );
    procedure SetNotes              (const Value: string    );
    procedure SetDone               (const Value: Boolean   );
    procedure SetAppearDays         (const Value: Integer   );
    procedure SetCreationDate       (const Value: TDateTime );
    procedure SetUpdateDate         (const Value: TDateTime );
    procedure SetIsSupplier         (const Value: Boolean   );
    procedure SetIsOtherContact     (const Value: Boolean   );
    procedure SetIsCustomer         (const Value: Boolean   );
    procedure SetHours              (const Value: Double    );
    procedure SetTypeId             (const Value: Integer   );
    procedure SetResultTypeId       (const Value: Integer   );
    procedure SetIsPhoneFollowUp    (const Value: Boolean   );
    procedure SetCustomField1       (const Value: string    );
    procedure SetCustomField2       (const Value: string    );
    procedure SetCustomField3       (const Value: string    );
    procedure SetCustomField4       (const Value: string    );
    procedure SetCustomField5       (const Value: string    );
    procedure SetCustomField6       (const Value: string    );
    procedure SetCustomField7       (const Value: string    );
    procedure SetCustomField8       (const Value: string    );
    procedure SetCustomField9       (const Value: string    );
    procedure SetCustomField10      (const Value: string    );
    procedure SetLeadLineID         (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property OtherContactID      :Integer     read GetOtherContactID    write SetOtherContactID ;
    property RepairID            :Integer     read GetRepairID          write SetRepairID       ;
    property EmployeeID          :Integer     read GetEmployeeID        write SetEmployeeID     ;
    property ClientID            :Integer     read GetClientID          write SetClientID       ;
    property FollowUpDate        :TDateTime   read GetFollowUpDate      write SetFollowUpDate   ;
    property Notes               :string      read GetNotes             write SetNotes          ;
    property Done                :Boolean     read GetDone              write SetDone           ;
    property AppearDays          :Integer     read GetAppearDays        write SetAppearDays     ;
    property CreationDate        :TDateTime   read GetCreationDate      write SetCreationDate   ;
    property UpdateDate          :TDateTime   read GetUpdateDate        write SetUpdateDate     ;
    property IsSupplier          :Boolean     read GetIsSupplier        write SetIsSupplier     ;
    property IsOtherContact      :Boolean     read GetIsOtherContact    write SetIsOtherContact ;
    property IsCustomer          :Boolean     read GetIsCustomer        write SetIsCustomer     ;
    property Hours               :Double      read GetHours             write SetHours          ;
    property TypeId              :Integer     read GetTypeId            write SetTypeId         ;
    property ResultTypeId        :Integer     read GetResultTypeId      write SetResultTypeId   ;
    property IsPhoneFollowUp     :Boolean     read GetIsPhoneFollowUp   write SetIsPhoneFollowUp;
    property CustomField1        :string      read GetCustomField1      write SetCustomField1   ;
    property CustomField2        :string      read GetCustomField2      write SetCustomField2   ;
    property CustomField3        :string      read GetCustomField3      write SetCustomField3   ;
    property CustomField4        :string      read GetCustomField4      write SetCustomField4   ;
    property CustomField5        :string      read GetCustomField5      write SetCustomField5   ;
    property CustomField6        :string      read GetCustomField6      write SetCustomField6   ;
    property CustomField7        :string      read GetCustomField7      write SetCustomField7   ;
    property CustomField8        :string      read GetCustomField8      write SetCustomField8   ;
    property CustomField9        :string      read GetCustomField9      write SetCustomField9   ;
    property CustomField10       :string      read GetCustomField10     write SetCustomField10  ;
    property LeadLineID          :Integer     read GetLeadLineID        write SetLeadLineID     ;
  end;


implementation


uses tcDataUtils, CommonLib,FastFuncs;   


  {TProspectfollowup}

constructor TProspectfollowup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'otherfollowup';
  fSQL := 'SELECT * FROM tblotherfollowup';
end;


destructor TProspectfollowup.Destroy;
begin
  inherited;
end;


procedure TProspectfollowup.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OtherContactID');
  SetPropertyFromNode(node,'RepairID');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'ClientID');
  SetDateTimePropertyFromNode(node,'FollowUpDate');
  SetPropertyFromNode(node,'Notes');
  SetBooleanPropertyFromNode(node,'Done');
  SetPropertyFromNode(node,'AppearDays');
  SetDateTimePropertyFromNode(node,'CreationDate');
  SetDateTimePropertyFromNode(node,'UpdateDate');
  SetBooleanPropertyFromNode(node,'IsSupplier');
  SetBooleanPropertyFromNode(node,'IsOtherContact');
  SetBooleanPropertyFromNode(node,'IsCustomer');
  SetPropertyFromNode(node,'Hours');
  SetPropertyFromNode(node,'TypeId');
  SetPropertyFromNode(node,'ResultTypeId');
  SetBooleanPropertyFromNode(node,'IsPhoneFollowUp');
  SetPropertyFromNode(node,'CustomField1');
  SetPropertyFromNode(node,'CustomField2');
  SetPropertyFromNode(node,'CustomField3');
  SetPropertyFromNode(node,'CustomField4');
  SetPropertyFromNode(node,'CustomField5');
  SetPropertyFromNode(node,'CustomField6');
  SetPropertyFromNode(node,'CustomField7');
  SetPropertyFromNode(node,'CustomField8');
  SetPropertyFromNode(node,'CustomField9');
  SetPropertyFromNode(node,'CustomField10');
  SetPropertyFromNode(node,'LeadLineID');
end;


procedure TProspectfollowup.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OtherContactID' ,OtherContactID);
  AddXMLNode(node,'RepairID' ,RepairID);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'FollowUpDate' ,FollowUpDate);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'Done' ,Done);
  AddXMLNode(node,'AppearDays' ,AppearDays);
  AddXMLNode(node,'CreationDate' ,CreationDate);
  AddXMLNode(node,'UpdateDate' ,UpdateDate);
  AddXMLNode(node,'IsSupplier' ,IsSupplier);
  AddXMLNode(node,'IsOtherContact' ,IsOtherContact);
  AddXMLNode(node,'IsCustomer' ,IsCustomer);
  AddXMLNode(node,'Hours' ,Hours);
  AddXMLNode(node,'TypeId' ,TypeId);
  AddXMLNode(node,'ResultTypeId' ,ResultTypeId);
  AddXMLNode(node,'IsPhoneFollowUp' ,IsPhoneFollowUp);
  AddXMLNode(node,'CustomField1' ,CustomField1);
  AddXMLNode(node,'CustomField2' ,CustomField2);
  AddXMLNode(node,'CustomField3' ,CustomField3);
  AddXMLNode(node,'CustomField4' ,CustomField4);
  AddXMLNode(node,'CustomField5' ,CustomField5);
  AddXMLNode(node,'CustomField6' ,CustomField6);
  AddXMLNode(node,'CustomField7' ,CustomField7);
  AddXMLNode(node,'CustomField8' ,CustomField8);
  AddXMLNode(node,'CustomField9' ,CustomField9);
  AddXMLNode(node,'CustomField10' ,CustomField10);
  AddXMLNode(node,'LeadLineID' ,LeadLineID);
end;


function TProspectfollowup.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if OtherContactID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'OtherContactID should not be 0'  );
    Exit;
  end;
 // if RepairID = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'RepairID should not be 0' );
//    Exit;
//  end;
//  if EmployeeID = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'EmployeeID should not be 0' );
//    Exit;
//  end;
//  if ClientID = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'ClientID should not be 0'  );
//    Exit;
//  end;
  if FollowUpDate = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'FollowUpDate should not be blank' );
    Exit;
  end;
//  if AppearDays = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'AppearDays should not be 0'  );
//    Exit;
//  end;
//  if CreationDate = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'CreationDate should not be blank'  );
//    Exit;
//  end;
//  if UpdateDate = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'UpdateDate should not be blank' , False );
//    Exit;
//  end;
//  if Hours = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'Hours should not be 0'  );
//    Exit;
//  end;
//  if TypeId = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'TypeId should not be 0'  );
//    Exit;
//  end;
//  if ResultTypeId = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'ResultTypeId should not be 0'  );
//    Exit;
//  end;
 // if LeadLineID = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'LeadLineID should not be 0'  );
//    Exit;
//  end;
  Result := True;
end;


function TProspectfollowup.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProspectfollowup.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProspectfollowup.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then Exit; // we are only interested in data fields.
  inherited;
//  if Sysutils.SameText(Sender.FieldName , '') then begin

//  end;
end;


function TProspectfollowup.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProspectfollowup.GetIDField: string;
begin
  Result := 'FollowUpID'
end;


class function TProspectfollowup.GetBusObjectTablename: string;
begin
  Result:= 'tblotherfollowup';
end;


function TProspectfollowup.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TProspectfollowup.GetOtherContactID : Integer   ; begin Result := GetIntegerField('OtherContactID');end;
function  TProspectfollowup.GetRepairID       : Integer   ; begin Result := GetIntegerField('RepairID');end;
function  TProspectfollowup.GetEmployeeID     : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TProspectfollowup.GetClientID       : Integer   ; begin Result := GetIntegerField('ClientID');end;
function  TProspectfollowup.GetFollowUpDate   : TDateTime ; begin Result := GetDateTimeField('FollowUpDate');end;
function  TProspectfollowup.GetNotes          : string    ; begin Result := GetStringField('Notes');end;
function  TProspectfollowup.GetDone           : Boolean   ; begin Result := GetBooleanField('Done');end;
function  TProspectfollowup.GetAppearDays     : Integer   ; begin Result := GetIntegerField('AppearDays');end;
function  TProspectfollowup.GetCreationDate   : TDateTime ; begin Result := GetDateTimeField('CreationDate');end;
function  TProspectfollowup.GetUpdateDate     : TDateTime ; begin Result := GetDateTimeField('UpdateDate');end;
function  TProspectfollowup.GetIsSupplier     : Boolean   ; begin Result := GetBooleanField('IsSupplier');end;
function  TProspectfollowup.GetIsOtherContact : Boolean   ; begin Result := GetBooleanField('IsOtherContact');end;
function  TProspectfollowup.GetIsCustomer     : Boolean   ; begin Result := GetBooleanField('IsCustomer');end;
function  TProspectfollowup.GetHours          : Double    ; begin Result := GetFloatField('Hours');end;
function  TProspectfollowup.GetTypeId         : Integer   ; begin Result := GetIntegerField('TypeId');end;
function  TProspectfollowup.GetResultTypeId   : Integer   ; begin Result := GetIntegerField('ResultTypeId');end;
function  TProspectfollowup.GetIsPhoneFollowUp: Boolean   ; begin Result := GetBooleanField('IsPhoneFollowUp');end;
function  TProspectfollowup.GetCustomField1   : string    ; begin Result := GetStringField('CustomField1');end;
function  TProspectfollowup.GetCustomField2   : string    ; begin Result := GetStringField('CustomField2');end;
function  TProspectfollowup.GetCustomField3   : string    ; begin Result := GetStringField('CustomField3');end;
function  TProspectfollowup.GetCustomField4   : string    ; begin Result := GetStringField('CustomField4');end;
function  TProspectfollowup.GetCustomField5   : string    ; begin Result := GetStringField('CustomField5');end;
function  TProspectfollowup.GetCustomField6   : string    ; begin Result := GetStringField('CustomField6');end;
function  TProspectfollowup.GetCustomField7   : string    ; begin Result := GetStringField('CustomField7');end;
function  TProspectfollowup.GetCustomField8   : string    ; begin Result := GetStringField('CustomField8');end;
function  TProspectfollowup.GetCustomField9   : string    ; begin Result := GetStringField('CustomField9');end;
function  TProspectfollowup.GetCustomField10  : string    ; begin Result := GetStringField('CustomField10');end;
function  TProspectfollowup.GetLeadLineID     : Integer   ; begin Result := GetIntegerField('LeadLineID');end;
procedure TProspectfollowup.SetOtherContactID (const Value: Integer   ); begin SetIntegerField('OtherContactID' , Value);end;
procedure TProspectfollowup.SetRepairID       (const Value: Integer   ); begin SetIntegerField('RepairID'        , Value);end;
procedure TProspectfollowup.SetEmployeeID     (const Value: Integer   ); begin SetIntegerField('EmployeeID'      , Value);end;
procedure TProspectfollowup.SetClientID       (const Value: Integer   ); begin SetIntegerField('ClientID'        , Value);end;
procedure TProspectfollowup.SetFollowUpDate   (const Value: TDateTime ); begin SetDateTimeField('FollowUpDate'    , Value);end;
procedure TProspectfollowup.SetNotes          (const Value: string    ); begin SetStringField('Notes'           , Value);end;
procedure TProspectfollowup.SetDone           (const Value: Boolean   ); begin SetBooleanField('Done'            , Value);end;
procedure TProspectfollowup.SetAppearDays     (const Value: Integer   ); begin SetIntegerField('AppearDays'      , Value);end;
procedure TProspectfollowup.SetCreationDate   (const Value: TDateTime ); begin SetDateTimeField('CreationDate'    , Value);end;
procedure TProspectfollowup.SetUpdateDate     (const Value: TDateTime ); begin SetDateTimeField('UpdateDate'      , Value);end;
procedure TProspectfollowup.SetIsSupplier     (const Value: Boolean   ); begin SetBooleanField('IsSupplier'      , Value);end;
procedure TProspectfollowup.SetIsOtherContact (const Value: Boolean   ); begin SetBooleanField('IsSupplier'      , Value);end;
procedure TProspectfollowup.SetIsCustomer     (const Value: Boolean   ); begin SetBooleanField('IsCustomer'      , Value);end;
procedure TProspectfollowup.SetHours          (const Value: Double    ); begin SetFloatField('Hours'           , Value);end;
procedure TProspectfollowup.SetTypeId         (const Value: Integer   ); begin SetIntegerField('TypeId'          , Value);end;
procedure TProspectfollowup.SetResultTypeId   (const Value: Integer   ); begin SetIntegerField('ResultTypeId'    , Value);end;
procedure TProspectfollowup.SetIsPhoneFollowUp(const Value: Boolean   ); begin SetBooleanField('ResultTypeId'    , Value);end;
procedure TProspectfollowup.SetCustomField1   (const Value: string    ); begin SetStringField('CustomField1'    , Value);end;
procedure TProspectfollowup.SetCustomField2   (const Value: string    ); begin SetStringField('CustomField2'    , Value);end;
procedure TProspectfollowup.SetCustomField3   (const Value: string    ); begin SetStringField('CustomField3'    , Value);end;
procedure TProspectfollowup.SetCustomField4   (const Value: string    ); begin SetStringField('CustomField4'    , Value);end;
procedure TProspectfollowup.SetCustomField5   (const Value: string    ); begin SetStringField('CustomField5'    , Value);end;
procedure TProspectfollowup.SetCustomField6   (const Value: string    ); begin SetStringField('CustomField6'    , Value);end;
procedure TProspectfollowup.SetCustomField7   (const Value: string    ); begin SetStringField('CustomField7'    , Value);end;
procedure TProspectfollowup.SetCustomField8   (const Value: string    ); begin SetStringField('CustomField8'    , Value);end;
procedure TProspectfollowup.SetCustomField9   (const Value: string    ); begin SetStringField('CustomField9'    , Value);end;
procedure TProspectfollowup.SetCustomField10  (const Value: string    ); begin SetStringField('CustomField10'   , Value);end;
procedure TProspectfollowup.SetLeadLineID     (const Value: Integer   ); begin SetIntegerField('LeadLineID'      , Value);end;


initialization
  RegisterClass(TProspectfollowup);


end.
