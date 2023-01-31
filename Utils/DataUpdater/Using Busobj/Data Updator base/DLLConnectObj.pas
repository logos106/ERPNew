unit DLLConnectObj;

interface

uses Classes, MyAccess;

Type
  TOpenCompany = function (var fConnection:TMyConnection; const  dbname: string;  const User:String='';
                     Server: string = ''; ServerPort: integer = 0): boolean;
  TLoadSelect = procedure (Const SelectStatement: string) of Object;
  TBooleanFunc = Function :Boolean of object;
  TGeneralProc = Procedure of Object;
  TCurConnection= Function  :TMyconnection;
  TFindbusobj = function (Const ComponentClassName: string;
                                 Const SingleInstance: boolean = true;
                                 Const Owner: TComponent = nil;
                                 Const CheckAccessLevel:Boolean=true;
                                 Const showErrorMsg :Boolean = True;
                                 Const iTag: Integer = 0): TComponent ;

  TDLLConnection = Class(TComponent)
    Private
      DLLHandle: THandle;
      fConnection: TMyConnection;
      function RunBooleanfunc(Sender :TObject;Functionname:String):Boolean;
    Public
      Property Connection :TMyConnection Read fConnection Write fConnection;
      Constructor Create(AOwner:TComponent); override;
      Destructor  Destroy; override;

      Function FindBusobj(Busobjbame:String):TObject;
      Function Openconnection(DLLPath :String; DBName:String;ServerName:String;ServerPort: integer = 3309):Boolean;
      Procedure Closeconnection;
      Function getNewDataset(strSQL:string):TMyQuery;
      Procedure Execute(strSQL:string);
      Function LoadSelect(Sender :TObject ; SQLSelect:String):Boolean;
      Function New(Sender :TObject ):Boolean;
      Function Save(Sender :TObject ):Boolean;
      Function Delete(Sender :TObject ):Boolean;
      Procedure PostDB(Sender :TObject );
      Procedure BeginTransaction;
      Procedure RollbackTransaction;
      Procedure CommitTransaction;


    Protected
  end;
implementation

uses windows, DataUpdaterconfig, typInfo, sysutils, LogThreadLib, LogMessageTypes;

{ TDLLConnection }

procedure TDLLConnection.BeginTransaction;
begin
  if fconnection.InTransaction then else
    fconnection.StartTransaction;
end;

procedure TDLLConnection.Closeconnection;
var
    CloseCompanyfuncs:TGeneralProc;
begin
  @CloseCompanyfuncs := GetProcAddress(DLLHandle, FUNC_CLOSECOMPANY);
  if @CloseCompanyfuncs <> nil then
        CloseCompanyfuncs;
end;

procedure TDLLConnection.CommitTransaction;
begin
  if fconnection.InTransaction then
    fconnection.Commit;

end;

constructor TDLLConnection.Create(AOwner: TComponent);
begin
  inherited create(AOwner);

end;

function TDLLConnection.Delete(Sender: TObject): Boolean;
begin
  REsult := RunBooleanfunc(Sender,FUNC_DELETE);
(*var
  Deletefunc :TBooleanFunc;
begin
 REsult := False;
  try
    TMethod(Deletefunc).Data := Pointer(Sender) ;
    TMethod(Deletefunc).Code := Sender.MethodAddress(FUNC_DELETE);
    if TMethod(Deletefunc).Code <> nil then begin
      Result := Deletefunc;
    end;
  finally
      Deletefunc := nil;
  end;

*)
end;

destructor TDLLConnection.Destroy;
var
  x:Integer;
begin
try
    for x :=  ComponentCount - 1 downto 0 do begin
        Components[x].Free;
    end;
  try
    FreeLibrary(DLLHandle);
  Except
      on E:Exception do begin

      end;
  end;
  inherited;
Except
    // kill exception ;
end;
end;

Procedure TDLLConnection.Execute(strSQL: string);
begin
  With TMyQuery.create(nil) do try
    connection :=fConnection;
    SQL.add(strSQL);
    Execute;
  Finally
      Free;
  end;
end;

function TDLLConnection.FindBusobj(Busobjbame: String): TObject;
var
  findBusobj:TFindbusobj;
  x:Integer;
