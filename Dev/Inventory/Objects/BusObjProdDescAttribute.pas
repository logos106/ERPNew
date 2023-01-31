unit BusObjProdDescAttribute;

interface

uses
  Classes, BusObjBase;

type

  TProductDescriptionAttributeLine = class;
  TProductDescriptionAttribute = class(TMSBusObj)
  private
    fProdDescAttribLines: TProductDescriptionAttributeLine;
    function GetActive: boolean;
    function GetTitle: string;
    procedure SetActive(const Value: boolean);
    procedure SetTitle(const Value: string);
    function GetProdDescAttribID: integer;
    function GetProdDescAttribLines: TProductDescriptionAttributeLine;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetId: integer; override;
    class function GetBusObjectTableName: string; override;
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    function LocateAttribByID(const ID: integer): boolean;
    function LocateAttribByTitle(const aTitle: string): boolean;
    property ProdDescAttribLines: TProductDescriptionAttributeLine read GetProdDescAttribLines;
  published
    property ProdDescAttribID: integer read GetProdDescAttribID;
    property Title: string read GetTitle write SetTitle;
    property Active: boolean read GetActive write SetActive;
  end;

  TProductDescriptionAttributeLine = class(TMSBusObj)
  private
    function GetActive: boolean;
    function GetAttribValue: string;
    function GetProdDescAttribID: integer;
    function GetProdDescAttribLineId: integer;
    procedure SetActive(const Value: boolean);
    procedure SetAttribValue(const Value: string);
    procedure SetProdDescAttribID(const Value: integer);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetId: integer; override;
    class function GetBusObjectTableName: string; override;
    class function GetIDField: string; override;
  published
    property ProdDescAttribLineId: integer read GetProdDescAttribLineId;
    property ProdDescAttribID: integer read GetProdDescAttribID write SetProdDescAttribID;
    property Active: boolean read GetActive write SetActive;
    property AttribValue: string read GetAttribValue write SetAttribValue;
  end;

implementation

uses
  FastFuncs, DB;

{ TProductDescriptionAttribute }

constructor TProductDescriptionAttribute.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'Product Description Attribute';
  fSQL := 'SELECT * FROM tblDescriptionAttribSetup';
end;

destructor TProductDescriptionAttribute.Destroy;
begin

  inherited;
end;

function TProductDescriptionAttribute.GetActive: boolean;
begin
  result:= GetBooleanField('Active');
end;

class function TProductDescriptionAttribute.GetBusObjectTableName: string;
begin
  result:= 'tblDescriptionAttribSetup';
end;

function TProductDescriptionAttribute.GetId: integer;
begin
  result:= ProdDescAttribID;
end;

class function TProductDescriptionAttribute.GetIDField: string;
begin
  result:= 'DescriptionAttribID';
end;

class function TProductDescriptionAttribute.GetKeyStringField: string;
begin
  result:= 'ComboName';
end;

function TProductDescriptionAttribute.GetProdDescAttribID: integer;
begin
  result:= GetIntegerField('DescriptionAttribID');
end;

function TProductDescriptionAttribute.GetProdDescAttribLines: TProductDescriptionAttributeLine;
begin
  if not Assigned(fProdDescAttribLines) then begin
    fProdDescAttribLines:= TProductDescriptionAttributeLine.Create(self);
  end;
  if fProdDescAttribLines.ProdDescAttribID <> self.Id then
    fProdDescAttribLines.LoadSelect('DescriptionAttribID = ' + FastFuncs.IntToStr(ID));
  result:= fProdDescAttribLines;  
end;

function TProductDescriptionAttribute.GetTitle: string;
begin
  result:= GetStringField('ComboName');
end;

function TProductDescriptionAttribute.LocateAttribByID(
  const ID: integer): boolean;
begin
  Result := false;
  if Assigned(Dataset) and Dataset.Active and (Dataset.RecordCount > 0) then begin
    Result := Dataset.Locate('DescriptionAttribID', ID, []);
  end;
end;

function TProductDescriptionAttribute.LocateAttribByTitle(
  const aTitle: string): boolean;
begin
  Result := false;
  if Assigned(Dataset) and Dataset.Active and (Dataset.RecordCount > 0) then begin
    Result := Dataset.Locate('ComboName', aTitle, [loCaseInsensitive]);
  end;
end;

procedure TProductDescriptionAttribute.SetActive(const Value: boolean);
begin
  SetBooleanField('Active',Value);
end;

procedure TProductDescriptionAttribute.SetTitle(const Value: string);
begin
  SetStringField('ComboName',Value);
end;

{ TProductDescriptionAttributeLine }

constructor TProductDescriptionAttributeLine.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'Product Description Attribute Line';
  fSQL := 'SELECT * FROM tblDescriptionAttribLines';
  SQLOrder := 'DescriptionAttribValue';
end;

destructor TProductDescriptionAttributeLine.Destroy;
begin

  inherited;
end;

function TProductDescriptionAttributeLine.GetActive: boolean;
begin
  result:= GetBooleanField('Active');
end;

function TProductDescriptionAttributeLine.GetAttribValue: string;
begin
  result:= GetStringField('DescriptionAttribValue');
end;

class function TProductDescriptionAttributeLine.GetBusObjectTableName: string;
begin
  result:= 'tblDescriptionAttribLines';
end;

function TProductDescriptionAttributeLine.GetId: integer;
begin
  result:= ProdDescAttribLineId;
end;

class function TProductDescriptionAttributeLine.GetIDField: string;
begin
  result:= 'DescriptionAttribLineId'
end;

function TProductDescriptionAttributeLine.GetProdDescAttribID: integer;
begin
 result:= GetIntegerField('DescriptionAttribID');
end;

function TProductDescriptionAttributeLine.GetProdDescAttribLineId: integer;
begin
  result:= GetIntegerField('DescriptionAttribLineID');
end;

procedure TProductDescriptionAttributeLine.SetActive(const Value: boolean);
begin
  SetBooleanField('Active',Value);
end;

procedure TProductDescriptionAttributeLine.SetAttribValue(
  const Value: string);
begin
  SetStringField('DescriptionAttribValue',Value);
end;

procedure TProductDescriptionAttributeLine.SetProdDescAttribID(
  const Value: integer);
begin
  SetIntegerField('DescriptionAttribID',Value);
end;

end.
