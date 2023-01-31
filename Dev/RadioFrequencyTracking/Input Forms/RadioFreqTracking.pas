unit RadioFreqTracking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, wwdblook, MemDS,
  DNMPanel, Buttons, DNMSpeedButton, DBCtrls, Mask, wwdbedit, Grids, Wwdbgrid,
  wwDialog, wwMemo, wwcheckbox, Wwdbigrd, wwdbdatetimepicker, Shader;

type
  TRadioFreqTrackingGUI = class(TBaseInputGUI)
    qryClients: TMyQuery;
    Label1: TLabel;
    qryRFT: TMyQuery;
    qryRFTRptRate: TFloatField;
    qryRFTSetupFee: TFloatField;
    qryRFTDescription: TMemoField;
    qryClientsClientID: TIntegerField;
    qryClientsCompany: TStringField;
    dsRFT: TDataSource;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    cboSelcallType: TwwDBLookupCombo;
    cboFreqBand: TwwDBLookupCombo;
    Bevel4: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Bevel5: TBevel;
    edtDescOfSys: TwwDBEdit;
    Label17: TLabel;
    edtMobilesQty: TwwDBEdit;
    edtRate: TwwDBEdit;
    edtSetupFee: TwwDBEdit;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Label18: TLabel;
    Label19: TLabel;
    grdChannels: TwwDBGrid;
    grdSelCallDetails: TwwDBGrid;
    qryFreqBand: TMyQuery;
    qryFreqBandFreqBandID: TIntegerField;
    qryFreqBandFreqBandName: TStringField;
    qryFreqBandFreqBandDescription: TStringField;
    edtMonthlyRental: TwwDBEdit;
    qryChannels: TMyQuery;
    qryRFTRFTID: TIntegerField;
    dsChannels: TDataSource;
    qryChannelsChannelsID: TWordField;
    qryChannelsRFTID: TIntegerField;
    qryChannelsChannelNo: TIntegerField;
    qryChannelsTxFreq: TFloatField;
    qryChannelsRxFreq: TFloatField;
    qryChannelsRepeaterNo: TStringField;
    qryChannelsRptLocations: TStringField;
    qryChannelsDeviation: TStringField;
    qryChannelsLicenseNo: TStringField;
    qryChannelsDetails: TStringField;
    qryChannelsActive: TStringField;
    qrySelcallsDetails: TMyQuery;
    dsSelcallsDetails: TDataSource;
    qrySelcallType: TMyQuery;
    qrySelcallTypeSelcallTypeID: TIntegerField;
    qrySelcallTypeSelcallType: TStringField;
    qrySelcallTypeSelcallTypeDescription: TStringField;
    qrySelcallTypeActive: TStringField;
    dsClients: TDataSource;
    qryRFTSelcallType: TStringField;
    qryRFTCustomerName: TStringField;
    qryRFTFreqBand: TStringField;
    qryRFTAntennaTypeBase: TStringField;
    qryRFTAntennaTypeMobiles1: TStringField;
    qryRFTAntennaTypeMobiles2: TStringField;
    qryRFTAntennaTypeMobiles3: TStringField;
    qryRFTRadioModelsUsed1: TStringField;
    qryRFTRadioModelsUsed2: TStringField;
    qryRFTRadioModelsUsed3: TStringField;
    qryRFTActive: TStringField;
    qryRFTMonthlyRental: TFloatField;
    dlgSelcallNote: TwwMemoDialog;
    qrdChannelsIButton: TwwIButton;
    grdSelCallDetailsIButton: TwwIButton;
    chkActive: TwwCheckBox;
    edtID: TwwDBEdit;
    Label20: TLabel;
    dlgChannelsNote: TwwMemoDialog;
    qryChannelsNote: TStringField;
    qrySelcallsDetailsSelcallDetailsID: TIntegerField;
    qrySelcallsDetailsRFTID: TIntegerField;
    qrySelcallsDetailsSelcallNo: TStringField;
    qrySelcallsDetailsVehicle: TStringField;
    qrySelcallsDetailsDriver: TStringField;
    qrySelcallsDetailsDateInstalled: TDateField;
    qrySelcallsDetailsAntennaType: TStringField;
    qrySelcallsDetailsRego: TStringField;
    qrySelcallsDetailsSerial: TStringField;
    qrySelcallsDetailsRadioModel: TStringField;
    qrySelcallsDetailsNote: TStringField;
    qrySelcallsDetailsInvoice: TStringField;
    qrySelcallsDetailsGlobalRef: TStringField;
    qrySelcallsDetailsActive: TStringField;
    qrySelcallsDetailsmsTimeStamp: TDateTimeField;
    dtDateInstalled: TwwDBDateTimePicker;
    cboClient: TwwDBLookupCombo;
    qryChannelsSubtone: TStringField;
    qryRFTUnitQty: TIntegerField;
    cboATM1: TwwDBLookupCombo;
    qryAntTypeMobiles: TMyQuery;
    qryAntTypeMobilesAntennaTypeMobilesName: TStringField;
    qryAntTypeMobilesAntennaTypeMobilesID: TIntegerField;
    qryAntTypeMobilesAntennaTypeMobilesDescription: TStringField;
    cboRMU1: TwwDBLookupCombo;
    qryRadioModelsUsed: TMyQuery;
    qryRadioModelsUsedRadioModelsUsedName: TStringField;
    qryRadioModelsUsedRadioModelsUsedID: TIntegerField;
    qryRadioModelsUsedRadioModelsUsedDescription: TStringField;
    Label4: TLabel;
    qrySelcallsDetailsFleetNo: TLargeintField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cboAnyNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure qryRFTCalcFields(DataSet: TDataSet);
    procedure grdSelCallDetailsDblClick(Sender: TObject);
    procedure qrdChannelsIButtonClick(Sender: TObject);
    procedure grdSelCallDetailsIButtonClick(Sender: TObject);
    procedure dlgSelcallNoteUserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
    procedure edtDescOfSysDblClick(Sender: TObject);
    procedure CustomiseGridClick(Sender: TObject);
    procedure grdChannelsDblClick(Sender: TObject);
    procedure dlgChannelsNoteUserButton1Click(Dialog: TwwMemoDlg;
      Memo: TMemo);
    procedure qrySelcallsDetailsBeforePost(DataSet: TDataSet);
    procedure qryChannelsBeforePost(DataSet: TDataSet);
    procedure qrySelcallsDetailsInvoiceChange(Sender: TField);
  private
    { Private declarations }
    Function GetNoOfUnits:Integer;
  protected
  public
    sl: TStringList;
    { Public declarations }
  end;

