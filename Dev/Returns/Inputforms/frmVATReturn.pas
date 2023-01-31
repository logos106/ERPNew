unit frmVATReturn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ReturnsBase, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ComCtrls, StdCtrls, wwcheckbox, DNMSpeedButton, ExtCtrls , BusObjVatReturns,
  DNMPanel, DBCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwclearbuttongroup,
  BusObjBase, wwradiogroup , VATObj, wwdbdatetimepicker,
  ProgressDialog, wwdblook, utGovUK_API, VATObligationObj;

type
  TfmVATReturn = class(TReturnsBaseGUI)
    QryReturnsGlobalRef: TWideStringField;
    QryReturnsID: TIntegerField;
    QryReturnsVATDesc: TWideStringField;
    QryReturnsType: TWideStringField;
    QryReturnsMonth: TWideStringField;
    QryReturnsYear: TIntegerField;
    QryReturnsAccMethod: TWideStringField;
    QryReturnsAllClass: TWideStringField;
    QryReturnsClassID: TIntegerField;
    QryReturnsVAT1: TFloatField;
    QryReturnsVAT1Selected: TWideStringField;
    QryReturnsVAT2: TFloatField;
    QryReturnsVAT2Selected: TWideStringField;
    QryReturnsVAT3: TFloatField;
    QryReturnsVAT3Selected: TWideStringField;
    QryReturnsVAT4: TFloatField;
    QryReturnsVAT4Selected: TWideStringField;
    QryReturnsVAT5: TFloatField;
    QryReturnsVAT5Selected: TWideStringField;
    QryReturnsVAT6: TFloatField;
    QryReturnsVAT6Selected: TWideStringField;
    QryReturnsVAT7: TFloatField;
    QryReturnsVAT7Selected: TWideStringField;
    QryReturnsVAT8: TFloatField;
    QryReturnsVAT8Selected: TWideStringField;
    QryReturnsVAT9: TFloatField;
    QryReturnsVAT9Selected: TWideStringField;
    QryReturnsActive: TWideStringField;
    QryReturnsmsTimeStamp: TDateTimeField;
    QryReturnsmsUpdateSiteCode: TWideStringField;
    QryReturnLinesID: TIntegerField;
    QryReturnLinesGlobalref: TWideStringField;
    QryReturnLinesVATID: TIntegerField;
    QryReturnLinesTransGlobalref: TWideStringField;
    QryReturnLinesTranstype: TWideStringField;
    QryReturnLinesTransSeqno: TFloatField;
    QryReturnLinesVATCode: TWideStringField;
    QryReturnLinesAmount: TFloatField;
    QryReturnLinesmstimeStamp: TDateTimeField;
    tabVat: TTabSheet;
    DNMPanel1: TDNMPanel;
    Panel2: TPanel;
    YearLabel: TLabel;
    MonthLabel: TLabel;
    Period: TwwRadioGroup;
    Month: TwwDBComboBox;
    Year: TwwDBComboBox;
    btnElectronic: TDNMSpeedButton;
    Label1: TLabel;
    Button2: TDNMSpeedButton;
    VAT1: TDBEdit;
    Label2: TLabel;
    DNMSpeedButton1: TDNMSpeedButton;
    VAT2: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    VAT3: TDBEdit;
    Label6: TLabel;
    DNMSpeedButton2: TDNMSpeedButton;
    VAT4: TDBEdit;
    Label7: TLabel;
    Label3: TLabel;
    VAT5: TDBEdit;
    Label8: TLabel;
    DNMSpeedButton3: TDNMSpeedButton;
    VAT6: TDBEdit;
    Label9: TLabel;
    DNMSpeedButton4: TDNMSpeedButton;
    VAT7: TDBEdit;
    Label10: TLabel;
    DNMSpeedButton5: TDNMSpeedButton;
    VAT8: TDBEdit;
    Label11: TLabel;
    DNMSpeedButton6: TDNMSpeedButton;
    VAT9: TDBEdit;
    Bevel1: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    lblMethod: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    dtPeriodEnding: TwwDBDateTimePicker;
    Label22: TLabel;
    pnlVAT_LastPeriod: TDNMPanel;
    Label23: TLabel;
    Label24: TLabel;
    dtVAT_from: TwwDBDateTimePicker;
    dtVAT_To: TwwDBDateTimePicker;
    QryReturnsDone: TWideStringField;
    QryReturnLinesTransDate: TDateField;
    QryReturnsSummarisedTransDate: TDateField;
    QryReturnsSubmitted: TWideStringField;
    chkSubmitted: TwwCheckBox;
    cboPeriodKey: TwwDBLookupCombo;
    Label25: TLabel;
    qryPeriodKeyLookup: TERPQuery;
    btnGetObligations: TDNMSpeedButton;
    QryReturnsObligationID: TIntegerField;
    qryPeriodKeyLookupGlobalRef: TWideStringField;
    qryPeriodKeyLookupID: TIntegerField;
    qryPeriodKeyLookupPeriodKey: TWideStringField;
    qryPeriodKeyLookupStart: TDateField;
    qryPeriodKeyLookupEnd: TDateField;
    qryPeriodKeyLookupDue: TDateField;
    qryPeriodKeyLookupReceived: TDateField;
    qryPeriodKeyLookupStatus: TWideStringField;
    qryPeriodKeyLookupActive: TWideStringField;
    qryPeriodKeyLookupmsTimeStamp: TDateTimeField;
    qryPeriodKeyLookupmsUpdateSiteCode: TWideStringField;
    qryPeriodKeyLookupPeriod: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnElectronicClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure VAT1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure DNMSpeedButton4Click(Sender: TObject);
    procedure DNMSpeedButton5Click(Sender: TObject);
    procedure DNMSpeedButton6Click(Sender: TObject);
    procedure PeriodChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TaxDblClick(Sender: TObject);Override;
    procedure AccDblClick(Sender: TObject);Override;
    procedure wwCheckBox2Click(Sender: TObject);
    procedure btnGetObligationsClick(Sender: TObject);
  private
    VAT: TVATObj;
    fbNoCashBasis :Boolean;
    GovUKAPI: TGovUK_API;
    Obligation: TVATObligation;
    function GetMonthEnding: string;
    function MonthNameToNumber(const Month: string): integer;
    procedure APISubmit;
    procedure DoAPISubmit;
  Protected
    Function Save:boolean;override;
    procedure RefreshAll;Override;
    procedure Quarterly(const Box: TwwDBComboBox);Override;
    procedure RefreshTypeValues;Override;
    procedure Silent_OpenTaxSelect(const Box: TDBEdit; const Tab: integer);Override;
    procedure OpenTaxSelect(const Box: TDBEdit; const Tab: integer);Override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType,      Value: string);Override;
    procedure PeriodForAutoPopulatehistory;Override;
    function GetReportTypeID: integer; Override;
    function HighestReturnDate: TDatetime;Override;
  public
    VATReturn: TVATReturns;
    Property NoCashBasis: boolean read fbNoCashBasis;
    procedure PrepareCashBasis;Override;

  end;


