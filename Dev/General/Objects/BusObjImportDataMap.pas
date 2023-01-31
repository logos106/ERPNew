unit BusObjImportDataMap;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  31/08/11  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, JsonObject;

type
  TImportDataMap = class(TMSBusObj)
  private
    function GetImportName: string;
    function GetImportFileName: string;
    function GetTypeName: string;
    function GetMapping: string;
    procedure SetImportName(const Value: string);
    procedure SetImportFileName(const Value: string);
    procedure SetTypeName(const Value: string);
    procedure SetMapping(const Value: string);
    function GetFirstLineHeadings: boolean;
    function GetSeparationType: string;
//    function GetSeparatorName: string;
    function GetSeparatorValue: string;
    function GetTextDelimiter: string;
    procedure SetFirstLineHeadings(const Value: boolean);
    procedure SetSeparationType(const Value: string);
//    procedure SetSeparatorName(const Value: string);
    procedure SetSeparatorValue(const Value: string);
    procedure SetTextDelimiter(const Value: string);
    function ImportNameUnique: boolean;
    function GetColumnCount: integer;
    procedure SetColumnCount(const Value: integer);
    function GetColumns: TJsonArray;
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function GetTypeClassName: string;
    procedure SetTypeClassName(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    Function DoAfterOpen(Sender :TDatasetBusObj): Boolean; override;
    Function DoBeforePost(Sender :TDatasetBusObj): Boolean; override;
  public
    MapJson: TJsonObject;
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure New; override;
    property Columns: TJsonArray read GetColumns;
  published
    property ImportName: string read GetImportName write SetImportName;
    property ImportFileName: string read GetImportFileName write SetImportFileName;
    property TypeName: string read GetTypeName write SetTypeName;
    property TypeClassName: string read GetTypeClassName write SetTypeClassName;
    property Active: boolean read GetActive write SetActive;
    property Mapping: string read GetMapping write SetMapping;
    {  properties implemented in json structure }
    property FirstLineHeadings: boolean read GetFirstLineHeadings write SetFirstLineHeadings;
    property SeparationType: string read GetSeparationType write SetSeparationType;
//    property SeparatorName: string read GetSeparatorName write SetSeparatorName;
    property SeparatorValue: string read GetSeparatorValue write SetSeparatorValue;
    property TextDelimiter: string read GetTextDelimiter write SetTextDelimiter;
    property ColumnCount: integer read GetColumnCount write SetColumnCount;
  end;

const
  SeparationType_Seperated = 'Seperated';
  SeparationType_Fixed = 'Fixed';
//  SeparatorName_Tab = 'Tab';
//  SeparatorName_Semicolon = 'Semicolon';
//  SeparatorName_Comma = 'Comma';
//  SeparatorName_Space = 'Space';
//  SeparatorName_Other = 'Other';

implementation

uses tcDataUtils, CommonLib, ERPdbComponents, sysutils;

{ TImportDataMap }

constructor TImportDataMap.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MapJson:= TJsonObject.Create;
  fBusObjectTypeDescription := 'ImportDataMap';
  fSQL := 'SELECT * FROM tblimportdatamap';
end;

destructor TImportDataMap.Destroy;
begin
  inherited;
  MapJson.Free;
end;

procedure TImportDataMap.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'ImportName');
  SetPropertyFromNode(node, 'ImportFileName');
  SetPropertyFromNode(node, 'TypeName');
  SetPropertyFromNode(node, 'Mapping');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TImportDataMap.New;
begin
  inherited;
  { initilalise defaults }
  FirstLineHeadings:= false;
  SeparationType:= SeparationType_Seperated;
//  SeparatorName:= SeparatorName_Comma;
  SeparatorValue:= ',';
  TextDelimiter:= '"';
  FirstLineHeadings:= true;
end;

procedure TImportDataMap.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'ImportName', ImportName);
  AddXMLNode(node, 'ImportFileName', ImportFileName);
  AddXMLNode(node, 'TypeName', TypeName);
  AddXMLNode(node, 'Mapping', Mapping);
  AddXMLNode(node, 'Active', Active);
end;

function TImportDataMap.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if self.ImportName = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Import Name should not be blank');
    Exit;
  end;
  if not ImportNameUnique then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Import Name has already been used by another active Import Map');
    Exit;
  end;
  if self.TypeName = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Type Name should not be blank');
    Exit;
  end;
  if self.TypeClassName = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Type Class Name should not be blank');
    Exit;
  end;
  Result := True;
