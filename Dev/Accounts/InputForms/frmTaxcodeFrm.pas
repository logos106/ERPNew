unit frmTaxcodeFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls,
    BaseInputForm, DNMPanel, kbmMemTable, wwcheckbox,
  DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, Buttons, DNMSpeedButton, Menus, AdvMenus,
  MemDS, Shader, ImgList, BusObjTaxCodes, BusObjBase, ActnList, Grids, Wwdbigrd,
  Wwdbgrid, wwdbedit, wwdblook, ProgressDialog, wwclearbuttongroup, wwradiogroup;

type
  TfrmTaxcode = class(TBaseInputGUI)
    dsTaxcodes: TDataSource;
    qryTaxcodes: TERPQuery;
    ActionList: TActionList;
    actSave: TAction;
    actNew: TAction;
    actCancel: TAction;
    qryTaxcodesTaxCodeID: TIntegerField;
    qryTaxcodesName: TWideStringField;
    qryTaxcodesDescription: TWideStringField;
    qryTaxcodesRate: TFloatField;
    qryTaxcodesRegionID: TWordField;
    qryTaxcodesActive: TWideStringField;
    qryTaxcodesEditedFlag: TWideStringField;
    qryTaxcodesGlobalRef: TWideStringField;
    QryTaxCodeLines: TERPQuery;
    dssTaxCodeLines: TDataSource;
    qryTaxcodesTaxFormula: TWideStringField;
    QryPercentageOn: TERPQuery;
    qrySubTaxCode: TERPQuery;
    qrySubTaxCodeID: TIntegerField;
    qrySubTaxCodeCode: TWideStringField;
    qrySubTaxCodeDescription: TWideStringField;
    QryTaxCodeLinesID: TIntegerField;
    QryTaxCodeLinesGlobalRef: TWideStringField;
    QryTaxCodeLinesTaxCodeID: TIntegerField;
    QryTaxCodeLinesSubTaxID: TIntegerField;
    QryTaxCodeLinesSubTaxCode: TWideStringField;
    QryTaxCodeLinesPercentage: TFloatField;
    QryTaxCodeLinesmsTimeStamp: TDateTimeField;
    QryTaxCodeLinesPercentageOn: TWideStringField;
    QryTaxCodeLinesPercentageOnID: TIntegerField;
    QryPercentageOnID: TLargeintField;
    QryPercentageOnSubTaxcode: TWideStringField;
    qryTaxcodescRate: TFloatField;
    qrySubTaxCodeActive: TWideStringField;
    qryTaxcodesmsTimeStamp: TDateTimeField;
    qryTaxcodesmsUpdateSiteCode: TWideStringField;
    qryTaxcodesTaxcodeLocationCategory: TWideStringField;
    qrytaxcodelocations: TERPQuery;
    dstaxcodelocations: TDataSource;
    qrytaxcodelocationsID: TIntegerField;
    qrytaxcodelocationsGlobalRef: TWideStringField;
    qrytaxcodelocationsTaxCodeID: TIntegerField;
    qrytaxcodelocationsLocationValue: TWideStringField;
    qrytaxcodelocationsActive: TWideStringField;
    qrytaxcodelocationsmstimeStamp: TDateTimeField;
    qrytaxcodelocationsmsUpdateSitecode: TWideStringField;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label3: TLabel;
    cmdCancel: TDNMSpeedButton;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    Bevel1: TBevel;
    Name_Label: TLabel;
    lblDescription: TLabel;
    Rate_Label: TLabel;
    Label1: TLabel;
    Name1: TDBEdit;
    grdSubTaxcodes: TwwDBGrid;
    grdSubTaxcodesIButton: TwwIButton;
    cboSubTaxCode: TwwDBLookupCombo;
    cboPercentageOn: TwwDBLookupCombo;
    edtRate: TwwDBEdit;
    edtDescription: TDBEdit;
    pnlCAtegoryDetails: TDNMPanel;
    lblTaxcodeLocationCategory: TLabel;
    grpTaxcodeLocationCategory: TwwRadioGroup;
    bvlTaxcodeLocationCategory: TBevel;
    grdTaxcodelocations: TwwDBGrid;
    btnTaxcodelocations: TwwIButton;
    lblLocations: TLabel;
    btnLocations: TDNMSpeedButton;
    Bevel2: TBevel;
    QryTaxCodeLinesCapAmount: TFloatField;
    QryTaxCodeLinesmsUpdateSiteCode: TWideStringField;
    QryTaxCodeLinesAmountPerUnit: TFloatField;
    QryTaxCodeLinesUOM: TWideStringField;
    QryTaxCodeLinesThresholdAmount: TFloatField;
    cboUOM: TwwDBLookupCombo;
    qryUOMLookup: TERPQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure grdSubTaxcodesKeyPress(Sender: TObject; var Key: Char);
    procedure qrySubTaxCodeBeforeOpen(DataSet: TDataSet);
    procedure cboSubTaxCodeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboPercentageOnCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboPercentageOnDropDown(Sender: TObject);
    procedure qryTaxcodesCalcFields(DataSet: TDataSet);
    procedure grdSubTaxcodesIButtonClick(Sender: TObject);
    procedure edtRateEnter(Sender: TObject);
    procedure edtRateExit(Sender: TObject);
    procedure btnTaxcodelocationsClick(Sender: TObject);
    procedure qryTaxcodesAfterOpen(DataSet: TDataSet);
    procedure btnLocationsClick(Sender: TObject);
    procedure grpTaxcodeLocationCategoryClick(Sender: TObject);
  private
    TaxCode: TTaxCode;
    fCodeName: string;
    fRegionID: integer;
    OldTaxrate:Double;
    fsLocationCategory:String;
    function SaveData: boolean;
    procedure HandleValidationErrors;
    function GetCodeName: string;
    procedure SetCodeName(const Value: string);
    procedure REfreshQryPercentageOn;
    Procedure AddLocations(Sender: TwwDbGrid);
    procedure applyCategoryCaptions;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    property CodeName: string read GetCodeName write SetCodeName;
    property RegionID: integer read fRegionID write fRegionID;
    procedure SetKeyString(const Value: string); Override;
  end;

