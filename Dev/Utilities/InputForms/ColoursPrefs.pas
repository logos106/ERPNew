unit ColoursPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, DNMSpeedButton, Mask,
  wwdbedit, DB, kbmMemTable, DataSourcePrefs, DBAccess, MyAccess,ERPdbComponents, DBCtrls,
  wwclearbuttongroup, wwradiogroup, wwdblook, MemDS, Wwdotdot, Wwdbcomb,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, MessageConst, AdvGlowButton,
  AdvOfficeSelectors, AdvTrackBar, asgcombo, ColorCombo, AdvSelectors, BasePrefs,
  tcTypes, frmBase, Menus, AdvScrollBox;

type
  TColourPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    qryPersonalPreferences: TERPQuery;
    dsPersonalPreferences: TDataSource;
    qryImageSchemesLookup: TERPQuery;
    pnlColours: TDNMPanel;
    pnlGeneral: TDNMPanel;
    lblGeneral: TLabel;
    GeneralColorSelector: TAdvOfficeColorSelector;
    GeneralGradIntensity: TAdvTrackBar;
    GeneralReset: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    Label3: TLabel;
    AccountsColorSelector: TAdvOfficeColorSelector;
    AccountsGradIntensity: TAdvTrackBar;
    AccountsReset: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    Label4: TLabel;
    AppointmentsColorSelector: TAdvOfficeColorSelector;
    AppointmentsGradIntensity: TAdvTrackBar;
    AppointmentsReset: TDNMSpeedButton;
    DNMPanel4: TDNMPanel;
    Label5: TLabel;
    CRMColorSelector: TAdvOfficeColorSelector;
    CRMGradIntensity: TAdvTrackBar;
    CRMReset: TDNMSpeedButton;
    DNMPanel5: TDNMPanel;
    Label6: TLabel;
    EmployeeColorSelector: TAdvOfficeColorSelector;
    EmployeeGradIntensity: TAdvTrackBar;
    EmployeeReset: TDNMSpeedButton;
    DNMPanel6: TDNMPanel;
    Label7: TLabel;
    FixedAssetsColorSelector: TAdvOfficeColorSelector;
    FixedAssetsGradIntensity: TAdvTrackBar;
    FixedAssetsReset: TDNMSpeedButton;
    DNMPanel7: TDNMPanel;
    Label8: TLabel;
    PurchasesColorSelector: TAdvOfficeColorSelector;
    PurchasesGradIntensity: TAdvTrackBar;
    PurchasesReset: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    Label9: TLabel;
    InventoryColorSelector: TAdvOfficeColorSelector;
    InventoryGradIntensity: TAdvTrackBar;
    InventoryReset: TDNMSpeedButton;
    DNMPanel8: TDNMPanel;
    Label11: TLabel;
    ManufacturingColorSelector: TAdvOfficeColorSelector;
    ManufacturingGradIntensity: TAdvTrackBar;
    ManufacturingReset: TDNMSpeedButton;
    DNMPanel10: TDNMPanel;
    Label12: TLabel;
    MiscellaneousColorSelector: TAdvOfficeColorSelector;
    MiscellaneousGradIntensity: TAdvTrackBar;
    MiscellaneousReset: TDNMSpeedButton;
    DNMPanel11: TDNMPanel;
    Label13: TLabel;
    PayrollColorSelector: TAdvOfficeColorSelector;
    PayrollGradIntensity: TAdvTrackBar;
    PayrollReset: TDNMSpeedButton;
    DNMPanel12: TDNMPanel;
    Label14: TLabel;
    ReturnsColorSelector: TAdvOfficeColorSelector;
    ReturnsGradIntensity: TAdvTrackBar;
    ReturnsReset: TDNMSpeedButton;
    DNMPanel13: TDNMPanel;
    Label15: TLabel;
    SalesColorSelector: TAdvOfficeColorSelector;
    SalesGradIntensity: TAdvTrackBar;
    SalesReset: TDNMSpeedButton;
    DNMPanel14: TDNMPanel;
    Label18: TLabel;
    SalesOrderColorSelector: TAdvOfficeColorSelector;
    SalesOrderGradIntensity: TAdvTrackBar;
    SalesOrderReset: TDNMSpeedButton;
    DNMPanel17: TDNMPanel;
    Label19: TLabel;
    UtilitiesColorSelector: TAdvOfficeColorSelector;
    UtilitiesGradIntensity: TAdvTrackBar;
    UtilitiesReset: TDNMSpeedButton;
    pnlTraining: TDNMPanel;
    Label16: TLabel;
    TrainingColorSelector: TAdvOfficeColorSelector;
    TrainingGradIntensity: TAdvTrackBar;
    TrainingReset: TDNMSpeedButton;
    DNMPanel15: TDNMPanel;
    lable33: TLabel;
    bankingColorSelector: TAdvOfficeColorSelector;
    bankingGradIntensity: TAdvTrackBar;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMPanel16: TDNMPanel;
    Label17: TLabel;
    DeliveryColorSelector: TAdvOfficeColorSelector;
    DeliveryGradIntensity: TAdvTrackBar;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMPanel18: TDNMPanel;
    Label20: TLabel;
    PaymentsColorSelector: TAdvOfficeColorSelector;
    PaymentsGradIntensity: TAdvTrackBar;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMPanel20: TDNMPanel;
    Label21: TLabel;
    POSColorSelector: TAdvOfficeColorSelector;
    POSGradIntensity: TAdvTrackBar;
    DNMSpeedButton4: TDNMSpeedButton;
    DNMPanel21: TDNMPanel;
    Label22: TLabel;
    RepairsColorSelector: TAdvOfficeColorSelector;
    RepairsGradIntensity: TAdvTrackBar;
    DNMSpeedButton5: TDNMSpeedButton;
    btnExport: TDNMSpeedButton;
    DNMPanel22: TDNMPanel;
    Label23: TLabel;
    GoogleColorSelector: TAdvOfficeColorSelector;
    GoogleGradIntensity: TAdvTrackBar;
    GoogleReset: TDNMSpeedButton;
    DNMPanel23: TDNMPanel;
    Label24: TLabel;
    ebayColorSelector: TAdvOfficeColorSelector;
    EBayGradIntensity: TAdvTrackBar;
    ebayReset: TDNMSpeedButton;
    DNMPanel24: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnDefault: TDNMSpeedButton;
    btnResetAll: TDNMSpeedButton;
    DNMPanel9: TDNMPanel;
    Label10: TLabel;
    MainBackgroundColorSelector: TAdvOfficeColorSelector;
    MainBackgroundGradIntensity: TAdvTrackBar;
    MainBackgroundReset: TDNMSpeedButton;
    chkShowImageOnMainBackGround: TDBCheckBox;
    DNMPanel26: TDNMPanel;
    Label25: TLabel;
    HireColorSelector: TAdvOfficeColorSelector;
    HireGradIntensity: TAdvTrackBar;
    HireReset: TDNMSpeedButton;
    DNMPanel25: TDNMPanel;
    Bevel1: TBevel;
    Label26: TLabel;
    Label27: TLabel;
    cboImageSchemes: TwwDBLookupCombo;
    DNMPanel19: TDNMPanel;
    Bevel2: TBevel;
    Label28: TLabel;
    Label29: TLabel;
    edtRaptorSalesStartsAt: TEdit;
    btnPersonelColorPrefs: TDNMSpeedButton;
    DNMPanel27: TDNMPanel;
    Label30: TLabel;
    SeedToSaleColorSelector: TAdvOfficeColorSelector;
    SeedToSaleGradIntensity: TAdvTrackBar;
    SeedToSaleReset: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure AccountsGradIntensityChange(Sender: TObject);
    procedure btnResetAllClick(Sender: TObject);
    procedure AccountsResetClick(Sender: TObject);
    procedure AccountsColorSelectorSelectColor(Sender: TObject;AColor: TColor);
    procedure btnExportClick(Sender: TObject);
    procedure chkShowImageOnMainBackGroundClick(Sender: TObject);
    procedure cboImageSchemesCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnPersonelColorPrefsClick(Sender: TObject);
  private

    fRestartRequired: Boolean;
    Function GetComponentByName(Const Name: String):TComponent;
    function GetColorMapRec(const ColorGroup: string): TColorMapRec;
    procedure LoadColourSetting;
    procedure SaveColourSetting;
    procedure ResetColourSetting(Const AreaButton: TDNMSpeedButton);
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
  Public constructor create(AOwner:TComponent); override;
  end;

