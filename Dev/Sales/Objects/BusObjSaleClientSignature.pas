unit BusObjSaleClientSignature;

interface
uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, myAccess;

type

  TSaleClientSignature = class(TMSBusObj)
  private
    function GetClientSignature: string;
    procedure SetClientSignature(const Value: string);
  protected
//    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
//    procedure DoFieldOnChange(Sender: TField); override;
//    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
//    function GetSQL: string; override;
//    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
//    function GetIsList: boolean; override;
//    function GetTableName: string; virtual;
//    procedure SetTableName(const Value: string); virtual;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
//    procedure LoadFromXMLNode(const node: IXMLNode); override;
//    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property ClientSignature: string read GetClientSignature write SetClientSignature;
  end;

implementation

uses
  IdCoderMime, SysUtils, tcDataUtils;

{ TSaleClientSignature }

constructor TSaleClientSignature.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'SaleClientSignature';
  fSQL := 'SELECT * FROM tblsales'; // where not IsNull(ClientSignature)';
end;

destructor TSaleClientSignature.Destroy;
begin

  inherited;
end;

class function TSaleClientSignature.GetBusObjectTablename: string;
begin
  result := 'tblsales';
end;

function TSaleClientSignature.GetClientSignature: string;
var
  MIMEEncoder: TIdEncoderMIME;
  Stream: TStream;
  fld: TField;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  fld := Dataset.FieldByName('ClientSignature');
  if (Dataset.State in [dsEdit, dsInsert]) then
    Stream := Dataset.CreateBlobStream(TBlobField(fld), bmReadWrite)
  else
    Stream := Dataset.CreateBlobStream(TBlobField(fld), bmRead);
  try
    Result := MIMEEncoder.Encode(Stream);
  finally
    MIMEEncoder.Free;
    Stream.Free;
  end;
end;

class function TSaleClientSignature.GetIDField: string;
begin
  result := 'SaleID';
end;

function TSaleClientSignature.Save: Boolean;
begin
  ResultStatus.Clear;
  result := ValidateData;
  if not result then
    Exit;
  result := inherited Save;
end;

procedure TSaleClientSignature.SetClientSignature(const Value: string);
var
  DecoderMIME: TIdDecoderMIME;
  Stream: TStream;
  fld: TField;
begin
  DecoderMIME := TIdDecoderMIME.Create(nil);
  try
    if not(Dataset.State in [dsEdit, dsInsert]) then Dataset.Edit;
    fld := Dataset.FieldByName('ClientSignature');
    Stream := Dataset.CreateBlobStream(TBlobField(fld), bmReadWrite);
    try
      DecoderMIME.DecodeBegin(Stream);
      try
        DecoderMIME.Decode(Value);
      finally
        DecoderMIME.DecodeEnd;
      end;
    finally
      Stream.free;
    end;
  finally
    DecoderMIME.Free;
  end;
end;

function TSaleClientSignature.ValidateData: Boolean;
var
  SaleType: string;
begin
  result := false;
  if (ID < 1) and (GlobalRef = '') then begin
    AddResult(false, rssError, 0, 'Sale ID or GlobalRef must have a value, can only update or add a signature for an existing Sale.');
    exit;
  end;
  if ID > 0 then
    SaleType := tcDataUtils.SaleType(ID)
  else
    SaleType := tcDataUtils.SaleType(GlobalRef);
  if SameText(SaleType, 'Unknown') then begin
    AddResult(false, rssError, 0, 'Could not find Sale for ID or GlobalRef provided, can only update or add a signature for an existing Sale.');
    exit;
  end;
  result := true;
end;


initialization

  RegisterClass(TSaleClientSignature);

end.