function DoTaxCodeEdit(const aTaxCodeId: integer; var aCodeName: string;
  aConnection: TERPConnection; const aRegionId: integer = 0): boolean;


implementation

uses
  DNMLib, FormFactory, DNMExceptions, CommonLib,  AppEnvironment, BusObjConst, AppEnvVirtualObj, RegionLocations, tcConst;

{$R *.DFM}

function DoTaxCodeEdit(const aTaxCodeId: integer; var aCodeName: string;
  aConnection: TERPConnection; const aRegionId: integer = 0): boolean;
var
  form: TfrmTaxcode;
begin
  result:= false;
  form:= TfrmTaxcode.Create(nil);
  try
    form.TransConnection:= aConnection;
    form.KeyID:= aTaxCodeId;
    form.CodeName:= aCodeName;
    form.RegionID:= aRegionID;
    if form.ShowModal = mrOk then begin
      result:= true;
      aCodeName:= form.CodeName;
    end;
  finally
    form.Free;
  end;
end;


procedure TfrmTaxcode.FormCreate(Sender: TObject);
begin
  pnlCAtegoryDetails.Visible := appenv.CompanyPrefs.filterTaxcodeforClient;
  if not appenv.CompanyPrefs.filterTaxcodeforClient then
       Self.Width := 598
  else Self.Width := 1002;

  CloseDb(QryPercentageOn);
  QryPercentageOn.SQL.clear;
  QryPercentageOn.SQL.add('SELECT ID, SubTaxcode  '   +
                          ' FROM tblTaxCodeLines   '   +
                          ' WHERE TaxCodeID =  :TaxCodeID and SubTaxID <> :SubTaxID    '   +
                          ' union all Select 0 , '+quotedstr(AMOUNT_EX) +' order by ID');
  inherited;
  fCodeName:= '';
  fRegionID:= 0;
  TaxCode:= TTaxCode.Create(self);
  TaxCode.Connection := TMyDacDataConnection.Create(TaxCode);
  TaxCode.Connection.MyDacConnection := MyConnection;
  TaxCode.BusObjEvent := DoBusinessObjectEvent;
  grpTaxcodeLocationCategory.items[1] := appenv.RegionalOptions.StateName;
  grpTaxcodeLocationCategory.items[2] := Appenv.RegionalOptions.SuburbName;