implementation

uses
  CommonLib,  tcDataUtils, 
  FastFuncs, GraphUtil, Clipbrd, tcConst,  Preferences, CommonDbLib,
  AppEnvironment, ColourLib, LogLib;

{$R *.dfm}

Const
  cMaxColorTypes = 26;
  cColorTypes: array[1..cMaxColorTypes] of String  = ('Accounts',
                                                      'Appointments',
                                                      'Banking',
                                                      'CRM',
                                                      'Delivery',
                                                      'Employee',
                                                      'FixedAssets',
                                                      'General',
                                                      'Google',
                                                      'Hire',
                                                      'Inventory',
                                                      'MainBackground',
                                                      'Manufacturing',
                                                      'Miscellaneous',
                                                      'Payments',
                                                      'Payroll',
                                                      'POS',
                                                      'Purchases',
                                                      'Repairs',
                                                      'Returns',
                                                      'Sales',
                                                      'SalesOrder',
                                                      'SeedToSale',
                                                      'Training',
                                                      'Utilities',
                                                      'EDI');
function TColourPrefsGUI.GetComponentByName(const Name: String): TComponent;
var
  I: integer;
Begin
  Result := nil;
  for I := 0 to Self.ComponentCount - 1 do begin
    if Sysutils.SameText(Self.Components[I].Name,Name) then begin
      Result := Self.Components[I];
      Exit;
    end;
  end;