implementation

uses CommonLib , AppEnvironment, VATSelectionPopup , tcDataUtils,
  frmVATElectronicFrm, DNMLib, TransAccountDetailsForm, CashBasisDetails,
  CommonDbLib, CashBasis, tcTypes , dateutils, ReturnObj, tcConst,
  BusObjConst, BusobjReturns, FormFactory, CommonFormLib, JsonObject;

{$R *.dfm}
procedure TfmVATReturn.RefreshTypeValues;
var
  VATSelectionGUI: TComponent;
  comp: TComponent;
begin
  if screen.activecontrol = btnClose then exit;
  try
    if not FormStillOpen('TVATSelectionGUI') then begin
      VATSelectionGUI := GetComponentByClassName('TVATSelectionGUI');
      with TVATSelectionGUI(VATSelectionGUI) do begin
        VAT.AccountingMethod := VATReturn.AccMethod;
        VAT.All := VATReturn.AllClass;
        VAT.Department := tcDatautils.GetClassName(VATReturn.ClassID);
        VAT.RefreshCalcFields;
      end;
    end else begin
      VATSelectionGUI := FindExistingComponent('TVATSelectionGUI');
      TVATSelectionGUI(VATSelectionGUI).VAT.RefreshCalcFields;
    end;
  except
    if FormStillOpen('TVATSelectionGUI') then begin
      CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
      comp:= FindExistingComponent('TVATSelectionGUI');
      if Assigned(comp) then
        TForm(comp).Close;
    end;
  end;
