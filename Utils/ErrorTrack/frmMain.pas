unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, DB, DBAccess, MyAccess, MemDS, Grids, Wwdbigrd,
  Wwdbgrid, StdCtrls, wwmemo, DAScript, MyScript, ERPdbComponents;

type
  TfmMain = class(TForm)
    ActionList: TActionList;
    actClose: TAction;
    MainMenu: TMainMenu;
    SharedConn: TMyConnection;
    File1: TMenuItem;
    Close1: TMenuItem;
    qryMain: TMyQuery;
    dsMain: TDataSource;
    wwDBGrid1: TwwDBGrid;
    actDownloadEmails: TAction;
    DownloadEmails1: TMenuItem;
    actSelection: TAction;
    SelectionString1: TMenuItem;
    actRefresh: TAction;
    Refresh1: TMenuItem;
    wwMemoDialog1: TwwMemoDialog;
    Edit1: TEdit;
    PopupMenu1: TPopupMenu;
    Addfilter1: TMenuItem;
    Purge1: TMenuItem;
    ScriptMain: TERPScript;
    qryMainId: TIntegerField;
    qryMainDateTime: TDateTimeField;
    qryMainVersionNo: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainUser: TWideStringField;
    qryMainPCName: TWideStringField;
    qryMainFocusedForm: TWideStringField;
    qryMainFocusedControl: TWideStringField;
    qryMainExceptionName: TWideStringField;
    qryMainModuleName: TWideStringField;
    qryMainErrorText: TWideMemoField;
    qryMainNotes: TWideMemoField;
    qryMainIsFixed: TWideStringField;
    qryMainErrorType: TWideStringField;
    procedure actCloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actDownloadEmailsExecute(Sender: TObject);
    procedure actSelectionExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure wwDBGrid1TitleButtonClick(Sender: TObject; AFieldName: string);
    procedure wwDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Addfilter1Click(Sender: TObject);
    procedure wwMemoDialog1CloseDialog(Dialog: TwwMemoDlg);
    procedure Purge1Click(Sender: TObject);
  private
    procedure ConnectToDb;
    procedure RefreshQuery;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  AppVarsObj, Lib, frmSelectText, dateutils;


const
  DB_DATABASE_NAME = 'ErrorTracker';
  DB_USER = 'P_One';
  DB_PASS = '1w$p&LD07';

function GetExeFileVersion(const FileName: string): string;
var
  VersionInfoSize, VersionInfoValueSize, Zero: DWord;
  VersionInfo, VersionInfoValue: Pointer;
begin
  Result := '';
  if not FileExists(FileName) then Exit;
  VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Zero);
  if VersionInfoSize = 0 then Exit;
  GetMem(VersionInfo, VersionInfoSize);
  try
    if GetFileVersionInfo(PChar(FileName), 0, VersionInfoSize, VersionInfo) and VerQueryValue(VersionInfo,
      '\', VersionInfoValue,
      VersionInfoValueSize) and (0 <> longint(VersionInfoValueSize)) then begin
      with TVSFixedFileInfo(VersionInfoValue^) do begin
        Result := IntToStr(HiWord(dwFileVersionMS));
        Result := Result + '.' + IntToStr(LoWord(dwFileVersionMS));
        Result := Result + '.' + IntToStr(HiWord(dwFileVersionLS));
        Result := Result + '.' + IntToStr(LoWord(dwFileVersionLS));
      end;
    end;
  finally
    FreeMem(VersionInfo);
  end;
end;

procedure TfmMain.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.ConnectToDb;
begin
  SharedConn.LoginPrompt:= false;
  SharedConn.Port:= 3309;
  SharedConn.Server:= AppVars['ServerName'];
  SharedConn.Database:= DB_DATABASE_NAME;
  SharedConn.Username:= DB_USER;
  SharedConn.Password:= DB_PASS;
  SharedConn.Connect;
  RefreshQuery;
end;

procedure TfmMain.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_return then begin
    if qryMain.Locate(wwDBGrid1.GetActiveField.FieldName ,Edit1.text, [loCaseInsensitive, loPartialKey]) then
      edit1.visible := False;
  end else if Key = VK_ESCAPE then  begin
    wwDBGrid1.setfocus;
    edit1.visible := False;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Caption:= Caption + ' [' + GetExeFileVersion(Application.ExeName) + ']';
  AppVars:= TAppVars.Create;
  AppVars.LoadFromFile();
  AppVars.SetDefault('ServerName', 'localhost');
  AppVars.SetDefault('SelectSQL', 'IsFixed = "F" and VersionNo >= "9.0.0.4"');

  ConnectToDb;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  if AppVars.Dirty then
    AppVars.SaveToFile();
  AppVars.Free;
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssCtrl] then begin
    if (Key = ord('F')) or (Key = ord('f'))  then begin
      Edit1.text := '';
      Edit1.visible := True;
      Edit1.SetFocus;
    end;
  end;
  if key = vk_escape then application.terminate;
