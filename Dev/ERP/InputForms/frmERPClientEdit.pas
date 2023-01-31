unit frmERPClientEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, wwcheckbox,
  wwdbedit, Wwdotdot, Wwdbcomb, Mask, DBCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, JsonObject, AdvEdit, wwdblook, AdvObj, BaseGrid,
  AdvGrid, ComCtrls;

type
  TfmERPClientEdit = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryClient: TMyQuery;
    dsClient: TDataSource;
    chkActive: TwwCheckBox;
    qryServers: TMyQuery;
    dsServers: TDataSource;
    qryLicence: TMyQuery;
    dsLicence: TDataSource;
    qryConfig: TMyQuery;
    dsConfig: TDataSource;
    qryERPCustLookup: TERPQuery;
    cmdNew: TDNMSpeedButton;
    qryLicenceid: TIntegerField;
    qryLicenceclientid: TIntegerField;
    qryLicencecomputerid: TIntegerField;
    qryLicenceactive: TWideStringField;
    qryLicencesoftwarename: TWideStringField;
    qryLicencestartdate: TDateTimeField;
    qryLicenceexpiredate: TDateTimeField;
    qryLicenceconcurrentusers: TIntegerField;
    qryLicencestatus: TWideStringField;
    qryLicencestatusreason: TWideStringField;
    qryLicencedatatext: TWideMemoField;
    qryLicencenotes: TWideMemoField;
    qryLicencedatetime: TDateTimeField;
    qryLicenceuser: TWideStringField;
    pcMain: TPageControl;
    tabMain: TTabSheet;
    tabDetail: TTabSheet;
    Label5: TLabel;
    cboReleaseType: TwwDBComboBox;
    Label1: TLabel;
    edtName: TDBEdit;
    Label19: TLabel;
    cboErpCust: TwwDBLookupCombo;
    Label2: TLabel;
    edtComputer: TDBEdit;
    DBNavigator1: TDBNavigator;
    lblComputerCount: TLabel;
    Label3: TLabel;
    edtLicence: TDBEdit;
    DBNavigator2: TDBNavigator;
    lblLicenceCount: TLabel;
    Label4: TLabel;
    cboLicence: TDBComboBox;
    Label6: TLabel;
    edtStatusReason: TDBEdit;
    Label7: TLabel;
    dtpStartDate: TwwDBDateTimePicker;
    Label8: TLabel;
    dtpExpireDate: TwwDBDateTimePicker;
    Label9: TLabel;
    edtUsers: TwwDBEdit;
    grdOptions: TAdvStringGrid;
    Label10: TLabel;
    memNotes: TDBMemo;
    Label12: TLabel;
    btnSeletConfigAll: TDNMSpeedButton;
    grdConfig: TwwDBGrid;
    grdConfigIButton: TwwIButton;
    grpSMS: TGroupBox;
    Label13: TLabel;
    edtSMSUser: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    chkSMSEnabled: TCheckBox;
    edtSMSNumber: TEdit;
    edtSMSName: TEdit;
    edtSMSPass: TEdit;
    cboDbLIst: TComboBox;
    btnSetToDefault: TDNMSpeedButton;
    edtMargin: TAdvEdit;
    edtMinOut: TAdvEdit;
    edtMinIn: TAdvEdit;
    Label11: TLabel;
    DBMemo1: TDBMemo;
    memDataText: TMemo;
    edtConfigNotes: TwwDBEdit;
    Label20: TLabel;
    grdCloudOptions: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryServersAfterScroll(DataSet: TDataSet);
    procedure btnSaveClick(Sender: TObject);
    procedure grdConfigIButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryLicenceAfterScroll(DataSet: TDataSet);
    procedure qryLicenceBeforeScroll(DataSet: TDataSet);
    procedure cboDbLIstChange(Sender: TObject);
    procedure chkSMSEnabledClick(Sender: TObject);
    procedure edtSMSNumberChange(Sender: TObject);
    procedure edtSMSNameChange(Sender: TObject);
    procedure edtSMSPassChange(Sender: TObject);
    procedure btnSetToDefaultClick(Sender: TObject);
    procedure qryLicenceBeforePost(DataSet: TDataSet);
    procedure qryServersBeforePost(DataSet: TDataSet);
    procedure qryConfigBeforePost(DataSet: TDataSet);
    procedure qryClientBeforePost(DataSet: TDataSet);
    procedure edtMarginChange(Sender: TObject);
    procedure edtMinOutChange(Sender: TObject);
    procedure edtMinInChange(Sender: TObject);
    procedure btnSeletConfigAllClick(Sender: TObject);
    procedure qryERPCustLookupBeforeOpen(DataSet: TDataSet);
    procedure cboErpCustCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure grdOptionsGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure grdOptionsCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure grdOptionsCellValidate(Sender: TObject; ACol, ARow: Integer;
      var Value: string; var Valid: Boolean);
    procedure grdOptionsCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
  private
    LicenceCoData: TJsonObject;
    procedure SaveLicenceCoData;
    procedure PopulateDbList;
    procedure PopulateSMSData;
    procedure PopulateOptions;
    procedure LoadLicenceOptions(CustConfig: TJsonObject);

    function SMSConfig: TJsonObject;
    function SavenCommit: Boolean;

  public
    { Public declarations }
  end;