end;
procedure TfmVATReturn.Quarterly(const Box: TwwDBComboBox);
begin
  inherited;
end;
procedure TfmVATReturn.btnElectronicClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;

  if AppEnv.CompanyPrefs.HMRC_APIConfig.Active then begin
    APISubmit;
    exit;
  end;

  Form := GetComponentByClassName('TfrmVATElectronic');
  if Assigned(Form) then begin
    with TfrmVATElectronic(Form) do begin
      Position  := poScreenCenter;
      FormStyle := fsNormal;
      VatReturnID := Self.KeyID;
      TfrmVATElectronic(Form).Year := StrToInt(Self.Year.Text);
      TfrmVATElectronic(Form).Month := GetMonthEnding;
      ShowModal;
    end;
  end;
end;

procedure TfmVATReturn.btnGetObligationsClick(Sender: TObject);
begin
  inherited;
  if Obligation.CheckObligations then begin
    qryPeriodKeyLookup.Close;
    qryPeriodKeyLookup.Open;
  end;
end;

procedure TfmVATReturn.btnPrintClick(Sender: TObject);
begin
  ReportToPrint := 'VAT Report';
  inherited;
end;

procedure TfmVATReturn.Button2Click(Sender: TObject);begin  OpenTaxSelect(VAT1,5);end;
procedure TfmVATReturn.DNMSpeedButton1Click(Sender: TObject);begin  OpenTaxSelect(VAT2,5);end;
procedure TfmVATReturn.DNMSpeedButton2Click(Sender: TObject);begin  OpenTaxSelect(VAT4,5);end;
procedure TfmVATReturn.DNMSpeedButton3Click(Sender: TObject);begin  OpenTaxSelect(VAT6,5);end;
procedure TfmVATReturn.DNMSpeedButton4Click(Sender: TObject);begin  OpenTaxSelect(VAT7,5);end;
procedure TfmVATReturn.DNMSpeedButton5Click(Sender: TObject);begin  OpenTaxSelect(VAT8,5);end;
procedure TfmVATReturn.DNMSpeedButton6Click(Sender: TObject);begin  OpenTaxSelect(VAT9,5);end;
procedure TfmVATReturn.PeriodForAutoPopulatehistory;
var
dtFrom , dtTo:TDatetime;
  stype:String;
begin
  inherited;
  VATReturn.LastReturn(dtFrom, dtTo , stype, tRPVAT);
  VATReturn.VATtype  := stype;
  VATReturn.month    := VATReturn.MonthNumberToName(monthof(dtFrom));
  VATReturn.year     := YearOf(dtFrom);
  VATReturn.Description := 'Summary ';
end;

procedure TfmVATReturn.APISubmit;
var
  msg: string;
  RequiresRefresh: boolean;