end;

procedure TfrmTaxcode.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      if Assigned(TransConnection) then begin
        TaxCode.Connection.MyDacConnection := TransConnection;
        qryTaxCodes.Connection:= TransConnection;
      end;

      // Roll back any existing transaction
      RollbackTransaction;


      // Put our Database Connection into transaction mode.
      BeginTransaction;

     // qryProcResource.ParamByName('ProcResourceId').asInteger := KeyID;

      if fRegionID > 0 then
        TaxCode.SQL:=   'SELECT * FROM tblTaxCodes WHERE RegionID = ' + IntToStr(fRegionID);
      if KeyID = 0 then begin
        TaxCode.New;
        if fRegionId > 0 then TaxCode.RegionID:= fRegionID
        else TaxCode.RegionID:= AppEnv.RegionalOptions.ID;
        if fCodeName <> '' then TaxCode.CodeName:= fCodeName;
        TaxCode.PostDb;
      end else begin
        TaxCode.Load(KeyId);
      end;
      TaxCode.Lines;
      TaxCode.TaxcodeLocations;
      OpenQueries;

      chkActive.Enabled := not (AccessLevel in [2, 3]);
      SetControlFocus(Name1);
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

procedure TfrmTaxcode.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  inherited;
  if fsModal in FormState then
    { don't free form if it is modal }
  else
    Action := caFree;
end;

procedure TfrmTaxcode.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
var
  fs:STring;
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TTaxCode then begin
      TTaxCode(Sender).DataSet:= qryTaxCodes;
    end else if Sender is TTaxCodeLines then begin
      TTaxCodeLines(Sender).DataSet:= QryTaxCodeLines;
    end else if Sender is TTaxcodeLocations then begin
      TTaxcodeLocations(Sender).DataSet:= qrytaxcodelocations;
    end;
  end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_Rate) then begin
    edtRate.Readonly := (TaxCode.Lines.count >0);
  end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_TaxcodeLocationChanged) then begin
    if Taxcode.ID>0 then begin
      fs:='You have changed the Location Category from ' + quotedstr(fsLocationCategory) +' to ' +quotedstr(Taxcode.LocationCategoryDesc)+'.';
      if not Sametext(fsLocationCategory , 'Overseas')  then fs:= fs + NL+ 'This will delete all ' + quotedstr(fsLocationCategory +'(s)')+' linked to the taxcode.';
      if Taxcode.LocationCategory <> 'O'          then fs:= fs + NL+ 'Make sure to select  ' +quotedstr(Taxcode.LocationCategoryDesc+'(s)')+'.';
      MessageDlgXP_vista(fs, mtWarning, [mbOK], 0);
    end;
    fsLocationCategory:=Taxcode.LocationCategoryDesc;
    applyCategoryCaptions;
  end
end;

procedure TfrmTaxcode.qrySubTaxCodeBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySubTaxCode.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmTaxcode.qryTaxcodesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  applyCategoryCaptions;
  fsLocationCategory := Taxcode.LocationCategoryDesc;
end;
procedure TfrmTaxcode.applyCategoryCaptions;
begin
  lblLocations.caption := Taxcode.LocationCategoryDesc+'(s)';
  btnLocations.caption := 'Choose ' +Taxcode.LocationCategoryDesc+'(s)';
  if TaxCode.isOverSeasTaxcode or (accesslevel <> 1 )then begin
    btnLocations.Enabled := false;
    lblLocations.Enabled := false;
    btnTaxcodelocations.Enabled := false;
    grdTaxcodelocations.Options := grdTaxcodelocations.Options - [dgEditing];
  end else if accesslevel = 1 then begin
    btnLocations.Enabled := true;
    lblLocations.Enabled := true;
    btnTaxcodelocations.Enabled := true;
    grdTaxcodelocations.Options := grdTaxcodelocations.Options + [dgEditing];
  end;
end;

procedure TfrmTaxcode.qryTaxcodesCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryTaxcodescRate.asFloat := qryTaxcodesRate.asFloat*100;
end;

procedure TfrmTaxcode.HandleValidationErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := TaxCode.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_TaxCode_NameBlank :
        begin
          SetControlFocus(Name1);
        end;
    end;
  end;