var
  fmERPClientEdit: TfmERPClientEdit;

implementation

{$R *.dfm}

uses
  DNMExceptions, CommonDbLib, IntegerListObj, frmSMSMasterAccountInfo,
  DateTimeUtils, ERPLicenceConst, ERPLib, BusObjSales, CommonFormLib, CommonLib,
  DbSharedObjectsObj, MySQLConst, JsonObjectUtils, DNMLib, AppEnvironment;

procedure TfmERPClientEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmERPClientEdit.btnSaveClick(Sender: TObject);
begin
  inherited;
  if SavenCommit then Close;
end;

Function TfmERPClientEdit.SavenCommit :Boolean;
begin
  result := False;
  try
    SaveLicenceCoData;
    PostDb(qryClient);
    PostDb(qryLicence);
    PostDb(qryConfig);
    Self.CommitTransaction;
    Result := True;
  Except
    // kill the exception
  end;
end;

procedure TfmERPClientEdit.btnSeletConfigAllClick(Sender: TObject);
begin
  inherited;
  qryConfig.DisableControls;
  try
    qryConfig.First;
    while qryConfig.RecNo < qryConfig.RecordCount do begin
      grdConfig.SelectRecord;

      qryConfig.Next;
    end;

  finally
    qryConfig.EnableControls;
  end;
end;

procedure TfmERPClientEdit.btnSetToDefaultClick(Sender: TObject);
var
  ConfigMaster: TSMSConfigMaster;
  obj: TJsonObject;
begin
  inherited;
  ConfigMaster := TSMSConfigMaster.Create;
  try
    ConfigMaster.Load(CommonDbLib.GetSharedMyDacConnection);
    self.FocusControl(edtSMSName);
    edtSMSName.Text := ConfigMaster.SMSUser;
    self.FocusControl(edtSMSPass);
    edtSMSPass.Text := ConfigMaster.SMSPass;

    self.FocusControl(edtMargin);
    edtMargin.FloatValue := ConfigMaster.PriceMargin;
    self.FocusControl(edtMinOut);
    edtMinOut.FloatValue := ConfigMaster.PriceMinOutbound;
    self.FocusControl(edtMinIn);
    edtMinIn.FloatValue := ConfigMaster.PriceMinInbound;

    obj := self.SMSConfig;
    obj.S['SMSUser'] := edtSMSName.text;
    obj.S['SMSPass'] := edtSMSPass.text;
    obj.F['PriceMargin'] := edtMargin.FloatValue;
    obj.F['PriceMinOutbound'] := edtMinOut.FloatValue;
    obj.F['PriceMinInbound'] := edtMinIn.FloatValue;

    LicenceCoData.B['_dirty'] := true;
  finally
    ConfigMaster.Free;
  end;
end;

procedure TfmERPClientEdit.cboDbLIstChange(Sender: TObject);
begin
  inherited;
  PopulateSMSData;
end;

procedure TfmERPClientEdit.cboErpCustCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if ((qryClient.FieldByName('name').AsString = '') or SameText(qryClient.FieldByName('name').AsString, 'UNKNOWN')) and
    (cboErpCust.Text <> '') then begin


   edtName.Text := cboErpCust.Text;
 end;

end;

procedure TfmERPClientEdit.chkSMSEnabledClick(Sender: TObject);
var
  obj: TJsonObject;
