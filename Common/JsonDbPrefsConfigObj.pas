unit JsonDbPrefsConfigObj;

interface

uses
  JsonObject, MyAccess, DB;

type

  TJsonDbPefConfig = class(TJsonObject)
  private
    fEncrypt: boolean;
    fName: string;
    function getName: string;
  Protected
  public
    constructor Create; override;
    procedure Load(connection: TMyConnection); overload; virtual;
    procedure Load(ds: TDataset); overload; virtual;
    procedure Save(connection: TMyConnection); virtual;
    property Name: string read getName write fName;
    property Encrypt: boolean read fEncrypt write fEncrypt;
  end;


implementation

uses
  SysUtils, DbSharedObjectsObj, ERPDBComponents, CipherUtils(*, PreferenceLib*),
  PreferancesLib;

{ TJsonDbPefConfig }

procedure TJsonDbPefConfig.Load(connection: TMyConnection);
var
  qry: TERPQuery;
  fs:String;
begin
try
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection);
  try
    qry.SQL.Add('select * from tbldbpreferences');
    qry.SQL.Add('where PrefType = '+ QuotedStr(self.ClassName));
    qry.SQL.Add('and Name = ' + QuotedStr(Name));
    qry.Open;
    if Encrypt then
      self.AsString :=  CipherUtils.DecryptString(qry.FieldByName('FieldValue').AsString)
    else
      self.AsString := qry.FieldByName('FieldValue').AsString;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
Except
  on E:Exception do begin
    fs := E.message;
  end;
end;
end;

constructor TJsonDbPefConfig.Create;
begin
  inherited;
  fName := 'Config';
  fEncrypt := false;
end;

function TJsonDbPefConfig.getName: string;
begin
  Result := fName;
  if result ='' then begin
    if sametext(copy(classname, 1,1) ,'T') then Result := copy(Classname, 2, length(classname)) else result := Classname;
    fname := Result;
  end;
end;

procedure TJsonDbPefConfig.Load(ds: TDataset);
begin
  self.AsString := ds.FieldByName('FieldValue').AsString;
end;


procedure TJsonDbPefConfig.Save(connection: TMyConnection);
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection);
  try
    qry.SQL.Add('select * from tbldbpreferences');
    qry.SQL.Add('where PrefType = '+ QuotedStr(self.ClassName));
    qry.SQL.Add('and Name = ' + QuotedStr(Name));
    qry.Open;
    if qry.IsEmpty then begin
      qry.Insert;
      qry.FieldByName('PrefType').AsString := self.ClassName;
      qry.FieldByName('Name').AsString := Name;
      qry.FieldByName('RefType').AsString := 'None';
      qry.FieldByName('LocalPref').AsString := 'F';
      qry.FieldByName('FieldType').AsString := 'ftMemo';
      qry.FieldByName('FieldSize').AsInteger := 0;
    end
    else
      qry.Edit;
    if Encrypt then
      qry.FieldByName('FieldValue').AsString:= CipherUtils.EncryptString(self.AsString)
    else
      qry.FieldByName('FieldValue').AsString:= self.AsString;
    qry.Post;
    PreferancesLib.DoPrefAuditTrail;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

end.
