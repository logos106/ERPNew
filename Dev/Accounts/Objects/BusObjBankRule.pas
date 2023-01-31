unit BusObjBankRule;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/09/11  1.00.01 Wang  Added TBankRule business object.
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TBankRuleCondLines = class;
  TBankRuleItemLines = class;

  TBankRule = class(TMSBusObj)
  private
    AllLinesValid               : Boolean;

    function GetRuleName        : String;
    function GetRuleType        : String;
    function GetDescription     : String;
    function GetActive          : Boolean;
    function GeTApplyTo         : String;
    function GetContactID       : Integer;
    function GetContactName     : String;
    function GetReferenceTo     : String;
    function GetComment         : String;
    function GetBankRuleCondLines: TBankRuleCondLines;
    function GetBankRuleItemLines: TBankRuleItemLines;

    procedure SetRuleName         (Const Value : String);
    procedure SetRuleType         (Const Value : String);
    procedure SetDescription      (Const Value : String);
    procedure SetActive           (Const Value : Boolean);
    procedure SetApplyTo          (Const value : String);
    procedure SetContactID        (Const value : Integer);
    procedure SetContactName      (Const Value : String);
    procedure SetReferenceTo      (Const Value : String);
    procedure SetComment          (Const Value : String);

  protected
    function  DoAfterInsert(Sender: TDatasetBusObj)   : Boolean;    Override;
    function  DoAfterPost(Sender: TDatasetBusObj)     : Boolean;    Override;
    function  DoBeforePost(Sender: TDatasetBusObj)    : Boolean;    Override;
    function  GetSQL                                  : String;     Override;
    function  ValidateXMLData(Const Node :IXMLNode)   : Boolean;    Override;
    procedure ValidateDatacallback1(const Sender: TBusObj; var Abort: boolean);
    procedure ValidateDatacallback2(const Sender: TBusObj; var Abort: boolean);

  public
    Constructor     Create(AOwner: TComponent);             Override;
    destructor      Destroy;                                Override;
    procedure       DoFieldOnChange(Sender: TField);        Override;
    class function  GetBusObjectTablename: string;          Override;
    class function  GetIDField: string;                     Override;
    procedure       LoadFromXMLNode(Const node: IXMLNode);  Override;
    procedure       SaveToXMLNode(Const node: IXMLNode);    Override;
    function        ValidateData :Boolean ;                 Override;
    function        Save :Boolean ;                         Override;

  Published
    property RuleName         : String                  Read GetRuleName            Write SetRuleName;
    property RuleType         : String                  Read GetRuleType            Write SetRuleType;
    property Description      : String                  Read GetDescription         Write SetDescription;
    Property Active           : Boolean                 Read GetActive              Write SetActive;
    Property ApplyTo          : String                  Read GetApplyTo             Write SetApplyTo;
    property ContactID        : Integer                 Read GetContactID           Write SetContactID;
    Property ContactName      : String                  Read GetContactName         Write SetContactName;
    Property ReferenceTo      : String                  Read GetReferenceTo         Write SetReferenceTo;
    Property Comment          : String                  Read GetComment             Write SetComment;
    Property ConditionLines   : TBankRuleCondLines      read GetBankRuleCondLines;
    Property ItemLines        : TBankRuleItemLines      read GetBankRuleItemLines;

  end;

  TBankRuleCondLines = class(TMSBusObj)
  private
    function GetBankRuleID    : Integer;
    function GetField         : String;
    function GetCondition     : string;
    function GetValue         : String;

    procedure SetBankRuleID   (const Value: Integer   );
    procedure SetField        (const Value: String   );
    procedure SetCondition    (const Value: String    );
    procedure SetValue        (const Value: String    );

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoAfterDelete(Sender :TDatasetBusObj): Boolean;           override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;

    property BankRuleID       :Integer     read GeTBankRuleID     write SeTBankRuleID  ;

  published
    property Field        : String    read GetField       write SetField;
    property Condition    : String    read GetCondition   write SetCondition;
    property Value        : String    read GetValue       write SetValue;

  end;

  TBankRuleItemLines = class(TMSBusObj)
  private
    function GeTBankRuleID    : Integer;
    function GetDescription   : String;
    function GetAccountID     : Integer;
    function GetAccountName   : String;
    function GetTaxCode       : String;
    function GetValueType     : String;
    function GetAmount        : Double;
    function GetPercent       : Double;

    procedure SeTBankRuleID   (const Value: Integer   );
    procedure SetDescription  (const Value: String   );
    procedure SetAccountID    (const Value: Integer    );
    procedure SetAccountName  (const Value: String    );
    procedure SetTaxCode      (const Value: String    );
    procedure SetValueType    (const Value: String    );
    procedure SetAmount       (const Value: Double    );
    procedure SetPercent      (const Value: Double    );

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoAfterDelete(Sender :TDatasetBusObj): Boolean;           override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;

    property BankRuleID       :Integer     read GeTBankRuleID     write SeTBankRuleID  ;

  published
    property Description  : String    read GetDescription   write SetDescription;
    property AccountID    : Integer   read GetAccountID     write SetAccountID;
    property AccountName  : String    read GetAccountName   write SetAccountName;
    property TaxCode      : String    read GetTaxCode       write SetTaxCode;
    property ValueType    : String    read GetValueType     write SetValueType;
    property Amount       : Double    read GetAmount        write SetAmount;
    property Percent      : Double    read GetPercent       write SetPercent;

  end;


implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TBankRule }
Constructor TBankRule.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblBankRule';
  ExportExcludeList.Add('ID');
end;

destructor TBankRule.Destroy;
begin
  inherited;
end;

class function TBankRule.GetBusObjectTablename: string;
begin
  Result := 'tblBankRule';
end;

function TBankRule.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function  TBankRule.GetIDField :String;
begin
    Result := 'ID';
end;

procedure TBankRule.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

Function  TBankRule.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
var
    fiRegionId :Integer;
    fsForeignKey :String;
begin
    Result      := inherited ValidateXMLData(Node);
    fiRegionId  := 0;
    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;
    XMLSearchRecorddesc := 'Name ='  + QuotedStr(GetXMLNodeStringValue(Node, 'CodeName')) +
                            ' and region = ' + GetXMLNodeStringValue(Node, 'RegionName');
    REsult      := False;
    //foreign key validations
    fsForeignKey :='RegionName';
    if GetXMLNodeStringValue(Node, fsForeignKey) <> '' then begin
        fiRegionId		:= tcDatautils.GetRegion(GetXMLNodeStringValue   (Node, fsForeignKey));
        if fiRegionId = 0 then begin
            ErrRecordNotfound(fsForeignKey , GetXMLNodeStringValue(Node, fsForeignKey));
            Exit;
        end;
    end;

    Result := true;
    XMLSearchRecord := 'Name ='  + QuotedStr(GetXMLNodeStringValue(Node, 'CodeName')) + ' and regionId = ' + IntToStr(fiRegionId) ;
    LocateXMLRecord;

end;

function TBankRule.GetRuleName:     String;   begin Result := GetStringField('RuleName');     end;
function TBankRule.GetRuleType:     String;   begin Result := GetStringField('RuleType');     end;
function TBankRule.GetDescription:  String;   begin Result := GetStringField('Description');      end;
function TBankRule.GetActive:       Boolean;  begin Result := GetBooleanField('Active');      end;
function TBankRule.GetApplyTo:      String;   begin Result := GetStringField('ApplyTo');      end;
function TBankRule.GetContactID:    Integer;  begin Result := GetIntegerField('ContactID');   end;
function TBankRule.GetContactName:  String;   begin Result := GetStringField('ContactName');  end;
function TBankRule.GetReferenceTo:  String;   begin Result := GetStringField('ReferenceTo');  end;
function TBankRule.GetComment:      String;   begin Result := GetStringField('Comment');      end;

function TBankRule.GetBankRuleCondLines: TBankRuleCondLines;
begin
  Result := TBankRuleCondLines(GetContainerComponent(TBankRuleCondLines, 'BankRuleID = ' + IntToStr(ID)));
end;

function TBankRule.GetBankRuleItemLines: TBankRuleItemLines;
begin
  Result := TBankRuleItemLines(GetContainerComponent(TBankRuleItemLines, 'BankRuleID = ' + IntToStr(ID)));
end;

procedure TBankRule.SetRuleName     (Const Value: String);  begin SetStringField('RuleName', Value);      end;
procedure TBankRule.SetRuleType     (Const Value: String);  begin SetStringField('RuleType', Value);      end;
procedure TBankRule.SetDescription  (Const Value: String);  begin SetStringField('Description', Value);  end;
procedure TBankRule.SetActive       (Const Value: Boolean); begin SetBooleanField('Active', Value);       end;
procedure TBankRule.SetApplyTo      (Const Value: String);  begin SetStringField('ApplyTo', Value);       end;
procedure TBankRule.SetContactID    (Const Value: Integer); begin SetIntegerField('ContactID', Value);    end;
procedure TBankRule.SetContactName  (Const Value: String);  begin SetStringField('ContactName', Value);   end;
procedure TBankRule.SetReferenceTo  (Const Value: String);  begin SetStringField('ReferenceTo', Value);   end;
procedure TBankRule.SetComment      (Const Value: String);  begin SetStringField('Comment', Value);       end;

