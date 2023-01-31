unit BusObjContacts;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  18/03/09  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, {ALXMLDoc ,} BusobjMarketingcontacts;


type
  TContact = class(TContactBase)
  private
    function GetCusID                       : Integer   ;
    function GetSupID                       : Integer   ;
    function GetEmployeeID                  : Integer   ;
(*    function GetCompany                     : string    ;
    function GetContactTitle                : string    ;
    function GetContactFirstName            : string    ;
    function GeTContacturName              : string    ;
    function GetContactAddress              : string    ;
    function GetContactAddress2             : string    ;
    function GetContactAddress3             : string    ;
    function GetContactCity                 : string    ;
    function GeTContacttate                : string    ;
    function GetContactPcode                : string    ;
    function GetContactCountry              : string    ;
    function GetContactPH                   : string    ;
    function GetContactAltPH                : string    ;
    function GetContactMOB                  : string    ;
    function GetContactFax                  : string    ;
    function GetContactEmail                : string    ;
    function GetNotes                       : string    ;
    function GetActive                      : Boolean   ;
    function GetCardNumber                  : string    ;
    function GetAccountNo                   : string    ;
    function GetJobTitle                    : string    ;*)
    function GetContactIsCustomer           : Boolean   ;
    function GetContactIsJob                : Boolean   ;
    function GetContactIsSupplier           : Boolean   ;
    function GetContactIsOtherContact       : Boolean   ;
    function GetUseOnRun                    : Boolean   ;
    function GetLogMeInComputerIPAddress    : string    ;
    function GetLogMeInEmailPassword        : string    ;
    function GetLogMeInUserName             : string    ;
    function GetLogMeInPassword             : string    ;
    function GetLogMeInERPUserName          : string    ;
    function GetLogMeInERPPassword          : string    ;
    function GetLogMeIncomputerPassword     : string    ;
    procedure SetCusID                       (const Value: Integer   );
    procedure SetSupID                       (const Value: Integer   );
    procedure SetEmployeeID                  (const Value: Integer   );
(*    procedure SetCompany                     (const Value: string    );
    procedure SetContactTitle                (const Value: string    );
    procedure SetContactFirstName            (const Value: string    );
    procedure SeTContacturName              (const Value: string    );
    procedure SetContactAddress              (const Value: string    );
    procedure SetContactAddress2             (const Value: string    );
    procedure SetContactAddress3             (const Value: string    );
    procedure SetContactCity                 (const Value: string    );
    procedure SeTContacttate                (const Value: string    );
    procedure SetContactPcode                (const Value: string    );
    procedure SetContactCountry              (const Value: string    );
    procedure SetContactPH                   (const Value: string    );
    procedure SetContactAltPH                (const Value: string    );
    procedure SetContactMOB                  (const Value: string    );
    procedure SetContactFax                  (const Value: string    );
    procedure SetContactEmail                (const Value: string    );
    procedure SetNotes                       (const Value: string    );
    procedure SetActive                      (const Value: Boolean   );
    procedure SetCardNumber                  (const Value: string    );
    procedure SetAccountNo                   (const Value: string    );
    procedure SetJobTitle                    (const Value: string    );*)
    procedure SetContactIsCustomer           (const Value: Boolean   );
    procedure SetContactIsJob                (const Value: Boolean   );
    procedure SetContactIsSupplier           (const Value: Boolean   );
    procedure SetContactIsOtherContact       (const Value: Boolean   );
    procedure SetUseOnRun                    (const Value: Boolean   );
    procedure SetLogMeInComputerIPAddress    (const Value: string    );
    procedure SetLogMeInEmailPassword        (const Value: string    );
    procedure SetLogMeInUserName             (const Value: string    );
    procedure SetLogMeInPassword             (const Value: string    );
    procedure SetLogMeInERPUserName          (const Value: string    );
    procedure SetLogMeInERPPassword          (const Value: string    );
    procedure SetLogMeIncomputerPassword     (const Value: string    );