end;

function TfrmTaxcode.SaveData: boolean;
begin
  result:= true;
  { validate data and return true if all ok }
  if TaxCode.Dirty then begin
    if not TaxCode.Save then
      result:= false
    else
      fCodeName:= TaxCode.CodeName;
  end;
end;

procedure TfrmTaxcode.actSaveExecute(Sender: TObject);
begin
  inherited;
    if not TaxCode.IsUnique(TaxCode.ID , 'Name = ' + quotedstr(TaxCode.CodeName) +' and REgionId = ' + inttostr(TaxCode.RegionID)) then begin
        TaxCode.REsultStatus.addItem(false, rssWarning, 0, 'Record already exists for Taxcode "' + TaxCode.CodeName + '"');
      Exit;
    end;

  PostDb(qryTaxcodes);
  if not SaveData then begin
    HandleValidationErrors;
    Exit;
  end;
  CommitTransaction;
  Notify;
  KeyId:= TaxCode.ID;
  Notify(False);
  if fsModal in FormState then
    ModalResult:= mrOk
  else
    Close;
end;

procedure TfrmTaxcode.AddLocations(Sender: TwwDbGrid);
var
  i: integer;
  fsLocationValuefieldName:String;
begin
       if sametext(Taxcode.LocationCategory , 'C') then fsLocationValuefieldName := 'Country'
  else if sametext(Taxcode.LocationCategory , 'S') then fsLocationValuefieldName := 'state'
  else if sametext(Taxcode.LocationCategory , 'L') then fsLocationValuefieldName := 'City_sub'
  else if sametext(Taxcode.LocationCategory , 'P') then fsLocationValuefieldName := 'PostCode'
  else exit;

  if sender.DataSource.DataSet.FindField(fsLocationValuefieldName) = nil then exit;

  showProgressbar(WAITMSG, Sender.Selected.Count);
  try
    if Sender.SelectedList.Count > 0 then begin
      for i := 0 to Sender.SelectedList.Count - 1 do begin
        sender.DataSource.DataSet.GoToBookmark(Sender.SelectedList.Items[i]);
        if not Taxcode.TaxcodeLocations.locate('LocationValue' ,  sender.DataSource.DataSet.fieldbyname(fsLocationValuefieldName).AsString , []) then begin
          Taxcode.TaxcodeLocations.New;
          Taxcode.TaxcodeLocations.LocationValue :=sender.DataSource.DataSet.fieldbyname(fsLocationValuefieldName).AsString;
          Taxcode.TaxcodeLocations.PostDB;
        end;
      end;
    end;
  finally
    HideProgressbar;
  end;



       if sametext(Taxcode.LocationCategory , 'C') and (Sender.DataSource.DataSet.FindField('Country') = nil) then exit
  else if sametext(Taxcode.LocationCategory , 'S') and (Sender.DataSource.DataSet.FindField('state') = nil) then exit
  else if sametext(Taxcode.LocationCategory , 'L') and (Sender.DataSource.DataSet.FindField('City_sub') = nil) then exit
  else if sametext(Taxcode.LocationCategory , 'P') and (Sender.DataSource.DataSet.FindField('PostCode') = nil) then exit;

end;

procedure TfrmTaxcode.btnLocationsClick(Sender: TObject);
begin
  inherited;
  OpenRegionLocationList(taxcode.LocationCategory, False, AddLocations , False);
end;

procedure TfrmTaxcode.cboPercentageOnCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  TaxCode.Lines.PercentageOn := QryPercentageOnSubTaxCode.asString;
  TaxCode.Lines.PercentageOnID := QryPercentageOnId.asInteger;
  TaxCode.Lines.ValidatePercentageOn(TaxCode.Lines.PercentageOnID);
end;

procedure TfrmTaxcode.cboPercentageOnDropDown(Sender: TObject);
begin
  inherited;
  REfreshQryPercentageOn;
end;
procedure TfrmTaxcode.REfreshQryPercentageOn;
begin
  CloseDB(QryPercentageOn);
  QryPercentageOn.Parambyname('TaxCodeID').asInteger:= TaxCode.ID;
  QryPercentageOn.Parambyname('SubTaxID').asInteger := QryTaxCodeLinesSubTaxID.asInteger;
  OpenDB(QryPercentageOn);