end;

procedure TfmMain.Purge1Click(Sender: TObject);
var
  s1, s2:String;
  Function Vertonum(const verno:String):Integer;
  var
    st:TStringlist;
    ctr:Integer;
  begin
    st:= tStringlist.Create;
    try
      result := 0;
      st.Delimiter:= '.';
      st.DelimitedText :=  verno;
      if st.Count >=1 then result := result + strtoint(st[0])*1000;
      if st.Count >=2 then result := result + strtoint(st[1])*100;
      if st.Count >=3 then result := result + strtoint(st[2])*10;
      if st.Count >=4 then result := result + strtoint(st[3]);
    finally
      st.Free;
    end;
  end;
begin
  s1:= inputBox('Version number to Purge upto', '', qryMainVersionNo.AsString);
  if s1='' then exit;
  s1:= inttostr(Vertonum(s1));
  with ScriptMain do begin
    connection := qryMain.Connection;
    SQL.Clear;
    s2:='exceptions_'+ trim(inttostr(yearof(date)));
    SQL.add('drop function if exists VersionToNo; ' + chr(13)+
              ' delimiter //; ' + chr(13)+
              '  CREATE DEFINER=`P_One`@`%` FUNCTION `VersionToNo`(`Version` varchar(20))  RETURNS bigint(20)  ' + chr(13)+
              ' BEGIN ' + chr(13)+
              '   Declare vData varchar(50); ' + chr(13)+
              '   Declare s1  varchar(2); ' + chr(13)+
              '   Declare s2  varchar(2); ' + chr(13)+
              '   Declare s3  varchar(2); ' + chr(13)+
              '   Declare s4  varchar(2); ' + chr(13)+
              '   Declare x int; ' + chr(13)+
              '  Set vData = version; ' + chr(13)+
              '  if vdata = "" then ' + chr(13)+
              '  	RETURN 0; ' + chr(13)+
              '  else ' + chr(13)+
              '  set x =0; ' + chr(13)+
              '  set s1 = ""; ' + chr(13)+
              '  while substr(vData,	x,1) <> "." do set s1 = concat(s1 , substr(vData,	x,1)); set x = x+1; end while; ' + chr(13)+
              '  set x = x+1; ' + chr(13)+
              '  set s2 = ""; ' + chr(13)+
              '  while substr(vData,	x,1) <> "." do set s2 = concat(s2 , substr(vData,	x,1)); set x = x+1; end while; ' + chr(13)+
              '  set x = x+1; ' + chr(13)+
              '  set s3 = ""; ' + chr(13)+
              '  while substr(vData,	x,1) <> "." do set s3 = concat(s3 , substr(vData,	x,1)); set x = x+1; end while; ' + chr(13)+
              '  set x = x+1; ' + chr(13)+
              '  set s4 = ""; ' + chr(13)+
              '  while x <=length(vdata) do set s4 = concat(s4 , substr(vData,	x,1)); set x = x+1; end while; ' + chr(13)+
              '   RETURN s1*1000 +s2*100 + s3*10+s4; ' + chr(13)+
              ' end if; ' + chr(13)+
              ' END;// ' + chr(13)+
              ' delimiter ;');
    if MessageDlg('Do you want to backup the data into ' + s2 +'?', mtConfirmation, [mbyes,mbno], 0) = mryes then begin
      SQL.add('Create table if not exists '+s2 +' like exceptions;');
      SQL.add('insert ignore into ' + s2 +' Select * from exceptions where VersionToNo(VersionNo) <= ' + s1+';');
    end;
    SQL.add('delete from exceptions where VersionToNo(VersionNo) <= ' + s1+';');
    Execute;
  end;
end;

procedure TfmMain.actDownloadEmailsExecute(Sender: TObject);
var
  sr: TSearchRec;
  fileName: string;
  TempDownloadPath:String;
  TempQry: TMyQuery;
