unit DataUpdateObj;

interface

Uses DLLConnectObj, classes;

type
  TDataUpdateObj = class(TComponent)
    Private
    fObj: TObject;
    fconnection: TDLLConnection;
    function getcount: Integer;
    function getID: Integer;

    Protected

    Public
      Function LoadSelect(Const Selectstatement:String):Boolean;
      Function New:Boolean;
      Function Save:Boolean;
      Function Delete:Boolean;
      Procedure PostDB;
      Constructor Create(AOwner:TComponent);overload;override;
      constructor Create(const oConnection : TDLLConnection;const objname :String; AOwner:TComponent);reintroduce;overload;Virtual;
      Destructor Destroy;override;
      Property  Obj :TObject Read fObj write fObj;
      Property connection :TDLLConnection read fconnection Write fConnection;
      Property Count :Integer read getcount;
      Property ID:Integer read getID;
  end;
implementation

uses DataUpdaterconfig, fastfuncs, typinfo , SysUtils;

{ TDataUpdateObj }

constructor TDataUpdateObj.Create(const oConnection : TDLLConnection;const objname: String; AOwner: TComponent);
begin
  create(AOwner);
  if Objname <> '' then begin
    obj:= oConnection.FindBusobj(Objname);
  end;
  Connection := oConnection;
end;

constructor TDataUpdateObj.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
end;

function TDataUpdateObj.Delete: Boolean;
begin
  result := Connection.Delete(Obj);
end;

destructor TDataUpdateObj.Destroy;
begin
  FreeAndNil(fObj);
  inherited;
end;

function TDataUpdateObj.getcount: Integer;
begin
   result := GetInt64Prop(obj , 'Count')
end;

function TDataUpdateObj.getID: Integer;
begin
   result := GetInt64Prop(obj , 'ID')
end;

function TDataUpdateObj.LoadSelect(const Selectstatement: String): Boolean;
begin
  result := Connection.LoadSelect(Obj , Selectstatement);
end;

function TDataUpdateObj.New: Boolean;
begin
  result := Connection.New(Obj);
end;

procedure TDataUpdateObj.PostDB;
begin
  Connection.PostDB(Obj);
end;

function TDataUpdateObj.Save: Boolean;
begin
  result := Connection.Save(Obj);
end;

end.
