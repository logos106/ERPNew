unit BusObjManufacture;

interface

uses BusObjBase, DB, classes, XMLDoc, XMLIntf, BusObjRepairsExportConfig, MyAccess;

type

  TManufacture = class(TMSBusObj)
  private
    function GetManufactureName: string;
    function GetActive: Boolean;
    function GetCreatedOn: TDateTime;
    procedure SetManufactureName(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure SetCreatedOn(const Value: TDateTime);
    function getRepairsExportConfig: TRepairsExportConfig;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function NewManufacture(const fManufactureName: string; Conn: TCustomMyConnection = nil): boolean;
    property RepairsExportConfig: TRepairsExportConfig read getRepairsExportConfig;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  published
    property ManufactureName: string read GetManufactureName write SetManufactureName;
    property Active: Boolean read GetActive write SetActive;
    property CreatedOn: TDateTime read GetCreatedOn write SetCreatedOn;
  end;

implementation

uses CommonDbLib, SysUtils, BusObjectListObj;

constructor TManufacture.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'manufacture';
  fSQL := 'SELECT * FROM tblmanufacture';
end;

destructor TManufacture.Destroy;
begin
  inherited;
end;

procedure TManufacture.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'ManufactureName');
  SetBooleanPropertyFromNode(node, 'Active');
  SetDateTimePropertyFromNode(node, 'CreatedOn');
  (* SetPropertyFromNode(node,'ReceiptNumberCaption'); *)

end;

procedure TManufacture.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'ManufactureName', ManufactureName);
  (* AddXMLNode(node,'ReceiptNumberCaption' ,ReceiptNumberCaption); *)
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'CreatedOn', CreatedOn);
end;

function TManufacture.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if ManufactureName = '' then begin
    AddResult(False, rssWarning, 0, 'Manufacture Name should not be blank');
    Exit;
  end;
  Result := True;
end;

class function TManufacture._Schema: string;
begin
  Result := inherited;
end;

function TManufacture.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TManufacture.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TManufacture.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TManufacture.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TManufacture.GetIDField: string;
begin
  Result := 'ID'
end;

class function TManufacture.GetKeyStringField: string;
begin
  Result := 'Name';
end;

class function TManufacture.GetKeyStringProperty: string;
begin
  Result := 'ManufactureName'
end;

class function TManufacture.GetBusObjectTablename: string;
begin
  Result := 'tblmanufacture';
end;

function TManufacture.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TManufacture.GetManufactureName: string;
begin
  Result := GetStringField('Name');
end;

function TManufacture.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TManufacture.GetCreatedOn: TDateTime;
begin
  Result := GetDateTimeField('CreatedOn');
end;

procedure TManufacture.SetManufactureName(const Value: string);
begin
  SetStringField('Name', Value);
end;

procedure TManufacture.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TManufacture.SetCreatedOn(const Value: TDateTime);
begin
  SetDateTimeField('CreatedOn', Value);
end;

class function TManufacture.NewManufacture(const fManufactureName: string; Conn: TCustomMyConnection = nil): boolean;
var
  Manufacture: TManufacture;
begin
  result := true;
  try
    Manufacture := TManufacture.Create(nil);
    try
      Manufacture.Connection := TmyDacdataconnection.Create(Manufacture);
      if Conn <> nil then Manufacture.Connection.Connection := Conn
      else Manufacture.Connection.Connection := GetNewMyDacConnection(Manufacture);
      Manufacture.loadselect('name = ' + QuotedStr(fManufactureName));
      if Manufacture.count = 0 then begin
        Manufacture.New;
        Manufacture.ManufactureName := fManufactureName;
        Manufacture.CreatedOn := now;
        Manufacture.Active := True;
        result := Manufacture.Save;
      end;
    finally
      Freeandnil(Manufacture);
    end;
  except
    result := false;
  end;
end;

function TManufacture.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  CreatedOn := Date;
  Active := True;
end;

function TManufacture.getRepairsExportConfig: TRepairsExportConfig;
begin
  Result := TRepairsExportConfig(getContainerComponent(TRepairsExportConfig, '(ifnull(ManufactureId,0) = ' + intToStr(ID) + ' or ifnull(ManufactureId,0) = 0 )'));
end;

(* function TManufacture.getReceiptNumberCaption: String;
  begin
  REsult := getStringfield('ReceiptNumberCaption');
  end;

  procedure TManufacture.setReceiptNumberCaption(const Value: String);
  begin
  SetStringfield('ReceiptNumberCaption' , Value);
  end; *)

initialization

  RegisterClass(TManufacture);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Manufacture','TManufacture','');

end.
