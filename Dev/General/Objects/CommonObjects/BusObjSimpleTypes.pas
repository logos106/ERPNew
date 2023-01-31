unit BusObjSimpleTypes;

interface

uses
  Classes, BusObjBase, DB,  MyAccess,ERPdbComponents, XMLDoc, XMLIntf;

type

  TSimpleTypes = class(TMSBusObj)
  private
    function GetTypeCode       : string    ;
    function GetTypeName       : string    ;
    function GetDescription    : string    ;
    function GetIsDefault      : Boolean   ;
    function GetActive         : Boolean   ;
    function GetEQPM           : Integer;

    procedure SetTypeCode       (const Value: string    );
    procedure SetTypeName       (const Value: string    );
    procedure SetDescription    (const Value: string    );
    procedure SetIsDefault      (const Value: Boolean   );
    procedure SetActive         (const Value: Boolean   );
    procedure SetEQPM           (const Value: Integer   );

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    procedure InitializeNewObject; override;

  public
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    procedure        LoadFromXMLNode(const node: IXMLNode);              override;
    procedure        SaveToXMLNode(const node: IXMLNode);                override;
    function         ValidateData: Boolean;                              override;
    function         Save: Boolean;                                      override;
    Class function   GetIDField              : string;                   override;
    Class function   GetKeyStringField       : string;                   override;
    Class function   GetBusObjectTablename   : string;                   override;
    class function DefaultTypeName(aConnection: TCustomMyConnection = nil ;aTypeCode: string = ''): string;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    class function IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string; overload; override;
    class function IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; override;
    class function SimpleTypeCode: String; virtual;
    Class function SimpleTypeTypeDesc(const TypeCode:String): string;
    Class function SimpleTypeTypeCode(const TypeCodeDesc: string): string;
    Class function ChecknMakeSimpleType(const aTypeCode: string; const aName: string): Integer;
    class function NameExistsAndActive(const aTypeName: string): boolean;

  published
    property TypeCode        :string      read GetTypeCode      write SetTypeCode   ;
    property TypeName        :string      read GetTypeName      write SetTypeName       ;
    property Description     :string      read GetDescription   write SetDescription;
    property IsDefault       :Boolean     read GetIsDefault     write SetIsDefault  ;
    property Active          :Boolean     read GetActive        write SetActive     ;
    property EQPM            :Integer     read GetEQPM          write SetEQPM       ;

  end;

  TFollowUpType = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TFollowUpResult = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TCompanyType = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;
  TBOM_WastageReason = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TFollowUpResultType = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TStatusType = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;


  TShippingContainerStatusType = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TLeadStatusType = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TCustomerReturnStatus = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TAppointmentCancellationType = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TAppointmentStatusType = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TLeadActionType = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TPhoneSupportType = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TPhoneSupportVersion = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TEmployeeskilLevel = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TSalesCategory = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;
  TStSRoom = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;
  TStSAction = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TPhsupportStatus = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;
  TChequeStatus = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;
  TBillStatus = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;
  TReturnAuthorityStatus = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

(*  TCustomerReturnStatusStatus = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;*)
  TProcresourceColour = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TCreditStatus = class(TSimpleTypes)
  private
  protected
  public
    class function SimpleTypecode: String;Override;
  published
  end;

  TOrderStatus = class(TSimpleTypes)
  private
  public
    class function SimpleTypecode: String;Override;
  end;

implementation

uses
  CommonLib, CommonDbLib, SysUtils, DbSharedObjectsObj, tcConst,
  StoredProcedures;

{ TSimpleTypes }



destructor TSimpleTypes.Destroy;
begin
  inherited;
end;
procedure TSimpleTypes.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TypeCode');
  SetPropertyFromNode(node,'TypeName');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'IsDefault');
  SetPropertyFromNode(node,'Active');
end;

class function TSimpleTypes.NameExistsAndActive(
  const aTypeName: string): boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.SQL.Add('SELECT * from tblsimpletypes');
    qry.SQL.Add('WHERE TypeCode = ' + QuotedStr(SimpleTypecode));
    qry.SQL.Add('AND Name = ' + QuotedStr(aTypeName));
    qry.Open;
    result := (not qry.IsEmpty) and qry.FieldByName('Active').ASBoolean;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TSimpleTypes.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TypeCode' ,TypeCode);
  AddXMLNode(node,'TypeName' ,TypeName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'IsDefault' ,IsDefault);
  AddXMLNode(node,'Active' ,Active);
end;
function TSimpleTypes.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  result := false;
  if TypeCode = '' then begin
    AddREsult(false,rssWarning,0,'Type Code is missing.');
    exit;
  end;
  if self.TypeName  = '' then begin
    AddREsult(false,rssWarning,0,'Type Name is missing.');
    exit;
  end;
  Result := True;
end;
class function TSimpleTypes._Schema: string;
begin
  result:= inherited;