end;

procedure TColourPrefsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fPreferencesForm := nil;
  btnExport.Visible := devmode;
  pnlcolours.height :=   pnlTraining.Height +pnlTraining.top + 5;
end;

procedure TColourPrefsGUI.ResetColourSetting(Const AreaButton: TDNMSpeedButton);
Var
  AreaName: String;
  tmpCompColorSelector,tmpCompGradIntensity: TComponent;
begin
  AreaName := StringReplace(AreaButton.Name,'Reset','',[]);
  tmpCompColorSelector := GetComponentByName(AreaName+'ColorSelector');
  tmpCompGradIntensity := GetComponentByName(AreaName+'GradIntensity');
  If Assigned(tmpCompColorSelector) and (tmpCompColorSelector is TAdvOfficeColorSelector) then begin
    TAdvOfficeColorSelector(tmpCompColorSelector).SelectedColor := TColor(dsPrefs.DataSet.FieldByName('Colour'+AreaName).AsInteger);
    If Assigned(tmpCompGradIntensity) and (tmpCompGradIntensity is TAdvTrackBar) then Begin
      TAdvTrackBar(tmpCompGradIntensity).Position := dsPrefs.DataSet.FieldByName('GradIntensity'+AreaName).AsInteger;
      TAdvTrackBar(tmpCompGradIntensity).Color := TAdvOfficeColorSelector(tmpCompColorSelector).SelectedColor;
      TAdvTrackBar(tmpCompGradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(tmpCompGradIntensity).Color,TAdvTrackBar(tmpCompGradIntensity).Position, False);
    end;
  end;
end;

procedure TColourPrefsGUI.SaveColourSetting;
Var
  I :Integer;
  tmpComp:TComponent;
begin
  if Assigned(self.Owner) and (self.Owner is TPreferencesGUI) then
    TPreferencesGUI(self.Owner).FormColorsChanged := true;

  dsPrefs.DataSet.Edit;
  //Color Selectors
  for I := 1 to cMaxColorTypes do Begin
    tmpComp := GetComponentByName(cColorTypes[I]+'ColorSelector');
    If Assigned(tmpComp) and (tmpComp is TAdvOfficeColorSelector) then
      dsPrefs.DataSet.FieldByName('Colour'+cColorTypes[I]).AsInteger := Integer(TAdvOfficeColorSelector(tmpComp).SelectedColor);
  end;
  //Color Selectors
  for I := 1 to cMaxColorTypes do Begin
    tmpComp := GetComponentByName(cColorTypes[I]+'GradIntensity');
    If Assigned(tmpComp) and (tmpComp is TAdvTrackBar) then
      dsPrefs.DataSet.FieldByName('GradIntensity'+cColorTypes[I]).AsInteger := TAdvTrackBar(tmpComp).Position
  end;
  dsPrefs.DataSet.Post;
end;

procedure TColourPrefsGUI.LoadColourSetting;
Var
  I :Integer;
  tmpCompColorSelector,tmpCompGradIntensity:TComponent;
