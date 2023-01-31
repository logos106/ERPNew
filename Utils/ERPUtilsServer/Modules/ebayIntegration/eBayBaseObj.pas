unit eBayBaseObj;

interface

uses Classes, ERPDBcomponents, db;

type

  TeBayObjBase = class(TComponent)
  private
    fdataset: TERPQuery;
    fsTablename: String;
    fsSQLWhere: String;
    fConn : TERPConnection;
    fsdatabase: String;
    function getdataset: TERPQuery;
    function SQL:string;
    function getID: Integer;
    procedure setID(const Value: Integer);
    function getCount: Integer;
    function getEOF: Boolean;
    function Conn : TERPConnection;
  Protected
    function IDFieldName:String ; virtual;
  Public
    Property Dataset :TERPQuery read getdataset write fDataset;
    Property Tablename :String read fsTablename Write fsTablename;
    Property SQLWhere :String read fsSQLWhere write fsSQLWhere;
    constructor Create(AOwner:TComponent); overload;override;
    constructor Create(AOwner:TComponent; objTablename:String; whereclause:String =''); reintroduce;overload;
    Procedure LoadSelect(whereclause:String);
    function GEtFieldValue(FieldName:String):Variant;
    Procedure SetFieldValue(const fieldName:String ; Value:Variant);
    Procedure New;
    Procedure PostDB;
    Procedure EditDB;
    function Locate(const KeyFields: string; const KeyValues: variant; Options: TLocateOptions): boolean;
    Property Count :Integer read getCount;
    Procedure First;
    Procedure Next;
    Procedure Prior;
    Property EOF:Boolean read getEOF;
    Property Database :String read fsdatabase write fsDatabase;

  Published
    Property ID :Integer read getID write setID;
  end;


implementation

uses eBayConfig, sysutils, Variants, MySQLUtils;

{ TeBayObjBase }

constructor TeBayObjBase.Create(AOwner: TComponent);
begin
  inherited;
  SQLWhere := '';
  fConn:= nil;
  if Assigned(Owner) then if Owner is TeBayObjBase then Database := TeBayObjBase(Self.Owner).Database;
end;

function TeBayObjBase.Conn: TERPConnection;
begin
  if fConn = nil then begin
    if Assigned(Self.Owner) and (Owner is TeBayObjBase) and (TeBayObjBase(Owner).Conn <> nil) then begin
      fconn := TeBayObjBase(Owner).Conn;
    end else begin
      fConn :=TERPConnection.Create(Self);
      SetConnectionProps(fconn , Database);
      fConn.Connect;
    end;
  end;
  result:= fConn;
end;

constructor TeBayObjBase.Create(AOwner:TComponent; objTablename:String; whereclause:String ='');
begin
  Create(AOwner);
  Tablename := objtablename;
  SQLWhere :=whereclause;
  Dataset;
end;

procedure TeBayObjBase.LoadSelect(whereclause: String);
begin
  SQLWhere :=whereclause;
  Dataset;
end;

function TeBayObjBase.Locate(const KeyFields: string; const KeyValues: variant; Options: TLocateOptions): boolean;
begin
  REsult:= False;
  if not(Assigned(Dataset)) or not(fDataset.Active) then exit;
  Result := Dataset.Locate(KeyFields, KeyValues,Options);
end;

procedure TeBayObjBase.EditDB;
begin
  if not(Assigned(Dataset)) or not(fDataset.Active) then exit;
  if fDataset.State in [dsEdit, dsInsert] then else fDataset.Edit;

end;

function TeBayObjBase.getEOF: Boolean;
begin
  REsult:= TRue;
  if not(Assigned(Dataset)) or not(fDataset.Active) then exit;
  Result := Dataset.EOF;

end;

procedure TeBayObjBase.First;
begin
  if not(Assigned(Dataset)) or not(fDataset.Active) then exit;
  Dataset.First;
end;

function TeBayObjBase.getCount: Integer;
begin
  REsult:= 0;
  if not(Assigned(Dataset)) or not(fDataset.Active) then exit;
  Result := Dataset.recordcount;
end;

function TeBayObjBase.getdataset: TERPQuery;
begin
  if fDataset = nil then begin
    fDataset := TERPQuery.Create(Self);
    fDataset.Connection := conn;
  end;
  if (fdataset.Active = False) or (trim(fDataset.SQL.Text) <> SQL) then begin
    if fdataset.Active then fdataset.close;
    fDataset.SQL.text:= SQL;
    fdataset.Active := True;
  end;
  Result := fDataset;
end;

function TeBayObjBase.GEtFieldValue(FieldName: String): Variant;
var
  fCurDBField: TField;
Begin
  Result := '';
  fCurDBField := Dataset.FindField(FieldName);
  If fCurDBField = Nil Then exit;
  case fCurDBField.DataType of
    ftVarBytes, ftUnknown : Result := fCurDBField.AsString;
    ftLargeint, ftAutoInc, ftWord, ftInteger, ftSmallint: Result := fCurDBField.asInteger;
    ftBoolean: Result := fCurDBField.asBoolean;
    ftBytes , ftBCD, ftCurrency, ftSingle, ftFloat : Result := fCurDBField.asFloat;
    ftTime , ftDate, ftTimeStamp, ftDateTime : Result := fCurDBField.asdatetime;
    else Result := fCurDBField.asString;
  end;
end;

function TeBayObjBase.getID: Integer;begin result:= GetfieldValue(IDFieldName);end;

function TeBayObjBase.IDFieldName: String;
begin
  REsult:= 'ID';
end;

procedure TeBayObjBase.New;
begin
  if not(Assigned(Dataset)) or not(fDataset.Active) then exit;
  fDataset.Append;
end;

procedure TeBayObjBase.Next;
begin
  if not(Assigned(Dataset)) or not(fDataset.Active) then exit;
  Dataset.Next;
end;

procedure TeBayObjBase.PostDB;
begin
  if not(Assigned(Dataset)) or not(fDataset.Active) then exit;
  if fDataset.State in [dsEdit, dsInsert] then fDataset.Post;
end;

procedure TeBayObjBase.Prior;
begin
  if not(Assigned(Dataset)) or not(fDataset.Active) then exit;
  Dataset.Prior;
end;

procedure TeBayObjBase.SetFieldValue(const fieldName: String; Value: Variant);
var
  fCurDBField: TField;
Begin
  try
    fCurDBField := Dataset.FindField(FieldName);
    If fCurDBField = Nil Then exit;
    EditDB;
    case fCurDBField.DataType of
      ftVarBytes, ftUnknown : fCurDBField.AsString := Value;
      ftLargeint, ftAutoInc, ftWord, ftInteger, ftSmallint:fCurDBField.asInteger := Value;
      ftBoolean: fCurDBField.asBoolean:= Value;
      ftBytes , ftBCD, ftCurrency, ftSingle, ftFloat : fCurDBField.asFloat:= Value;
      ftTime , ftDate, ftTimeStamp, ftDateTime : if Value = 0 then fCurDBField.Value:= NULL else fCurDBField.asdatetime := Value;
      else fCurDBField.asString := Value;
    end;
  Except
    // kill the exception
  end;
end;

procedure TeBayObjBase.setID(const Value: Integer);begin SetFieldValue(IDFieldName , Value);end;

function TeBayObjBase.SQL: string;
begin
  result:= 'Select * from ' + tablename ;
  if SQLWhere <> '' then result := result + ' where ' + SQLWhere;
end;

end.