end;

function TImportDataMap.Save: Boolean;
begin
  SetStringField('Mapping', MapJson.AsString);
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TImportDataMap.OnDataIDChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TImportDataMap.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TImportDataMap.GetSeparationType: string;
begin
  result:= MapJson.S['SeparationType'];
end;

//function TImportDataMap.GetSeparatorName: string;
//begin
//  result:= MapJson.S['SeparatorName'];
//end;

function TImportDataMap.GetSeparatorValue: string;
begin
  result:= MapJson.S['SeparatorValue'];
end;

function TImportDataMap.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TImportDataMap.GetIDField: string;
begin
  Result := 'ImportDataMapID'
end;

function TImportDataMap.GetActive: boolean;
begin
  result:= GetBooleanField('Active');
end;

class function TImportDataMap.GetBusObjectTablename: string;
begin
  Result := 'tblimportdatamap';
end;

function TImportDataMap.GetColumnCount: integer;
begin
  result:= MapJson.I['ColumnCount'];
end;

function TImportDataMap.GetColumns: TJsonArray;
begin
  result:= MapJson.A['Columns'];
end;

function TImportDataMap.GetFirstLineHeadings: boolean;
begin
  result:= MapJson.B['FirstLineHeadings'];
end;

function TImportDataMap.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
  MapJson.AsString:= GetStringField('Mapping');
end;

function TImportDataMap.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TImportDataMap.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
end;

{ Property Functions }
function TImportDataMap.GetImportName: string;
begin
  Result := GetStringField('ImportName');
end;

class function TImportDataMap.GetKeyStringField: string;
begin
  result:= 'ImportName';
end;

function TImportDataMap.GetImportFileName: string;
begin
  Result := GetStringField('ImportFileName');
end;

function TImportDataMap.GetTextDelimiter: string;
begin
  result:= MapJson.S['TextDelimiter'];
end;

function TImportDataMap.GetTypeClassName: string;
begin
  result:= MapJson.S['TypeClassName'];
end;

function TImportDataMap.GetTypeName: string;
begin
  Result := GetStringField('TypeName');
end;

function TImportDataMap.ImportNameUnique: boolean;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= Connection.Connection;
    qry.SQL.Add('select ImportDataMapID from tblImportDataMap');
    qry.SQL.Add('where ImportDataMapID <> ' + IntToStr(ID));
    qry.SQL.Add('and Active = "T"');
    qry.SQL.Add('and typename =' +Quotedstr(typename));
    qry.SQL.Add('and ImportName = ' + QuotedStr(ImportName));
    qry.Open;
    result:= qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

function TImportDataMap.GetMapping: string;
begin
  Result := MapJson.AsString;
end;

procedure TImportDataMap.SetImportName(const Value: string);
begin
  SetStringField('ImportName', Value);
end;

procedure TImportDataMap.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TImportDataMap.SetColumnCount(const Value: integer);
begin
  MapJson.I['ColumnCount']:= Value;
  self.Dirty:= true;
end;

procedure TImportDataMap.SetFirstLineHeadings(const Value: boolean);
begin
  MapJson.B['FirstLineHeadings']:= Value;
  self.Dirty:= true;
end;

procedure TImportDataMap.SetImportFileName(const Value: string);
begin
  SetStringField('ImportFileName', Value);
end;

procedure TImportDataMap.SetTextDelimiter(const Value: string);
begin
  MapJson.S['TextDelimiter']:= Value;
  self.Dirty:= true;
end;

procedure TImportDataMap.SetTypeClassName(const Value: string);
begin
  MapJson.S['TypeClassName']:= Value;
  self.Dirty:= true;
end;

procedure TImportDataMap.SetTypeName(const Value: string);
begin
  SetStringField('TypeName', Value);
end;

procedure TImportDataMap.SetMapping(const Value: string);
begin
  MapJson.AsString:= Value;
  self.Dirty:= true;
end;

procedure TImportDataMap.SetSeparationType(const Value: string);
begin
  MapJson.S['SeparationType']:= Value;
  self.Dirty:= true;
end;

//procedure TImportDataMap.SetSeparatorName(const Value: string);
//begin
//  MapJson.S['SeparatorName']:= Value;
//  self.Dirty:= true;
//end;

procedure TImportDataMap.SetSeparatorValue(const Value: string);
begin
  MapJson.S['SeparatorValue']:= Value;
  self.Dirty:= true;
end;

initialization

RegisterClass(TImportDataMap);

end.
