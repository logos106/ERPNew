unit BusObjLocation;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  19/08/11  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TLocation = class(TMSBusObj)
  private
    function GetCity_Sub: string;
    function GetState: string;
    function GetPostcode: string;
    function GetCountry: string;
    function GetCreationDate: TDateTime;
    function GetRegionID: Integer;
    function GetCode: string;
    function GetCountryID: Integer;
    procedure SetCity_Sub(const Value: string);
    procedure SetState(const Value: string);
    procedure SetPostcode(const Value: string);
    procedure SetCountry(const Value: string);
    procedure SetCreationDate(const Value: TDateTime);
    procedure SetRegionID(const Value: Integer);
    procedure SetCode(const Value: string);
    procedure SetCountryID(const Value: Integer);
    function GetRegion: string;
    procedure SetRegion(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function ValidLocation(const Value, Category: String; RegionID:Integer =0): Boolean; static;
    class function CodeForLocation(aCountry, aSuburb, aState, aPostCode: string): string;
  published
    property City_Sub: string read GetCity_Sub write SetCity_Sub;
    property State: string read GetState write SetState;
    property Postcode: string read GetPostcode write SetPostcode;
    property Country: string read GetCountry write SetCountry;
    property CreationDate: TDateTime read GetCreationDate write SetCreationDate;
    property RegionID: Integer read GetRegionID write SetRegionID;
    property Region: string read GetRegion write SetRegion;
    property Code: string read GetCode write SetCode;
    property CountryID: Integer read GetCountryID write SetCountryID;
  end;

implementation

uses
  tcDataUtils, CommonLib, BusObjRegionalOptions, sysutils, BusObjCountries,
  BusObjectListObj, CommonDbLib, AppEnvironment, ERPDbComponents,
  DbSharedObjectsObj;

{ TLocation }

class function TLocation.CodeForLocation(aCountry, aSuburb, aState,
  aPostCode: string): string;
var
  qry: TERPQuery;
begin
  result := '';
  if (aCountry = '') or (aSuburb = '') or (aState = '') or (aPostCode = '') then
    exit;
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select Code from tbllocations');
    qry.SQL.Add('where Country = ' + QuotedStr(aCountry));
    qry.SQL.Add('and PostCode = ' + QuotedStr(aPostCode));
    qry.SQL.Add('and State = ' + QuotedStr(aState));
    qry.SQL.Add('and City_sub = ' + QuotedStr(aSuburb));
    qry.Open;
    result := qry.FieldByName('Code').AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

constructor TLocation.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Location';
  fSQL := 'SELECT * FROM tbllocations';
  ExportExcludeList.Add('countryid');
  ExportExcludeList.Add('regionid');
end;

destructor TLocation.Destroy;
begin
  inherited;
end;
Class function TLocation.ValidLocation(Const Value :String ; Const Category :String; RegionID:Integer =0):Boolean;
begin
  result:= False;
  with TempMyquery do try
    SQL.text := 'Select * from tblLocations ';
          if sametext(Category , 'C') then SQL.add('where Country   = ' +quotedstr(Value))
    else  if sametext(Category , 'S') then SQL.add('where State     = ' +quotedstr(Value))
    else  if sametext(Category , 'S') then SQL.add('where City_sub  = ' +quotedstr(Value))
    else  if sametext(Category , 'S') then SQL.add('where Postcode  = ' +quotedstr(Value))
    else exit;
    if regionID<> 0 then
          SQL.add(' and RegionId = ' + inttostr(REgionID))
    else  SQL.add(' and RegionId = ' + inttostr(Appenv.regionaloptions.ID));
    open;
    Result := recordcount > 0;
  finally
    if Active then close;
    Free;
  end;
end;
procedure TLocation.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'City_sub');
  SetPropertyFromNode(node, 'State');
  SetPropertyFromNode(node, 'Postcode');
  SetPropertyFromNode(node, 'Country');
  SetDateTimePropertyFromNode(node, 'CreationDate');
  SetPropertyFromNode(node, 'RegionID');
  SetPropertyFromNode(node, 'Code');
  SetPropertyFromNode(node, 'CountryID');
  SetPropertyFromNode(node, 'Region');