end;
function TSimpleTypes.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;
procedure TSimpleTypes.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;
procedure TSimpleTypes.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;
function TSimpleTypes.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  InitializeNewObject;
end;
Class function TSimpleTypes.GetIDField: string;begin  Result := 'Id'end;
Class function TSimpleTypes.GetKeyStringField: string;begin  Result := 'Name'end;
class function TSimpleTypes.GetKeyStringProperty: string;begin  result:= 'TypeName';end;
Class function TSimpleTypes.SimpleTypecode: String;begin  result:= '';end;

Class function TSimpleTypes.SimpleTypeTypeCode(const typecodedesc:String):String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.sql.text := 'Select SimpleTypeDesctocode(' +Quotedstr(typecodedesc)+') as SimpleTypeCode';
    Qry.open;
    REsult := Qry.fieldbyname('SimpleTypeCode').asString;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;
class function TSimpleTypes.SimpleTypeTypeDesc(const typecode: String): String;
var
  qry: TERPQuery;
begin
  result := '';
  try
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        Qry.sql.text := 'Select SimpleTypetoDesc(' +Quotedstr(typecode)+') as SimpleTypedesc';
        try
          Qry.open;
        except
          on e: exception do begin
            if Pos('SimpleTypetoDesc does not exist', e.Message) > 0 then begin
              CreateSP('SimpleTypetoDesc');
              Qry.Open;
            end;
          end;
        end;
        result := Qry.fieldbyname('SimpleTypedesc').asString;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
  Except
    // kill the exception of the stored procedure not being created - running erp once will create it and second time it will work
  end;
end;


Class function TSimpleTypes.GetBusObjectTablename: string;begin  Result := 'tblsimpletypes'end;
{Property functions}
function  TSimpleTypes.GetTypeCode   : string    ; begin Result := GetStringField('TypeCode');end;
function  TSimpleTypes.GetTypeName   : string    ; begin Result := GetStringField('Name');end;
function  TSimpleTypes.GetDescription: string    ; begin Result := GetStringField('Description');end;
function  TSimpleTypes.GetIsDefault  : Boolean   ; begin Result := GetBooleanField('IsDefault');end;
function  TSimpleTypes.GetActive     : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TSimpleTypes.GetEQPM       : Integer   ; begin Result := GetIntegerField('EQPM');end;

procedure TSimpleTypes.SetTypeCode   (const Value: string    ); begin SetStringField('TypeCode'    , Value);end;
procedure TSimpleTypes.SetTypeName   (const Value: string    ); begin SetStringField('Name'        , Value);end;
procedure TSimpleTypes.SetDescription(const Value: string    ); begin SetStringField('Description'        , Value);end;
procedure TSimpleTypes.SetIsDefault  (const Value: Boolean   ); begin SetBooleanField('IsDefault'   , Value);end;
procedure TSimpleTypes.SetActive     (const Value: Boolean   ); begin SetBooleanField('Active'      , Value);end;
procedure TSimpleTypes.SetEQPM       (const Value: Integer   ); begin SetIntegerField('EQPM'        , Value);end;


function TSimpleTypes.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  InitializeNewObject;
end;

class function TSimpleTypes.DefaultTypeName(aConnection: TCustomMyConnection = nil;  aTypeCode: string = ''): string;
var
  Qry:TERPQuery;
begin
  Result := '';
  if aTypeCode = '' then aTypeCode :=SimpleTypecode;
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    with Qry do begin
      SQL.Text := 'select name from tblSimpleTypes where TypeCode = ' + QuotedStr(aTypeCode)+' and IsDefault ="T"';
      Open;
      Result := FieldByName('name').AsString;
      Close;
      SQL.Clear;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

end;
class function TSimpleTypes.IDToggle(const ID: Integer; Connection: TCustomMyConnection; const AndSQL: string): string;
begin
  result:= inherited IdToggle(ID, Connection,    'TypeCode = "' + SimpleTypeCode + '"' );
end;

class function TSimpleTypes.IDToggle(const KeyString: string; Connection: TCustomMyConnection; const AndSQL: string): Integer;
begin
  result:= inherited IdToggle(KeyString, Connection,    'TypeCode = "' + SimpletypeCode + '"' );
end;

procedure TSimpleTypes.InitializeNewObject;
begin
  inherited;
  if TypeCode = '' then TypeCode:= SimpleTypecode;
end;

class function TSimpleTypes.ChecknMakeSimpleType(const atypecode, aName: String): Integer;
var
  STObj :TSimpleTypes;
begin
  result := 0;
  if(atypecode ='' ) or (aname = '') then exit;
  STObj := TSimpleTypes.createwithNewConn(nil);
  try
    STObj.loadselect('TypeCode = ' + quotedstr(atypecode)+' and Name = ' + quotedstr(aName));
    if STObj.count =0 then begin
      STObj.New;
      STObj.TypeCode := atypecode;
      STObj.TypeName := aName;
      STObj.PostDB;
    end
    else begin
      if not STObj.Active then begin
        STObj.Active := true;
        STObj.PostDB;
      end;
    end;
    result := STObj.ID;
  finally
    Freeandnil(STObj);
  end;

