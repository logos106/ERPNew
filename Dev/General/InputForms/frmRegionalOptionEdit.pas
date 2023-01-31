unit frmRegionalOptionEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMSpeedButton, DNMPanel, ActnList,
  BusObjRegionalOptions, BusObjBase, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  AdvEdit, DBAdvEd, wwdblook, AdvPicture, Wwdbspin, ComCtrls, Grids, Wwdbigrd,
  Wwdbgrid, ProgressDialog, wwclearbuttongroup, wwradiogroup;
type
  TfmRegionalOptionEdit = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryRegion: TERPQuery;
    dsRegion: TDataSource;
    qryRegionGlobalRef: TWideStringField;
    qryRegionRegionID: TIntegerField;
    qryRegionRegion: TWideStringField;
    qryRegionRegionAbbreviation: TWideStringField;
    qryRegionCurrencySymbol: TWideStringField;
    qryRegionWholeCurrencyName: TWideStringField;
    qryRegionDecimalCurrencyName: TWideStringField;
    qryRegionCurrencyFormat: TSmallintField;
    qryRegionNegCurrFormat: TSmallintField;
    qryRegionShortDateFormat: TWideStringField;
    qryRegionDateSeparator: TWideStringField;
    qryRegionSuburbName: TWideStringField;
    qryRegionStateName: TWideStringField;
    qryRegionPostcodeLength: TIntegerField;
    qryRegionPostcodeMask: TWideStringField;
    qryRegionPhoneNumberLength: TIntegerField;
    qryRegionPhoneNumberMask: TWideStringField;
    qryRegionMobileNumberLength: TIntegerField;
    qryRegionMobileNumberMask: TWideStringField;
    qryRegionmsTimeStamp: TDateTimeField;
    qryRegionBSBName: TWideStringField;
    qryRegionBSBLength: TIntegerField;
    qryRegionBSBMask: TWideStringField;
    qryRegionBankAccountLength: TIntegerField;
    qryRegionBankAccountMask: TWideStringField;
    qryRegionForeignExDefault: TWideStringField;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actNew: TAction;
    qryCurrency: TERPQuery;
    qryRegionWeekStartDay: TIntegerField;
    qryRegionTaxCodeSalesInc: TWideStringField;
    qryRegionTaxCodeSalesEx: TWideStringField;
    qryRegionTaxCodePurchaseInc: TWideStringField;
    qryRegionTaxCodePurchaseEx: TWideStringField;
    qryRegionTaxCodeNoTax: TWideStringField;
    qryRegionFlagImage: TBlobField;
    btnHelp: TDNMSpeedButton;
    qryCurrencyCurrencyID: TIntegerField;
    qryCurrencyCountry: TWideStringField;
    qryCurrencyCode: TWideStringField;
    qryRegionBusinessTaxNoLabel: TWideStringField;
    qryRegionBusinessTaxNoMask: TWideStringField;
    qryRegionBusinessTaxNoLength: TIntegerField;
    qryRegionBusinessNoLabel: TWideStringField;
    qryRegionSLName: TWideStringField;
    qryRegionDecimalPlaces: TLargeintField;
    qryTaxCodesNoTax: TERPQuery;
    dlgOpenFlagImage: TOpenDialog;
    qryTaxCodesSalesInc: TERPQuery;
    qryTaxCodesSalesEx: TERPQuery;
    qryTaxCodesPurchaseInc: TERPQuery;
    qryTaxCodesPurchaseEx: TERPQuery;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    Bevel10: TBevel;
    Bevel8: TBevel;
    Bevel3: TBevel;
    Bevel6: TBevel;
    Bevel4: TBevel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label23: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    lblFlag: TLabel;
    Label43: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    apFlag: TAdvPicture;
    edtCurrencySymbol: TwwDBEdit;
    edtWholeCurrencyName: TwwDBEdit;
    edtDecimalCurrencyName: TwwDBEdit;
    cboCurrencyFormat: TwwDBComboBox;
    cboNegativeCurrencyFormat: TwwDBComboBox;
    edtShortDateFormat: TwwDBEdit;
    edtDateSeparator: TwwDBEdit;
    edtSuburbName: TwwDBEdit;
    edtStateName: TwwDBEdit;
    edtPostCodeLength: TDBAdvEdit;
    edtPostCodeMask: TwwDBEdit;
    edtPhoneNumberLength: TDBAdvEdit;
    edtPhoneNumberMask: TwwDBEdit;
    edtMobileNumberLength: TDBAdvEdit;
    edtMobileNumberMask: TwwDBEdit;
    edtBSBName: TwwDBEdit;
    edtBusinessTaxNoLabel: TwwDBEdit;
    cboForeignExDefault: TwwDBLookupCombo;
    cboTaxCodeSalesInc: TwwDBLookupCombo;
    cboTaxCodePurchaseInc: TwwDBLookupCombo;
    cboWeekStartDay: TwwDBComboBox;
    cboTaxCodeSalesEx: TwwDBLookupCombo;
    cboSalesTaxPurchaseEx: TwwDBLookupCombo;
    cboTaxCodeNoTax: TwwDBLookupCombo;
    btnSelectFlag: TDNMSpeedButton;
    txtBusinessNoLabel: TwwDBEdit;
    edtPOSDocName: TwwDBEdit;
    wwDBSpinEdit1: TwwDBSpinEdit;
    Label42: TLabel;
    qryRegionISDCode: TIntegerField;
    edtISDCode: TwwDBEdit;
    qryRegionmsUpdateSiteCode: TWideStringField;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    qryRegionBankNumberLength: TIntegerField;
    qryRegionBankNumberMask: TWideStringField;
    edtBSBLength: TDBAdvEdit;
    edtBankAccountLength: TDBAdvEdit;
    edtBankAccountMask: TwwDBEdit;
    edtBusinessTaxNoLength: TDBAdvEdit;
    edtBSBMask: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    qryRegionCountryID: TIntegerField;
    qryCountry: TERPQuery;
    qryCountryCurrencyDesc: TWideStringField;
    qryCountryCountry: TWideStringField;
    qryCountryCountryId: TIntegerField;
    qryRegionMoneyWordsShowsDecimalCurrencyName: TWideStringField;
    optMoneyWordsShowsDecimalCurrencyName: TwwRadioGroup;
    qryRegionMoneyWordsDecimal: TWideStringField;
    Qrylanguages: TERPQuery;
    QrylanguagesID: TIntegerField;
    QrylanguagesLanguage: TWideStringField;
    qryRegionLanguageID: TIntegerField;
    DNMPanel3: TDNMPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    edtRegion: TwwDBEdit;
    edtRegionAbbrev: TwwDBEdit;
    cbocountry: TwwDBLookupCombo;
    wwDBLookupCombo1: TwwDBLookupCombo;
    btnSpelling: TDNMSpeedButton;
    Label26: TLabel;
    wwDBEdit4: TwwDBEdit;
    Bevel5: TBevel;
    qryRegionPOSDocName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure edtCurrencySymbolChange(Sender: TObject);
    procedure TaxCodeNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure qryRegionRegionAbbreviationSetText(Sender: TField;
      const Text: String);
    procedure btnSelectFlagClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure cboTaxCodeDblClick(Sender: TObject);
    procedure qryRegionCalcFields(DataSet: TDataSet);
    procedure btnSpellingClick(Sender: TObject);
    procedure qryRegionAfterOpen(DataSet: TDataSet);
  private
    fCurrentCurrencySymbol: string;
    RegionalOptions: TRegionalOptions;
    fRegion: string;
    cleanLanguageId :Integer;
    CleanSLName:String;
    function SaveData: boolean;
    procedure PopulateCurrencyFormatList;
    procedure SetDefaultValues;
    procedure LoadFlagPicture;
    procedure RefreshTaxLookups;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    property Region: string read fRegion write fRegion;
    procedure BeginTransaction; Override;
    procedure CommitTransaction; Override;
    procedure RollbackTransaction;Override;
  end;


  function DoNewRegionalOption(var aRegion: string): boolean;