end;

procedure TLocation.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'City_sub', City_Sub);
  AddXMLNode(node, 'State', State);
  AddXMLNode(node, 'Postcode', Postcode);
  AddXMLNode(node, 'Country', Country);
  AddXMLNode(node, 'CreationDate', CreationDate);
  AddXMLNode(node, 'RegionID', RegionID);
  AddXMLNode(node, 'Code', Code);
  AddXMLNode(node, 'CountryID', CountryID);
  AddXMLNode(node, 'Region', Region);
end;

function TLocation.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  if City_Sub = '' then begin
    Resultstatus.AddItem(False, rssWarning, 0, 'City_Sub should not be blank');
    Result := False;
    Exit;
  end;
  if CountryID < 1 then begin
    if Country = '' then begin
      Resultstatus.AddItem(False, rssWarning, 0, 'Country should not be blank');
      Result := False;
      Exit;
    end else begin
      Resultstatus.AddItem(False, rssWarning, 0, 'Country "' + Country + '" not found in Country list');
      Result := False;
      Exit;
    end;
  end;
  if RegionID < 1 then begin
    Resultstatus.AddItem(False, rssWarning, 0, 'Region is either blank or does not exist in Region list');
    Result := False;
    Exit;
  end;
  Result := True;
end;

function TLocation.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TLocation.OnDataIDChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TLocation.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
  if (sysutils.SameText(Sender.FieldName, 'Country')) then begin
    CountryID:= TCountries.IDToggle(Sender.AsString, Connection.Connection);
  end
  else if (sysutils.SameText(Sender.FieldName, 'CountryID')) then begin
    Country:= TCountries.IDToggle(Sender.AsInteger, Connection.Connection);
  end;
end;

function TLocation.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TLocation.GetIDField: string;
begin
  Result := 'LocationID'
end;

class function TLocation.GetBusObjectTablename: string;
begin
  Result := 'tbllocations';
end;

function TLocation.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TLocation.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  CreationDate:= now;
  result:= inherited;
end;

{ Property Functions }
function TLocation.GetCity_Sub: string;
begin
  Result := GetStringField('City_sub');
end;

function TLocation.GetState: string;
begin
  Result := GetStringField('State');
end;

function TLocation.GetPostcode: string;
begin
  Result := GetStringField('Postcode');
end;

function TLocation.GetCountry: string;
begin
  Result := GetStringField('Country');
end;

function TLocation.GetCreationDate: TDateTime;
begin
  Result := GetDateTimeField('CreationDate');
end;

function TLocation.GetRegion: string;
begin
  Result := TRegionalOptions.IDToggle(RegionID, Connection.Connection);
end;

function TLocation.GetRegionID: Integer;
begin
  Result := GetIntegerField('RegionID');
end;

function TLocation.GetCode: string;
begin
  Result := GetStringField('Code');
end;

function TLocation.GetCountryID: Integer;
begin
  Result := GetIntegerField('CountryID');
end;

procedure TLocation.SetCity_Sub(const Value: string);
begin
  SetStringField('City_sub', Value);
end;

procedure TLocation.SetState(const Value: string);
begin
  SetStringField('State', Value);
end;

procedure TLocation.SetPostcode(const Value: string);
begin
  SetStringField('Postcode', Value);
end;

procedure TLocation.SetCountry(const Value: string);
begin
  SetStringField('Country', Value);
end;

procedure TLocation.SetCreationDate(const Value: TDateTime);
begin
  SetDateTimeField('CreationDate', Value);
end;

procedure TLocation.SetRegion(const Value: string);
begin
  RegionID := TRegionalOptions.IDToggle(Value, Connection.Connection);
end;

procedure TLocation.SetRegionID(const Value: Integer);
begin
  SetIntegerField('RegionID', Value);
end;

procedure TLocation.SetCode(const Value: string);
begin
  SetStringField('Code', Value);
end;

procedure TLocation.SetCountryID(const Value: Integer);
begin
  SetIntegerField('CountryID', Value);
end;

initialization

  RegisterClass(TLocation);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Location','TLocation','TLocationListGUI');
end.