procedure TBankRule.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'RuleName');
  SetPropertyFromNode(Node,'RuleType');
  SetBooleanPropertyFromNode(Node,'Active');
  SetPropertyFromNode(Node,'ContactID');
  SetPropertyFromNode(Node,'ContactName');
  SetPropertyFromNode(Node,'ReferenceTo');
  SetPropertyFromNode(Node,'Comment');
end;

procedure TBankRule.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited;
    AddXMLNode(node , 'RuleName',     RuleName);
    AddXMLNode(node , 'RuleType',     RuleType);
    AddXMLNode(node , 'Active',       Active);
    AddXMLNode(node , 'ContactID',    ContactID);
    AddXMLNode(node , 'ContactName',  ContactName);
    AddXMLNode(node , 'ReferenceTo',  ReferenceTo);
    AddXMLNode(Node , 'Comment',      Comment);
end;

function TBankRule.ValidateData : Boolean;
var
  CleanCodeName: string;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  Result := False;
  Resultstatus.Clear;
  if Trim(RuleName) = '' then begin
    AddResult(False, rssWarning, 0, 'Rule name should not be blank');
    Exit;
  end;

  AllLinesValid := True;
  ConditionLines.IterateRecords(ValidateDatacallback1);
  Result := AllLinesValid;
  if not Result then Exit;

  AllLinesValid := True;
  ItemLines.IterateRecords(ValidateDatacallback2);
  Result := AllLinesValid;
  if not Result then Exit;

end;

procedure TBankRule.ValidateDatacallback1(const Sender: TBusObj; var Abort: boolean);
begin
  if not(Sender is TBankRuleCondLines ) then Exit;
  if not (TBankRuleCondLines(Sender).ValidateData) then begin
    AllLinesValid:= False;
    Abort := True;
  end;
end;

procedure TBankRule.ValidateDatacallback2(const Sender: TBusObj; var Abort: boolean);
begin
  if not(Sender is TBankRuleItemLines ) then Exit;
  if not (TBankRuleCondLines(Sender).ValidateData) then begin
    AllLinesValid:= False;
    Abort := True;
  end;
end;

function    TBankRule.Save :Boolean ;
begin
    Result := False;
    if not ValidateData then Exit;
    result := inherited Save;
end;

function TBankRule.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterInsert(Sender);
  if not Result then exit;
end;

function TBankRule.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TBankRule.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;

 {TBankRuleCondLine}
constructor TBankRuleCondLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Bank Rule Condition Lines';
  fSQL := 'SELECT * FROM tblbankrulecondline';
end;

destructor TBankRuleCondLines.Destroy;
begin
  inherited;
end;

class function TBankRuleCondLines.GetBusObjectTablename: string;
begin
  Result := 'tblbankrulecondline';
end;

procedure TBankRuleCondLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Field');
  SetPropertyFromNode(node,'Cndition');
  SetPropertyFromNode(node,'Value');
end;

procedure TBankRuleCondLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'BankRuleID', BankRuleID);
  AddXMLNode(node,'Field', Field);
  AddXMLNode(node,'Condition', Condition);
  AddXMLNode(node,'Value', Value);
end;

function TBankRuleCondLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if BankRuleID = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Bank Rule should not be blank', True);
    Exit;
  end;

  Result := True;
end;

function TBankRuleCondLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TBankRuleCondLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TBankRuleCondLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

function TBankRuleCondLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TBankRuleCondLines.GetIDField: string;
begin
  Result := 'ID'
end;

function TBankRuleCondLines.DoAfterDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterDelete(Sender);
  if not result then Exit;
end;

function TBankRuleCondLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;

function TBankRuleCondLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TBankRuleCondLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
end;

function TBankRuleCondLines.GetBankRuleID : Integer;  begin Result := GetIntegerField('BankRuleID');  end;
function TBankRuleCondLines.GetField      : String;   begin Result := GetStringField('Field');       end;
function TBankRuleCondLines.GetCondition  : String;   begin Result := GetStringField('Condition');   end;
function TBankRuleCondLines.GetValue      : String;   begin Result := GetStringField('Value');       end;

