unit BusObjBankImportRule;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 23/02/03  1.00.01 Wang  Added TBankImportRule business object.
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TBankImportRule = class(TMSBusObj)
  private
    function GetBankCodeID        : Integer;
    function GetBankName          : String;
    function GetDateColumn        : Integer;
    function GetDateLabel         : String;
    function GetDescColumn        : Integer;
    function GetDescLabel         : String;
    function GetAmountColumn      : Integer;
    function GetAmountLabel       : String;
    function GetBankDescColumn    : Integer;
    function GetBankDescLabel     : String;
    function GetReferenceColumn   : Integer;
    function GetReferenceLabel    : String;
    function GetNotesColumn       : Integer;
    function GetNotesLabel        : String;

    procedure SetBankCodeID       (Const Value : Integer);
    procedure SetDateColumn       (Const Value : Integer);
    procedure SetDateLabel        (Const Value : String);
    procedure SetDescColumn       (Const value : Integer);
    procedure SetDescLabel        (Const value : String);
    procedure SetAmountColumn     (Const Value : Integer);
    procedure SetAmountLabel      (Const Value : String);
    procedure SetBankDescColumn   (Const Value : Integer);
    procedure SetBankDescLabel    (Const Value : String);
    procedure SetReferenceColumn  (Const Value : Integer);
    procedure SetReferenceLabel   (Const Value : String);
    procedure SetNotesColumn      (Const Value : Integer);
    procedure SetNotesLabel       (Const Value : String);

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
    property BankCodeID         : Integer   read GetBankCodeID        write SetBankCodeID;
    property BankName           : String    read GetBankName;
    property DateColumn         : Integer   read GetDateColumn        write SetDateColumn;
    property DateLabel          : String    read GetDateLabel         write SetDateLabel;
    property DescColumn         : Integer   read GetDescColumn        write SetDescColumn;
    property DescLabel          : String    read GetDescLabel         write SetDescLabel;
    property AmountColumn       : Integer   read GetAmountColumn      write SetAmountColumn;
    property AmountLabel        : String    read GetAmountLabel       write SetAmountLabel;
    property BankDescColumn     : Integer   read GetBankDescColumn    write SetBankDescColumn;
    property BankDescLabel      : String    read GetBankDescLabel     write SetBankDescLabel;
    property ReferenceColumn    : Integer   read GetReferenceColumn   write SetReferenceColumn;
    property ReferenceLabel     : String    read GetReferenceLabel    write SetReferencelabel;
    property NotesColumn        : Integer   read GetNotesColumn       write SetNotesColumn;
    property NotesLabel         : String    read GetNotesLabel        write SetNoteslabel;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TBankImportRule }
Constructor TBankImportRule.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fSql := 'SELECT r.*, b.BankName FROM tblBankImportRules r INNER JOIN tblBankCodes b ON r.BankCodeID=b.CodeID';
end;

destructor TBankImportRule.Destroy;
begin
  inherited;
end;

class function TBankImportRule.GetBusObjectTablename: string;
begin
  Result := 'tblBankImportRules';
end;

function TBankImportRule.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function  TBankImportRule.GetIDField :String;
begin
    Result := 'ID';
end;

procedure TBankImportRule.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

Function  TBankImportRule.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
var
    fiRegionId :Integer;
    fsForeignKey :String;
begin
    Result := inherited ValidateXMLData(Node);
    LocateXMLRecord;
end;

function TBankImportRule.GetBankCodeID:         Integer;  begin Result := GetIntegerField('BankCodeID');        end;
function TBankImportRule.GetBankName:           String;   begin Result := GetStringField('BankName');           end;
function TBankImportRule.GetDateColumn:         Integer;  begin Result := GetIntegerField('DateColumn');        end;
function TBankImportRule.GetDateLabel:          String;   begin Result := GetStringField('DateLabel');          end;
function TBankImportRule.GetDescColumn:         Integer;  begin Result := GetIntegerField('DescColumn');        end;
function TBankImportRule.GetDescLabel:          String;   begin Result := GetStringField('DescLabel');          end;
function TBankImportRule.GetAmountColumn:       Integer;  begin Result := GetIntegerField('AmountColumn');      end;
function TBankImportRule.GetAmountLabel:        String;   begin Result := GetStringField('AmountLabel');        end;
function TBankImportRule.GetBankDescColumn:     Integer;  begin Result := GetIntegerField('BankDescColumn');    end;
function TBankImportRule.GetBankDescLabel:      String;   begin Result := GetStringField('BankDescLabel');      end;
function TBankImportRule.GetReferenceColumn:    Integer;  begin Result := GetIntegerField('ReferenceColumn');   end;
function TBankImportRule.GetReferenceLabel:     String;   begin Result := GetStringField('ReferenceLabel');     end;
function TBankImportRule.GetNotesColumn:        Integer;  begin Result := GetIntegerField('NotesColumn');       end;
function TBankImportRule.GetNotesLabel:         String;   begin Result := GetStringField('NotesLabel');         end;

