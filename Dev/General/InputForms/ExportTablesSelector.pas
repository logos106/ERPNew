unit ExportTablesSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar, ProgressDialog,
  frmBase, ExtCtrls, Menus, Shader, DNMPanel , BaseInputForm, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog;

type
  TfrmExportTablesSelector = class(TBaseInputGUI)
    dlgProgress: TProgressDialog;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    btnOk: TDNMSpeedButton;
    btnSelectAll: TDNMSpeedButton;
    btnUnselect: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    lvExportTables: TListView;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnUnselectClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    (*function GetSelectedTablesCount: integer;*)
    (*{$HINTS OFF}function TableSelected(const TableName: string): boolean;{$HINTS ON}*)
    (*procedure ExportSelectedTables;*)
    procedure ListExportTables;
    procedure SetItemsChecked(Value: boolean);
    procedure DoExportSelectedTables;
    function Tablenames: String;
    procedure DoExportProgress(Sender: TObject);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses FastFuncs,CommonDBLib, tcConst, tcTypes, tcDataUtils,
  CommonLib, SyncReportTableObj, DbConst, ExportToReportDBObj;

procedure TfrmExportTablesSelector.FormCreate(Sender: TObject);
begin
  inherited;
  ListExportTables;
end;

procedure TfrmExportTablesSelector.ListExportTables;
var
  LI: TListItem;
  tmpQuery: TERPQuery;
begin
  lvExportTables.Clear;
  tmpQuery := TERPQuery.Create(nil);
  try
    with tmpQuery do Begin
        Connection := GetSharedMyDacConnection;
        SQL.Add('SELECT * FROM tblexporttables order by TableName');
        Open;
        while not Eof do begin
          LI := lvExportTables.Items.Add;
          LI.Caption := FieldByName('TableName').AsString;
          LI.SubItems.Add(FieldByName('TableDescription').AsString);
          Next;
        end;
    end;
  finally
    FreeandNil(tmpQuery);
  end;
end;

procedure TfrmExportTablesSelector.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmExportTablesSelector.btnSelectAllClick(Sender: TObject);
begin
  SetItemsChecked(true);
end;

procedure TfrmExportTablesSelector.btnOkClick(Sender: TObject);
begin
  Self.Enabled := False;
  try
    DoExportSelectedTables;
  finally
    Self.Enabled := True;
  end;
end;
procedure TfrmExportTablesSelector.DoExportProgress(Sender :TObject);
begin
  DoStepProgressbar;
end;
procedure TfrmExportTablesSelector.DoExportSelectedTables;
var
  ExportToreportDB: TExportToreportDB;
begin
  ExportToreportDB := TExportToreportDB.Create;
  try
    ExportToreportDB.OnProgress := self.DoExportProgress;
    ExportToreportDB.conn   := CommonDbLib.GetSharedMyDacConnection;
    DoShowProgressbar(10, WAITMSG);
    try
      ExportToreportDB.ExportToreport(Tablenames);
    finally
      DoHideProgressbar;
    end;
    TimerMsg(Label1 ,ExportToreportDB.Progress.Detail , 30);
    //Label1.Caption:=ExportToreportDB.Progress.Detail;(* 'Data exported to ' + {'(ie): C:\Mysql_ERP\data\' +}
    //                GetSharedMyDacConnection.Database + REPORTING_DB_SUFIX + ' (on ERP Server)';*)
    //Label1.Refresh;
  finally
    Freeandnil(ExportToreportDB);
  end;
end;
Function TfrmExportTablesSelector.Tablenames:String;
var
  i:Integer;
begin
  REsult := '';
  for I := 0 to lvExportTables.Items.Count - 1 do begin
      if lvExportTables.Items[I].Checked then begin
          if result <> '' then result := result +',';
          result := Result + quotedstr(lvExportTables.Items[I].Caption);
      end;
  end;
end;
procedure TfrmExportTablesSelector.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmExportTablesSelector.btnUnselectClick(Sender: TObject);
begin
  SetItemsChecked(false);
end;

