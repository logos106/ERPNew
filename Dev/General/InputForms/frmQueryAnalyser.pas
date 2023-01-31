unit frmQueryAnalyser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  Shader, Grids, Wwdbigrd, Wwdbgrid, DAScript, MyScript, Buttons;

type
  TLinetype = (TTime = 1, TUser = 2, TQrytime=3, TOther=4);

  TSQLSegment = record
    Time:String;
    User :String;
    Query_time :String;
    Lock_time:String;
    Rows_sent:String;
    Rows_examined:String;
    SQL:String;
  end;

  TfmQueryAnalyser = class(TBaseInputGUI)
    FooterPanel: TPanel;
    Panel1: TPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Panel2: TPanel;
    OpenDialog1: TOpenDialog;
    QryMain: TERPQuery;
    dsMain: TDataSource;
    Label1: TLabel;
    edtSQLFilename: TEdit;
    btnSQLfile: TDNMSpeedButton;
    btnProcess: TDNMSpeedButton;
    ERPScript: TERPScript;
    QryMainID: TIntegerField;
    QryMainSQLTime: TWideStringField;
    QryMainSQLUser: TWideStringField;
    QryMainQuery_time: TFloatField;
    QryMainLock_time: TFloatField;
    QryMainRows_sent: TIntegerField;
    QryMainRows_examined: TIntegerField;
    QryMainQrySQL: TWideMemoField;
    btnClose: TDNMSpeedButton;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    QryMainContainsfixedQry: TWideStringField;
    QryMainQryfixedVer: TWideStringField;
    wwMemoDialog1: TwwMemoDialog;
    procedure btnSQLfileClick(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ERPScriptError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure btnCloseClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdMainDblClick(Sender: TObject);
  private
    F: TextFile;
    tablename:string;
    (*function Extractsingle:String;*)
    Function MakeSQLSegment(s:String):TSQLSegment;
    procedure initSQLSegment(var SQLSegment: TSQLSegment);
    function StartsWith(const Str, substr: String;CaseSensitive:boolean): boolean;
    (*procedure Query_time(var SQLSegment: TSQLSegment; s: String);*)
    procedure Execute(const SQL: String);
    Procedure ReadExtraGuipref;
    Procedure WriteExtraGuiPref;
    procedure UpdateFixed;
    procedure beforeshowueryAnalyserdetails(Sender: TObject);
  public
  end;
const
  SQLTime = '# Time:';
  SQLUser = '# User@Host:';
  SQLQuery_Time = '# Query_time:';
  SQLLock_time = 'Lock_time:';
  SQLRows_sent = 'Rows_sent:';
  SQLRows_examined = 'Rows_examined:';
  SQLH1 = 'C:\Mysql_ERP\bin\mysqld.exe, Version: 5.1.52-community-log (MySQL Community Server (GPL)). started with:';
  SQLH2 = 'TCP Port: 3309, Named Pipe: /tmp/mysql.sock';
  SQLH3 = 'Time                 Id Command    Argument';
  timestamp = 'SET timestamp=';

implementation

uses CommonLib, strutils, types, CommonDbLib, tcConst, AppVarsObj,
  CommonFormLib, frmQueryAnalyserdetails;

{$R *.dfm}

Function EmptySQLSegment(SQLSegment:TSQLSegment):Boolean;
begin
  result:=        not((Trim(SQLSegment.Time         ) <> '') or
                      (Trim(SQLSegment.user         ) <> '') or
                      (Trim(SQLSegment.Query_time   ) <> '') or
                      (Trim(SQLSegment.Lock_time    ) <> '') or
                      (Trim(SQLSegment.Rows_sent    ) <> '') or
                      (Trim(SQLSegment.Rows_examined) <> '') or
                      (Trim(SQLSegment.SQL          ) <> ''));

end;
procedure TfmQueryAnalyser.Execute(Const SQL:String);
begin
    ERPScript.SQL.clear;
    ERPScript.SQL.add(SQL);
    ERPScript.Execute;
end;
procedure TfmQueryAnalyser.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmQueryAnalyser.btnProcessClick(Sender: TObject);
var
  s:String;
  SQLSegment :TSQLSegment;
  sSQL:String;
begin
  inherited;
  CloseDB(Qrymain);
  try
      Execute('Truncate '+tablename+';')  ;
      if not(FileExists(edtSQLFilename.Text)) then begin
        MessageDlg(edtSQLFilename.Text +' file doesn''t exists', mtWarning, [mbOK], 0);
        Exit;
      end;
        {$I-}
        AssignFile(F, edtSQLFilename.Text );
        Reset(F);
        sSQL:='';
        showProgressbar(WAITMSG, 100, false);
        try
          while not Eof(F) do begin
            Readln(F, s);
            if (s<> '') and (Length(s) >= length(SQLTime)) and (Copy(s , 1, Length(SQLTime)) = SQLTime) then begin
                  SQLSegment := MakeSQLSegment(sSQL);
                  if not(EmptySQLSegment(SQLSegment)) then begin
                    Execute('insert into '+Tablename +
                        ' ( SQLTime , SQLUser , Query_time , Lock_time , Rows_sent , Rows_examined , QrySQL)Values (' +
                         quotedstr(Trim(SQLSegment.Time)) +',' +
                         quotedstr(Trim(SQLSegment.user)) +',' +
                         quotedstr(Trim(SQLSegment.Query_time)) +',' +
                         quotedstr(Trim(SQLSegment.Lock_time)) +',' +
                         quotedstr(Trim(SQLSegment.Rows_sent)) +',' +
                         quotedstr(Trim(SQLSegment.Rows_examined)) +',' +
                         quotedstr(trim(SQLSegment.SQL)) +');');
                  end;
                  sSQL:=s;
                  stepProgressbar;
            end else begin
              if pos(timestamp, s)=1 then else
                sSQL := sSQL + NL+s;
            end;
          end;
        finally
          HideProgressbar;
        end;
        CloseFile(F);
        {$I+}
  finally
    updateFixed;
    opendb(Qrymain);
  end;
end;
Procedure TFmQueryAnalyser.UpdateFixed;
var
  AlreadyfixedSQL:Array of array of string;
  ctr:Integer;
begin
  SetLength(AlreadyFixedSQL,2);

  (*AlreadyFixedSQL[0,ctr] stores the version where the issue was handled*)

  SetLength(AlreadyFixedSQL[0],1);  SetLength(AlreadyFixedSQL[1],1);
  AlreadyFixedSQL[0,0] := '10.1.5.0';  AlreadyFixedSQL[1,0] := 'Select SaleId from tblSaleslines   where ifnull(ProgresspaymentRef,"") in   (select Globalref from tblsaleslines where saleId = ';

        (*  AlreadyFixedSQL[0,1] := '';  AlreadyFixedSQL[1,1] := ' ';
          AlreadyFixedSQL[0,2] := '';  AlreadyFixedSQL[1,2] := ' ';
          AlreadyFixedSQL[0,3] := '';  AlreadyFixedSQL[1,3] := ' ';
          AlreadyFixedSQL[0,4] := '';  AlreadyFixedSQL[1,4] := ' ';*)

  for ctr:= low(AlreadyFixedSQL) to high(AlreadyFixedSQL) do begin
    if trim(AlreadyFixedSQL[1,ctr]) <> '' then
          Execute('update '+tablename +' Set ContainsfixedQry = "T" , '+
                                           ' QryfixedVer = ' +Quotedstr(AlreadyFixedSQL[0,ctr]) +
                                           ' where QrySQL like ' +Quotedstr('%' + trim(AlreadyFixedSQL[ctr,1]) +'%'));
  end;

end;
procedure TfmQueryAnalyser.btnSQLfileClick(Sender: TObject);
begin
  inherited;
  if OpenDialog1.Execute then begin
    edtSQLFilename.Text := Opendialog1.Filename;
  end;
end;

procedure TfmQueryAnalyser.ERPScriptError(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  inherited;
  Action := eaContinue;
end;

(*function TfmQueryAnalyser.Extractsingle: String;
var
  s:String;
begin
  REsult:= '';
  while not Eof(F) do begin
  Readln(F, s);
    if (s<> '') and (Length(s) >= length(SQLTime)) and (Copy(s , 1, Length(SQLTime)) = SQLTime) then begin
      break;
      Exit;
    end;
    result := result + s;
  end;

end;*)
procedure TfmQueryAnalyser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteExtraGuiPref;
  inherited;
  action := caFree;
end;

procedure TfmQueryAnalyser.FormCreate(Sender: TObject);
begin
  AllowGridSorting  := True;
  AllowCustomiseGrid := true;
  inherited;
  tablename:= '';
  GuiPrefs.active := True;
  if devmode then
    if GuiPrefs.Node['General.Tablename'].AsString <> '' then
      tablename := GuiPrefs.Node['General.Tablename'].AsString ;


  if (tablename<> '') and (tableexists(tablename)) then else begin
    TableName := CommonDbLib.GetUserTemporaryTableName('SQLanalyser');
    With tempMyScript do try
      SQL.Add('Drop table if exists '+tablename +';' +
            ' CREATE TABLE `'+tablename +'` (' +
            ' 	`ID` INT(10) NULL AUTO_INCREMENT,' +
            ' 	`SQLTime` VARCHAR(100) NULL DEFAULT NULL,' +
            ' 	`SQLUser` VARCHAR(100) NULL DEFAULT NULL,' +
            ' 	`Query_time` Double NULL DEFAULT NULL,' +
            ' 	`Lock_time` Double NULL DEFAULT NULL,' +
            ' 	`Rows_sent` INT NULL DEFAULT NULL,' +
            ' 	`Rows_examined` INT NULL DEFAULT NULL,' +
            ' 	`QrySQL` TEXT NULL DEFAULT NULL,' +
            '    ContainsfixedQry Enum("T","F") default "F",' +
            '    QryfixedVer varchar(15),' +
            ' 	PRIMARY KEY (`ID`)' +
            ' )' +
            ' COLLATE="utf8_general_ci"' +
            ' ENGINE=MyISAM;');
      execute;
    finally
      free;
    end;
  end;
  Qrymain.SQL.Text := 'Select * from '+tablename ;
end;

procedure TfmQueryAnalyser.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = vk_return then begin
    grdmain.SetActivefield('QrySQL');
    wwMemoDialog1.DataField := 'QrySQL';
    wwMemoDialog1.Execute ;
  end;
end;

procedure TfmQueryAnalyser.FormShow(Sender: TObject);
begin
  inherited;
  OpenQueries;
  ReadExtraGuiPref;
  qryMain.IndexFieldNames := ' Query_time desc';
end;

procedure TfmQueryAnalyser.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if QryMainContainsfixedQry.AsBoolean then Afont.Color := clGreen;
end;
procedure TfmQueryAnalyser.beforeshowueryAnalyserdetails(Sender: TObject);
begin
   if not(Sender is TfmQueryAnalyserdetails) then exit;
   TfmQueryAnalyserdetails(Sender).sql := QrymainQrySQL.asString;
end;
procedure TfmQueryAnalyser.grdMainDblClick(Sender: TObject);
begin
  inherited;
  if Sametext(grdmain.GetActiveField.FieldName , QryMainQuery_time.FieldName) then
    OpenERPFormModal('TfmQueryAnalyserdetails' , 0 , beforeshowueryAnalyserdetails, true)
end;

Procedure  TfmQueryAnalyser.initSQLSegment(var SQLSegment :TSQLSegment);
begin
      SQLSegment.Time         := '';
      SQLSegment.user         := '';
      SQLSegment.Query_time   := '';
      SQLSegment.Lock_time    := '';
      SQLSegment.Rows_sent    := '';
      SQLSegment.Rows_examined:= '';
      SQLSegment.SQL          := '';
end;
function TfmQueryAnalyser.StartsWith(Const Str, substr:String;CaseSensitive:Boolean):boolean;
begin
  result:= False;
  if str = '' then exit;
  if substr='' then exit;
  if CaseSensitive and (copy(str , 1, length(substr)) = substr) then result := TRue
  else if sametext(copy(str , 1, length(substr)) , substr) then result:= TRue;
end;

procedure TfmQueryAnalyser.WriteExtraGuiPref;
begin
  GuiPrefs.Node['General.filename'].AsString:= edtSQLFilename.text;
  GuiPrefs.Node['General.Tablename'].AsString:= Tablename;
  GuiPrefs.Node['General.indexfilename'].AsString:= qryMain.IndexFieldNames;
end;

(*Procedure TfmQueryAnalyser.Query_time(Var SQLSegment:TSQLSegment;s:String);
var
  sQuery_time,sLock_time,sRows_sent,sRows_examined:String;
  i:Integer;
begin
  sQuery_time     := '';
  sLock_time      :='';
  sRows_sent      :='';
  sRows_examined  :='';

  s:= trim(replacestr(s , SQLQuery_Time , '')); {19.500500  Lock_time: 0.982825 Rows_sent: 0  Rows_examined: 915625}

  i:= pos(SQLLock_time , s);
  if i>0 then begin
     sQuery_time := trim(copy(s , 1,i-1));
     s:= replacestr(s,sQuery_time, '');
     s:=replacestr(s,SQLLock_time , '');
  end;

  s:= trim(s);                            {0.982825 Rows_sent: 0  Rows_examined: 915625}
  i:= pos(SQLRows_sent , s);
  if i>0 then begin
     sLock_time := copy(s , 1,i-1);
     s:= replacestr(s,sLock_time, '');
     s:=replacestr(s,SQLRows_sent , '');
  end;

  s:= trim(s);                        {0  Rows_examined: 915625}
  i:= pos(SQLRows_examined , s);
  if i>0 then begin
     sRows_sent := copy(s , 1,i-1);
     s:= replacestr(s,sRows_sent, '');
     s:=replacestr(s,SQLRows_examined , '');
  end;
  sRows_examined:= trim(s);                        {915625}
  SQLSegment.Query_time   := sQuery_time;
  SQLSegment.Lock_time    := sLock_time;
  SQLSegment.Rows_sent    := sRows_sent;
  SQLSegment.Rows_examined:= sRows_examined;
end;*)

procedure TfmQueryAnalyser.ReadExtraGuipref;
begin
  if not(GuiPrefs.Active) then GuiPrefs.Active := True;
  edtSQLFilename.text:= GuiPrefs.Node['General.filename'].AsString;
  qryMain.IndexFieldNames:= GuiPrefs.Node['General.indexfilename'].AsString;
end;

function TfmQueryAnalyser.MakeSQLSegment(s: String): TSQLSegment;
var
  sa: TStringDynArray;
  ctr:Integer;
begin
  initSQLSegment(REsult);
  if s= '' then exit;
  s:= replacestr(s , SQLH1 , '');
  s:= replacestr(s , SQLH2 , '');
  s:= replacestr(s , SQLH3 , '');
  {# Query_time: ,Lock_time: ,Rows_sent: and Rows_examined: are all inthe same line, inser NL as they will be split into separate lines }
  s:= replacestr(s , SQLLock_time , NL+SQLLock_time);
  s:= replacestr(s , SQLRows_sent , NL+SQLRows_sent);
  s:= replacestr(s , SQLRows_examined , NL+SQLRows_examined);
  if Trim(s) = '' then exit;

  sa := SplitString(Trim(s),NL);
  if Length(sa) > 1 then begin
    for ctr:= 0 to length(sa)-1 do begin
            if startswith(sa[ctr] ,  SQLTime          , false) then REsult.Time         := replacestr(sa[ctr],SQLTime,'')
      else  if startswith(sa[ctr] ,  SQLUser          , false) then REsult.user         := replacestr(sa[ctr],SQLUser,'')
      else  if startswith(sa[ctr] ,  SQLQuery_Time    , false) then REsult.Query_time   := replacestr(sa[ctr],SQLQuery_Time,'')
      else  if startswith(sa[ctr] ,  SQLLock_time     , false) then REsult.Lock_time    := replacestr(sa[ctr],SQLLock_time,'')
      else  if startswith(sa[ctr] ,  SQLRows_sent     , false) then REsult.Rows_sent    := replacestr(sa[ctr],SQLRows_sent,'')
      else  if startswith(sa[ctr] ,  SQLRows_examined , false) then REsult.Rows_examined:= replacestr(sa[ctr],SQLRows_sent,'')
      else Result.SQL := Result.SQL +NL+sa[ctr] ;
    end;
  end;
end;

initialization
  RegisterClass(TfmQueryAnalyser);

end.