(*    function getIsPrimarycontact: Boolean;
    procedure setIsPrimarycontact(const Value: Boolean);*)
  protected
    procedure OnDataIDChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: TALXMLNode);                 override;
    procedure    SaveToXMLNode(const node: TALXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property CusID                        :Integer     read GetCusID                      write SetCusID                   ;
    property SupID                        :Integer     read GetSupID                      write SetSupID                   ;
    property EmployeeID                   :Integer     read GetEmployeeID                 write SetEmployeeID              ;
(*    property Company                      :string      read GetCompany                    write SetCompany                 ;
    property ContactTitle                 :string      read GetContactTitle               write SetContactTitle            ;
    property ContactFirstName             :string      read GetContactFirstName           write SetContactFirstName        ;
    property ContactSurName               :string      read GeTContacturName             write SeTContacturName          ;
    property ContactAddress               :string      read GetContactAddress             write SetContactAddress          ;
    property ContactAddress2              :string      read GetContactAddress2            write SetContactAddress2         ;
    property ContactAddress3              :string      read GetContactAddress3            write SetContactAddress3         ;
    property ContactCity                  :string      read GetContactCity                write SetContactCity             ;
    property ContactState                 :string      read GeTContacttate               write SeTContacttate            ;
    property ContactPcode                 :string      read GetContactPcode               write SetContactPcode            ;
    property ContactCountry               :string      read GetContactCountry             write SetContactCountry          ;
    property ContactPH                    :string      read GetContactPH                  write SetContactPH               ;
    property ContactAltPH                 :string      read GetContactAltPH               write SetContactAltPH            ;
    property ContactMOB                   :string      read GetContactMOB                 write SetContactMOB              ;
    property ContactFax                   :string      read GetContactFax                 write SetContactFax              ;
    property ContactEmail                 :string      read GetContactEmail               write SetContactEmail            ;
    property Notes                        :string      read GetNotes                      write SetNotes                   ;
    property Active                       :Boolean     read GetActive                     write SetActive                  ;
    property CardNumber                   :string      read GetCardNumber                 write SetCardNumber              ;
    property AccountNo                    :string      read GetAccountNo                  write SetAccountNo               ;
    property JobTitle                     :string      read GetJobTitle                   write SetJobTitle                ;
    Property IsPrimarycontact             :Boolean     Read getIsPrimarycontact           Write setIsPrimarycontact;*)
    property ContactIsCustomer            :Boolean     read GetContactIsCustomer          write SetContactIsCustomer       ;
    property ContactIsJob                 :Boolean     read GetContactIsJob               write SetContactIsJob            ;
    property ContactIsSupplier            :Boolean     read GetContactIsSupplier          write SetContactIsSupplier       ;
    property ContactIsOtherContact        :Boolean     read GetContactIsOtherContact      write SetContactIsOtherContact   ;
    property UseOnRun                     :Boolean     read GetUseOnRun                   write SetUseOnRun                ;
    property LogMeInComputerIPAddress     :string      read GetLogMeInComputerIPAddress   write SetLogMeInComputerIPAddress;
    property LogMeInEmailPassword         :string      read GetLogMeInEmailPassword       write SetLogMeInEmailPassword    ;
    property LogMeInUserName              :string      read GetLogMeInUserName            write SetLogMeInUserName         ;
    property LogMeInPassword              :string      read GetLogMeInPassword            write SetLogMeInPassword         ;
    property LogMeInERPUserName           :string      read GetLogMeInERPUserName         write SetLogMeInERPUserName      ;
    property LogMeInERPPassword           :string      read GetLogMeInERPPassword         write SetLogMeInERPPassword      ;
    property LogMeIncomputerPassword      :string      read GetLogMeIncomputerPassword    write SetLogMeIncomputerPassword ;

  end;


implementation


uses tcDataUtils, CommonLib, FastFuncs;



  {TContact}

constructor TContact.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Contacts';
  fSQL := 'SELECT * FROM tblcontacts';
end;


destructor TContact.Destroy;
begin
  inherited;
end;


procedure TContact.LoadFromXMLNode(const node: TALXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'CusID');
  SetPropertyFromNode(node,'SupID');
  SetPropertyFromNode(node,'EmployeeID');
(*  SetPropertyFromNode(node,'Company');
  SetPropertyFromNode(node,'ContactTitle');
  SetPropertyFromNode(node,'ContactFirstName');
  SetPropertyFromNode(node,'ContactSurName');
  SetPropertyFromNode(node,'ContactAddress');
  SetPropertyFromNode(node,'ContactAddress2');
  SetPropertyFromNode(node,'ContactAddress3');
  SetPropertyFromNode(node,'ContactCity');
  SetPropertyFromNode(node,'ContactState');
  SetPropertyFromNode(node,'ContactPcode');
  SetPropertyFromNode(node,'ContactCountry');
  SetPropertyFromNode(node,'ContactPH');
  SetPropertyFromNode(node,'ContactAltPH');
  SetPropertyFromNode(node,'ContactMOB');
  SetPropertyFromNode(node,'ContactFax');
  SetPropertyFromNode(node,'ContactEmail');
  SetPropertyFromNode(node,'Notes');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'CardNumber');
  SetPropertyFromNode(node,'AccountNo');
  SetPropertyFromNode(node,'JobTitle');*)
  SetBooleanPropertyFromNode(node,'ContactIsCustomer');
  SetBooleanPropertyFromNode(node,'ContactIsJob');
  SetBooleanPropertyFromNode(node,'ContactIsSupplier');
  SetBooleanPropertyFromNode(node,'ContactIsOtherContact');
  SetBooleanPropertyFromNode(node,'UseOnRun');
  SetPropertyFromNode(node,'LogMeInComputerIPAddress');
  SetPropertyFromNode(node,'LogMeInEmailPassword');
  SetPropertyFromNode(node,'LogMeInUserName');
  SetPropertyFromNode(node,'LogMeInPassword');
  SetPropertyFromNode(node,'LogMeInERPUserName');
  SetPropertyFromNode(node,'LogMeInERPPassword');
  SetPropertyFromNode(node,'LogMeIncomputerPassword');
