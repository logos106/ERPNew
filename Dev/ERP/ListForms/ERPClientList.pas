unit ERPClientList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProcessListItemProc = procedure (ds: TDataset) of object;

  TERPClientListGUI = class(TBaseListingGUI)
    qryMainLevel: TLargeintField;
    qryMainClientId: TIntegerField;
    qryMainClientName: TWideStringField;
    qryMainReleaseType: TWideStringField;
    qryMainClientDateTime: TDateTimeField;
    qryMainClientActive: TWideStringField;
    qryMainComputerId: TIntegerField;
    qryMainComputerName: TWideStringField;
    qryMainComputerDateTime: TDateTimeField;
    qryMainComputerActive: TWideStringField;
    qryMainLicenceId: TIntegerField;
    qryMainLicenceName: TWideStringField;
    qryMainLicenceStatus: TWideStringField;
    qryMainLicenceStatusReason: TWideStringField;
    qryMainConcurrentUsers: TIntegerField;
    qryMainStartDate: TDateTimeField;
    qryMainExpireDate: TDateTimeField;
    qryMainLicenceNotes: TWideMemoField;
    qryMainLicenceDateTime: TDateTimeField;
    qryMainLicenceActive: TWideStringField;
    qryMainConfigId: TIntegerField;
    qryMainConfigNotes: TWideMemoField;
    qryMainConfigText: TWideMemoField;
    qryMainConfigDateTime: TDateTimeField;
    qryMainConfigActive: TWideStringField;
    ERPConnection1: TERPConnection;
    chkActiveClients: TCheckBox;
    Label4: TLabel;
    cboLicenceStatus: TComboBox;
    Label5: TLabel;
    cboRelease: TComboBox;
    qryMainERPClient: TWideStringField;
    N1: TMenuItem;
    MakeAllSelectedInactive1: TMenuItem;
    ChangeLicenseStatusofSelected1: TMenuItem;
    ChangeReleaseTypeofSelected1: TMenuItem;
    qryMainEmail: TWideStringField;
    qryMainContactEmail: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure btnGridClick(Sender: TObject);
    procedure MakeAllSelectedInactive1Click(Sender: TObject);
  private
    fLicence,
    fRelease: string;
    fUpdateCount: integer;
    procedure ChangeLicenceClick(Sender: TObject);
    procedure ChangeReleaseClick(Sender: TObject);
    procedure ProcessSelected(aProc: TProcessListItemProc);
    procedure DoMakeInactive(ds: TDataset);
    procedure DoChangeLicence(ds: TDataset);
    procedure DoChangeRelease(ds: TDataset);
    Procedure MakeQrymain;
  public
    { Public declarations }
  end;

var
  ERPClientListGUI: TERPClientListGUI;

implementation

uses
  MySqlUtils, frmERPClientEdit, CommonLib, IntegerListObj, ERPLicenceUtils,
  AppEnvironment, ERPLicenceConst, CommonDbLib, ERPLib, JsonObject, StrUtils,
  Types;

{$R *.dfm}

procedure TERPClientListGUI.btnGridClick(Sender: TObject);
var
  x: integer;
  clientList: TIntegerList;
  computerList: TIntegerList;
  configList: TIntegerList;
  licenceList: TIntegerList;

begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('These items will be permantly deleted, are you sure?',mtConfirmation,[mbNo,mbYes],0) = mrYes then begin
    clientList := TIntegerList.Create;
    computerList := TIntegerList.Create;
    configList := TIntegerList.Create;
    licenceList := TIntegerList.Create;
    try
      qryMAin.DisableControls;
      try
        for x := 0 to grdMain.SelectedList.Count -1 do begin
          qryMain.GotoBookmark(grdMain.SelectedList[x]);
          case self.qryMain.FieldByName('Level').AsInteger of
            0: clientList.Add(qryMain.FieldByName('ClientId').AsInteger);
            1: computerList.Add(qryMain.FieldByName('ComputerId').AsInteger);
            2: licenceList.Add(qryMain.FieldByName('LicenceId').AsInteger);
            3: configList.Add(qryMain.FieldByName('ConfigId').AsInteger);
          end;
        end;
        for x := 0 to clientList.Count -1 do
          ERPLicenceUtils.DeleteClient(clientList[x], ERPConnection1);
        for x := 0 to computerList.Count -1 do
          ERPLicenceUtils.DeleteComputer(computerList[x], ERPConnection1);
        for x := 0 to licenceList.Count -1 do
          ERPLicenceUtils.DeleteLicence(licenceList[x], ERPConnection1);
        for x := 0 to configList.Count -1 do
          ERPLicenceUtils.DeleteConfig(configList[x], ERPConnection1);
        grdMain.SelectedList.Clear;
        qryMain.Refresh;
      finally
        qryMain.EnableControls;
      end;
    finally
      clientList.Free;
      computerList.Free;
      configList.Free;
      licenceList.Free;
    end;
  end;
end;

procedure TERPClientListGUI.ProcessSelected(aProc: TProcessListItemProc);
var
  x: integer;
  pd: TProgressDialog;