begin
  Result := nil;
    for x := 0 to ComponentCount - 1 do begin
      if uppercase(Components[x].ClassName) =uppercase(Busobjbame) Then Begin
        REsult  := Components[x];
        exit;
      end;
    end;

  @FindBusobj := GetProcAddress(DLLHandle, FUNC_GETBUSOBJ);
  if @FindBusobj <> nil then begin
    REsult  := FindBusobj(Busobjbame , True , Self , true  , True , 0);
  end;
end;


function TDLLConnection.getNewDataset(strSQL: string): TMyQuery;
begin
  Result := TMyQuery.create(nil);
  Result.connection :=fConnection;
  Result.SQL.add(strSQL);
  Result.Open;
end;

function TDLLConnection.LoadSelect(Sender: TObject; SQLSelect: String):Boolean;
var
  LoadSelectProc:TLoadSelect;
begin
  REsult := False;
  try
    TMethod(LoadSelectProc).Data := Pointer(Sender) ;
    TMethod(LoadSelectProc).Code := Sender.MethodAddress(FUNC_LOADSELECT);
    if TMethod(LoadSelectProc).Code <> nil then begin
      LoadSelectProc(SQLSelect);
      Result := True;
    end;
  finally
      LoadSelectProc := nil;
  end;
end;

function TDLLConnection.New(Sender :TObject ): Boolean;
begin
  Result := RunBooleanfunc(Sender,FUNC_NEW);
(*var
  Newfunc :TBooleanFunc;
begin
 REsult := False;
  try
    TMethod(Newfunc).Data := Pointer(Sender) ;
    TMethod(Newfunc).Code := Sender.MethodAddress(FUNC_NEW);
    if TMethod(NewFunc).Code <> nil then begin
      Result := NewFunc;
    end;
  finally
      NewFunc := nil;
  end;*)
end;

Function TDLLConnection.Openconnection(DLLPath :String; DBName, ServerName: String;  ServerPort: integer):Boolean;
var
  OpencompFunc: TOpenCompany;
  (*CurConnection :TCurConnection;*)
begin
  Result := False;
  DLLHandle := LoadLibrary(pchar(DLLPath + DLLNAME));
  if DLLHandle <> 0 then begin
    @OpencompFunc := GetProcAddress(DLLHandle, FUNC_OPENFORUSER);
      if @OpencompFunc <> nil then      begin
        try
          if OpencompFunc(fConnection,  DBName , USERNAME, ServerName , ServerPort) then begin
            (*@CurConnection := GetProcAddress(DLLHandle, FUNC_CURCONNECTION);
            if @CurConnection <> nil then begin
              fConnection := CurConnection;
              Result := True;
            end;*)
            Result := True;
          end;
        except
           //kill exception if not ERPdatabase
        end;
      end;
  end;
end;

procedure TDLLConnection.PostDB(Sender: TObject);
var
  PostDBProc :TGeneralProc;
begin
  try
    TMethod(PostDBProc).Data := Pointer(Sender) ;
    TMethod(PostDBProc).Code := Sender.MethodAddress(FUNC_POSTDB);
    if TMethod(PostDBProc).Code <> nil then begin
      PostDBProc;
    end;
  finally
      PostDBProc := nil;
  end;
end;

procedure TDLLConnection.RollbackTransaction;
begin
  if fconnection.InTransaction then
    fconnection.Rollback;

end;

function TDLLConnection.RunBooleanfunc(Sender :TObject;Functionname: String): Boolean;
var
  Func :TBooleanFunc;
begin
 REsult := False;
  try
    TMethod(Func).Data := Pointer(Sender) ;
    TMethod(Func).Code := Sender.MethodAddress(Functionname);
    if TMethod(Func).Code <> nil then begin
      Result := Func;
    end;
  finally
      Func := nil;
  end;

end;

function TDLLConnection.Save(Sender: TObject): Boolean;
begin
  Result := RunBooleanfunc(sender,FUNC_SAVE);
(*var
  Savefunc :TBooleanFunc;
begin
 REsult := False;
  try
    TMethod(Savefunc).Data := Pointer(Sender) ;
    TMethod(Savefunc).Code := Sender.MethodAddress(FUNC_SAVE);
    if TMethod(Savefunc).Code <> nil then begin
      Result := Savefunc;
    end;
  finally
      Savefunc := nil;
  end;*)

end;

end.
