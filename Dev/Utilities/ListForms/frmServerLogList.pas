unit frmServerLogList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, wwcheckbox, DAScript, MyScript,
  CustomInputBox;

type
  TfmServerLogList = class(TBaseListingGUI)
    qryMainModule: TWideStringField;
    qryMainLogTime: TDateTimeField;
    qryMainLogType: TWideStringField;
    qryMainLog: TWideMemoField;
    qryMainLogID: TLargeintField;
    chkFollowTail: TwwCheckBox;
    tmrFollowTail: TTimer;
    btnClearLog: TDNMSpeedButton;
    Label2: TLabel;
    cboModule: TComboBox;
    Label4: TLabel;
    cboType: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure chkFollowTailClick(Sender: TObject);
    procedure tmrFollowTailTimer(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure MyConnection1Error(Sender: TObject; E: EDAError;
      var Fail: Boolean);
  private
    FirstRefresh: boolean;
    LogCount: integer;
    function GetModuleName: string;
    procedure SetModuleName(const Value: string);
  protected
    procedure RefreshQuery; override;
    procedure SetDefaultDateRange; override;
  public
  published
    property ModuleName: string read GetModuleName write SetModuleName;
  end;

var
  fmServerLogList: TfmServerLogList;

implementation

{$R *.dfm}

uses
  CommonDbLib, tcConst, CommonLib, DbSharedObjectsObj;


procedure TfmServerLogList.btnClearLogClick(Sender: TObject);
var
  cmd: TErpCommand;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This will delete all the Server Log Entries, is that what you want to do?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    cmd:= TErpCommand.Create(nil);
    try
      cmd.Connection := MyConnection1;
      cmd.SQL.Text:= 'truncate tblLog';
      cmd.Execute;
      self.btnRequery.Click;
    finally
      cmd.Free;
    end;
  end;
end;

procedure TfmServerLogList.chkFollowTailClick(Sender: TObject);
begin
  inherited;
  tmrFollowTail.Enabled:= chkFollowTail.Checked;
end;

procedure TfmServerLogList.FormCreate(Sender: TObject);
var
  cmd: TErpCommand;
  qry: TERPQuery;
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
  cmd:= TErpCommand.Create(nil);
  try
    cmd.SQL.Text:= 'delete from tblLog where LogTime < "' + FormatDateTime('yyyy-mm-dd',now - 30) + '"';
    cmd.Connection:= MyConnection1;
    cmd.Execute;
  finally
    cmd.Free;
  end;
  qry := DbSharedObj.GetQuery(myConnection1);
  try
    qry.SQL.Text := 'select distinct Module from tbllog';
    qry.Open;
    cboModule.Items.Clear;
    cboModule.Items.Add('All');
    while not qry.Eof do begin
      cboModule.Items.Add(qry.FieldByName('Module').AsString);
      qry.Next;
    end;
    cboModule.ItemIndex := 0;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TfmServerLogList.GetModuleName: string;
begin
  result := cboModule.Text;
end;

procedure TfmServerLogList.grdMainDblClick(Sender: TObject);
begin
  if grdMain.GetActiveField.FieldName <> 'Log' then
    inherited;
end;

procedure TfmServerLogList.MyConnection1Error(Sender: TObject; E: EDAError;
  var Fail: Boolean);
var
  cmd: TERPCommand;
begin
  inherited;
  Fail := true;
  if (Pos('is marked as crashed and should be repaired', E.Message) > 0) and
     (Pos('tbllog', E.Message) > 0) then begin
    Fail := false;
    CommonLib.MessageDlgXP_Vista('The Server Log Table (tbllog) has a problem and needs to be repared, ERP will now attempt to do this.',mtWarning,[mbOk],0);
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
      cmd.SQL.Text := 'REPAIR TABLE `tbllog`';
      cmd.Execute;
    finally
      cmd.Free;
    end;
  end;
end;

procedure TfmServerLogList.RefreshQuery;
begin
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('dtFrom').AsDateTime := 0;
    qryMain.ParamByName('dtTo').AsDateTime := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('dtFrom').AsDateTime := dtFrom.Date;
    qryMain.ParamByName('dtTo').AsDateTime := dtTo.Date;
  end;
  qryMain.ParamByName('Module').AsString := cboModule.Text;
  qryMain.ParamByName('LogType').AsString := cboType.Text;
  inherited;
end;

procedure TfmServerLogList.SetDefaultDateRange;
begin
  inherited;
  dtTo.Date := Date + 1;
  dtFrom.Date := Date - 7;
end;

procedure TfmServerLogList.SetModuleName(const Value: string);
var
  idx: integer;
begin
  idx := cboModule.Items.IndexOf(Value);
  if idx > -1 then
    cboModule.ItemIndex := idx;
end;

procedure TfmServerLogList.tmrFollowTailTimer(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;
  tmrFollowTail.Enabled:= false;
  try
    qry:= DbSharedObj.GetQuery(qryMain.Connection);
    try
      qry.Connection:= qryMain.Connection;
      qry.SQL.Add('select count(LogId) as LogCount from tblLog');
      qry.SQL.Add('where LogTime between :dtFrom and :dtTo');
      qry.SQL.Add('and ((:Module = "All") or (:Module = Module))');
      qry.SQL.Add('and ((:LogType = "All") or (:LogType = "Error" and LogType = "ltError") or (:LogType = "Warning" and LogType = "ltWarning"))');

      qry.ParamByName('dtFrom').AsDate:= dtFrom.Date;
      qry.ParamByName('dtTo').AsDate:= dtTo.Date;
      qry.ParamByName('Module').AsString := cboModule.Text;
      qry.ParamByName('LogType').AsString := cboType.Text;

      qry.Open;
      if LogCount <> qry.FieldByName('LogCount').AsInteger then begin
        LogCount:= qry.FieldByName('LogCount').AsInteger;
        qry.Close;
        btnRequery.Click;
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  finally
    if chkFollowTail.Enabled then
      tmrFollowTail.Enabled:= true;
  end;
end;

initialization
  RegisterClass(TfmServerLogList);

end.
