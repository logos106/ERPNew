unit frmSiteIntegrationReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TfmSiteIntegrationReport = class(TBaseListingGUI)
    qryMainId: TLargeintField;
    qryMainName: TWideStringField;
    qryMainTwoWaySynch: TWideStringField;
    qryMainSourceURL: TWideStringField;
    qryMainSourceDatabase: TWideStringField;
    qryMainDestinationURL: TWideStringField;
    qryMainDestinationDatabase: TWideStringField;
    qryMainSynchType: TWideStringField;
    qryMainStartTime: TDateTimeField;
    qryMainFinishTime: TDateTimeField;
    qryMainDurationSecs: TLargeintField;
    qryMainLastOkDurationSecs: TLargeintField;
    qryMainStatus: TWideStringField;
    qryMainOkCount: TLargeintField;
    qryMainFailCount: TLargeintField;
    qryMainDuration: TStringField;
    qryMainTimeSinceLastSuccess: TStringField;
    tmrFollowTail: TTimer;
    btnClearLog: TDNMSpeedButton;
    chkFollowTail: TwwCheckBox;
    qryMainAvgSecs: TLargeintField;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure chkFollowTailClick(Sender: TObject);
    procedure tmrFollowTailTimer(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure qryMainFinishTimeGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure MyConnection1Error(Sender: TObject; E: EDAError;
      var Fail: Boolean);
  private
    FirstRefresh: boolean;
    LogCount, FailCount, OkCount: integer;
  protected
    procedure RefreshQuery; override;
  public
  end;

var
  fmSiteIntegrationReport: TfmSiteIntegrationReport;

implementation

uses
  CommonDbLib, CommonLib, DbConst, frmSiteIntegrationLinesReport;

{$R *.dfm}

procedure TfmSiteIntegrationReport.btnClearLogClick(Sender: TObject);
var
  cmd: TErpCommand;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This will delete all the Report Entries, is that what you want to do?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    cmd:= TErpCommand.Create(nil);
    try
      cmd.Connection := MyConnection1;
      cmd.SQL.Text:= 'truncate tblsynchist;';
      cmd.SQL.Add('truncate tblsynchistLines;');
      cmd.Execute;
      self.btnRequery.Click;
    finally
      cmd.Free;
    end;
  end;
end;

procedure TfmSiteIntegrationReport.chkFollowTailClick(Sender: TObject);
begin
  inherited;
  tmrFollowTail.Enabled:= chkFollowTail.Checked;
end;

procedure TfmSiteIntegrationReport.cmdNewClick(Sender: TObject);
var
  s: string;
begin
//  inherited;
  s:= 'With site integration when running between machines on an internal network this is an indication of speed of transfer:' + #13#10 +
    'POS Cash Sale - 11 Seconds' + #13#10 +
    'Product - 3.5 Seconds' + #13#10 + #13#10 +
    'If times are greater on your sites the difference will be related to the speed and reliability of your internet.';

  CommonLib.MessageDlgXP_Vista(s,mtInformation,[mbOk],0);
end;

procedure TfmSiteIntegrationReport.FormCreate(Sender: TObject);
begin
  inherited;
  FirstRefresh:= true;
  MyConnection1.Server := CommonDbLib.GetSharedMyDacConnection.Server;
  MyConnection1.Username := CommonDbLib.GetSharedMyDacConnection.Username;
  MyConnection1.Password := CommonDbLib.GetSharedMyDacConnection.Password;
  MyConnection1.Database := 'services';
  MyConnection1.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
  MyConnection1.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;
  MyConnection1.Port := CommonDbLib.GetSharedMyDacConnection.Port;
  qryMain.Connection:= MyConnection1;
  if TableExists('tblsynchist' , TERPConnection(qrymain.Connection)) = False then
      ExecuteSQL('CREATE TABLE `tblsynchist` (' +
	                ' `Id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,' +
	                ' 	`Name` VARCHAR(255) NULL DEFAULT NULL,' +
	                ' 	`TwoWaySynch` ENUM("T","F") NULL DEFAULT "T",' +
	                ' 	`SourceURL` VARCHAR(255) NULL DEFAULT NULL,' +
	                ' 	`SourceDatabase` VARCHAR(255) NULL DEFAULT NULL,' +
	                ' 	`DestinationURL` VARCHAR(255) NULL DEFAULT NULL,' +
	                ' 	`DestinationDatabase` VARCHAR(255) NULL DEFAULT NULL,' +
	                ' 	`SynchType` VARCHAR(10) NULL DEFAULT NULL,' +
	                ' 	`StartTime` DATETIME NULL DEFAULT NULL,' +
	                ' 	`FinishTime` DATETIME NULL DEFAULT NULL,' +
	                ' 	`DurationSecs` BIGINT(20) NULL DEFAULT 0,' +
	                ' 	`AvgSecs` BIGINT(20) NULL DEFAULT 0,' +
	                ' 	`LastOkFinishTime` DATETIME NULL DEFAULT NULL,' +
	                ' 	`LastOkDurationSecs` BIGINT(20) NULL DEFAULT 0,' +
	                ' 	`Status` VARCHAR(15) NULL DEFAULT NULL,' +
	                ' 	`OkCount` BIGINT(20) NULL DEFAULT 0,' +
	                ' 	`FailCount` BIGINT(20) NULL DEFAULT 0,' +
	                ' 	PRIMARY KEY (`Id`),' +
	                ' 	INDEX `NameIdx` (`Name`)' +
	                ' )' +
	                ' COLLATE="utf8_general_ci"' +
	                ' ENGINE=MyISAM;' , Qrymain.connection );

  if TableExists('tblsynchistlines' , TERPConnection(qrymain.Connection)) = False then
      ExecuteSQL('CREATE TABLE `tblsynchistlines` (' +
	                ' 	`Id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,' +
	                ' 	`ParentId` BIGINT(20) NULL DEFAULT NULL,' +
	                ' 	`LogTime` DATETIME NULL DEFAULT NULL,' +
	                ' 	`LogType` VARCHAR(20) NULL DEFAULT NULL,' +
	                ' 	`LogText` TEXT NULL,' +
	                ' 	PRIMARY KEY (`Id`),' +
	                ' 	INDEX `ParentIdIdx` (`ParentId`),' +
	                ' 	INDEX `LogTypeIdx` (`LogType`)' +
	                ' )' +
	                ' COLLATE="utf8_general_ci"' +
	                ' ENGINE=MyISAM;' , Qrymain.connection );
end;

procedure TfmSiteIntegrationReport.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('Id,DurationSecs,LastOkDurationSecs');
  cmdNew.Caption := 'Info';
end;

procedure TfmSiteIntegrationReport.grdMainDblClick(Sender: TObject);
var
  Form: TfmSiteIntegrationLinesReport;
begin
  if grdMain.SelectedField.Name = 'qryMainFailCount' then begin
    Form := TfmSiteIntegrationLinesReport.Create(nil);
    try
      Form.ParentId := qryMainId.AsInteger;
      Form.LogType := 'Fail';
      Form.Position := poScreenCenter;
      Form.ShowModal;
    finally
      Form.Free;
    end;
  end
  else if grdMain.SelectedField.Name = 'qryMainOkCount' then begin
    Form := TfmSiteIntegrationLinesReport.Create(nil);
    try
      Form.ParentId := qryMainId.AsInteger;
      Form.LogType := 'Ok';
      Form.Position := poScreenCenter;
      Form.ShowModal;
    finally
      Form.Free;
    end;
  end
  else
    inherited;
end;

procedure TfmSiteIntegrationReport.MyConnection1Error(Sender: TObject;
  E: EDAError; var Fail: Boolean);
var
  cmd: TERPCommand;
begin
  inherited;
  Fail := true;
  if (Pos('is marked as crashed and should be repaired', E.Message) > 0) and
     (Pos('tblsynchist', E.Message) > 0) then begin
    Fail := false;
    CommonLib.MessageDlgXP_Vista('The Integration Report Table (tblsynchist) has a problem and needs to be repared, ERP will now attempt to do this.',mtWarning,[mbOk],0);
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
      cmd.SQL.Text := 'REPAIR TABLE `tblsynchist`';
      cmd.Execute;
    finally
      cmd.Free;
    end;
  end;

end;

procedure TfmSiteIntegrationReport.qryMainCalcFields(DataSet: TDataSet);
var
  x, days, hours, mins, secs: integer;
  s: string;

  function Ft(aVal: integer): string;
  begin
    result := IntToStr(aVal);
    while Length(result) < 2 do
      result := '0' + result;
  end;

begin
  inherited;
  qryMainDuration.AsString := '';
  if qryMainDurationSecs.AsInteger > 0 then begin
    x:= qryMainDurationSecs.AsInteger;
    days := 0;
    hours := 0;
    mins := 0;
//    secs := 0;
    if x >= SecsPerDay then begin
      days := Trunc(x/SecsPerDay);
      x:= x - (days * SecsPerDay);
    end;
    if x >= 3600 then begin
      hours := Trunc(x/3600);
      x:= x - (hours * 3600);
    end;
    if x >= 60 then begin
      mins := Trunc(x/60);
      x:= x - (mins * 60);
    end;
    secs := x;
    if days > 0 then
      s:= IntToStr(days) + ' days '
    else
      s:= '';
    s:= s + ft(hours) + ':' + ft(mins) + ':' + ft(secs);
    qryMainDuration.AsString := s;
  end;

  qryMainTimeSinceLastSuccess.AsString := 'Unknown';
  if qryMainLastOkDurationSecs.AsInteger > 0 then begin
    x:= qryMainLastOkDurationSecs.AsInteger;
    days := 0;
    hours := 0;
    mins := 0;
//    secs := 0;
    if x >= SecsPerDay then begin
      days := Trunc(x/SecsPerDay);
      x:= x - (days * SecsPerDay);
    end;
    if x >= 3600 then begin
      hours := Trunc(x/3600);
      x:= x - (hours * 3600);
    end;
    if x >= 60 then begin
      mins := Trunc(x/60);
      x:= x - (mins * 60);
    end;
    secs := x;
    if days > 0 then
      s:= IntToStr(days) + ' days '
    else
      s:= '';
    s:= s + ft(hours) + ':' + ft(mins) + ':' + ft(secs);
    qryMainTimeSinceLastSuccess.AsString := s;
  end

end;

procedure TfmSiteIntegrationReport.qryMainFinishTimeGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.AsDateTime = 0 then begin
    Text := 'N/A';
  end
  else begin
    Text := Sender.AsString;
  end;
end;

procedure TfmSiteIntegrationReport.RefreshQuery;
begin
  if FirstRefresh then begin
    FirstRefresh:= false;
    dtTo.Date := Date + 1;
    dtFrom.Date := Date - 14;
  end;
  qryMain.ParamByName('dtFrom').AsDate:= dtFrom.Date;
  qryMain.ParamByName('dtTo').AsDate:= dtTo.Date;
  inherited;
end;

procedure TfmSiteIntegrationReport.tmrFollowTailTimer(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;
  tmrFollowTail.Enabled:= false;
  try
    qry:= TERPQuery.Create(nil);
    try
      qry.Connection:= qryMain.Connection;
      qry.SQL.Add('select count(Id) as LogCount from tblsynchist');
      qry.SQL.Add('where StartTime between :dtFrom and :dtTo');
      qry.ParamByName('dtFrom').AsDate:= dtFrom.Date;
      qry.ParamByName('dtTo').AsDate:= dtTo.Date;
      qry.Open;
      if LogCount <> qry.FieldByName('LogCount').AsInteger then begin
        LogCount:= qry.FieldByName('LogCount').AsInteger;
        qry.Close;
        btnRequery.Click;
      end
      else begin
        qry.Close;
        qry.SQL.Text := 'select * from tblsynchist';
        qry.SQL.Add('where Status = "Checking"');
        qry.Open;
        if not qry.IsEmpty then begin
          if (OkCount <> qry.FieldByName('OkCount').AsInteger) <>  (FailCount <> qry.FieldByName('FailCount').AsInteger)  then begin
            OkCount := qry.FieldByName('OkCount').AsInteger;
            FailCount := qry.FieldByName('FailCount').AsInteger;
            qry.Close;
            btnRequery.Click;
          end;
        end;
      end;
    finally
      qry.Free;
    end;
  finally
    if chkFollowTail.Enabled then
      tmrFollowTail.Enabled:= true;
  end;
end;

initialization
  RegisterClass(TfmSiteIntegrationReport);

end.