begin
  if VATReturn.Submitted then begin
    CommonLib.MessageDlgXP_Vista('This Return has already been submitted.', mtInformation,[mbOk],0);
    exit;
  end;
  if not VATReturn.Active then begin
    CommonLib.MessageDlgXP_Vista('Can not submit an inactive return.', mtInformation,[mbOk],0);
    exit;
  end;
  if VATReturn.ObligationID < 1 then begin
    CommonLib.MessageDlgXP_Vista('Please select an Obligation Period for this return.', mtInformation,[mbOk],0);
    exit;
  end;

  if not AppEnv.CompanyPrefs.HMRC_APIConfig.Validate(msg) then begin
    CommonLib.MessageDlgXP_Vista(msg, mtInformation,[mbOk],0);
    exit;
  end;

  if not VATReturn.Save then
    exit;

  self.showProgressbar('Processing VAT Return',2);
  self.stepProgressbar('Checking validation');

  GovUKAPI.SandboxClientID := AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientID;
  GovUKAPI.SandboxClientSecret := AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientSecret;
  GovUKAPI.ProductionClientID := AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientID;
  GovUKAPI.ProductionClientSecret := AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientSecret;
  GovUKAPI.VATRegistrationNumber := AppEnv.CompanyPrefs.HMRC_APIConfig.VATRegistrationNumber;

  GovUKAPI.SandboxMode := AppEnv.CompanyPrefs.HMRC_APIConfig.TestMode;
  GovUKAPI.AuthSuccessMessage := 'Click on "Submit" to submit this VAT return.';
  if GovUKAPI.CheckToken(Scope_VAT,RequiresRefresh) then begin
    if RequiresRefresh then begin
      self.HideProgressbar;
      if CommonLib.MessageDlgXP_Vista('User validation required, continue?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        GovUKAPI.RefreshToken(Scope_VAT);
        exit;
      end
      else begin
        exit;
      end;
    end;

  end
  else begin
    self.HideProgressbar;
    CommonLib.MessageDlgXP_Vista(GovUKAPI.ErrorList.FormattedErrors, mtInformation,[mbOk],0);
    self.HideProgressbar;
    exit;
  end;
  if CommonLib.MessageDlgXP_Vista(
    'When you submit this VAT information you are making a legal declaration ' +
    'that the information is true and complete. ' +
    'A false declaration can result in prosecution.' +#13#10 + #13#10 +
    'Continue with submission?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then begin
    self.HideProgressbar;
    exit;
  end;

  DoApiSubmit;

end;

procedure TfmVATReturn.DoAPISubmit;
var
  obj, res: TJsonObject;
  ScopeRequiringRefresh: string;
begin
  self.stepProgressbar('Submitting VAT');
  try
    obj := JO;
    res := JO;
    try
      obj.S['periodKey'] := VATReturn.PeriodKey;
      obj.F['vatDueSales'] := VATReturn.VAT1;
      obj.F['vatDueAcquisitions'] := VATReturn.VAT2;
      obj.F['totalVatDue'] := VATReturn.VAT3;
      obj.F['vatReclaimedCurrPeriod'] := VATReturn.VAT4;
      obj.F['netVatDue'] := VATReturn.VAT5;
      obj.F['totalValueSalesExVAT'] := VATReturn.VAT6;
      obj.F['totalValuePurchasesExVAT'] := VATReturn.VAT7;
      obj.F['totalValueGoodsSuppliedExVAT'] := VATReturn.VAT8;
      obj.F['totalAcquisitionsExVAT'] := VATReturn.VAT9;
      obj.B['finalised'] := true;

      if GovUKAPI.SubmitVATReturn(obj, res, ScopeRequiringRefresh) then begin
        if ScopeRequiringRefresh <> '' then begin
          self.HideProgressbar;
          CommonLib.MessageDlgXP_Vista('User validation needs refreshing.',mtInformation,[mbOk],0);
        end
        else begin
          { All good }
          VATReturn.Done := true;
          VATReturn.Submitted := true;
          VATReturn.PostDb;
          self.CommitTransaction;
          self.BeginTransaction;
          self.HideProgressbar;
          if Accesslevel <5 then
            if Return.done then begin
              Accesslevel := 5;
              Self.Caption := Formname +' Return : Done';
            end;
          CommonLib.MessageDlgXP_Vista('VAT Submision Complete.',mtInformation,[mbOk],0);
        end;
      end
      else begin
        self.HideProgressbar;
        CommonLib.MessageDlgXP_Vista(GovUKAPI.ErrorList.FormattedErrors,mtInformation,[mbOk],0);
      end;
    finally
      obj.Free;
      res.Free;
    end;
  except
    on e: exception do begin
      self.HideProgressbar;
      CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOk],0);
    end;
  end;