end;


procedure TContact.SaveToXMLNode(Const node: TALXMLNode);
begin
  inherited;
  AddXMLNode(node,'CusID' ,CusID);
  AddXMLNode(node,'SupID' ,SupID);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  (*AddXMLNode(node,'Company' ,Company);
  AddXMLNode(node,'ContactTitle' ,ContactTitle);
  AddXMLNode(node,'ContactFirstName' ,ContactFirstName);
  AddXMLNode(node,'ContactSurName' ,ContactSurName);
  AddXMLNode(node,'ContactAddress' ,ContactAddress);
  AddXMLNode(node,'ContactAddress2' ,ContactAddress2);
  AddXMLNode(node,'ContactAddress3' ,ContactAddress3);
  AddXMLNode(node,'ContactCity' ,ContactCity);
  AddXMLNode(node,'ContactState' ,ContactState);
  AddXMLNode(node,'ContactPcode' ,ContactPcode);
  AddXMLNode(node,'ContactCountry' ,ContactCountry);
  AddXMLNode(node,'ContactPH' ,ContactPH);
  AddXMLNode(node,'ContactAltPH' ,ContactAltPH);
  AddXMLNode(node,'ContactMOB' ,ContactMOB);
  AddXMLNode(node,'ContactFax' ,ContactFax);
  AddXMLNode(node,'ContactEmail' ,ContactEmail);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'CardNumber' ,CardNumber);
  AddXMLNode(node,'AccountNo' ,AccountNo);
  AddXMLNode(node,'JobTitle' ,JobTitle);*)
  AddXMLNode(node,'ContactIsCustomer' ,ContactIsCustomer);
  AddXMLNode(node,'ContactIsJob' ,ContactIsJob);
  AddXMLNode(node,'ContactIsSupplier' ,ContactIsSupplier);
  AddXMLNode(node,'ContactIsOtherContact' ,ContactIsOtherContact);
  AddXMLNode(node,'UseOnRun' ,UseOnRun);
  AddXMLNode(node,'LogMeInComputerIPAddress' ,LogMeInComputerIPAddress);
  AddXMLNode(node,'LogMeInEmailPassword' ,LogMeInEmailPassword);
  AddXMLNode(node,'LogMeInUserName' ,LogMeInUserName);
  AddXMLNode(node,'LogMeInPassword' ,LogMeInPassword);
  AddXMLNode(node,'LogMeInERPUserName' ,LogMeInERPUserName);
  AddXMLNode(node,'LogMeInERPPassword' ,LogMeInERPPassword);
  AddXMLNode(node,'LogMeIncomputerPassword' ,LogMeIncomputerPassword);
