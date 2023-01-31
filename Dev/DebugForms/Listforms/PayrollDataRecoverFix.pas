unit PayrollDataRecoverFix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TPayrollDataRecoverFixGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblBackupdb: TLabel;
    lbllivedb: TLabel;
    DNMSpeedButton1: TDNMSpeedButton;
    btnHelp: TDNMSpeedButton;
    btnMakeScript: TDNMSpeedButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    qryMainTablename: TWideStringField;
    qryMainhistorycount: TLargeintField;
    qryMainlivecount: TLargeintField;
    btnupdateleaveaccruals: TDNMSpeedButton;
    procedure btnMakeScriptClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnupdateleaveaccrualsClick(Sender: TObject);
  private
    fslivedb: String;
    fsbackupdb: String;
    procedure Choosebackupdb(Sender: TwwDbGrid);
    procedure Chooselivedb(Sender: TwwDbGrid);
    procedure setbackupdb(const Value: String);
    procedure setlivedb(const Value: String);
    function ValidatePassword: Boolean;
    function InputPassword: String;
  public
    Property backupdb: String read fsbackupdb write setbackupdb;
    Property livedb: String read fslivedb write setlivedb;
    Procedure REfreshquery;Override;
  end;


implementation

uses CommonFormLib, BusObjPayBase, BusObjPaysPayratesBASE, BusObjPaysAllowances,
  BusObjPaysDeductions, BusObjPaysSuperannuation, BusObjpaysLeave,
  BusObjPaySundriesBASE, BusObjLeaveAccruals, BusObjPayCommissionsBASE,
  BusObjTerminationSimple, BusObjPayLine, CommonLib, CommonDbLib,
  DbSharedObjectsObj, LogLib, tcConst;

{$R *.dfm}

{ TPayrollDataRecoverFixGUI }

Function TPayrollDataRecoverFixGUI.ValidatePassword:Boolean;
var
  fsPassword:String;
begin
  result := False;
  fsPassword:= '';
  if fsPassword <> SPECIALPASSWORD then fsPassword :=  InputPassword;

  if fsPassword = SPECIALPASSWORD then begin
    Result := True;
    Exit;
  end else begin
    ListTimerMsg('Invalid Password. Access Denied');
  end;

end;
procedure TPayrollDataRecoverFixGUI.btnHelpClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TERPDatabasesListGUI', Choosebackupdb);
end;


procedure TPayrollDataRecoverFixGUI.btnMakeScriptClick(Sender: TObject);
var
  conBackup, conlive:TERPConnection;
  ctr:Integer;
  Procedure Logrecordcount(fstablename:String;con :TERPConnection );
  var
    qry: TERPQuery;
  begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(con);
    try
      qry.active := false;
      qry.SQL.Text := 'Select count(*) ctr from  '+ fstablename;
      qry.open;
      ListBox2.Items.Add( con.Database +':' +fsTablename + '->' + inttostr(Qry.FieldByName('ctr').AsInteger));
      qry.active := false;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  end;
  Procedure DoFixRun(fstablename:String);
  var
    scr :TERPScript;
  begin
    inherited;
    Logrecordcount(fstablename, conBackup);
    Logrecordcount(fstablename, conlive);
    try
      scr := DbSharedObj.GetScript(conlive);
      try
        scr.SQL.Clear;
        if sametext(fstablename , 'tblleave') then begin
          scr.SQL.Add('create table if not exists erpfix_'+fstablename+'_Payrollfix_400 like '+fstablename+' ;');
          scr.SQL.Add('insert ignore into erpfix_'+fstablename+'_Payrollfix_400 select * from  '+fstablename+' ;');          scr.SQL.Add('Drop table if exists tmp_'+fstablename+'_Payrollfix_Copy;');          scr.SQL.Add('create table tmp_'+fstablename+'_Payrollfix_Copy like '+fstablename+' ;');          scr.SQL.Add('insert ignore into tmp_'+fstablename+'_Payrollfix_Copy select * from  '+ fsbackupdb+'.'+fstablename+' ;');          scr.SQL.Add('update ' + fslivedb+'.'+fstablename +' T1 '+                      ' inner join tmp_'+fstablename+'_Payrollfix_Copy T2 on T1.LeaveID = T2.LeaveID '+                      ' Set T1.AccruedHours = ifnull(T1.AccruedHours,0) + ifnull(T2.AccruedHours,0);');          scr.SQL.Add('Drop table if exists tmp_'+fstablename+'_Payrollfix_Copy;');
        end else begin
          scr.SQL.Add('create table if not exists erpfix_'+fstablename+'_Payrollfix_400 like '+fstablename+' ;');
          scr.SQL.Add('insert ignore into erpfix_'+fstablename+'_Payrollfix_400 select * from  '+fstablename+' ;');          scr.SQL.Add('/* truncate '+fstablename+';');          scr.SQL.Add(' insert ignore into '+fstablename+' select * from  erpfix_'+fstablename+'_Payrollfix_400 ;*/');
          scr.SQL.Add('insert ignore into ' + fslivedb+'.'+fstablename +' select * from '+ fsbackupdb+'.' +fstablename +';');
        end;
        scr.Execute;
      finally
        DbSharedObj.ReleaseObj(scr);
      end;
    finally
      Logrecordcount(fstablename, conlive);
      ListBox2.Items.Add('===========================================');
    end;
  end;
