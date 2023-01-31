unit frmSpecial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, DAScript,
  MyScript, Buttons, Wwdbigrd, Grids, Wwdbgrid, DBCtrls;

type
  TfmSpecial = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    btnrun: TDNMSpeedButton;
    btnLoad: TDNMSpeedButton;
    memSQLtoRun: TMemo;
    lblMsg: TLabel;
    OpenDialog1: TOpenDialog;
    scr: TERPScript;
    memfiles: TMemo;
    QryUpdate: TERPQuery;
    lblDbName: TLabel;
    memSQLToshow: TMemo;
    qryMain: TERPQuery;
    dsMain: TDataSource;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    edtMaindesc: TDBText;
    DNMSpeedButton1: TDNMSpeedButton;
    chkOneSideJournal: TCheckBox;
    procedure cmdCloseClick(Sender: TObject);
    procedure btnrunClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure scrBeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure chkOneSideJournalClick(Sender: TObject);
  private
    fsPassword :String;
    function InputPassword: String;
    function ValidatePassword: Boolean;
    function RunSQL(Filename:String): Boolean;
    function IsValidVersion(sVersionno:String; filename:String): Boolean;
    procedure getFromnTo(filename: String; var sfrom, sto: String);
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses DbSharedObjectsObj, CommonLib, CommonDbLib, tcConst, LogLib,
  AppEnvironment, ERPErrorEmailUtils, AppDatabase ,Clipbrd, ERPVersionConst,
  CommonFormLib;


{$R *.dfm}

procedure TfmSpecial.chkOneSideJournalClick(Sender: TObject);
begin
  AppEnv.CompanyPrefs.OneSidedJournal := chkOneSideJournal.Checked;
end;

procedure TfmSpecial.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmSpecial.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  openerpform('TfmTrialBalanceAdjustment',0);
end;

procedure TfmSpecial.btnLoadClick(Sender: TObject);
var
  files : TStringlist;
  ctr:Integer;
  filename :String;
  fbDorun :Boolean;
  fsEmailtoERp :TStringlist;
begin
  inherited;
  if not(ValidatePassword) then exit;
  inherited;
    memfiles.lines.clear;
    if OpenDialog1.Execute = False then exit;
    if Opendialog1.Files.count =0 then exit;
    files := TStringlist.create;
    try
      files.text := Opendialog1.Files.text;
      DoShowProgressbar(files.count , WAITMSG);
      try
        fbDorun := True;
        memSQLtoShow.Lines.Clear;
        grdmain.visible := False;
        edtMaindesc.visible := False;
        fsEmailToERP := TStringlist.create;
        try
          for ctr:= 0 to files.count-1 do begin
            filename := files[ctr];
            fsEmailToERP.add(inttostr(ctr+1)+'.    File ->  ' +filename+'   ' + formatdatetime('dd/mm/yyyy hh:nn:ss am/pm' , now) +NL+NL);
            if (filename = '') or not(FileExists(filename)) then begin
              fsEmailToERP.add('Error - File Does not Exists');
              continue;
            end;

            if fbDorun then begin
              memSQLtoRun.Lines.Clear;
              DoStepProgressbar(filename);
              memSQLtoRun.Lines.Add('\*' +filename +'*/');memSQLtoShow.Lines.Add('\*' +filename +'*/');
              memSQLtoRun.Lines.LoadFromFile(filename);memSQLtoShow.Lines.LoadFromFile(filename);
              memSQLtoShow.Lines.add('==================================================================================================');
              fsEmailToERP.add(memSQLtoRun.Lines.text);
              if not RunSQL(filename) then begin
                fbDorun := False;
                memfiles.lines.add('FAILED - ' + filename);
                memSQLtoShow.lines.add('FAILED - ' + filename);
                fsEmailToERP.add('FAILED' );
              end else begin
                memfiles.lines.add('Done - ' + filename);
                memSQLtoShow.lines.add('Done - ' + filename);
                fsEmailToERP.add('Done ');
              end;
            end else  begin
              memfiles.lines.add('NOT Done - ' + filename);
              memSQLtoShow.lines.add('NOT Done - ' + filename);
              fsEmailToERP.add('NOT Done ');
            end;
            fsEmailToERP.add('==================================================================================================');
          end;
          finally
            SendEmailtoErp('Special Form : SQL Executed ' ,
                            '    Company     :' + Appenv.CompanyInfo.Companyname + chr(13) +
                            '    Server      :' + GetSharedMyDacConnection.Server + chr(13) +
                            '    Datase      :' + GetSharedMyDacConnection.Database + chr(13) +
                            '    Version     :' + TABLE_VERSION + chr(13) +
                            '    User        :' + Appenv.employee.employeename +chr(13) +
                            '    Details :' + chr(13) +chr(13) +
                            fsEmailToERP.text , 'sendemail');

            FreeandNil(fsEmailToERP);
            if tableexists('tmp_1') then begin
              closedb(qrymain);
              qrymain.SQL.Text := 'Select * from tmp_1;';
              qrymain.Open;
              grdmain.visible := True;
              edtMaindesc.top := 0;
            end;
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      freeandnil(files);
    end;
end;