begin
  inherited;
  if chkSMSEnabled.Focused then begin
    obj := self.SMSConfig;
    if Assigned(obj) then  begin
      obj.B['SMSEnabled'] := chkSMSEnabled.Checked;
      LicenceCoData.B['_dirty'] := true;
    end;
  end;
end;

procedure TfmERPClientEdit.cmdNewClick(Sender: TObject);
var
  inv:TInvoice;
  qry: TERPQuery;
begin
  inherited;
  if not SavenCommit then exit;
  if trim(qryClient.fieldbyname('erpclientname').asString) = '' then begin
    MessageDlgXP_vista('Please Choose ''ERP Customer''', mtInformation, [mbOK], 0);
    Exit;
  end;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
      Qry.SQL.text := 'Select * from services.`tsoftwarelicenceinvoice` '+
                      ' where LicenseID =' + inttostr( qryLicence.FieldByName('ID').AsInteger) +
                      ' and expiredate =' + quotedstr(formatDateTime(MysqlDateTimeFormat,  qryLicence.FieldByName('expiredate').asDatetime))+
                      ' and ifnull(InvoiceID,0)<> 0';
      Qry.open;
      if Qry.recordcount >0 then begin
        if MessageDlgXP_Vista('Invoice #'+ inttostr(Qry.FieldByName('InvoiceID').asInteger)+' is Already Created on '+ quotedstr(formatDateTime(FormatSettings.Shortdateformat , Qry.FieldByName('InvoicedOn').asDatetime)),
                          mtInformation, [mbOK], 0 , nil,  '' , '' , False , nil , 'Open Invoice #'+ inttostr(Qry.FieldByName('InvoiceID').asInteger)  )= 100 then begin
          OpenERPForm('TInvoiceGUI' , Qry.FieldByName('InvoiceID').asInteger);
          closewait;
        end;
        Exit;
      end;
      inv := TInvoice.CreateWithNewConn(Self);
      try
        inv.load(0);
        inv.connection.BeginTransaction;
        try
          inv.New;
          inv.customername := trim(qryClient.fieldbyname('erpclientname').asString);
          inv.DueDate := qryLicence.FieldByName('expiredate').AsDateTime;
          inv.PostDB;
          inv.Lines.New;
               if qryLicence.fieldbyname('concurrentusers').asInteger <=5  then inv.lines.Productname := 'Software Support Up To 5 Licenses'
          else if qryLicence.fieldbyname('concurrentusers').asInteger <=10 then inv.lines.Productname := 'Software Support 6 - 10 Licenses'
          else if qryLicence.fieldbyname('concurrentusers').asInteger <=20 then inv.lines.Productname := 'Software Support 11 - 20 Licenses'
          else if qryLicence.fieldbyname('concurrentusers').asInteger <=25 then inv.lines.Productname := 'Software Support 21 - 25 Licenses'
          else if qryLicence.fieldbyname('concurrentusers').asInteger <=35 then inv.lines.Productname := 'Software Support 26 - 35 Licenses'
          else if qryLicence.fieldbyname('concurrentusers').asInteger <=50 then inv.lines.Productname := 'Software Support 36 - 50 Licenses'
          else if qryLicence.fieldbyname('concurrentusers').asInteger <=99 then inv.lines.Productname := 'Software Support 51 - 99 Licenses'
          else inv.lines.Productname := 'Software Support More than 99 Licenses';
          inv.Lines.qtysold := 1;
          inv.Lines.QtyShipped := 1;
          inv.Lines.PostDB;
          inv.Lines.CalcLineTotals;
          inv.Lines.PostDB;
          inv.CalcOrderTotals;
          if not inv.Save then begin
             inv.connection.RollbackTransaction;
             Exit;
          end;
          inv.connection.CommitTransaction;
          Qry.Append;
          Qry.FieldByName('LicenseID').AsInteger := qryLicence.FieldByName('ID').AsInteger;
          Qry.FieldByName('expiredate').asDatetime:= qryLicence.FieldByName('expiredate').asDatetime;
          Qry.FieldByName('InvoiceID').AsInteger := inv.ID;
          Qry.FieldByName('InvoicedOn').asDatetime:=now;
          Qry.Post;
          OpenERPForm('TInvoiceGUI' , inv.id);
          closewait;
        Except
          on E:Exception do begin
            inv.connection.RollbackTransaction;
          end;
        end;
      finally
        FreeandNil(inv);
      end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TfmERPClientEdit.edtMarginChange(Sender: TObject);