(*procedure TfrmExportTablesSelector.ExportSelectedTables;
var
  I, Step, SelectedCount, Temp: integer;
  ExportRec: TExportRec;
  ErrorMsg, ActiveDB: string;
  DBCR: TDBCreateRec;
  Ratio, Increment: double;
  qry: TERPQuery;
  usingReportTables:Boolean;
begin
  SelectedCount := GetSelectedTablesCount;
  if SelectedCount = 0 then begin
    CommonLib.MessageDlgXP_Vista('No tables selected for export.', mtInformation, [mbOK], 0);
    Exit;
  end;

  Ratio := 100 / SelectedCount;
  Step := 1;
  if System.Round(Ratio) > 1 then Step := Trunc(Ratio);

  ActiveDB := GetActiveDatabaseName;

  DropDatabase(REPORTING_DB_NAME, ErrorMsg);
  DBCR.DBName := REPORTING_DB_NAME;
  DBCR.CreateIfNotExists := true;

  if not CreateDatabase(DBCR, ErrorMsg) then Exit;

  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select * from mysql.user where user = "' + REPORTING_DB_USER + '"';
    qry.Open;
    if qry.RecordCount > 0 then begin
      qry.Close;
      qry.SQL.Text:= 'DROP USER ' + Quotedstr(REPORTING_DB_USER) ;
      qry.Execute;
    end;
    qry.Close;
    qry.SQL.Text:= 'CREATE USER ' + Quotedstr(REPORTING_DB_USER) +'@'+ Quotedstr('%')+' IDENTIFIED BY '+ quotedstr(REPORTING_DB_USER_PASS);
    qry.Execute;
    qry.SQL.Text:= 'GRANT ALL ON ' + REPORTING_DB_NAME + '.* TO ' + Quotedstr(REPORTING_DB_USER);
    qry.Execute;
  finally
    qry.Free;
  end;

  Increment := 0;
  Self.FormStyle := fsNormal;
  Self.Hide;
  dlgProgress.Step := Step;
  dlgProgress.Execute;
  try
    Application.ProcessMessages;
    for I := 0 to lvExportTables.Items.Count - 1 do begin
      if lvExportTables.Items[I].Checked then begin
        ExportRec := GetExportDataRec(lvExportTables.Items[I].Caption);
        if ExportRec.Success then begin
          PrefixSQLWithDatabaseName(ActiveDB, ExportRec.SQL);
          ExportRec.SQL := SyncReportObj.ChangeQuery(ExportRec.SQL, usingReportTables);
          ExecuteDBCommand('USE ' + REPORTING_DB_NAME, ErrorMsg);
          try
            if not CreateTableFromSQL(ExportRec.TableName, ExportRec.SQL, ErrorMsg, ExportRec.IndexDefs) then
              CommonLib.MessageDlgXP_Vista(ErrorMsg, mtWarning, [mbOK], 0);
          finally
            ExecuteDBCommand('USE ' + ActiveDB, ErrorMsg);
          end;
        end;

        if Step = 1 then begin
          Temp := Trunc(Increment);
          Increment := Increment + Ratio;
          if Temp < Trunc(Increment) then dlgProgress.StepIt;
        end else dlgProgress.StepIt;
      end;
    end;
  finally
    dlgProgress.CloseDialog;
    CommonLib.MessageDlgXP_Vista('All selected tables successfully exported.', mtInformation, [mbOK], 0);
    Self.Close;
  end;
end;*)

(*function TfrmExportTablesSelector.GetSelectedTablesCount: integer;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to lvExportTables.Items.Count - 1 do if lvExportTables.Items[I].Checked then Inc(Result);
end;*)

procedure TfrmExportTablesSelector.SetItemsChecked(Value: boolean);
var
  I: integer;
begin
  for I := 0 to lvExportTables.Items.Count - 1 do lvExportTables.Items[I].Checked := Value;
end;

(*function TfrmExportTablesSelector.TableSelected(const TableName: string): boolean;
var
  I: integer;
  LI: TListItem;
begin
  Result := false;
  if lvExportTables.Items.Count = 0 then Exit;
  for I := 0 to lvExportTables.Items.Count - 1 do begin
    LI := lvExportTables.Items[I];
    if Sysutils.SameText(LI.Caption, TableName) then begin
      Result := true;
      Break;
    end;
  end;
end;*)


procedure TfrmExportTablesSelector.FormPaint(Sender: TObject);
begin
  inherited;
  (*PaintGradientColor(Self);*)
end;

initialization
RegisterClassOnce(TfrmExportTablesSelector);
end.