implementation

uses
  DNMExceptions, FormFactory, CommonLib, BusObjConst, FastFuncs,
  frmTaxcodeFrm, AppEnvironment, MainSwitchFrm2, AppHelpProcessorObj,
  BusObjTaxCodes, CommonDbLib, LanguageTranslationObj, DNMLib,systemlib, Math,
  datSpelling;

{$R *.dfm}

function DoNewRegionalOption(var aRegion: string): boolean;
var
  form: TfmRegionalOptionEdit;
begin
  result:= false;
  form:= TfmRegionalOptionEdit.Create(nil);
  try
    form.Region:= aRegion;
    form.fbIgnoreAccessLevels:= true;
    if form.ShowModal = mrOk then begin
      result:= true;
      aRegion:= form.Region;
    end;
  finally
    form.Free;
  end;
end;


procedure TfmRegionalOptionEdit.FormCreate(Sender: TObject);
begin
  cleanLanguageId := 0;
  CleanSLName:= '';
  EnableChangeForm := False;
  inherited;
  fCurrentCurrencySymbol:= '';
  RegionalOptions:= TRegionalOptions.Create(self);
  RegionalOptions.Connection := TMyDacDataConnection.Create(RegionalOptions);
  RegionalOptions.Connection.MyDacConnection := MyConnection;
  RegionalOptions.BusObjEvent := DoBusinessObjectEvent;
  dlgOpenFlagImage.InitialDir:= SystemLib.ExeDir + 'Flags\';