var
  obj: TJsonObject;
begin
  inherited;
  if edtMargin.Focused then begin
    obj := self.SMSConfig;
    if Assigned(obj) then  begin
      obj.F['PriceMargin'] := edtMargin.FloatValue;
      LicenceCoData.B['_dirty'] := true;
    end;
  end;
end;

procedure TfmERPClientEdit.edtMinInChange(Sender: TObject);
var
  obj: TJsonObject;
begin
  inherited;
  if edtMinIn.Focused then begin
    obj := self.SMSConfig;
    if Assigned(obj) then  begin
      obj.F['PriceMinInbound'] := edtMinIn.FloatValue;
      LicenceCoData.B['_dirty'] := true;
    end;
  end;
end;

procedure TfmERPClientEdit.edtMinOutChange(Sender: TObject);
var
  obj: TJsonObject;
begin
  inherited;
  if edtMinOut.Focused then begin
    obj := self.SMSConfig;
    if Assigned(obj) then  begin
      obj.F['PriceMinOutbound'] := edtMinOut.FloatValue;
      LicenceCoData.B['_dirty'] := true;
    end;
  end;
end;

procedure TfmERPClientEdit.edtSMSNameChange(Sender: TObject);
var
  obj: TJsonObject;
begin
  inherited;
  if edtSMSName.Focused then begin
    obj := self.SMSConfig;
    if Assigned(obj) then  begin
      obj.S['SMSUser'] := edtSMSName.text;
      LicenceCoData.B['_dirty'] := true;
    end;
  end;
end;

procedure TfmERPClientEdit.edtSMSNumberChange(Sender: TObject);
var
  obj: TJsonObject;
begin
  inherited;
  if edtSMSNumber.Focused then begin
    obj := self.SMSConfig;
    if Assigned(obj) then  begin
      obj.S['PhoneNumber'] := edtSMSNumber.text;
      LicenceCoData.B['_dirty'] := true;
    end;
  end;
end;

procedure TfmERPClientEdit.edtSMSPassChange(Sender: TObject);
var
  obj: TJsonObject;
begin
  inherited;
  if edtSMSPass.Focused then begin
    obj := self.SMSConfig;
    if Assigned(obj) then  begin
      obj.S['SMSPass'] := edtSMSPass.text;
      LicenceCoData.B['_dirty'] := true;
    end;
  end;
end;

procedure TfmERPClientEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmERPClientEdit.FormCreate(Sender: TObject);
var
//  sl: TStringList;
  x: integer;
  CustConfig: TJsonObject;
begin
  inherited;
  CustConfig := ERPLib.GetERPCustomConfig;
  try
    if CustConfig.ArrayExists('ERPVersions') then begin
      cboReleaseType.Items.Clear;
      for x := 0 to CustConfig.A['ERPVersions'].Count - 1 do
        cboReleaseType.Items.Add(CustConfig.A['ERPVersions'].Items[x].AsString);
    end;
    LoadLicenceOptions(CustConfig);
  finally
    CustConfig.Free;
  end;

  MyConnection.Database := 'Services';
  qryMemTrans.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCustomField.Connection := CommonDbLib.GetSharedMyDacConnection;
  LicenceCoData := JO;

  grdOptions.ColWidths[0] := 0;
  grdOptions.ColWidths[1] := 160;
  grdOptions.ColWidths[2] := 60;
  grdOptions.ColWidths[3] := 160;
  grdOptions.ColWidths[4] := 60;
  grdOptions.CheckTrue := 'true';
  grdOptions.CheckFalse := 'false';

  grdCloudOptions.ColWidths[0] := 0;
  grdCloudOptions.ColWidths[1] := 160;
  grdCloudOptions.ColWidths[2] := 60;
  grdCloudOptions.ColWidths[3] := 160;
  grdCloudOptions.CheckTrue := 'true';
  grdCloudOptions.CheckFalse := 'false';

//  cboReleaseType.Items.Clear;
//  sl := TStringList.Create;
//  try
//    sl.CommaText := ERPLicenceConst.ReleaseTypeList;
//    for x := 0 to sl.Count -1 do
//      cboReleaseType.Items.Add(sl[x] + #9 + sl[x]);
//  finally
//    sl.Free;
//  end;
  cboLicence.Items.CommaText := ERPLicenceConst.LicenceTypeList;
