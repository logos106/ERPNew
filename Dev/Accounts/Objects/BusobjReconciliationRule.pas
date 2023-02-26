unit BusObjReconciliationRule;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 23/02/03  1.00.01 Wang  Added TBankImportRule business object.
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TReconciliationRule = class(TMSBusObj)
  private
    function  GetPayee        : String;
    function  GetStatementDesc: String;

    procedure SetPayee        (Const Value : String);
    procedure SetStatementDesc(Const Value : String);

  protected
    function  DoAfterInsert(Sender: TDatasetBusObj)   : Boolean;    Override;
    function  DoAfterPost(Sender: TDatasetBusObj)     : Boolean;    Override;
    function  DoBeforePost(Sender: TDatasetBusObj)    : Boolean;    Override;
    function  GetSQL                                  : String;     Override;
    function  ValidateXMLData(Const Node :IXMLNode)   : Boolean;    Override;

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
    property Payee          : String    read GetPayee         write SetPayee;
    property StatementDesc  : String    read GetStatementDesc write SetStatementDesc;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TBankImportRule }
Constructor TReconciliationRule.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fSql := 'SELECT * FROM tblbankreconciliationrules';
end;

destructor TReconciliationRule.Destroy;
begin
  inherited;
end;

class function TReconciliationRule.GetBusObjectTablename: string;
begin
  Result := 'tblbankreconciliationrules';
end;

function TReconciliationRule.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function  TReconciliationRule.GetIDField :String;
begin
    Result := 'ID';
end;

procedure TReconciliationRule.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

Function  TReconciliationRule.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
var
    fiRegionId :Integer;
    fsForeignKey :String;
begin
    Result := inherited ValidateXMLData(Node);
    LocateXMLRecord;
end;

function TReconciliationRule.GetPayee:          String;   begin Result := GetStringField('Payee');          end;
function TReconciliationRule.GetStatementDesc:  String;   begin Result := GetStringField('StatementDesc');  end;

procedure TReconciliationRule.SetPayee        (Const Value: String);  begin SetStringField('Payee', Value);         end;
procedure TReconciliationRule.SetStatementDesc(Const Value: String);  begin SetStringField('StatementDesc', Value); end;

procedure TReconciliationRule.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'Payee');
  SetPropertyFromNode(Node, 'StatementDesc');
end;

procedure TReconciliationRule.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node , 'BankCodeID', Payee);
  AddXMLNode(node , 'BankName', StatementDesc);
end;

function TReconciliationRule.ValidateData: Boolean;
var
  CleanCodeName: string;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  Result := False;
  Resultstatus.Clear;

  if Payee <> '' then begin
    AddResult(False, rssWarning, 0, 'Payee should not be blank');
    Exit;
  end;

  Result := True;
end;

function TReconciliationRule.Save :Boolean ;
begin
    Result := False;
    if not ValidateData then Exit;

    result := inherited Save;
end;

function TReconciliationRule.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterInsert(Sender);
  if not Result then exit;
end;

function TReconciliationRule.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TReconciliationRule.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;

initialization
  RegisterClassOnce(TReconciliationRule);
end.