procedure TBankImportRule.SetBankCodeID         (Const Value: Integer); begin SetIntegerField('BankCodeID', Value);     end;
procedure TBankImportRule.SetDateColumn         (Const Value: Integer); begin SetIntegerField('DateColumn', Value);     end;
procedure TBankImportRule.SetDateLabel          (Const Value: String);  begin SetStringField('DateLabel', Value);       end;
procedure TBankImportRule.SetDescColumn         (Const Value: Integer); begin SetIntegerField('DescColumn', Value);     end;
procedure TBankImportRule.SetDescLabel          (Const Value: String);  begin SetStringField('DescLabel', Value);       end;
procedure TBankImportRule.SetAmountColumn       (Const Value: Integer); begin SetIntegerField('AmountColumn', Value);   end;
procedure TBankImportRule.SetAmountLabel        (Const Value: String);  begin SetStringField('AmountLabel', Value);     end;
procedure TBankImportRule.SetBankDescColumn     (Const Value: Integer); begin SetIntegerField('BankDescColumn', Value); end;
procedure TBankImportRule.SetBankDescLabel      (Const Value: String);  begin SetStringField('BankDescLabel', Value);   end;
procedure TBankImportRule.SetReferenceColumn    (Const Value: Integer); begin SetIntegerField('ReferenceColumn', Value);end;
procedure TBankImportRule.SetReferenceLabel     (Const Value: String);  begin SetStringField('ReferenceLabel', Value);  end;
procedure TBankImportRule.SetNotesColumn        (Const Value: Integer); begin SetIntegerField('NotesColumn', Value);    end;
procedure TBankImportRule.SetNotesLabel         (Const Value: String);  begin SetStringField('NotesLabel', Value);      end;

procedure TBankImportRule.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'BankCodeID');
  SetPropertyFromNode(Node, 'BankName');
  SetPropertyFromNode(Node, 'DateColumn');
  SetPropertyFromNode(Node, 'DateLabel');
  SetPropertyFromNode(Node, 'DescColumn');
  SetPropertyFromNode(Node, 'DescLabel');
  SetPropertyFromNode(Node, 'AmountColumn');
  SetPropertyFromNode(Node, 'AmountLabel');
  SetPropertyFromNode(Node, 'BankDescColumn');
  SetPropertyFromNode(Node, 'BankDescLabel');
  SetPropertyFromNode(Node, 'ReferenceColumn');
  SetPropertyFromNode(Node, 'ReferenceLabel');
  SetPropertyFromNode(Node, 'NotesColumn');
  SetPropertyFromNode(Node, 'NotesLabel');
end;

procedure TBankImportRule.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node , 'BankCodeID', BankCodeID);
  AddXMLNode(node , 'BankName', BankName);
  AddXMLNode(node , 'DateColumn', DateColumn);
  AddXMLNode(node , 'DateLabel', DateLabel);
  AddXMLNode(node , 'DescColumn', DescColumn);
  AddXMLNode(node , 'DescColumn', DescColumn);
  AddXMLNode(Node , 'AmountColumn', AmountColumn);
  AddXMLNode(Node , 'AmountLabel', AmountLabel);
  AddXMLNode(Node , 'BankDescColumn', BankDescColumn);
  AddXMLNode(Node , 'BankDescLabel', BankDescLabel);
  AddXMLNode(Node , 'ReferenceColumn', ReferenceColumn);
  AddXMLNode(Node , 'ReferenceLabel', ReferenceLabel);
  AddXMLNode(Node , 'NotesColumn', NotesColumn);
  AddXMLNode(Node , 'NotesLabel', NotesLabel);
end;

function TBankImportRule.ValidateData: Boolean;
var
  CleanCodeName: string;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  Result := False;
  Resultstatus.Clear;

  if BankCodeID < 1 then begin
    AddResult(False, rssWarning, 0, 'Bank code ID should not be less than 1');
    Exit;
  end;

  Result := True;
end;

function    TBankImportRule.Save :Boolean ;
begin
    Result := False;
    if not ValidateData then Exit;

    result := inherited Save;
end;

function TBankImportRule.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterInsert(Sender);
  if not Result then exit;
end;

function TBankImportRule.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TBankImportRule.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;

initialization
  RegisterClassOnce(TBankImportRule);
end.