end;

procedure TfmRegionalOptionEdit.FormShow(Sender: TObject);
var
  x: integer;
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;


      // Put our Database Connection into transaction mode.
      BeginTransaction;
      qryCountry.Open;
      Qrylanguages.Open;
      qryCurrency.Open;
      (*Qrylanguages.Open;*)

      if KeyID = 0 then begin
        RegionalOptions.New;
        PostDb(qryRegion);
        EditDb(qryRegion);
        SetDefaultValues;
        if fRegion <> '' then
          RegionalOptions.Region:= fRegion;
      end else begin
        RegionalOptions.Load(KeyId);
        edtRegion.ReadOnly:= true;
      end;
      qryTaxCodesNoTax.ParamByName('RegionID').AsInteger:= RegionalOptions.ID;
      qryTaxCodesSalesInc.ParamByName('RegionID').AsInteger:= RegionalOptions.ID;
      qryTaxCodesSalesEx.ParamByName('RegionID').AsInteger:= RegionalOptions.ID;
      qryTaxCodesPurchaseInc.ParamByName('RegionID').AsInteger:= RegionalOptions.ID;
      qryTaxCodesPurchaseEx.ParamByName('RegionID').AsInteger:= RegionalOptions.ID;

      RefreshTaxLookups;

      LoadFlagPicture;

      for x:= 0 to qryRegion.FieldCount -1 do
        qryRegion.Fields[x].EditMask:= '';

      wwDBSpinEdit1.Value := qryRegion.FieldByName('DecimalPlaces').AsInteger;

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

procedure TfmRegionalOptionEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  //
end;

procedure TfmRegionalOptionEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  if fsModal in FormState then
    {}
  else
    Action := caFree;
end;

procedure TfmRegionalOptionEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfmRegionalOptionEdit.actSaveExecute(Sender: TObject);
var
  currentRegionId: integer;
begin
  inherited;
  postDB(qryRegion);
  if not SaveData then Exit;
  CommitTransaction;
  currentRegionId:= AppEnv.RegionalOptions.ID;
  if currentRegionId = self.RegionalOptions.ID then begin
    { update the app environment }
    AppEnv.RegionalOptions.Closedb;
    AppEnv.RegionalOptions.Load(currentRegionId);
    if FormStillOpen('TMainSwitch2') then
      TMainSwitch2(GetComponentByClassName('TMainSwitch2')).LoadFlagImage;
  end;

  Notify;
  if fsModal in FormState then
    ModalResult:= mrOk
  else
    Close;
end;

procedure TfmRegionalOptionEdit.BeginTransaction;
begin
  inherited;
end;