end;

procedure TfmVATReturn.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
var
  dtFrom , dtTo:TDatetime;
  stype:String;
begin
  inherited;
  if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_IDChange) then begin
    VATReturn.LastReturn(dtFrom, dtTo , stype, tRPVAT);
    pnlVAT_LastPeriod.visible := dtFrom <> 0;
    dtVAT_from.Date := dtFrom;
    dtVAT_to.Date := dtTo;
  end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_DateRangeChange) then begin
    if fbFormshown then begin
      OnchangePeriod(MonthLabel ,Month , Period  );
      if VATREturn.VAT_To <> 0 then dtPeriodEnding.Date := VATREturn.VAT_To;
      if (VATREturn.Description = '') and (VATREturn.Month <> '') and (VATREturn.year<> 0) then VATREturn.Description := VATREturn.Vattype +' From ' + VATREturn.Month +' ' + inttostr(VATREturn.year);
    end;
  end;
end;

procedure TfmVATReturn.FormCreate(Sender: TObject);
begin
  VAT := TVATObj.Create;
  objReturn := VAT;
  inherited;
  VATReturn := TVATReturns.Create(Self);
  VATReturn.Connection := TMydacdataconnection.Create(VATReturn);
  VATReturn.Connection.connection := Self.Myconnection;
  VATReturn.BusObjEvent := DoBusinessObjectEvent;
  Return := VATReturn;
  VAT.ReturnsObj := Return;
  fbNoCashBasis := False;
  GovUKAPI := TGovUK_API.Inst;
  GovUKAPI.AuthSuccessMessage := 'Click on "Submit" to submit this VAT return.';
  Obligation := TVATObligation.Create;
  Obligation.API := GovUKAPI;
  Obligation.AuthSuccessMessage := 'Click on "Get Obligations" to dowmload latest Obligation data.'
end;

procedure TfmVATReturn.FormDestroy(Sender: TObject);
begin
  FreeandNil(VAT);
  objReturn := nil;
  FreeandNil(VATReturn);
  Return := nil;
  Obligation.Free;
  inherited;
end;

procedure TfmVATReturn.Silent_OpenTaxSelect(const Box: TDBEdit; const Tab: integer);
begin
    VAT.From := Box;
    VAT.FromName := Box.Name;
    VAT.ObjType := ftTax;
    VAT.AccountingMethod := Self.VATReturn.AccMethod;
    VAT.All := Self.VATReturn.AllClass;
    VAT.Department := GetClassName(Self.VATReturn.ClassID);
    VAT.Initialize;
    VAT.FromDate := VATReturn.VAT_From;//Self.FromDate(Month.Text, Year.Text);
    VAT.ToDate := VATReturn.VAT_To;//Self.ToDate(Period.Value, Month.Text, Year.Text);
    VAT.Calc;
end;

procedure TfmVATReturn.TaxDblClick(Sender: TObject);
begin
    //inherited;
  if  not(Sender is TDBEdit) then exit;
  //if accesslevel = 5 then exit;
  SelectedCode :=TDBEdit(Sender).Name;
  if accesslevel <> 5 then
      if not(Savencommit) then exit;
  OpenErpListform('TVATTransReturnListGUI' , beforeOpenDetails);
end;

procedure TfmVATReturn.AccDblClick(Sender: TObject);
begin
  //inherited;
  if Devmode then
    MessageDlgXP_Vista('This should be TaxDblclick not AccdblClick', mtWarning, [mbOK], 0);