end;

procedure TfmERPClientEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  LicenceCoData.Free;
end;

procedure TfmERPClientEdit.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;

      // Put our Database Connection into transaction mode.
      BeginTransaction;

      qryClient.ParamByName('ClientID').AsInteger := KeyId;
      qryServers.ParamByName('ClientID').AsInteger := KeyId;
      Self.OpenQueries;
      pcMain.ActivePage := tabMain;
      RealignTabControl(pcMain, 1);

      // Exception Handler
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmERPClientEdit.grdConfigIButtonClick(Sender: TObject);
var
  idList: TIntegerList;
  x: integer;
  cmd: TMyCommand;
begin
  inherited;
  if MessageDlg('This will permently delete these Config records, ' +
    'is that what you want to do?',mtWarning, [mbNo,mbYes],0) = mrYes then begin
    idList := TIntegerList.Create;
    try
      qryConfig.DisableControls;
      try
        for x := 0 to grdConfig.SelectedList.Count -1 do begin
          qryConfig.GotoBookmark(grdConfig.SelectedList.Items[x]);
          idList.Add(qryConfig.FieldByName('id').AsInteger);
        end;
        if idList.Count > 0 then begin
          cmd := TMyCommand.Create(nil);
          try
            cmd.Connection := MyConnection;
            cmd.SQL.Add('delete from tcomputerconfig');
            cmd.SQL.Add('where id in (' + idList.CommaText + ')');
            cmd.Execute;
          finally
            cmd.Free;
          end;
          grdConfig.SelectedList.Clear;
        end;
      finally
        qryConfig.EnableControls;
      end;
      qryConfig.Refresh;
    finally
      idList.Free;
    end;
  end;
end;

procedure TfmERPClientEdit.grdOptionsCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  if ACol = 2 then
    CanEdit := true;
end;

procedure TfmERPClientEdit.grdOptionsCellValidate(Sender: TObject; ACol,
  ARow: Integer; var Value: string; var Valid: Boolean);
begin
  inherited;
  Valid := true;
end;

procedure TfmERPClientEdit.grdOptionsCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  inherited;
  LicenceCoData.O['Options'].B[TAdvStringGrid(Sender).Cells[0,ARow]] := State;
  LicenceCoData.B['_dirty'] := true;
end;

procedure TfmERPClientEdit.grdOptionsGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  if Acol = 2 then
    AEditor := edCheckBox;
end;

procedure TfmERPClientEdit.LoadLicenceOptions(CustConfig: TJsonObject);
var
  I: integer;
  item: TJsonObject;
  grid: TAdvStringGrid;
begin
  grdOptions.RowCount := 2;
  grdOptions.Cells[0,1] := '';
  grdCloudOptions.RowCount := 2;
  grdCloudOptions.Cells[0,1] := '';
  for I := 0 to CustConfig.A['LicenceOptions'].Count - 1 do begin
    item := CustConfig.A['LicenceOptions'][I].AsObject;
    if Pos('cloud', Lowercase(item.S['Name'])) = 1 then
      grid := grdCloudOptions
    else
      grid := grdOptions;
    if (grid.RowCount > 2) or (grid.Cells[0, 1] <> '') then
      grid.RowCount := grid.RowCount + 1;
    grid.Cells[0, grid.RowCount - 1] := item.S['Name'];
    grid.Cells[1, grid.RowCount - 1] := item.S['Caption'];
    grid.AddCheckBox(2, grid.RowCount - 1, false, false);
    grid.Cells[3, grid.RowCount - 1] := item.S['Category'];
    grid.Cells[4, grid.RowCount - 1] := '1';
  end;
end;

procedure TfmERPClientEdit.PopulateDbList;
var
  x: integer;
begin
  cboDbList.Clear;
  for x := 0 to LicenceCoData.O['erpinfo'].Count - 1 do begin
    cboDbList.Items.Add(LicenceCoData.O['erpinfo'].Items[x].Name);
  end;
  if cboDbList.Items.Count > 0 then
    cboDbList.ItemIndex := 0;
end;

procedure TfmERPClientEdit.PopulateOptions;
var
  I: integer;