begin
  if grdMain.SelectedList.Count = 0 then begin
    MessageDlgXP_Vista('Nothing selected',mtInformation,[mbOk],0);
    exit;
  end
  else begin
    if MessageDlgXP_Vista('This will update all of the selected records, is this what you want to do?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      exit;
  end;
  fUpdateCount := 0;
  pd := TProgressDialog.Create(nil);
  try
    pd.Caption := 'Please Wait ..';
    pd.Message := 'Checking/Updating Records';
    pd.Step := 1;
    pd.MaxValue := grdMain.SelectedList.Count;
    pd.Value := 0;
    pd.Execute;
    qryMain.DisableControls;
    try
      for x := 0 to grdMain.SelectedList.Count -1 do begin
        pd.StepIt;
        qryMain.GotoBookmark(grdMain.SelectedList[x]);
        aProc(qryMain);
      end;
    finally
      qryMain.EnableControls;
    end;
  finally
    pd.Free;
  end;
  qryMain.Refresh;
  MessageDlgXP_Vista('Total number of records modified: ' + IntToStr(fUpdateCount), mtInformation, [mbOk], 0);
end;

procedure TERPClientListGUI.ChangeLicenceClick(Sender: TObject);
begin
  fLicence := TMenuItem(Sender).Caption;
  ProcessSelected(DoChangeLicence);
end;

procedure TERPClientListGUI.ChangeReleaseClick(Sender: TObject);
begin
  fRelease := TMenuItem(Sender).Caption;
  ProcessSelected(DoChangeRelease);
end;

procedure TERPClientListGUI.DoChangeLicence(ds: TDataset);
var
  scr: TERPScript;
begin
  if grpFilters.ItemIndex >= 2 then begin
    { Licence or Config level of detail }
    if (ds.FieldByName('Level').AsInteger = 2) and  (not SameText(ds.FieldByName('LicenceStatus').AsString,fLicence)) then begin
      Inc(fUpdateCount);
      scr := TERPScript.Create(nil);
      try
        scr.Connection := ERPConnection1;
        scr.SQL.Add('update tsoftwarelicence');
        scr.SQL.Add('set status = ' + QuotedStr(fLicence) + ',');
        scr.SQL.Add('statusreason = "",');
        scr.SQL.Add('datetime = UTC_TIMESTAMP(),');
        scr.SQL.Add('user = "ERP"');
        scr.SQL.Add('where id = ' + IntToStr(ds.FieldByName('LicenceId').AsInteger) + ';');

        scr.SQL.Add('update tcomputer');
        scr.SQL.Add('set datetime = UTC_TIMESTAMP(),');
        scr.SQL.Add('user = "ERP"');
        scr.SQL.Add('where id = ' + IntToStr(ds.FieldByName('ComputerId').AsInteger) + ';');

        scr.SQL.Add('update tclientconfig');
        scr.SQL.Add('set datetime = UTC_TIMESTAMP(),');
        scr.SQL.Add('user = "ERP"');
        scr.SQL.Add('where id = ' + IntToStr(ds.FieldByName('ClientId').AsInteger) + ';');

        scr.Execute;
      finally
        scr.Free;
      end;
    end;
  end
  else if grpFilters.ItemIndex = 1 then begin
    { Computer level of detail }
    if (ds.FieldByName('Level').AsInteger = 1) then begin
      Inc(fUpdateCount);
      scr := TERPScript.Create(nil);
      try
        scr.Connection := ERPConnection1;
        scr.SQL.Add('update tsoftwarelicence');
        scr.SQL.Add('set status = ' + QuotedStr(fLicence) + ',');
        scr.SQL.Add('statusreason = "",');
        scr.SQL.Add('datetime = UTC_TIMESTAMP(),');
        scr.SQL.Add('user = "ERP"');
        scr.SQL.Add('where computerid = ' + IntToStr(ds.FieldByName('ComputerId').AsInteger) + ';');

        scr.SQL.Add('update tcomputer');
        scr.SQL.Add('set datetime = UTC_TIMESTAMP(),');
        scr.SQL.Add('user = "ERP"');
        scr.SQL.Add('where id = ' + IntToStr(ds.FieldByName('ComputerId').AsInteger) + ';');

        scr.SQL.Add('update tclientconfig');
        scr.SQL.Add('set datetime = UTC_TIMESTAMP(),');
        scr.SQL.Add('user = "ERP"');
        scr.SQL.Add('where id = ' + IntToStr(ds.FieldByName('ClientId').AsInteger) + ';');

        scr.Execute;
      finally
        scr.Free;
      end;
    end;
  end
  else if grpFilters.ItemIndex = 0 then begin
    { Client level of detail }
    if (ds.FieldByName('Level').AsInteger = 1) then begin
      Inc(fUpdateCount);
      scr := TERPScript.Create(nil);
      try
        scr.Connection := ERPConnection1;
        scr.SQL.Add('update tsoftwarelicence');
        scr.SQL.Add('set status = ' + QuotedStr(fLicence) + ',');
        scr.SQL.Add('statusreason = "",');
        scr.SQL.Add('datetime = UTC_TIMESTAMP(),');
        scr.SQL.Add('user = "ERP"');
        scr.SQL.Add('where computerid in (select id from tcomputer where clientid = ' + IntToStr(ds.FieldByName('ClientId').AsInteger) + ');');

        scr.SQL.Add('update tcomputer');
        scr.SQL.Add('set datetime = UTC_TIMESTAMP(),');
        scr.SQL.Add('user = "ERP"');
        scr.SQL.Add('where clientid = ' + IntToStr(ds.FieldByName('ClientId').AsInteger) + ';');

        scr.SQL.Add('update tclientconfig');
        scr.SQL.Add('set datetime = UTC_TIMESTAMP(),');
        scr.SQL.Add('user = "ERP"');
        scr.SQL.Add('where id = ' + IntToStr(ds.FieldByName('ClientId').AsInteger) + ';');

        scr.Execute;
      finally
        scr.Free;
      end;
    end;
  end;
end;

procedure TERPClientListGUI.DoChangeRelease(ds: TDataset);
var
  cmd: TERPCommand;
begin
  if (ds.FieldByName('Level').AsInteger = 0) and  (not SameText(ds.FieldByName('ReleaseType').AsString,fRelease)) then begin
    Inc(fUpdateCount);
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := ERPConnection1;
      cmd.SQL.Add('update tclientconfig');
      cmd.SQL.Add('set softwarereleasetype = ' + QuotedStr(fRelease) + ',');
      cmd.SQL.Add('datetime = UTC_TIMESTAMP(),');
      cmd.SQL.Add('user = "ERP"');
      cmd.SQL.Add('where id = ' + IntToStr(ds.FieldByName('ClientId').AsInteger));
      cmd.Execute;
    finally
      cmd.Free;
    end;
  end;
end;

procedure TERPClientListGUI.DoMakeInactive(ds: TDataset);
var
  cmd: TERPCommand;
begin
  if (ds.FieldByName('Level').AsInteger = 0) and ds.FieldByName('Active').AsBoolean then begin
    Inc(fUpdateCount);
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := ERPConnection1;
      cmd.SQL.Add('update tclientconfig');
      cmd.SQL.Add('set Active = "F",');
      cmd.SQL.Add('datetime = UTC_TIMESTAMP(),');
      cmd.SQL.Add('user = "ERP"');
      cmd.SQL.Add('where id = ' + IntToStr(ds.FieldByName('ClientId').AsInteger));
      cmd.Execute;
    finally
      cmd.Free;
    end;
  end;
end;

procedure TERPClientListGUI.MakeAllSelectedInactive1Click(Sender: TObject);
begin
  inherited;
  ProcessSelected(DoMakeInactive);
end;

procedure TERPClientListGUI.MakeQrymain;
var
  dbname :STring;
begin
  dbname := trim(commondblib.GetSharedMyDacConnection.Database);
  closeDB(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.add('select');
  Qrymain.SQL.add('0 as Level,');
  Qrymain.SQL.add('tclientconfig.id as ClientId,');
  Qrymain.SQL.add('tclientconfig.Name as ClientName,');
  Qrymain.SQL.add('tclientconfig.ERPClientName as ERPClient,');
  Qrymain.SQL.add('tclientconfig.softwarereleasetype as ReleaseType,');
  Qrymain.SQL.add('tclientconfig.datetime as ClientDateTime,');
  Qrymain.SQL.add('tclientconfig.active as ClientActive,');
  Qrymain.SQL.add('C.Email as Email,');
  Qrymain.SQL.add('CC.ContactEmail as ContactEmail,');
  Qrymain.SQL.add('null as ComputerId,');
  Qrymain.SQL.add('null as ComputerName,');
  Qrymain.SQL.add('null as ComputerDateTime,');
  Qrymain.SQL.add('null as ComputerActive,');
  Qrymain.SQL.add('null as LicenceId,');
  Qrymain.SQL.add('null as LicenceName,');
  Qrymain.SQL.add('null as LicenceStatus,');
  Qrymain.SQL.add('null as LicenceStatusReason,');
  Qrymain.SQL.add('null as ConcurrentUsers,');
  Qrymain.SQL.add('null as StartDate,');
  Qrymain.SQL.add('null as ExpireDate,');
  Qrymain.SQL.add('null as LicenceNotes,');
  Qrymain.SQL.add('null as LicenceDateTime,');
  Qrymain.SQL.add('null as LicenceActive,');
  Qrymain.SQL.add('null as ConfigId,');
  Qrymain.SQL.add('null as ConfigNotes,');
  Qrymain.SQL.add('null as ConfigText,');
  Qrymain.SQL.add('null as ConfigDateTime,');
  Qrymain.SQL.add('null as ConfigActive');
  Qrymain.SQL.add('from tclientconfig');
  Qrymain.SQL.add('left join ' + dbname  +'.tblclients C  on tclientconfig.ERPClientName = C.Company');
  Qrymain.SQL.add('Left join ' + dbname  +'.tblcontacts CC on C.clientID = CC.ClientID and CC.IsPrimarycontact ="T"');

  Qrymain.SQL.add('union all');

  Qrymain.SQL.add('select');
  Qrymain.SQL.add('1 as Level,');
  Qrymain.SQL.add('tclientconfig.id as ClientId,');
  Qrymain.SQL.add('tclientconfig.Name as ClientName,');
  Qrymain.SQL.add('tclientconfig.ERPClientName as ERPClient,');
  Qrymain.SQL.add('tclientconfig.softwarereleasetype as ReleaseType,');
  Qrymain.SQL.add('tclientconfig.datetime as ClientDateTime,');
  Qrymain.SQL.add('tclientconfig.active as ClientActive,');
  Qrymain.SQL.add('C.Email as Email,');
  Qrymain.SQL.add('CC.ContactEmail as ContactEmail,');
  Qrymain.SQL.add('tcomputer.id as ComputerId,');
  Qrymain.SQL.add('tcomputer.computername as ComputerName,');
  Qrymain.SQL.add('tcomputer.datetime as ComputerDateTime,');
  Qrymain.SQL.add('tcomputer.Active as ComputerActive,');
  Qrymain.SQL.add('null as LicenceId,');
  Qrymain.SQL.add('null as LicenceName,');
  Qrymain.SQL.add('null as LicenceStatus,');
  Qrymain.SQL.add('null as LicenceStatusReason,');
  Qrymain.SQL.add('null as ConcurrentUsers,');
  Qrymain.SQL.add('null as StartDate,');
  Qrymain.SQL.add('null as ExpireDate,');
  Qrymain.SQL.add('null as LicenceNotes,');
  Qrymain.SQL.add('null as LicenceDateTime,');
  Qrymain.SQL.add('null as LicenceActive,');
  Qrymain.SQL.add('null as ConfigId,');
  Qrymain.SQL.add('null as ConfigNotes,');
  Qrymain.SQL.add('null as ConfigText,');
  Qrymain.SQL.add('null as ConfigDateTime,');
  Qrymain.SQL.add('null as ConfigActive');
  Qrymain.SQL.add('from tclientconfig inner join  tcomputer on tclientconfig.id = tcomputer.clientid');
  Qrymain.SQL.add('left join ' + dbname  +'.tblclients C  on tclientconfig.ERPClientName = C.Company');
  Qrymain.SQL.add('Left join ' + dbname  +'.tblcontacts CC on C.clientID = CC.ClientID and CC.IsPrimarycontact ="T"');

  Qrymain.SQL.add('union all');

  Qrymain.SQL.add('select');
  Qrymain.SQL.add('2 as Level,');
  Qrymain.SQL.add('tclientconfig.id as ClientId,');
  Qrymain.SQL.add('tclientconfig.Name as ClientName,');
  Qrymain.SQL.add('tclientconfig.ERPClientName as ERPClient,');
  Qrymain.SQL.add('tclientconfig.softwarereleasetype as ReleaseType,');
  Qrymain.SQL.add('tclientconfig.datetime as ClientDateTime,');
  Qrymain.SQL.add('tclientconfig.active as ClientActive,');
  Qrymain.SQL.add('C.Email as Email,');
  Qrymain.SQL.add('CC.ContactEmail as ContactEmail,');
  Qrymain.SQL.add('tcomputer.id as ComputerId,');
  Qrymain.SQL.add('tcomputer.computername as ComputerName,');
  Qrymain.SQL.add('tcomputer.datetime as ComputerDateTime,');
  Qrymain.SQL.add('tcomputer.Active as ComputerActive,');
  Qrymain.SQL.add('tsoftwarelicence.id as LicenceId,');
  Qrymain.SQL.add('tsoftwarelicence.softwarename as LicenceName,');
  Qrymain.SQL.add('tsoftwarelicence.status as LicenceStatus,');
  Qrymain.SQL.add('tsoftwarelicence.statusreason as LicenceStatusReason,');
  Qrymain.SQL.add('tsoftwarelicence.concurrentusers as ConcurrentUsers,');
  Qrymain.SQL.add('tsoftwarelicence.startdate as StartDate,');
  Qrymain.SQL.add('tsoftwarelicence.expiredate as ExpireDate,');
  Qrymain.SQL.add('tsoftwarelicence.notes as LicenceNotes,');
  Qrymain.SQL.add('tsoftwarelicence.datetime as LicenceDateTime,');
  Qrymain.SQL.add('tsoftwarelicence.active as LicenceActive,');
  Qrymain.SQL.add('null as ConfigId,');
  Qrymain.SQL.add('null as ConfigNotes,');
  Qrymain.SQL.add('null as ConfigText,');
  Qrymain.SQL.add('null as ConfigDateTime,');
  Qrymain.SQL.add('null as ConfigActive      ');
  Qrymain.SQL.add('from tclientconfig inner join  tcomputer on tclientconfig.id = tcomputer.clientid');
  Qrymain.SQL.add('inner join tsoftwarelicence on tcomputer.id = tsoftwarelicence.computerid');
  Qrymain.SQL.add('left join ' + dbname  +'.tblclients C  on tclientconfig.ERPClientName = C.Company');
  Qrymain.SQL.add('Left join ' + dbname  +'.tblcontacts CC on C.clientID = CC.ClientID and CC.IsPrimarycontact ="T"');

  Qrymain.SQL.add('union all');

  Qrymain.SQL.add('select');
  Qrymain.SQL.add('3 as Level,');
  Qrymain.SQL.add('tclientconfig.id as ClientId,');
  Qrymain.SQL.add('tclientconfig.Name as ClientName,');
  Qrymain.SQL.add('tclientconfig.ERPClientName as ERPClient,');
  Qrymain.SQL.add('tclientconfig.softwarereleasetype as ReleaseType,');
  Qrymain.SQL.add('tclientconfig.datetime as ClientDateTime,');
  Qrymain.SQL.add('tclientconfig.active as ClientActive,');
  Qrymain.SQL.add('C.Email as Email,');
  Qrymain.SQL.add('CC.ContactEmail as ContactEmail,');
  Qrymain.SQL.add('tcomputer.id as ComputerId,');
  Qrymain.SQL.add('tcomputer.computername as ComputerName,');
  Qrymain.SQL.add('tcomputer.datetime as ComputerDateTime,');
  Qrymain.SQL.add('tcomputer.Active as ComputerActive,');
  Qrymain.SQL.add('null as LicenceId,');
  Qrymain.SQL.add('null as LicenceName,');
  Qrymain.SQL.add('null as LicenceStatus,');
  Qrymain.SQL.add('null as LicenceStatusReason,');
  Qrymain.SQL.add('null as ConcurrentUsers,');
  Qrymain.SQL.add('null as StartDate,');
  Qrymain.SQL.add('null as ExpireDate,');
  Qrymain.SQL.add('null as LicenceNotes,');
  Qrymain.SQL.add('null as LicenceDateTime,');
  Qrymain.SQL.add('null as LicenceActive,');
  Qrymain.SQL.add('TCC.id as ConfigId,');
  Qrymain.SQL.add('TCC.notes as ConfigNotes,');
  Qrymain.SQL.add('TCC.text as ConfigText,');
  Qrymain.SQL.add('TCC.datetime as ConfigDateTime,');
  Qrymain.SQL.add('TCC.Active as ConfigActive');
  Qrymain.SQL.add('from tclientconfig inner join  tcomputer on tclientconfig.id = tcomputer.clientid');
  Qrymain.SQL.add('inner join  tcomputerconfig TCC on tcomputer.id = TCC.computerid');
  Qrymain.SQL.add('left join ' + dbname  +'.tblclients C  on tclientconfig.ERPClientName = C.Company');
  Qrymain.SQL.add('Left join ' + dbname  +'.tblcontacts CC on C.clientID = CC.ClientID and CC.IsPrimarycontact ="T"');
  Qrymain.SQL.add('order by ClientName, ComputerName');
end;

procedure TERPClientListGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TERPClientListGUI.FormCreate(Sender: TObject);
var
  mi: TMenuItem;
  sl: TStringList;
  x: integer;
  CustConfig: TJsonObject;
  strArr: TStringDynArray;
begin
  MakeQryMain;
  inherited;
  MySqlUtils.SetConnectionProps(ERPConnection1,'services', AppEnv.AppDb.Server);
  qryMain.Connection := ERPConnection1;
  GroupFilterString := '(Level = 0)';

  sl := TStringList.Create;
  try
    sl.CommaText := ERPLicenceConst.LicenceTypeList;
    for x := 0 to sl.Count -1 do begin
      mi := TMenuItem.Create(self);
      mi.Caption := sl[x];
      mi.OnClick := ChangeLicenceClick;
      ChangeLicenseStatusofSelected1.Add(mi);
    end;


//    sl.CommaText := ERPLicenceConst.ReleaseTypeList;
//    for x := 0 to sl.Count -1 do begin
//      mi := TMenuItem.Create(self);
//      mi.Caption := sl[x];
//      mi.OnClick := ChangeReleaseClick;
//      ChangeReleaseTypeofSelected1.Add(mi);
//    end;
  finally
    sl.Free;
  end;

  CustConfig := ERPLib.GetERPCustomConfig;
  try
    if CustConfig.ArrayExists('ERPVersions') then begin
      cboRelease.Items.Text := 'All';
      for x := 0 to CustConfig.A['ERPVersions'].Count -1 do begin
        strArr := SplitString(CustConfig.A['ERPVersions'].Items[x].AsString,#9);
        cboRelease.Items.Add(strArr[0]);
        mi := TMenuItem.Create(self);
        mi.Caption := strArr[0];
        mi.OnClick := ChangeReleaseClick;
        ChangeReleaseTypeofSelected1.Add(mi);
      end;
    end;
  finally
    CustConfig.Free;
  end;
end;

procedure TERPClientListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (qryMain.fieldbyname('Level').AsInteger = 0) then
    AFont.Style := AFont.Style + [fsBold];

end;

procedure TERPClientListGUI.grdMainDblClick(Sender: TObject);
var
  form: TfmERPClientEdit;
begin
  form := TfmERPClientEdit.Create(Application);
  form.KeyID := qryMain.FieldByName('ClientId').AsInteger;
  form.AttachObserver(self);
  form.FormStyle := fsMDIChild;
  form.BringToFront;
end;

procedure TERPClientListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(Level = 0)';
      end;
    1:
      begin {Details}
        GroupFilterString := '(Level < 2)';
      end;
    2:
      begin  {Extra Details}
        GroupFilterString := '(Level < 3)';
      end;
  end;
  if chkActiveClients.Checked then begin
    if GroupFilterString <> '' then
      GroupFilterString := GroupFilterString + ' and (ClientActive = "T")'
    else
      GroupFilterString := '(ClientActive = "T")';
  end
  else begin
    if GroupFilterString <> '' then
      GroupFilterString := GroupFilterString + ' and (ClientActive = "F")'
    else
      GroupFilterString := '(ClientActive = "F")';
  end;
  if cboLicenceStatus.Text <> 'All' then begin
    if GroupFilterString <> '' then
      GroupFilterString := GroupFilterString + ' and (LicenceStatus = "ls' + cboLicenceStatus.Text + '")'
    else
      GroupFilterString := '(LicenceStatus = "ls' + cboLicenceStatus.Text + '")';
  end;
  if cboRelease.Text <> 'All' then begin
    if GroupFilterString <> '' then
      GroupFilterString := GroupFilterString + ' and (ReleaseType = "' + cboRelease.Text + '")'
    else
      GroupFilterString := '(ReleaseType = "' + cboRelease.Text + '")';
  end;

  inherited;
end;
(*


select
0 as Level,
tclientconfig.id as ClientId,
tclientconfig.Name as ClientName,
tclientconfig.ERPClientName as ERPClient,
tclientconfig.softwarereleasetype as ReleaseType,
tclientconfig.datetime as ClientDateTime,
tclientconfig.active as ClientActive,
null as ComputerId,
null as ComputerName,
null as ComputerDateTime,
null as ComputerActive,
null as LicenceId,
null as LicenceName,
null as LicenceStatus,
null as LicenceStatusReason,
null as ConcurrentUsers,
null as StartDate,
null as ExpireDate,
null as LicenceNotes,
null as LicenceDateTime,
null as LicenceActive,
null as ConfigId,
null as ConfigNotes,
null as ConfigText,
null as ConfigDateTime,
null as ConfigActive
from tclientconfig

union all

select
1 as Level,
tclientconfig.id as ClientId,
tclientconfig.Name as ClientName,
tclientconfig.ERPClientName as ERPClient,
tclientconfig.softwarereleasetype as ReleaseType,
tclientconfig.datetime as ClientDateTime,
tclientconfig.active as ClientActive,
tcomputer.id as ComputerId,
tcomputer.computername as ComputerName,
tcomputer.datetime as ComputerDateTime,
tcomputer.Active as ComputerActive,
null as LicenceId,
null as LicenceName,
null as LicenceStatus,
null as LicenceStatusReason,
null as ConcurrentUsers,
null as StartDate,
null as ExpireDate,
null as LicenceNotes,
null as LicenceDateTime,
null as LicenceActive,
null as ConfigId,
null as ConfigNotes,
null as ConfigText,
null as ConfigDateTime,
null as ConfigActive
from tclientconfig, tcomputer
where tclientconfig.id = tcomputer.clientid

union all

select
2 as Level,
tclientconfig.id as ClientId,
tclientconfig.Name as ClientName,
tclientconfig.ERPClientName as ERPClient,
tclientconfig.softwarereleasetype as ReleaseType,
tclientconfig.datetime as ClientDateTime,
tclientconfig.active as ClientActive,
tcomputer.id as ComputerId,
tcomputer.computername as ComputerName,
tcomputer.datetime as ComputerDateTime,
tcomputer.Active as ComputerActive,
tsoftwarelicence.id as LicenceId,
tsoftwarelicence.softwarename as LicenceName,
tsoftwarelicence.status as LicenceStatus,
tsoftwarelicence.statusreason as LicenceStatusReason,
tsoftwarelicence.concurrentusers as ConcurrentUsers,
tsoftwarelicence.startdate as StartDate,
tsoftwarelicence.expiredate as ExpireDate,
tsoftwarelicence.notes as LicenceNotes,
tsoftwarelicence.datetime as LicenceDateTime,
tsoftwarelicence.active as LicenceActive,
null as ConfigId,
null as ConfigNotes,
null as ConfigText,
null as ConfigDateTime,
null as ConfigActive
from tclientconfig, tcomputer, tsoftwarelicence
where tclientconfig.id = tcomputer.clientid
and tcomputer.id = tsoftwarelicence.computerid

union all

select
3 as Level,
tclientconfig.id as ClientId,
tclientconfig.Name as ClientName,
tclientconfig.ERPClientName as ERPClient,
tclientconfig.softwarereleasetype as ReleaseType,
tclientconfig.datetime as ClientDateTime,
tclientconfig.active as ClientActive,
tcomputer.id as ComputerId,
tcomputer.computername as ComputerName,
tcomputer.datetime as ComputerDateTime,
tcomputer.Active as ComputerActive,
null as LicenceId,
null as LicenceName,
null as LicenceStatus,
null as LicenceStatusReason,
null as ConcurrentUsers,
null as StartDate,
null as ExpireDate,
null as LicenceNotes,
null as LicenceDateTime,
null as LicenceActive,
tcomputerconfig.id as ConfigId,
tcomputerconfig.notes as ConfigNotes,
tcomputerconfig.text as ConfigText,
tcomputerconfig.datetime as ConfigDateTime,
tcomputerconfig.Active as ConfigActive
from tclientconfig, tcomputer, tcomputerconfig
where tclientconfig.id = tcomputer.clientid
and tcomputer.id = tcomputerconfig.computerid

order by ClientName, ComputerName
*)
initialization
  RegisterClass(TERPClientListGUI);

end.