end;

procedure TfmVATReturn.OpenTaxSelect(const Box: TDBEdit; const Tab: integer);
begin
  //if AccessLevel >= 5 then exit;

  if not FormStillOpen('TVATSelectionGUI') then begin
    GetComponentByClassName('TVATSelectionGUI');
  end;

  try
    with TVATSelectionGUI(FindExistingComponent('TVATSelectionGUI')) do begin
      VAT.From     := Box;
      VAT.FromName := Box.Name;
      VAT.ObjType := ftTax;
      VAT.FromDate := VATReturn.VAT_From;//Self.FromDate(Month.Text, Year.Text);
      VAT.ToDate := VATReturn.VAT_To;//Self.ToDate(Period.Value, Month.Text, Year.Text);
      VAT.AccountingMethod := Self.VATReturn.AccMethod;
      VAT.Ownerform := Self;
      VAT.All := Self.VATReturn.AllClass;
      VAT.ReturnsObj := Return;
      VAT.Department := GetClassName(Self.VATReturn.ClassID);
      Accesslevel := Self.Accesslevel;
      FormStyle := fsMDIChild;
     end;
  except
    CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
    TVATSelectionGUI(FindExistingComponent('TVATSelectionGUI')).Close;
  end;
end;

procedure TfmVATReturn.PeriodChange(Sender: TObject);
begin
  inherited;
  if not fbFormshown then exit;
  if vatreturn = nil then exit;
  VATREturn.VATType :=Period.Value;
  if VATREturn.Month <> '' then if  Month.Items.Indexof(VATREturn.Month) <0 then VATREturn.NextReturn(TRPVAT , False);
end;

procedure TfmVATReturn.PrepareCashBasis;
begin
  if   (AccessLevel =5) then Exit;
  //Cash Basis Prepare
  If CashBasis.IsCashBasisTransSummarised(Self,FromDate(Month.Text, Year.Text),
    ToDate(Period.Value, Month.Text, Year.Text)) then Begin
    fbNoCashBasis := True;
    Exit;
  end;
  CashBasis.PrepareCashBasisDetails(0,0, 'VAT');
  //CashBasis.PrepareCashBasisDetails(0,0, 'VAT', true);
end;

procedure TfmVATReturn.RefreshAll;
begin
  showProgressbar(WAITMSG , 7);
  try
    Silent_OpenTaxSelect(VAT1,5);stepProgressbar;
    Silent_OpenTaxSelect(VAT2,5);stepProgressbar;
    Silent_OpenTaxSelect(VAT4,5);stepProgressbar;
    Silent_OpenTaxSelect(VAT6,5);stepProgressbar;
    Silent_OpenTaxSelect(VAT7,5);stepProgressbar;
    Silent_OpenTaxSelect(VAT8,5);stepProgressbar;
    Silent_OpenTaxSelect(VAT9,5);stepProgressbar;
    Application.ProcessMessages;
    inherited;
  finally
    HideProgressbar;
  end;
end;

function TfmVATReturn.Save: boolean;
var
  Form:Tcomponent;