begin
  for I := 1 to cMaxColorTypes do Begin
    tmpCompColorSelector := GetComponentByName(cColorTypes[I]+'ColorSelector');
    tmpCompGradIntensity := GetComponentByName(cColorTypes[I]+'GradIntensity');
    If Assigned(tmpCompColorSelector) and (tmpCompColorSelector is TAdvOfficeColorSelector) then begin
      TAdvOfficeColorSelector(tmpCompColorSelector).SelectedColor := TColor(dsPrefs.DataSet.FieldByName('Colour'+cColorTypes[I]).AsInteger);
      If Assigned(tmpCompGradIntensity) and (tmpCompGradIntensity is TAdvTrackBar) then Begin
        (*TAdvTrackBar(tmpCompGradIntensity).Position := dsPrefs.DataSet.FieldByName('GradIntensity'+cColorTypes[I]).AsInteger;
        TAdvTrackBar(tmpCompGradIntensity).Color := TAdvOfficeColorSelector(tmpCompColorSelector).SelectedColor;
        TAdvTrackBar(tmpCompGradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(tmpCompGradIntensity).Color,TAdvTrackBar(tmpCompGradIntensity).Position, False);*)
        SetcolorComp(TAdvTrackBar(tmpCompGradIntensity), TAdvOfficeColorSelector(tmpCompColorSelector), dsPrefs.DataSet, 'Colour'+cColorTypes[I] , 'GradIntensity'+cColorTypes[I]);
      end;
    end;
  end;
end;

function TColourPrefsGUI.GetColorMapRec(const ColorGroup: string): TColorMapRec;
var
  Index: Integer;
  FoundMatch: Boolean;
begin
  Result := cColorMapping[1];
  if ColorGroup <> '' then begin
    Index := 1;
    FoundMatch := False;
    while (Index <= cMaxColorMap) and (not FoundMatch) do begin
      if Sysutils.SameText(cColorMapping[Index].Name, ColorGroup) then
        FoundMatch := True
      else
        Inc(Index);
    end;
    if FoundMatch then
      Result := cColorMapping[Index];
  end;
end;

procedure TColourPrefsGUI.btnDefaultClick(Sender: TObject);
Var
  I :Integer;
  tmpCompColorSelector,tmpCompGradIntensity:TComponent;
  ColorMap: TColorMapRec;
begin
  for I := 1 to cMaxColorTypes do Begin
    tmpCompColorSelector := GetComponentByName(cColorTypes[I]+'ColorSelector');
    tmpCompGradIntensity := GetComponentByName(cColorTypes[I]+'GradIntensity');
    ColorMap :=  GetColorMapRec(cColorTypes[I]);
    If Assigned(tmpCompColorSelector) and (tmpCompColorSelector is TAdvOfficeColorSelector) then begin
      TAdvOfficeColorSelector(tmpCompColorSelector).SelectedColor := ColorMap.Color;
      If Assigned(tmpCompGradIntensity) and (tmpCompGradIntensity is TAdvTrackBar) then Begin
        TAdvTrackBar(tmpCompGradIntensity).Position := ColorMap.AdjLuma;
        TAdvTrackBar(tmpCompGradIntensity).Color := TAdvOfficeColorSelector(tmpCompColorSelector).SelectedColor;
        TAdvTrackBar(tmpCompGradIntensity).ColorTo := ColorAdjustLuma(ColorMap.Color,ColorMap.AdjLuma, False);
      end;
    end;
  end;
end;

procedure TColourPrefsGUI.btnExportClick(Sender: TObject);
Var
  I :Integer;
  tmpCompColorSelector,tmpCompGradIntensity:TComponent;
  s:String;
  st:TStringlist;
begin
  st:= TStringlist.Create;
  try
    for I := 1 to cMaxColorTypes do Begin
      tmpCompColorSelector := GetComponentByName(cColorTypes[I]+'ColorSelector');
      tmpCompGradIntensity := GetComponentByName(cColorTypes[I]+'GradIntensity');
      s:= '(Name: ' +quotedstr(cColorTypes[I]) + ';Color: ';

      If Assigned(tmpCompColorSelector) and (tmpCompColorSelector is TAdvOfficeColorSelector) then begin
        s := s + ColorToString(TAdvOfficeColorSelector(tmpCompColorSelector).SelectedColor);
        If Assigned(tmpCompGradIntensity) and (tmpCompGradIntensity is TAdvTrackBar) then Begin
          s:= s + '; AdjLuma: ' +
          inttostr(TAdvTrackBar(tmpCompGradIntensity).Position) + '),';
        end;
      end;
       st.Add(s);
    end;
    //Clipboard.asText := st.text;
    MessageDlgXP_Vista('Paste this in to ''TcConst: cColorMapping: ', mtInformation, [mbOK], 0);
  finally
    Freeandnil(st);
  end;