var
  RadioFreqTrackingGUI: TRadioFreqTrackingGUI;

implementation

uses FastFuncs, FormFactory, DNMLib, GuiPrefsObj,CommonLib, AppEnvironment;

{$R *.dfm}
procedure TRadioFreqTrackingGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TRadioFreqTrackingGUI.FormCreate(Sender: TObject);
Var Index : integer;
begin
  AllowCustomiseGrid := true;
  inherited;
  fbTabSettingEnabled := False;
  sl := TStringList.Create;
  KeyID := 0;

  for Index := 0 to GuiPrefs.Elements.Count - 1 do begin
    if GuiPrefs.Elements.Items[Index].Target = grdChannels then
      GuiPrefs.Elements.Items[Index].Description := 'Channels Details Grid'
    else if GuiPrefs.Elements.Items[Index].Target = grdSelCallDetails then
      GuiPrefs.Elements.Items[Index].Description := 'Selcalls Details Grid'
  end;

  GuiPrefs.Active := true;
end;

procedure TRadioFreqTrackingGUI.FormShow(Sender: TObject);
Var QueryNamesNotToOpen: array of string;
begin
  inherited;
  BeginTransaction;

  SetLength(QueryNamesNotToOpen, 3);
  QueryNamesNotToOpen[0] := 'qryRFT';
  QueryNamesNotToOpen[1] := 'qryChannels';
  QueryNamesNotToOpen[2] := 'qrySelcallsDetails';
  OpenQueries(QueryNamesNotToOpen);

  //KeyID := 1; { <-- 4 testing only}
  if KeyID = 0 then begin
    qryRFT.Open;
    qryRFT.Insert;
    qryRFTActive.AsBoolean := True;
    qryRFT.Post;
    KeyID := qryRFTRFTID.AsInteger;
    qryRFT.Edit;
  end
  else begin
    qryRFT.ParamByName('KeyID').asInteger := KeyID;
    qryRFT.Open;
  end;

  qryChannels.Params.ParamByName('xID').AsInteger := KeyID;
  qrySelcallsDetails.Params.ParamByName('xID').AsInteger := KeyID;
  qryChannels.Open;
  qrySelcallsDetails.Open;

  SaveFieldPrefs(GuiPrefs);
  SetControlFocus(cboClient)
end;

procedure TRadioFreqTrackingGUI.btnOkClick(Sender: TObject);
begin
  inherited;
  if qryRFT.State in [dsEdit, dsInsert] then
    qryRFT.Post;
  if qryChannels.State in [dsEdit,dsInsert] then
    qryChannels.Post;
  if qrySelcallsDetails.State in [dsEdit,dsInsert] then
    qrySelcallsDetails.Post;
  CommitTransaction;
  Notify;
  Close;
end;

procedure TRadioFreqTrackingGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Close;
end;