end;


function TContact.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  //if CusID = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'CusID should not be 0' , False );
//    Exit;
//  end;
//  if SupID = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'SupID should not be 0' , False );
//    Exit;
//  end;
  if ContactFirstName = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Contact First Name should not be blank'  );
    Exit;
  end;

 // if EmployeeID = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'EmployeeID should not be 0'  );
//    Exit;
//  end;
  Result := True;
end;


function TContact.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TContact.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TContact.DoFieldOnChange(Sender: TField);
var
  strSQL:String;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Fastfuncs.sameTexT(Sender.fieldname , 'ISPrimaryContact') then begin
    {there can be only 1 record with ISPrimaryContact true
    don;t use update SQL - locks the table}
      if IsPrimarycontact then begin
        strSQL :='Select * from tblcontacts Where ContactID <> ' +fastfuncs.intToStr(ID);
        if CusID<>0  then strSQL:= strSQL + ' and cusId = ' +Fastfuncs.intToStr(CusID)
        else if SupID<> 0 then strSQL:= strSQL + ' and SupId = ' +Fastfuncs.intToStr(SupID);
        With getNewDataset(strSQL, true) do try
          if recordcount > 0 then begin
              first;
              while eof = False do begin
                Edit;
                fieldbyname('ISPrimaryContact').asBoolean := False;
                Post;
                Next;
              end;
          end;
        finally
          if active then close;
          free;
        end;
      end;
  end;
end;


function TContact.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TContact.GetIDField: string;
begin
  Result := 'ContactID'
end;


class function TContact.GetBusObjectTablename: string;
begin
  Result:= 'tblcontacts';
end;