begin
  for I := 1 to grdOptions.RowCount - 1 do begin
    grdOptions.SetCheckBoxState(2,I,LicenceCoData.O['Options'].B[grdOptions.Cells[0,I]]);
  end;
  for I := 1 to grdCloudOptions.RowCount - 1 do begin
    grdCloudOptions.SetCheckBoxState(2,I,LicenceCoData.O['Options'].B[grdCloudOptions.Cells[0,I]]);
  end;
end;

procedure TfmERPClientEdit.PopulateSMSData;
var
  obj: TJsonObject;
begin
  chkSMSEnabled.Checked := false;
  edtSMSNumber.Clear;
  edtSMSName.Clear;
  edtSMSPass.Clear;
  obj := SMSConfig;
  if Assigned(obj) then begin
    chkSMSEnabled.Checked := obj.B['SMSEnabled'];
    edtSMSNumber.Text := obj.S['PhoneNumber'];
    edtSMSName.Text := obj.S['SMSUser'];
    edtSMSPass.Text := obj.S['SMSPass'];
    edtMargin.FloatValue := obj.F['PriceMargin'];
    edtMinOut.FloatValue := obj.F['PriceMinOutbound'];
    edtMinIn.FloatValue := obj.F['PriceMinInbound'];
  end;
end;

procedure TfmERPClientEdit.qryClientBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryClient.FieldByName('datetime').AsDateTime:= nowUTC;
  qryClient.FieldByName('user').AsString:= 'ERP';
end;

procedure TfmERPClientEdit.qryConfigBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryConfig.FieldByName('datetime').AsDateTime:= nowUTC;
  qryConfig.FieldByName('user').AsString:= 'ERP';
end;

procedure TfmERPClientEdit.qryERPCustLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryERPCustLookup.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

procedure TfmERPClientEdit.qryLicenceAfterScroll(DataSet: TDataSet);
begin
  inherited;
  LicenceCoData.AsString := qryLicence.FieldByName('datatext').AsString;
  PopulateDbList;
  PopulateSMSData;
  PopulateOptions;
  lblLicenceCount.Caption := IntToStr(qryLicence.RecNo) + ' of ' + IntToStr(qryLicence.Recordcount);
  memDataText.Text := JsonToStrFormat(qryLicence.FieldByName('datatext').AsString);

end;

procedure TfmERPClientEdit.qryLicenceBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryLicence.FieldByName('datetime').AsDateTime:= nowUTC;
  qryLicence.FieldByName('user').AsString:= 'ERP';
end;

procedure TfmERPClientEdit.qryLicenceBeforeScroll(DataSet: TDataSet);
begin
  inherited;
  SaveLicenceCoData;
end;

procedure TfmERPClientEdit.qryServersAfterScroll(DataSet: TDataSet);
begin
  inherited;
  PostDb(qryLicence);
  PostDb(qryConfig);
  CloseDb(qryLicence);
  qryLicence.ParamByName('ComputerId').AsInteger := qryServers.FieldByName('Id').AsInteger;
  CloseDb(qryConfig);
  qryConfig.ParamByName('ComputerId').AsInteger := qryServers.FieldByName('Id').AsInteger;
  OpenDb(qryLicence);
  OpenDb(qryConfig);
  lblComputerCount.Caption := IntToStr(qryServers.RecNo) + ' of ' + IntToStr(qryServers.Recordcount);
  lblLicenceCount.Caption := IntToStr(qryLicence.RecNo) + ' of ' + IntToStr(qryLicence.Recordcount);
end;

procedure TfmERPClientEdit.qryServersBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryServers.FieldByName('datetime').AsDateTime:= nowUTC;
  qryServers.FieldByName('user').AsString:= 'ERP';
end;

procedure TfmERPClientEdit.SaveLicenceCoData;
begin
  if (LicenceCoData.Count > 0) and LicenceCoData.B['_dirty'] then begin
    LicenceCoData.Delete('_dirty');
    EditDb(qryLicence);
    qryLicence.FieldByName('datatext').AsString := LicenceCoData.AsString;
    PostDb(qryLicence);
  end;
end;

function TfmERPClientEdit.SMSConfig: TJsonObject;
begin
  result := nil;
  if cboDbList.Text <> '' then begin
    result := LicenceCoData.O['erpinfo'].O[cboDbList.Text].O['SMSConfig'];
  end;
end;

end.