procedure TfmRegionalOptionEdit.actCancelExecute(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then
    ModalResult:= mrCancel
  else
    Close;
end;

procedure TfmRegionalOptionEdit.actNewExecute(Sender: TObject);
begin
  inherited;
  if qryRegion.State in [dsInsert, dsEdit] then
    qryRegion.post;
  if RegionalOptions.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not SaveData then Exit;
          self.CommitTransaction;
          if AppEnv.RegionalOptions.ID = self.RegionalOptions.ID then
            { update the app environment }
            AppEnv.RegionalOptions.Load(AppEnv.RegionalOptions.ID);
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
  FormShow(nil);
  RegionalOptions.Dirty := false;
end;

procedure TfmRegionalOptionEdit.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TRegionalOptions then
      TRegionalOptions(Sender).DataSet:= qryRegion;
  end
end;

procedure TfmRegionalOptionEdit.edtCurrencySymbolChange(Sender: TObject);
begin
  inherited;
  if fCurrentCurrencySymbol <> RegionalOptions.CurrencySymbol then begin
    fCurrentCurrencySymbol:= RegionalOptions.CurrencySymbol;
    PopulateCurrencyFormatList;
  end;
end;

procedure TfmRegionalOptionEdit.PopulateCurrencyFormatList;
var
  cs: string;
begin
  cs:= RegionalOptions.CurrencySymbol;
  cboCurrencyFormat.Items.Clear;
  cboCurrencyFormat.Items.Add(cs + '1' + #09 + '0');
  cboCurrencyFormat.Items.Add('1' + cs + #09 + '1');
  cboCurrencyFormat.Items.Add(cs + ' 1' + #09 + '2');
  cboCurrencyFormat.Items.Add('1 ' + cs + #09 + '3');

  cboNegativeCurrencyFormat.Items.Clear;
  cboNegativeCurrencyFormat.Items.Add('('+cs+'1)' + #09 + '0');
  cboNegativeCurrencyFormat.Items.Add('-'+cs+'1' + #09 + '1');
  cboNegativeCurrencyFormat.Items.Add(cs+'-1' + #09 + '2');
  cboNegativeCurrencyFormat.Items.Add(cs+'1-' + #09 + '3');
  cboNegativeCurrencyFormat.Items.Add('(1'+cs+')' + #09 + '4');
  cboNegativeCurrencyFormat.Items.Add('-1'+cs + #09 + '5');
  cboNegativeCurrencyFormat.Items.Add('1-'+cs + #09 + '6');
  cboNegativeCurrencyFormat.Items.Add('1'+cs+'-' + #09 + '7');
  cboNegativeCurrencyFormat.Items.Add('-1 '+cs + #09 + '8');
  cboNegativeCurrencyFormat.Items.Add('-'+cs+' 1' + #09 + '9');
  cboNegativeCurrencyFormat.Items.Add('1 '+cs+'-' + #09 + '10');
  cboNegativeCurrencyFormat.Items.Add(cs+' 1-' + #09 + '11');
  cboNegativeCurrencyFormat.Items.Add(cs+' -1' + #09 + '12');
  cboNegativeCurrencyFormat.Items.Add('1- '+cs + #09 + '13');
  cboNegativeCurrencyFormat.Items.Add('('+cs+' 1)' + #09 + '14');
  cboNegativeCurrencyFormat.Items.Add('(1 '+cs+')' + #09 + '15');
end;

procedure TfmRegionalOptionEdit.TaxCodeNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
var
  NewTaxCode: string;
begin
  inherited;
  NewTaxCode:= NewValue;
  if (CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) and
      DoTaxCodeEdit(0,NewTaxCode,MyConnection,qryRegionRegionID.AsInteger) then begin
    Accept:= true;
    RefreshTaxLookups;
    TwwDbLookupCombo(Sender).Text:= NewTaxCode;
    LookupTable.Locate('Name',NewTaxCode,[]);
  end
  else
    Accept:= false;
end;


function TfmRegionalOptionEdit.SaveData: boolean;
begin
  result:= false;
  if not RegionalOptions.UpdateSLName(CleanSLName) then exit;

  if RegionalOptions.Save then begin
    result:= true;
    fRegion:= RegionalOptions.Region;
  end;
end;

procedure TfmRegionalOptionEdit.SetDefaultValues;
var
  qry: TMyQuery;
  x: integer;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= qryRegion.Connection;
    qry.SQL.Text:= 'select * from tblRegionalOptions where Region = "United Kingdom"';
    qry.Open;
    if not (qryRegion.State in [dsEdit, dsInsert]) then
      qryRegion.Edit;
    for x:= 0 to qry.FieldCount -1 do begin
      if not ((qry.Fields[x].FieldName = 'Region') or
              (qry.Fields[x].FieldName = 'RegionAbbreviation') or
              (qry.Fields[x].FieldName = 'RegionID') or
              (qry.Fields[x].FieldName = 'GlobalRef') or
              (qry.Fields[x].FieldName = 'msTimeStamp') or
              (qry.Fields[x].FieldName = 'TaxCodeSalesInc') or
              (qry.Fields[x].FieldName = 'TaxCodeSalesEx') or
              (qry.Fields[x].FieldName = 'TaxCodePurchaseInc') or
              (qry.Fields[x].FieldName = 'TaxCodePurchaseEx') or
              (qry.Fields[x].FieldName = 'TaxCodeNoTax') or
              (qry.Fields[x].FieldName = 'ForeignExDefault')) then
        qryRegion.FieldByName(qry.Fields[x].FieldName).Value:=
          qry.FieldByName(qry.Fields[x].FieldName).Value
    end;


  finally
    qry.Free;
  end;
end;

procedure TfmRegionalOptionEdit.qryRegionAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cleanLanguageId := qryRegionLanguageID.AsInteger;
  CleanSLName := QryregionSLname.asString;
end;

procedure TfmRegionalOptionEdit.qryRegionCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryRegionMoneyWordsDecimal.asString :=floattostr(Math.IntPower(10,qryRegionDecimalPlaces.asInteger));
  optMoneyWordsShowsDecimalCurrencyName.items[0] := replicateStr('*' ,qryRegionDecimalPlaces.asInteger )+' ' +qryRegionDecimalCurrencyName.asString;
  optMoneyWordsShowsDecimalCurrencyName.items[1] := replicateStr('*' ,qryRegionDecimalPlaces.asInteger )+ '/' + qryRegionMoneyWordsDecimal.asString;
end;

procedure TfmRegionalOptionEdit.qryRegionRegionAbbreviationSetText(
  Sender: TField; const Text: String);
begin
  inherited;
  Sender.AsString:= Uppercase(Text);
end;

procedure TfmRegionalOptionEdit.btnSelectFlagClick(Sender: TObject);
begin
  inherited;
  if dlgOpenFlagImage.Execute then begin
    if not (qryRegion.State in [dsInsert, dsEdit]) then
      qryRegion.Edit;
    qryRegionFlagImage.LoadFromFile(dlgOpenFlagImage.FileName);
    LoadFlagPicture;
  end;
end;

procedure TfmRegionalOptionEdit.btnSpellingClick(Sender: TObject);
begin
  inherited;
  Spelling.AddictSpell.Setup;
end;

procedure TfmRegionalOptionEdit.LoadFlagPicture;
var
  ms: TMemoryStream;
begin
  ms:= TMemoryStream.Create;
  try
    apFlag.Picture:= nil;
    qryRegionFlagImage.SaveToStream(ms);
    if ms.Size > 0 then begin
      apFlag.Picture.LoadFromStream(ms);
      lblFlag.Visible:= false;
    end
    else
      lblFlag.Visible:= true;
  finally
    ms.Free;
  end;
end;

procedure TfmRegionalOptionEdit.btnHelpClick(Sender: TObject);
begin
  inherited;
  AppHelpProcessor.ShowHelp(self.HelpContext);
end;

procedure TfmRegionalOptionEdit.RefreshTaxLookups;
var
  curr: string;
begin
  curr:= cboTaxCodeNoTax.Text;
  qryTaxCodesNoTax.Close;
  qryTaxCodesNoTax.Open;
  cboTaxCodeNoTax.Text:= curr;
  if curr <> '' then qryTaxCodesNoTax.Locate('Name',curr,[]);

  curr:= cboTaxCodeSalesInc.Text;
  qryTaxCodesSalesInc.Close;
  qryTaxCodesSalesInc.Open;
  cboTaxCodeSalesInc.Text:= curr;
  if curr <> '' then qryTaxCodesSalesInc.Locate('Name',curr,[]);

  curr:= cboTaxCodeSalesEx.Text;
  qryTaxCodesSalesEx.Close;
  qryTaxCodesSalesEx.Open;
  cboTaxCodeSalesEx.Text:= curr;
  if curr <> '' then qryTaxCodesSalesEx.Locate('Name',curr,[]);

  curr:= cboTaxCodePurchaseInc.Text;
  qryTaxCodesPurchaseInc.Close;
  qryTaxCodesPurchaseInc.Open;
  cboTaxCodePurchaseInc.Text:= curr;
  if curr <> '' then qryTaxCodesPurchaseInc.Locate('Name',curr,[]);

  curr:= cboSalesTaxPurchaseEx.Text;
  qryTaxCodesPurchaseEx.Close;
  qryTaxCodesPurchaseEx.Open;
  cboSalesTaxPurchaseEx.Text:= curr;
  if curr <> '' then qryTaxCodesPurchaseEx.Locate('Name',curr,[]);
end;

procedure TfmRegionalOptionEdit.RollbackTransaction;
begin
  inherited;
end;

procedure TfmRegionalOptionEdit.cboTaxCodeDblClick(Sender: TObject);
var
  code: string;
begin
  inherited;
  code:= TwwDBLookupCombo(Sender).Text;
  if DoTaxCodeEdit(TTaxCode.IdForCode(code,qryRegionRegionID.AsInteger,MyConnection),code,MyConnection,qryRegionRegionID.AsInteger) then
    RefreshTaxLookups;
end;

procedure TfmRegionalOptionEdit.CommitTransaction;
begin
  inherited;
  if qryRegionRegionID.AsInteger = Appenv.RegionalOptions.ID then
    if TLanguageTranslationObj.Inst.UserLanguageID = cleanLanguageId then
      TLanguageTranslationObj.Inst.UserLanguageID := qryRegionLanguageID.AsInteger;
end;

initialization

  RegisterClassOnce(TfmRegionalOptionEdit);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmRegionalOptionEdit, 'TfmRegionalOptionList_*=RegionId');
  end;


end.