function TContact.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TContact.GetCusID                   : Integer   ; begin Result := GetIntegerField('CusID')                  ;end;
function  TContact.GetSupID                   : Integer   ; begin Result := GetIntegerField('SupID')                  ;end;
function  TContact.GetEmployeeID              : Integer   ; begin Result := GetIntegerField('EmployeeID')             ;end;
(*function  TContact.GetCompany                 : string    ; begin Result := GetStringField('Company')                 ;end;
function  TContact.GetContactTitle            : string    ; begin Result := GetStringField('ContactTitle')            ;end;
function  TContact.GetContactFirstName        : string    ; begin Result := GetStringField('ContactFirstName')        ;end;
function  TContact.GeTContacturName           : string    ; begin Result := GetStringField('ContactSurName')          ;end;
function  TContact.GetContactAddress          : string    ; begin Result := GetStringField('ContactAddress')          ;end;
function  TContact.GetContactAddress2         : string    ; begin Result := GetStringField('ContactAddress2')         ;end;
function  TContact.GetContactAddress3         : string    ; begin Result := GetStringField('ContactAddress3')         ;end;
function  TContact.GetContactCity             : string    ; begin Result := GetStringField('ContactCity')             ;end;
function  TContact.GeTContacttate             : string    ; begin Result := GetStringField('ContactState')            ;end;
function  TContact.GetContactPcode            : string    ; begin Result := GetStringField('ContactPcode')            ;end;
function  TContact.GetContactCountry          : string    ; begin Result := GetStringField('ContactCountry')          ;end;
function  TContact.GetContactPH               : string    ; begin Result := GetStringField('ContactPH')               ;end;
function  TContact.GetContactAltPH            : string    ; begin Result := GetStringField('ContactAltPH')            ;end;
function  TContact.GetContactMOB              : string    ; begin Result := GetStringField('ContactMOB')              ;end;
function  TContact.GetContactFax              : string    ; begin Result := GetStringField('ContactFax')              ;end;
function  TContact.GetContactEmail            : string    ; begin Result := GetStringField('ContactEmail')            ;end;
function  TContact.GetNotes                   : string    ; begin Result := GetStringField('Notes')                   ;end;
function  TContact.GetActive                  : Boolean   ; begin Result := GetBooleanField('Active')                 ;end;
function  TContact.GetCardNumber              : string    ; begin Result := GetStringField('CardNumber')              ;end;
function  TContact.GetAccountNo               : string    ; begin Result := GetStringField('AccountNo')               ;end;
function  TContact.GetJobTitle                : string    ; begin Result := GetStringField('JobTitle')                ;end;*)

function  TContact.GetContactIsOtherContact   : Boolean   ; begin Result := GetBooleanField('ContactIsOtherContact')  ;end;
function  TContact.GetContactIsCustomer       : Boolean   ; begin Result := GetBooleanField('ContactIsCustomer')      ;end;
function  TContact.GetContactIsJob            : Boolean   ; begin Result := GetBooleanField('ContactIsJob')           ;end;
function  TContact.GetContactIsSupplier       : Boolean   ; begin Result := GetBooleanField('ContactIsSupplier')      ;end;
function  TContact.GetUseOnRun                : Boolean   ; begin Result := GetBooleanField('UseOnRun')               ;end;
function  TContact.GetLogMeInComputerIPAddress: string    ; begin Result := GetStringField('LogMeInComputerIPAddress');end;
function  TContact.GetLogMeInEmailPassword    : string    ; begin Result := GetStringField('LogMeInEmailPassword')    ;end;
function  TContact.GetLogMeInUserName         : string    ; begin Result := GetStringField('LogMeInUserName')         ;end;
function  TContact.GetLogMeInPassword         : string    ; begin Result := GetStringField('LogMeInPassword')         ;end;
function  TContact.GetLogMeInERPUserName      : string    ; begin Result := GetStringField('LogMeInERPUserName')      ;end;
function  TContact.GetLogMeInERPPassword      : string    ; begin Result := GetStringField('LogMeInERPPassword')      ;end;
function  TContact.GetLogMeIncomputerPassword : string    ; begin Result := GetStringField('LogMeIncomputerPassword') ;end;