begin
  inherited;
  if (fsbackupdb = '') or ( fslivedb = '') then begin
    MessageDlgXP_vista('Please Choose the Live and backup databases', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not(ValidatePassword) then exit;


  ListBox2.Items.Clear;
  conBackup:= commondblib.GetNewMyDacConnection(self, fsbackupdb);
  conlive  := commondblib.GetNewMyDacConnection(self, fslivedb);
  try
    if Sender = btnMakeScript then begin
      for ctr:= 0 to ListBox1.Items.Count-1 do begin
          DoFixRun(ListBox1.Items[ctr]);
      end;
    end else if Sender = btnupdateleaveaccruals then begin
          DoFixRun('tblleave');
    end;
      if devmode  then ListBox2.Items.Savetofile('c:\erp.log');
  finally
    Freeandnil(conBackup);
    Freeandnil(conlive);
  end;

  MessageDlgXP_vista('Update Finished', mtInformation, [mbOK], 0);
end;

procedure TPayrollDataRecoverFixGUI.btnupdateleaveaccrualsClick(
  Sender: TObject);
begin
  inherited;
  if MessageDlgXP_Vista('"Update Leave Accruals" can be Run only once in a databse. '+NL+
                         'Running this function again will double the Leave Accrued. '+NL+NL+
                         'It is not possible to revert it once done. '+NL+NL+
                         'Do you wish to Run it?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  btnMakeScriptClick(sender);
end;

procedure TPayrollDataRecoverFixGUI.Choosebackupdb(Sender: TwwDbGrid);
begin
  backupdb:= Sender.datasource.dataset.fieldbyname('Databasename').asString;
end;

procedure TPayrollDataRecoverFixGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TERPDatabasesListGUI', Chooselivedb);
end;
procedure TPayrollDataRecoverFixGUI.setbackupdb(const Value: String);
begin
  fsbackupdb := Value;
  lblbackupdb.caption :=Value;
  RefreshQuery;
end;

procedure TPayrollDataRecoverFixGUI.setlivedb(const Value: String);
begin
  fslivedb := Value;
  lbllivedb.caption :=Value;
  RefreshQuery;
end;

procedure TPayrollDataRecoverFixGUI.Chooselivedb(Sender: TwwDbGrid);
begin
  livedb:= Sender.datasource.dataset.fieldbyname('Databasename').asString;
end;

procedure TPayrollDataRecoverFixGUI.FormCreate(Sender: TObject);
begin
  inherited;
  clog('');
  backupdb :='';
  livedb :='';
  ListBox1.visible := devmode;
  ListBox2.visible := devmode;

  ListBox1.items.clear;
  ListBox1.items.add(Tpayspayrates.GetBusObjectTablename);
  ListBox1.items.add(Tpaysallowances.GetBusObjectTablename);
  ListBox1.items.add(Tpaysdeductions.GetBusObjectTablename);
  ListBox1.items.add(Tpayssundries.GetBusObjectTablename);
  ListBox1.items.add(TLeaveaccruals.GetBusObjectTablename);
  ListBox1.items.add(Tpayscommission.GetBusObjectTablename);
  ListBox1.items.add(Tpayssuperannuation.GetBusObjectTablename);
  ListBox1.items.add(TTerminationSimple.GetBusObjectTablename);
  ListBox1.items.add(TPayLine.GetBusObjectTablename);
  HaveDateRangeSelection := false;
end;

procedure TPayrollDataRecoverFixGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qrymainlivecount.asinteger-qrymainhistorycount.asinteger < 0 then
    Doredhighlight(Afont, abrush);
end;

function TPayrollDataRecoverFixGUI.InputPassword: String;
var
  s:String;
begin
  if devmode then s:= SPECIALPASSWORD else s:= '';
  result := CustomInputPassword('Login', 'Please Check with ERP that this Utilities is verified on your database backup!!!!' + chr(13) + 'Please Enter the Password',s);
end;

procedure TPayrollDataRecoverFixGUI.REfreshquery;
var
  ctr:Integer;
begin
  Closedb(qrymain);
  qrymain.SQL.Clear;
  IF (backupdb ='') OR (livedb ='') then begin
    qrymain.SQL.add('Select "" as Tablename, 0 as historycount, 0 as livecount from dual');
  end else begin
    for ctr:= 0 to ListBox1.Items.Count-1 do begin
      IF qrymain.SQL.COUNt > 0 then qrymain.SQL.add('union all');
      qrymain.SQL.add('Select ');
      qrymain.SQL.add(inttostr(ctr)+' as ctr, ');
      qrymain.SQL.add(quotedstr(ListBox1.Items[ctr])+' as Tablename, ');
      qrymain.SQL.add('(Select Count(*) from '+backupdb+'.'+ListBox1.Items[ctr]+') as historycount, ');
      qrymain.SQL.add('(Select Count(*) from '+livedb+'.'+ListBox1.Items[ctr]+') as livecount ');
    end;
    qrymain.SQL.add('order by livecount-historycount');
  end;
  RefreshOrignalSQL(False);
  logtext(qrymain.SQL.text);
  inherited;

end;

initialization
  RegisterClassOnce(TPayrollDataRecoverFixGUI);

end.