Begin
  TempQry := TMyQuery.Create(nil);
  try
    Screen.Cursor := crHourGlass;
    TempQry.Options.FlatBuffers := True;
    TempQry.Connection := SharedConn;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('SELECT * FROM exceptions WHERE ID = 0;');
    TempQry.Open;
    {$WARN SYMBOL_PLATFORM OFF}
    TempDownloadPath := ExtractFilePath(Application.ExeName) + 'Temp';
    SysUtils.ForceDirectories(TempDownloadPath);
    DownloadEmail(TempDownloadPath);
    Application.MainForm.Update;
    Application.ProcessMessages;
    if SysUtils.FindFirst(TempDownloadPath + '\*.txt', 0, sr) = 0 then begin
      repeat
        if not (((sr.Attr and sysutils.faVolumeId) <> 0) or
                ((sr.Attr and sysutils.faDirectory) <> 0) or
                ((sr.Attr and sysutils.faReadOnly) <> 0)) then begin
          fileName := sr.Name;
          LoadFileToDB(TempDownloadPath + '\' + fileName,TempQry);
          SysUtils.DeleteFile(TempDownloadPath + '\' + fileName);
        end;
      until SysUtils.FindNext(sr) <> 0;
      SysUtils.FindClose(sr);
    end;
  finally
    TempQry.Free;
    Screen.Cursor := crDefault;
  end;
  RefreshQuery;
end;

procedure TfmMain.RefreshQuery;
begin
  qryMain.Close;
  if AppVars['SelectSQL'] <> '' then
    qryMain.SQL.Text:= 'SELECT * FROM exceptions WHERE ' + AppVars['SelectSQL']
  else
    qryMain.SQL.Text:= 'SELECT * FROM exceptions';
  qryMain.SQL.Add('ORDER BY ID');
  qryMain.Open;
end;

procedure TfmMain.wwDBGrid1DblClick(Sender: TObject);
begin
    if (wwDBGrid1.GetActiveField.FieldName = 'VersionNo') then begin
      if pos('NFF' , qryMainVersionNo.asString) =0 then begin
        if MessageDlg('Do u Wish to Flag it as NFF?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
          qryMain.Edit;
          qryMainVersionNo.asString := qryMainVersionNo.asString +' - NFF';
          qryMain.Post;
        end;
      end;
    end else if (wwDBGrid1.GetActiveField.FieldName = 'ErrorText') or (wwDBGrid1.GetActiveField.FieldName = 'Notes') then begin
       wwMemoDialog1.DataField := wwDBGrid1.GetActiveField.FieldName;
       if AppVars.IntVar['MemoWidth'] = 0 then begin
         AppVars.IntVar['MemoLeft']:= 0;
         AppVars.IntVar['MemoTop']:= 0;
         AppVars.IntVar['MemoWidth']:= 300;
         AppVars.IntVar['MemoHeight']:= 300;
       end;
       wwMemoDialog1.DlgLeft := AppVars.IntVar['MemoLeft'];
       wwMemoDialog1.Dlgtop := AppVars.IntVar['MemoTop'];
       wwMemoDialog1.DlgWidth := AppVars.IntVar['MemoWidth'];
       wwMemoDialog1.DlgHeight:= AppVars.IntVar['MemoHeight'];
       wwMemoDialog1.Execute ;
    end;
end;

procedure TfmMain.wwDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = vk_return then begin
    wwDBGrid1.SetActivefield('ErrorText');
    wwDBGrid1DblClick(wwDBGrid1);
end;
end;

procedure TfmMain.wwDBGrid1TitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
  qryMain.IndexFieldNames := AFieldName;
end;

procedure TfmMain.wwMemoDialog1CloseDialog(Dialog: TwwMemoDlg);
begin
  AppVars.IntVar['MemoLeft']:= Dialog.Left;
  AppVars.IntVar['MemoTop']:= Dialog.Top;
  AppVars.IntVar['MemoWidth']:= Dialog.Width;
  AppVars.IntVar['MemoHeight']:= Dialog.Height;
end;

procedure TfmMain.actSelectionExecute(Sender: TObject);
var s: string;
begin
  s:= AppVars['SelectSQL'];
  if DoSelectString(s) then begin
    AppVars['SelectSQL']:= s;
    RefreshQuery;
  end;
end;

procedure TfmMain.Addfilter1Click(Sender: TObject);
var
   s, ss:String;
begin
  s:= wwDBGrid1.GetActiveField.FieldName + ' = ' +Quotedstr(wwDBGrid1.GetActiveField.AsString);
  s:= InputBox('filter' , '' , s);
  if s='' then exit;
  ss:= AppVars['SelectSQL'];
  if ss<> '' then ss := ss +' and ' +s
  else ss:= s;
  AppVars['SelectSQL']:= ss;
  RefreshQuery;
end;

procedure TfmMain.actRefreshExecute(Sender: TObject);
begin
  RefreshQuery;
end;

end.
