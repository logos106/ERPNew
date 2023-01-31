unit BusObjTenderAccountPrefs;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  10/12/12  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TTenderAccountPrefs = class(TMSBusObj)
  private
    function GetPaymethodID         : Integer   ;
    function GetPaymethod           : string    ;
    function GetAccountID           : Integer   ;
    function GetAccount             : string    ;
    function GetSurchargePercent    : Double    ;
    function GetActive              : Boolean   ;
    procedure SetPaymethodID         (const Value: Integer   );
    procedure SetPaymethod           (const Value: string    );
    procedure SetAccountID           (const Value: Integer   );
    procedure SetAccount             (const Value: string    );
    procedure SetSurchargePercent    (const Value: Double    );
    procedure SetActive              (const Value: Boolean   );
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
    property PayMethodID          :Integer     read GetPaymethodID        write SetPaymethodID     ;
    property PayMethod            :string      read GetPaymethod          write SetPaymethod       ;
    property AccountID            :Integer     read GetAccountID          write SetAccountID       ;
    property Account              :string      read GetAccount            write SetAccount         ;
    property SurchargePercent     :Double      read GetSurchargePercent   write SetSurchargePercent;
    property Active               :Boolean     read GetActive             write SetActive          ;
  end;


implementation


uses
  tcDataUtils, CommonLib, SysUtils, BusObjGLAccount, BusobjPaymethods;


  {TTenderAccountPrefs}

constructor TTenderAccountPrefs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TenderAccountPrefs';
  fSQL := 'SELECT * FROM tbltenderaccountprefs';
end;


destructor TTenderAccountPrefs.Destroy;
begin
  inherited;
end;


procedure TTenderAccountPrefs.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PaymethodID');
  SetPropertyFromNode(node,'Paymethod');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'Account');
  SetPropertyFromNode(node,'SurchargePercent');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TTenderAccountPrefs.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PaymethodID' ,PaymethodID);
  AddXMLNode(node,'Paymethod' ,Paymethod);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'Account' ,Account);
  AddXMLNode(node,'SurchargePercent' ,SurchargePercent);
  AddXMLNode(node,'Active' ,Active);
end;


function TTenderAccountPrefs.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TTenderAccountPrefs.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTenderAccountPrefs.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TTenderAccountPrefs.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName , 'PayMethodID') then begin
    self.Paymethod := TPaymentMethod.IDToggle(self.PayMethodID, self.Connection.Connection);
  end
  else if SysUtils.SameText(Sender.fieldName , 'PayMethod') then begin
    self.PaymethodID := TPaymentMethod.IDToggle(self.PayMethod, self.Connection.Connection);
  end
  else if SysUtils.SameText(Sender.fieldName , 'AccountID') then begin
    self.Account := TAccount.IDToggle(self.AccountID, self.Connection.Connection);
  end
  else if SysUtils.SameText(Sender.fieldName , 'Account') then begin
    self.AccountID := TAccount.IDToggle(self.Account, self.Connection.Connection);
  end;
end;


function TTenderAccountPrefs.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTenderAccountPrefs.GetIDField: string;
begin
  Result := 'TAPID'
end;


class function TTenderAccountPrefs.GetBusObjectTablename: string;
begin
  Result:= 'tbltenderaccountprefs';
end;


function TTenderAccountPrefs.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TTenderAccountPrefs.GetPaymethodID     : Integer   ; begin Result := GetIntegerField('PaymethodID');end;
function  TTenderAccountPrefs.GetPaymethod       : string    ; begin Result := GetStringField('Paymethod');end;
function  TTenderAccountPrefs.GetAccountID       : Integer   ; begin Result := GetIntegerField('AccountID');end;
function  TTenderAccountPrefs.GetAccount         : string    ; begin Result := GetStringField('Account');end;
function  TTenderAccountPrefs.GetSurchargePercent: Double    ; begin Result := GetFloatField('SurchargePercent');end;
function  TTenderAccountPrefs.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TTenderAccountPrefs.SetPaymethodID     (const Value: Integer   ); begin SetIntegerField('PaymethodID'      , Value);end;
procedure TTenderAccountPrefs.SetPaymethod       (const Value: string    ); begin SetStringField('Paymethod'        , Value);end;
procedure TTenderAccountPrefs.SetAccountID       (const Value: Integer   ); begin SetIntegerField('AccountID'        , Value);end;
procedure TTenderAccountPrefs.SetAccount         (const Value: string    ); begin SetStringField('Account'          , Value);end;
procedure TTenderAccountPrefs.SetSurchargePercent(const Value: Double    ); begin SetFloatField('SurchargePercent' , Value);end;
procedure TTenderAccountPrefs.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;


initialization
  RegisterClass(TTenderAccountPrefs);


end.