end;

procedure TfrmTaxcode.cboSubTaxCodeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  Taxcode.lines.SubTaxID    := qrySubTaxCodeID.asInteger;
  Taxcode.lines.SubTaxCode  := qrySubTaxCodeCode.asString;
  Taxcode.lines.PostDB;
  //REfreshQryPercentageOn;
end;

procedure TfrmTaxcode.actNewExecute(Sender: TObject);
begin
  inherited;
  PostDB(qryTaxcodes);
  if TaxCode.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not SaveData then Exit;
          self.CommitTransaction;
        end;
      mrNo:
        begin

        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;

  KeyID := 0;
  fCodeName:= '';
  FormShow(nil);
  TaxCode.Dirty := false;
end;

procedure TfrmTaxcode.actCancelExecute(Sender: TObject);
begin
  inherited;
  Notify(TRue);
  if fsModal in FormState then
    ModalResult:= mrCancel
  else
    Close;
end;

function TfrmTaxcode.GetCodeName: string;
begin
  result:= fCodeName;
end;

procedure TfrmTaxcode.SetCodeName(const Value: string);
begin
  fCodeName:= Value;
end;

procedure TfrmTaxcode.SetKeyString(const Value: string);
begin
  inherited;
  SetKeyString(TTaxcode, qryTaxcodes, Value , 'Name');
end;

procedure TfrmTaxcode.btnTaxcodelocationsClick(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  if grdTaxcodelocations.SelectedList.Count = 0 then
    grdTaxcodelocations.selectrecord;

  if grdTaxcodelocations.SelectedList.Count = 0 then exit;

  if MessageDlgxp_vista('Are you Sure you want to Delete Selected ' +Taxcode.LocationCategoryDesc+'(s)', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    for ctr := 0 to grdTaxcodelocations.SelectedList.Count - 1 do begin
      TaxCode.TaxcodeLocations.dataset.GoToBookmark(grdTaxcodelocations.SelectedList.Items[ctr]);
      TaxCode.TaxcodeLocations.Delete;
    end;

end;

procedure TfrmTaxcode.edtRateEnter(Sender: TObject);
begin
  inherited;
  TaxCode.Lines.PostDB;
  edtRate.Readonly := (TaxCode.Lines.count >0);
  OldTaxrate := qryTaxcodescRate.asFloat;
end;

procedure TfrmTaxcode.edtRateExit(Sender: TObject);
begin
  inherited;
  if OldTaxrate <> qryTaxcodescRate.asFloat then
    if qryTaxcodescRate.asFloat = 0 then
      qryTaxcodesRate.asFloat := 0
    else
    qryTaxcodesRate.asFloat := qryTaxcodescRate.asFloat /100;
end;

procedure TfrmTaxcode.grdSubTaxcodesIButtonClick(Sender: TObject);
begin
  inherited;
  if MessageDlgxp_vista('Are you Sure you want to Delete ' + TaxCode.Lines.SubTaxCode + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    TaxCode.Lines.Delete;
end;

procedure TfrmTaxcode.grdSubTaxcodesKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if SAmeText(grdSubTaxcodes.getActivefield.fieldname , 'code') then
    if (Key = '[') or (Key = ']') then Key := chr(0); // as [] is used as the delimeter in the formula , it cannot be a part of the sring
end;

procedure TfrmTaxcode.grpTaxcodeLocationCategoryClick(Sender: TObject);
begin
  inherited;
  Taxcode.LocationCategory := grpTaxcodeLocationCategory.values[grpTaxcodeLocationCategory.itemindex];
  Taxcode.postDB;
end;

initialization
  RegisterClassOnce(TfrmTaxCode);
  FormFact.RegisterMe(TfrmTaxcode, 'TTaxCodeListGUI_*=TaxCodeID');
  FormFact.RegisterControl(TfrmTaxcode, '*_cboTaxCode=TaxCodeID');
  FormFact.RegisterControl(TfrmTaxcode, '*_cboTax=TaxCodeID');
  FormFact.RegisterControl(TfrmTaxcode, '*_cboPURTaxCode=TaxCodeID');
end.