procedure TRadioFreqTrackingGUI.cboAnyNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
Var S : TStringList;
begin
  inherited;
  s := TstringList.Create;
  s.CommaText := TwwDBLookupCombo(Sender).Selected[0];
  LookupTable.Insert;
  LookupTable.FieldByName(s[0]).AsString := NewValue;
  LookupTable.Post;
  LookupTable.Close;
  LookupTable.Open;
  LookupTable.Last;
  TwwDBLookupCombo(Sender).Text := NewValue;
  Accept := true;
end;

procedure TRadioFreqTrackingGUI.qryRFTCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryRFTMonthlyRental.AsCurrency := qryRFTUnitQty.AsInteger * qryRFTRptRate.AsCurrency;
end;

procedure TRadioFreqTrackingGUI.grdSelCallDetailsDblClick(Sender: TObject);
begin
  //inherited;
  If qrySelcallsDetailsSelcallDetailsID.AsInteger > 0 then begin
    if FastFuncs.UpperCase(grdSelCallDetails.GetActiveField.Name) = FastFuncs.UpperCase('qrySelcallsDetailsNote') then begin
      dlgSelcallNote.Execute;
    end
  end;
end;

procedure TRadioFreqTrackingGUI.qrdChannelsIButtonClick(Sender: TObject);
begin
  inherited;
  if qryChannels.RecordCount > 0 then begin
    if (CommonLib.MessageDlgXP_Vista('Delete Record?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
      qryChannels.Delete;
    end;
  end;  
end;

procedure TRadioFreqTrackingGUI.grdSelCallDetailsIButtonClick(
  Sender: TObject);
begin
  inherited;
    if qrySelcallsDetails.RecordCount > 0 then begin
    if (CommonLib.MessageDlgXP_Vista('Delete Record?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
      qrySelcallsDetails.Delete;
    end;
  end;
end;

procedure TRadioFreqTrackingGUI.dlgSelcallNoteUserButton1Click(Dialog: TwwMemoDlg;
  Memo: TMemo);
begin
  inherited;
  dlgSelcallNote.Form.Memo.Lines.Append(AppEnv.Employee.LogonName + ',' + DateTimeToStr(Now));
end;


procedure TRadioFreqTrackingGUI.edtDescOfSysDblClick(Sender: TObject);
begin
  inherited;
  edtDescOfSys.Text := edtDescOfSys.Text + #13#10 + AppEnv.Employee.LogonName + ',' + DateTimeToStr(Now);
end;

procedure TRadioFreqTrackingGUI.CustomiseGridClick(Sender: TObject);
var
  SourceGrid: TComponent;
begin
  //inherited;

  if Sender is TMenuItem then
  begin
    with TMenuItem(Sender) do
    begin
      SourceGrid := TAdvPopupMenu(TMenuItem(Sender).GetParentMenu).PopupComponent;

      if SourceGrid.Name = 'grdChannels' then
      begin
        GuiPrefs.ShowCustomiseForm('Channels Details Grid');
      end
      else if SourceGrid.Name = 'grdSelCallDetails' then
      begin
        GuiPrefs.ShowCustomiseForm('Selcalls Details Grid');
      end
    end;
  end;
end;

procedure TRadioFreqTrackingGUI.grdChannelsDblClick(Sender: TObject);
begin
//  inherited;

  if (qryChannelsChannelsID.AsInteger > 0) and
     FastFuncs.SameText(grdChannels.GetActiveField.Name, 'qryChannelsNote') then
    dlgChannelsNote.Execute;
end;

procedure TRadioFreqTrackingGUI.dlgChannelsNoteUserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
begin
  inherited;
  dlgChannelsNote.Form.Memo.Lines.Append(AppEnv.Employee.LogonName + ',' + DateTimeToStr(Now));
end;

function TRadioFreqTrackingGUI.GetNoOfUnits: Integer;
var
  bm: TBookmark;
begin
  Result := 0;
  if not qrySelcallsDetails.Active then Exit;
  with qrySelcallsDetails do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      If (qrySelcallsDetailsInvoice.AsString='T') then Inc(Result);
      Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;
end;

procedure TRadioFreqTrackingGUI.qrySelcallsDetailsBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  qrySelcallsDetailsRFTID.AsInteger := qryRFTRFTID.AsInteger;
end;

procedure TRadioFreqTrackingGUI.qryChannelsBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryChannelsRFTID.AsInteger := qryRFTRFTID.AsInteger;
end;

procedure TRadioFreqTrackingGUI.qrySelcallsDetailsInvoiceChange(
  Sender: TField);
begin
  inherited;
  qryRFT.Edit;
  qryRFTUnitQty.AsInteger := GetNoOfUnits;
end;

initialization
  RegisterClassOnce(TRadioFreqTrackingGUI);
  FormFact.RegisterMe(TRadioFreqTrackingGUI, 'TRadioFreqTrackingList_*_RFTID=RFTID');
end.