begin
  REsult := inherited Save;
  if not result then exit;
  try
    if (AppEnv.RegionalOptions.RegionType = rUK) and (AppEnv.CompanyPrefs.UseElectronicVAT) then
      if CommonLib.MessageDlgXP_Vista('Do you wish to use electronic submission?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
        Form := GetComponentByClassName('TfrmVATElectronic');
        if Assigned(Form) then
          with TfrmVATElectronic(Form) do begin
            Position  := poScreenCenter;
            FormStyle := fsNormal;
            VatReturnID := Self.KeyID;
            TfrmVATElectronic(Form).Year := StrToInt(Self.Year.Text);
            TfrmVATElectronic(Form).Month := GetMonthEnding;
            ShowModal;
          end;
      end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TfmVATReturn.VAT1Change(Sender: TObject);
begin
  inherited;
  RefreshTypeValues;
end;

procedure TfmVATReturn.wwCheckBox2Click(Sender: TObject);
begin
  if not TwwCheckBox(Sender).Focused then exit;

  if AppEnv.CompanyPrefs.HMRC_APIConfig.Active then begin
    if not VatReturn.Submitted then begin
      if TwwCheckBox(Sender).Checked then begin
        TwwCheckBox(Sender).Checked := false;
        VatReturn.Done := false;
        CommonLib.MessageDlgXP_Vista(
          'HMRC API (VAT Submission) is enabled in Accounts Preferences so this VAT Return can not be ticked as Done until it is Submitted', mtInformation, [mbOk],0);
        exit;
      end;
    end;
  end;
  inherited;

end;

procedure TfmVATReturn.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if VATREturn.VAT_To <> 0 then dtPeriodEnding.Date := VATREturn.VAT_To;

      btnElectronic.Enabled := AppEnv.CompanyPrefs.UseElectronicVAT or AppEnv.CompanyPrefs.HMRC_APIConfig.Active;

      if (VATReturn.AccMethod = 'Cash') then begin
        PrepareCashBasis;
        lblMethod.caption := 'Accounting Method : Cash';
      end else begin
        lblMethod.caption := 'Accounting Method : Non-Cash (Accruals)';
      end;
      qryPeriodKeyLookup.Close;
      qryPeriodKeyLookup.ParamByName('VATReturnID').AsInteger := VATReturn.ID;
      qryPeriodKeyLookup.Open;
      if (KeyId <> 0) then begin
        if (Accesslevel<5) then
          if Check4closingdate(VATREturn.VAT_from , VATReturn.VAT_To)  then
            Self.Caption := FormName +' Return - Date Range Selected ' +
                ' (' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,VATREturn.VAT_from  )) +
                ' to ' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,VATREturn.VAT_to  )) +') is Prior to Closing Date' ;
//        if VatReturn.ObligationID > 0 then
//          cboPeriodKey.LookupTable.Locate('ID',VatReturn.ObligationID, []);
      end;
    except
      on EAbort do HandleEAbortException;
      else raise;;
    end;
    AutoPopulateForHistory;
    CheckforSummary;
  finally
    EnableForm;
  end;
end;
function TfmVATReturn.GetMonthEnding:string;
var
  iMonth:integer;
begin
  Result := '';
  iMonth := MonthNameToNumber(VatReturn.month);
  if Period.ItemIndex = 0 then iMonth := iMonth + 2;
  Result := GetMonthName(iMonth);
end;
function TfmVATReturn.GetReportTypeID: integer;
begin
  REsult := 103;
end;

function TfmVATReturn.HighestReturnDate: TDatetime;
begin
  result:=0;
  if result < dtPeriodEnding.DateTime then result := dtPeriodEnding.DateTime;
end;

function TfmVATReturn.MonthNameToNumber(const Month: string): integer;
begin
  if Month = 'January' then begin
    Result := 1;
  end else if Month = 'February' then begin
    Result := 2;
  end else if Month = 'March' then begin
    Result := 3;
  end else if Month = 'April' then begin
    Result := 4;
  end else if Month = 'May' then begin
    Result := 5;
  end else if Month = 'June' then begin
    Result := 6;
  end else if Month = 'July' then begin
    Result := 7;
  end else if Month = 'August' then begin
    Result := 8;
  end else if Month = 'September' then begin
    Result := 9;
  end else if Month = 'October' then begin
    Result := 10;
  end else if Month = 'November' then begin
    Result := 11;
  end else if Month = 'December' then begin
    Result := 12;
  end else begin
    Result := 0;
  end;
end;

initialization
  RegisterClassOnce(TfmVATReturn);
  FormFact.RegisterMe(TfmVATReturn, 'TVATReturnListGUI_*=ID');
  FormFact.RegisterMe(TfmVATReturn, 'TVATTransReturnListGUI_*=ID');

end.

