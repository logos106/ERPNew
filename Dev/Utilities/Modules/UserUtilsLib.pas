unit UserUtilsLib;

interface

Uses
  JSONObject, ERPWebAPIObjBase;
Type
  TUserUtilsActions = Class(TERPWebAPIObjBase)
  Private
    TaskId: string;
    procedure UtilsEventHandler(Sender: TObject; const Event, Value: string);
    procedure DoOnProgress(ProgJson: TJsonObject);
  Protected
        Procedure Ontimer(Sender:TObjecT);Override;

  Public
    constructor Create; Override;
    destructor Destroy; override;
    Function MakeNewDatabase(const NewDBName:String; RegionforNewDB:String; var msg:String):boolean;
  End;
implementation

uses AppEnvironment, SysUtils, classes , LogMessageTypes;

{ TUserUtilsActions }

constructor TUserUtilsActions.Create;
begin
  inherited;
end;

destructor TUserUtilsActions.Destroy;
begin
  inherited;
end;



function TUserUtilsActions.MakeNewDatabase(const NewDBName: String; RegionforNewDB: String; var msg:String): boolean;
var
  Params, ResultJson : TJsonObject;
begin
  msg := '';
  if AppEnv.AppDb.DatabaseExists(NewDBName) then begin
    msg :='Database ' + Quotedstr(NewDBName)+' Already Exists';
    Result := False;
    Exit;
  end;
  if RegionforNewDB ='' then begin
    Msg := 'Region for the new Database Cannot be blank';
    Result := False;
    Exit;
  end;
  with SharedQuery do begin
    if active then close;
    SQL.Text := 'SELECT * FROM erpnewdb.tblregionaloptions where region = '+ quotedstr(RegionforNewDB);
    open;
    if recordcount =0 then begin
      msg:= 'Region ' + quotedstr(RegionforNewDB)+' is invalid';
      REsult := False;
    end;
  end;
  with SharedScript do begin
    SQL.Text:= 'update erpnewdb.tbldbpreferences set FieldValue = ' +
      QuotedStr(RegionforNewDB) + ' where Name = "CompanyRegion" and PrefType = "ptCompany"';
    Execute;
  end;
  Params:= TJsonObject.Create;
  Params.S['UserName']:= AppEnv.AppDb.UserName;
  Params.S['DatabaseName']:= 'erpnewdb';
  Params.S['NewDatabaseName']:= NewDBName;
  Params.B['BackupFirst']:= False;
  Params.S['Operation']:= 'Copy';;
  AppEnv.UtilsClient.Events.AddMultiEvent(UtilsEventHandler);
  try
      ResultJson:= AppEnv.UtilsClient.Client.SendRequest('UserUtils.dbbackup',Params);
      if Assigned(ResultJson) then begin
        try
          TaskID:= ResultJson.O['result'].S['TaskID'];
        finally
          ResultJson.Free;
        end;
        REsult := True;
        msg := 'Waiting for creating the Database';
      end
      else begin
        { error }
        msg :='Error : No response from ERP Utils Server';
        Result := false;
      end;
  finally
    //AppEnv.UtilsClient.Events.RemoveMultiEvent(UtilsEventHandler);
  end;
end;

procedure TUserUtilsActions.Ontimer(Sender: TObjecT);
begin
  inherited;
  beep;
end;

procedure TUserUtilsActions.UtilsEventHandler(Sender: TObject; const Event,
  Value: string);
var
  ProgJson: TJsonObject;
begin
  if SameText(Event,'Progress') then begin
    ProgJson:= JO;
    try
      ProgJson.AsString:= Value;
      if ProgJson.S['TaskId'] = TaskId then begin
        DoOnProgress(ProgJson);
      end;
    finally
      ProgJson.Free;
    end;
  end;
end;

procedure TUserUtilsActions.DoOnProgress(ProgJson: TJsonObject);
begin
 AppEnv.UtilsClient.Logger.Log(ProgJson.S['Task'],ltWarning);
end;

initialization
  RegisterClass(TUserUtilsActions);

end.