procedure TBankRuleCondLines.SeTBankRuleID(const Value: Integer); begin SetIntegerField('BankRuleID', Value); end;
procedure TBankRuleCondLines.SeTField(const Value: String);       begin SetStringField('Field', Value);       end;
procedure TBankRuleCondLines.SeTCondition(const Value: String);   begin SetStringField('Field', Value);       end;
procedure TBankRuleCondLines.SeTValue(const Value: String);       begin SetStringField('Field', Value);       end;

 {TBankRuleItemLines}
constructor TBankRuleItemLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Bank Rule Condition Lines';
  fSQL := 'SELECT * FROM tblbankruleitemline';
end;

destructor TBankRuleItemLines.Destroy;
begin
  inherited;
end;

class function TBankRuleItemLines.GetBusObjectTablename: string;
begin
  Result := 'tblbankruleitemline';
end;

procedure TBankRuleItemLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'BankruleID');
  SetPropertyFromNode(node, 'Description');
  SetPropertyFromNode(node, 'AccountID');
  SetPropertyFromNode(node, 'AccountName');
  SetPropertyFromNode(node, 'TaxCode');
  SetPropertyFromNode(node, 'ValueType');
  SetPropertyFromNode(node, 'Amount');
  SetPropertyFromNode(node, 'Percent');
end;

procedure TBankRuleItemLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'BankRuleID', BankRuleID);
  AddXMLNode(node,'Description', Description);
  AddXMLNode(node,'AccountID', AccountID);
  AddXMLNode(node,'AccountName', AccountName);
  AddXMLNode(node,'TaxCode', TaxCode);
  AddXMLNode(node,'ValueType', ValueType);
  AddXMLNode(node,'Amount', Amount);
  AddXMLNode(node,'Percent', Percent);
end;

function TBankRuleItemLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if BankRuleID = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Bank Rule should not be blank', True);
    Exit;
  end;

  Result := True;
end;

function TBankRuleItemLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TBankRuleItemLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TBankRuleItemLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

function TBankRuleItemLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TBankRuleItemLines.GetIDField: string;
begin
  Result := 'ID'
end;

function TBankRuleItemLines.DoAfterDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterDelete(Sender);
  if not result then Exit;
end;

function TBankRuleItemLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;

function TBankRuleItemLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TBankRuleItemLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
end;

function TBankRuleItemLines.GetBankRuleID   : Integer;  begin Result := GetIntegerField('BankRuleID');  end;
function TBankRuleItemLines.GetDescription  : String;   begin Result := GetStringField('Description');  end;
function TBankRuleItemLines.GetAccountID    : Integer;   begin Result := GetIntegerField('AccountID');   end;
function TBankRuleItemLines.GetAccountName  : String;   begin Result := GetStringField('AccountName');  end;
function TBankRuleItemLines.GetTaxCode      : String;   begin Result := GetStringField('AccountName');  end;
function TBankRuleItemLines.GetValueType    : String;   begin Result := GetStringField('AccountName');  end;
function TBankRuleItemLines.GetAmount       : Double;   begin Result := GetFloatField('Amount');        end;
function TBankRuleItemLines.GetPercent      : Double;   begin Result := GetFloatField('Percent');       end;

procedure TBankRuleItemLines.SetBankRuleID(const Value: Integer);   begin SetIntegerField('BankRuleID', Value); end;
procedure TBankRuleItemLines.SetDescription(const Value: String);   begin SetStringField('Description', Value); end;
procedure TBankRuleItemLines.SetAccountID(const Value: Integer);    begin SetIntegerField('AccountID', Value);  end;
procedure TBankRuleItemLines.SetAccountName(const Value: String);   begin SetStringField('AccountName', Value); end;
procedure TBankRuleItemLines.SetTaxCode(const Value: String);       begin SetStringField('TaxCode', Value);     end;
procedure TBankRuleItemLines.SetValueType(const Value: String);     begin SetStringField('ValueType', Value);   end;
procedure TBankRuleItemLines.SetAmount(const Value: Double);        begin SetFloatField('Amount', Value);      end;
procedure TBankRuleItemLines.SetPercent(const Value: Double);       begin SetFloatField('Percent', Value);     end;


initialization
  RegisterClassOnce(TBankRule);
  RegisterClassOnce(TBankRuleCondLines);
  RegisterClassOnce(TBankRuleItemLines);
end.