end;

constructor TSimpleTypes.Create(AOwner: TComponent);
begin
  inherited  Create(AOwner);
  fSQL := 'SELECT * FROM tblsimpletypes';
  if SimpleTypecode <> '' then fSQL := fSQL + ' WHERE TypeCode = "' + SimpleTypecode + '"';
end;

class function TLeadStatusType.SimpleTypecode              : string;begin  Result := SimpleTypes_LeadStatusType              ;end;
class function TFollowUpResult.SimpleTypecode              : string;begin  Result := SimpleTypes_FollowUpResultType          ;end;
class function TCompanyType.SimpleTypecode                 : string;begin  Result := SimpleTypes_CompanyType                 ;end;
class function TBOM_WastageReason.SimpleTypecode           : string;begin  Result := SimpleTypes_BOM_WastageReason           ;end;
class function TFollowUpResultType.SimpleTypecode          : string;begin  Result := SimpleTypes_FollowUpResultType          ;end;
class function TStatusType.SimpleTypecode                  : string;begin  Result := SimpleTypes_StatusType                  ;end;
class function TCustomerReturnStatus.SimpleTypecode        : string;begin  Result := SimpleTypes_CustomerReturnStatus        ;end;
class function TShippingContainerStatusType.SimpleTypecode : string;begin  Result := SimpleTypes_ShippingContainerStatusType ;end;
class function TAppointmentCancellationType.SimpleTypecode : string;begin  Result := SimpleTypes_AppointmentCancellationType ;end;
class function TAppointmentStatusType.SimpleTypecode       : string;begin  Result := SimpleTypes_AppointmentStatusType       ;end;
class function TLeadActionType.SimpleTypecode              : string;begin  Result := SimpleTypes_LeadActionType              ;end;
class function TFollowUpType.SimpleTypecode                : string;begin  Result := SimpleTypes_FollowUpType                ;end;
class function TPhoneSupportType.SimpleTypecode            : string;begin  Result := SimpleTypes_PhoneSupportType            ;end;
class function TPhoneSupportVersion.SimpleTypecode         : string;begin  Result := SimpleTypes_PhoneSupportVersion         ;end;
class function TSalesCategory.SimpleTypecode               : string;begin  Result := SimpleTypes_SalesCategory               ;end;
class function TStSRoom.SimpleTypecode                     : string;begin  Result := SimpleTypes_StSRoom                     ;end;
class function TStSAction.SimpleTypecode                   : string;begin  Result := SimpleTypes_StSAction                   ;end;
class function TEmployeeskilLevel.SimpleTypecode           : string;begin  Result := SimpleTypes_EmployeeskillLevel          ;end;
class function TPhsupportStatus.SimpleTypecode             : String;begin  Result := SimpleTypes_PhSupportStatusType         ;end;
class function TChequeStatus.SimpleTypecode                : String;begin  Result := SimpleTypes_cheque                      ;end;
class function TBillStatus.SimpleTypecode                  : String;begin  Result := SimpleTypes_Bill                        ;end;
class function TCreditStatus.SimpleTypecode                : String;begin  Result := SimpleTypes_Credit                      ;end;
class function TOrderStatus.SimpleTypeCode                 : string;begin  Result := SimpleTypes_OrderStatus                 ;end;
class function TReturnAuthorityStatus.SimpleTypecode       : String;begin  Result := SimpleTypes_ReturnAuthority             ;end;
//class function TCustomerReturnStatusStatus.SimpleTypecode  : String;begin  Result := SimpleTypes_CustomerReturnStatus        ;end;
class function TProcresourceColour.SimpleTypecode          : String;begin  Result := SimpleTypes_ProcresourceColour          ;end;

initialization
  RegisterClassOnce(TSimpleTypes);
  RegisterClassOnce(TFollowUpResult);
  RegisterClassOnce(TFollowUpType);
  RegisterClassOnce(TCompanyType);
  RegisterClassOnce(TBOM_WastageReason);
  RegisterClassOnce(TFollowUpResultType);
  RegisterClassOnce(TStatusType);
  RegisterClassOnce(TLeadStatusType);
  RegisterClassOnce(TCustomerReturnStatus);
  RegisterClassOnce(TAppointmentCancellationType);
  RegisterClassOnce(TAppointmentStatusType);
  RegisterClassOnce(TLeadActionType);
  RegisterClassOnce(TPhoneSupportType);
  RegisterClassOnce(TPhoneSupportVersion);
  RegisterClassOnce(TSalesCategory);
  RegisterClassOnce(TStSRoom);
  RegisterClassOnce(TStSAction);
  RegisterClassOnce(TOrderStatus);
  RegisterClassOnce(TChequeStatus);
  RegisterClassOnce(TBillStatus);
  RegisterClassOnce(TCreditStatus);
  RegisterClassOnce(TReturnAuthorityStatus);
  //RegisterClassOnce(TCustomerReturnStatusStatus);
  RegisterClassOnce(TProcresourceColour);

end.