end;

procedure TColourPrefsGUI.AccountsGradIntensityChange(Sender: TObject);
Var
  I :Integer;
  tmpCompColorSelector,tmpCompGradIntensity:TComponent;
begin
  try
    for I := 1 to cMaxColorTypes do Begin
      tmpCompColorSelector := GetComponentByName(cColorTypes[I]+'ColorSelector');
      tmpCompGradIntensity := GetComponentByName(cColorTypes[I]+'GradIntensity');
      If Assigned(tmpCompColorSelector) and (tmpCompColorSelector is TAdvOfficeColorSelector) then begin
        If Assigned(tmpCompGradIntensity) and (tmpCompGradIntensity is TAdvTrackBar) then Begin
          (*TAdvTrackBar(tmpCompGradIntensity).Color := TAdvOfficeColorSelector(tmpCompColorSelector).SelectedColor;
          TAdvTrackBar(tmpCompGradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(tmpCompGradIntensity).Color,TAdvTrackBar(tmpCompGradIntensity).Position, False);*)
          GradIntensityChange(TAdvTrackBar(tmpCompGradIntensity),TAdvOfficeColorSelector(tmpCompColorSelector) );
        end;
      end;
    end;
  Except
    on E:Exception do begin
      logtext('AccountsGradIntensityChange Exception :' + E.message);
    end;
  end;
end;
procedure TColourPrefsGUI.btnResetAllClick(Sender: TObject);
begin
  LoadColourSetting;
end;

procedure TColourPrefsGUI.cboImageSchemesCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not fRestartRequired then
    if (MessageDlgXP_Vista('To Apply the selected Image Scheme requires'+#13+#10+
     'Application Restart (Log off / Log on).'+#13+#10+''+#13+#10+
     'Do You Wish To Proceed with Restarting?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    fRestartRequired:= True;
end;

procedure TColourPrefsGUI.chkShowImageOnMainBackGroundClick(Sender: TObject);
begin
  inherited;
  if chkShowImageOnMainBackGround.Focused then
    fRestartRequired := true;

end;


constructor TColourPrefsGUI.create(AOwner: TComponent);
begin
  inherited;
end;

procedure TColourPrefsGUI.btnPersonelColorPrefsClick(Sender: TObject);
begin
  Try
    TPreferencesGUI(Preferenceform).SearchForText(DoTranslate('List and Button Colours'), '' , true);
  Except
  End;
end;

procedure TColourPrefsGUI.AccountsResetClick(Sender: TObject);
begin
try
  If (Sender is  TDNMSpeedButton) then
    ResetColourSetting(TDNMSpeedButton(Sender));
  Except
    on E:Exception do begin
      logtext('AccountsResetClick Exception :' + E.message);
    end;
  end;
end;

procedure TColourPrefsGUI.AccountsColorSelectorSelectColor(Sender: TObject; AColor: TColor);
begin
try
  AccountsGradIntensityChange(nil);
Except
  on E:Exception do begin
    logtext('AccountsGradIntensityChange Exception :' + E.message);
  end;
end;
end;
procedure TColourPrefsGUI.PerformStartup(var Msg: TMessage);
begin
   DoPerformStartup(Msg);
end;
procedure TColourPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
try
  LoadColourSetting;
  SetupPersonalPreferences(qryPersonalPreferences, AppEnv.Employee.EmployeeID);
  ShowcontrolHint(chkShowImageOnMainBackGround, 'When Checked, ERP''s main page bakground will display a tiled image.');
  fRestartRequired := false;
  btnPersonelColorPrefs.Enabled:= not(TPreferencesGUI(Preferenceform).SinglePanelMode);
Except
  on E:Exception do begin
    Logtext ('TColourPrefsGUI.PerformStartup:'+E.message);
  end;
end;
end;

procedure TColourPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TColourPrefsGUI.FinishProcess(var Msg: TMessage);
begin
 if qryPersonalPreferences.State in [dsEdit, dsInsert] then
   qryPersonalPreferences.Post;
 SaveColourSetting;
 if fRestartRequired then Begin
    if owner is TPreferencesGUI then
      TPreferencesGUI(Owner).RestartRequired:= fRestartRequired;
 end;
end;

initialization
  RegisterClassOnce(TColourPrefsGUI);
finalization
  UnRegisterClass(TColourPrefsGUI);
end.