procedure TfmSpecial.btnrunClick(Sender: TObject);
begin
if memSQLtoRun.Lines.Count =0 then begin
  timerMsg(lblmsg, 'Please Choose the SQL to Run');
  exit;
end;
  RunSQL('');
end;
function TfmSpecial.RunSQL(Filename:String) :Boolean;
var
  s:String;
begin
  result := False;
  if not(ValidatePassword) then exit;

  if memSQLtoRun.Lines.Count =0 then exit;
    scr.connection := Myconnection;

    scr.SQL.Clear;
    scr.SQL.Add(memSQLtoRun.Lines.Text);

    if memSQLtoRun.Lines.count >=1 then
      if sametext(copy(memSQLtoRun.Lines[0] , 1, 15) , '#UpdateVersion=') then begin
        s:= trim(replacestr(memSQLtoRun.Lines[0],'#UpdateVersion=', ''));
        if not(IsValidVersion(s,Filename )) then begin
          Result := False;
          timerMsg(lblMsg, 'Update Failed. Databse Version =' + QryUpdate.fieldbyname('version').asString+', its not possible to update to version ' + s);
          memSQLtoShow.lines.add('******   Update Failed. Databse Version =' + QryUpdate.fieldbyname('version').asString+', its not possible to update to version ' + s);
        end;
      end;
    begintransaction;
    try
      scr.Execute;
      CommitTransaction;
      REsult := TRue;
      memSQLtoRun.Lines.Clear;
    Except
      on E:Exception do begin
        RollbackTransaction;
        memSQLtoRun.Lines.Clear;
      end;
    end;
end;
function TfmSpecial.IsValidVersion(sVersionno:String; filename:String):Boolean;
var
   sfrom, sto :String;
begin
  if QryUpdate.active then QryUpdate.close;
  QryUpdate.SQL.clear;
  QryUpdate.SQL.add('select * , VersionToNo(version) as Verno , VersionToNo(' +quotedstr(sVersionno)+') as updatetoVerno from tblupdatedetails');
  QryUpdate.open;
  result := QryUpdate.fieldbyname('Verno').asInteger < QryUpdate.fieldbyname('updatetoVerno').asInteger;
  if result then begin
    getFromnTo(filename, sFrom, sTo);
    result := sametext(sfrom , QryUpdate.fieldbyname('Version').asString);
  end;
end;
procedure TfmSpecial.qryMainAfterOpen(DataSet: TDataSet);
var
  ctr:Integer;
begin
  inherited;
  grdmain.selected.clear;
  for ctr := 0 to Qrymain.FieldCount-1 do
    if sametext('Maindesc' , Qrymain.Fields[ctr].fieldname ) then edtMaindesc.visible := True
    else grdmain.selected.add(SelectedText(Qrymain.Fields[ctr].fieldname  , Qrymain.Fields[ctr].fieldname, 30));
  grdmain.Applyselected;
end;

procedure TfmSpecial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmSpecial.FormCreate(Sender: TObject);
begin
  inherited;
  fsPassword :='';
end;


procedure TfmSpecial.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Screen.ActiveControl = grdMain then begin
    if Shift = [ssctrl] then begin
      if Chr(Key) = 'C' then begin
        try
          Clipboard.asText:= TField(grdMain.GetActiveField).asString;
        Except
          on E:Exception do begin
            MessageDlgXP_vista('Copy Failed.'+NL+E.Message+NL+NL+'Try Again', mtWarning, [mbOK], 0);
          end;
        end;

      end;
    end;
  end;
end;

procedure TfmSpecial.FormShow(Sender: TObject);
begin
  inherited;
  lblDbName.caption := 'Database : ' + AppEnv.AppDb.Database;
  lblDbName.Refresh;
  ValidatePassword;
end;

Function TfmSpecial.ValidatePassword: Boolean;
begin
  result := False;

  if fsPassword <> SPECIALPASSWORD then fsPassword := InputPassword;
  chkOneSideJournal.Visible := fsPassword = SPECIALPASSWORD;

  if fsPassword = SPECIALPASSWORD then begin
    Result := True;
    Exit;
  end else begin
    TimerMsg(lblmsg , 'Invalid Password. Access Denied');
  end;

end;
function TfmSpecial.InputPassword: String;
var
  s:String;
begin
  if devmode then s := SPECIALPASSWORD else s := '';
    result := CustomInputPassword('Login', 'Please Check with ERP that the SQL is Correct Before Proceed!!!!' + chr(13) + 'Please Enter the Password', s);
end;

procedure TfmSpecial.scrBeforeExecute(Sender: TObject; var SQL: string;
  var Omit: Boolean);
begin
  inherited;
  logtext(SQL);
end;

Procedure TfmSpecial.getFromnTo(filename:String; var sfrom:String;var sto:String);
begin
  sFrom := replacestr(filename , 'Update' , '');
  sto := sFrom;
  sfrom := copy(sfrom , 1 , pos('to' , sfrom)-1);
  sto := copy(sto, length(sfrom)+1 , length(sto));
  sto := replaceStr(sto, '.sql', '');
  sto := replaceStr(sto, 'to', '');
  sto:= replacestr(sto, '.' , '');
  sFrom:= replacestr(sFrom, '.' , '');
end;


Initialization
  RegisterClassOnce(TfmSpecial);

end.
