unit Runscript;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, StdCtrls,
  {$WARNINGS OFF}
  {$WARNINGS OFF}FileCtrl{$WARNINGS ON},
  {$WARNINGS ON}
  ExtCtrls, DAScript, MyScript,
  ComCtrls, ERPdbComponents;
const Rootdir = '\\dev-server\Development\P1';
type
  TRunScriptGUI = class(TBaseForm)
    files: TFileListBox;
    dbs: TListBox;
    btn: TButton;
    script: TERPScript;
    dbname: TListBox;
    ProgressBar: TProgressBar;
    Comments: TListBox;
    procedure FormShow(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure scriptError(Sender: TObject; E: Exception; SQL: String;
      var Action: TErrorAction);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure scriptBeforeExecute(Sender: TObject; var SQL: String;
      var Omit: Boolean);
    procedure scriptAfterExecute(Sender: TObject; SQL: String);
  private
    ctr:Integer;
    procedure GetDataBases;
    Procedure LogText(Const value:String);
  public
    { Public declarations }
  end;

implementation

uses AppDatabase, AppEnvironment, CommonLib, CommonDbLib, MyAccess,
  DBAccess, FastFuncs ;

{$R *.dfm}

{ TBaseForm1 }

procedure TRunScriptGUI.GetDataBases;
var
  x : integer;
  DbRec: TDatabaseRec;
begin
  dbs.Items.Clear;dbname.Items.Clear;
  for x:= 0 to AppEnv.AppDb.DatabaseList.Count -1 do begin
    DbRec:= TDatabaseRec(AppEnv.AppDb.DatabaseList.Objects[x]);
    if DbRec.Name <> 'erpnewdb' then begin
     dbs.Items.Add(DbRec.Name+ '    ' +DbRec.Version);
     dbname.Items.Add(DbRec.Name);
    end;
  end;
end;

procedure TRunScriptGUI.FormShow(Sender: TObject);
begin
  inherited;
  GetDataBases;
  files.Directory := rootdir;
  files.mask:= 'Update*.sql';
  script.Connection:= GetNewMyDacConnection(Self);
end;
procedure TRunScriptGUI.btnClick(Sender: TObject);
var
  i1, i2: Integer;
  Procedure Startexec;
  begin
      ProgressBar.min := 1;
      ProgressBar.max := Script.SQL.count;
      ProgressBar.visible := true;
      ctr:= 0;
      Comments.Items.clear;
      Comments.visible:= true;
      dbs.visible := false;
      files.visible:= False;
      btn.visible := false;
  end;
  Procedure finsihexec;
  begin
      ProgressBar.visible := false;
      dbs.visible := true;
      files.visible:= true;
      btn.visible := true;
  end;
begin
for i1 := 0 to (dbs.Items.Count - 1) do begin
  if dbs.Selected[i1] then    begin
    with script.connection do begin
        if connected then close;
        Database := dbname.items[i1];
        Connect;
    end;
    script.connection.StartTransaction;
    try
      for i2 := 0 to (files.Items.Count - 1) do begin
        if files.Selected[i2] then    begin
          if FileExists(rootdir+'\'+ files.Items.Strings[i2]) then begin
            LogText('Script file   : '+ files.Items.Strings[i2]);
            LogText('Database      : '+ dbname.Items.Strings[i1]);
            script.SQL.clear;
            script.SQL.LoadFromFile(rootdir+'\'+ files.Items.Strings[i2]);
            Startexec;
            try
              script.Execute;
            finally
              finsihexec;
            end;
          end;
        end;
      end;
      script.connection.Commit;
    except
        on E:Exception do begin
            script.connection.Rollback;
        end;
    end;

  end;
end;
end;

procedure TRunScriptGUI.scriptError(Sender: TObject; E: Exception;
  SQL: String; var Action: TErrorAction);
begin
  inherited;
  LogText('Error:' +SQL + chr(13) + E.message+chr(13)+chr(13));
  action := eacontinue;
end;

procedure TRunScriptGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TRunScriptGUI.scriptBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  inherited;
  ctr:= ctr+1;
  LogText('...... line no : ' +IntToStr(ctr));
  ProgressBar.StepIt;
end;

procedure TRunScriptGUI.scriptAfterExecute(Sender: TObject; SQL: String);
begin
  inherited;
  LogText('......done ' + chr(13));
end;

procedure TRunScriptGUI.LogText(const value: String);
begin
  comments.Items.add(Value);
end;

initialization
  RegisterClassOnce(TRunScriptGUI);

end.