procedure TContact.SetCusID                   (const Value: Integer   ); begin SetIntegerField('CusID'                   , Value);end;
procedure TContact.SetSupID                   (const Value: Integer   ); begin SetIntegerField('SupID'                   , Value);end;
procedure TContact.SetEmployeeID              (const Value: Integer   ); begin SetIntegerField('EmployeeID'              , Value);end;
(*procedure TContact.SetCompany                 (const Value: string    ); begin SetStringField('Company'                  , Value);end;
procedure TContact.SetContactTitle            (const Value: string    ); begin SetStringField('ContactTitle'             , Value);end;
procedure TContact.SetContactFirstName        (const Value: string    ); begin SetStringField('ContactFirstName'         , Value);end;
procedure TContact.SeTContacturName           (const Value: string    ); begin SetStringField('ContactSurName'           , Value);end;
procedure TContact.SetContactAddress          (const Value: string    ); begin SetStringField('ContactAddress'           , Value);end;
procedure TContact.SetContactAddress2         (const Value: string    ); begin SetStringField('ContactAddress2'          , Value);end;
procedure TContact.SetContactAddress3         (const Value: string    ); begin SetStringField('ContactAddress3'          , Value);end;
procedure TContact.SetContactCity             (const Value: string    ); begin SetStringField('ContactCity'              , Value);end;
procedure TContact.SeTContacttate             (const Value: string    ); begin SetStringField('ContactState'             , Value);end;
procedure TContact.SetContactPcode            (const Value: string    ); begin SetStringField('ContactPcode'             , Value);end;
procedure TContact.SetContactCountry          (const Value: string    ); begin SetStringField('ContactCountry'           , Value);end;
procedure TContact.SetContactPH               (const Value: string    ); begin SetStringField('ContactPH'                , Value);end;
procedure TContact.SetContactAltPH            (const Value: string    ); begin SetStringField('ContactAltPH'             , Value);end;
procedure TContact.SetContactMOB              (const Value: string    ); begin SetStringField('ContactMOB'               , Value);end;
procedure TContact.SetContactFax              (const Value: string    ); begin SetStringField('ContactFax'               , Value);end;
procedure TContact.SetContactEmail            (const Value: string    ); begin SetStringField('ContactEmail'             , Value);end;
procedure TContact.SetNotes                   (const Value: string    ); begin SetStringField('Notes'                    , Value);end;
procedure TContact.SetActive                  (const Value: Boolean   ); begin SetBooleanField('Active'                  , Value);end;
procedure TContact.SetCardNumber              (const Value: string    ); begin SetStringField('CardNumber'               , Value);end;
procedure TContact.SetAccountNo               (const Value: string    ); begin SetStringField('AccountNo'                , Value);end;
procedure TContact.SetJobTitle                (const Value: string    ); begin SetStringField('JobTitle'                 , Value);end;*)
procedure TContact.SetContactIsCustomer       (const Value: Boolean   ); begin SetBooleanField('ContactIsCustomer'       , Value);end;
procedure TContact.SetContactIsJob            (const Value: Boolean   ); begin SetBooleanField('ContactIsJob'            , Value);end;
procedure TContact.SetContactIsSupplier       (const Value: Boolean   ); begin SetBooleanField('ContactIsSupplier'       , Value);end;
procedure TContact.SetContactIsOtherContact   (const Value: Boolean   ); begin SetBooleanField('ContactIsOtherContact'   , Value);end;
procedure TContact.SetUseOnRun                (const Value: Boolean   ); begin SetBooleanField('UseOnRun'                , Value);end;
procedure TContact.SetLogMeInComputerIPAddress(const Value: string    ); begin SetStringField('UseOnRun'                 , Value);end;
procedure TContact.SetLogMeInEmailPassword    (const Value: string    ); begin SetStringField('LogMeInEmailPassword'     , Value);end;
procedure TContact.SetLogMeInUserName         (const Value: string    ); begin SetStringField('LogMeInUserName'          , Value);end;
procedure TContact.SetLogMeInPassword         (const Value: string    ); begin SetStringField('LogMeInPassword'          , Value);end;
procedure TContact.SetLogMeInERPUserName      (const Value: string    ); begin SetStringField('LogMeInERPUserName'       , Value);end;
procedure TContact.SetLogMeInERPPassword      (const Value: string    ); begin SetStringField('LogMeInERPPassword'       , Value);end;
procedure TContact.SetLogMeIncomputerPassword (const Value: string    ); begin SetStringField('LogMeInERPPassword'       , Value);end;


(*function TContact.getIsPrimarycontact: Boolean;begin  REsult := getbooleanfield('IsPrimarycontact');end;

procedure TContact.setIsPrimarycontact(const Value: Boolean);
begin
  SetBooleanField('IsPrimarycontact' , Value);
end;*)

initialization
  RegisterClass(TContact);


end.
