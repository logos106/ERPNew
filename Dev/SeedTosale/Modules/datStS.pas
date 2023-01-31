unit datStS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BaseGUIDatamodule, BaseAddinModule, ActnList, DNMAction, Menus,
  AdvMenus, frmReportSelectorFrm , Wwdbgrid , ActionsObj ;

type
  TdmStS = class(TdtmGUI)
    ActionList: TActionList;
    MainMenu: TAdvMainMenu;
    Budgets1: TMenuItem;
    actStrain: TDNMAction;
    actStSStrains: TDNMAction;
    actStSReport: TDNMAction;
    SeedtoSaleStrain1: TMenuItem;
    SeedtoSaleStrainList1: TMenuItem;
    actStSClassList: TDNMAction;
    SeedtoSaleClassList1: TMenuItem;
    Reports1: TMenuItem;
    N1: TMenuItem;
    actint_StS: TDNMAction;
    actStsTagOrder: TDNMAction;
    actStsTagOrders: TDNMAction;
    actStSTags: TDNMAction;
    actStSMain: TDNMAction;
    actStSTagsofStSSupplier: TDNMAction;
    actStSClass: TDNMAction;
    actStSProductQtyList: TDNMAction;
    actStsTagGrowthHistory: TDNMAction;
    actStsTagActivityLog: TDNMAction;
    actShowTagReports: TDNMAction;
    actRefreshTagReports: TDNMAction;
    actStsHarvestList: TDNMAction;
    actStsHarvest: TDNMAction;
    actStSRooms: TDNMAction;
    actStsTransferPackage: TDNMAction;
    actStsTransferPackageList: TDNMAction;
    actStsNewHarvestPackage: TDNMAction;
    actStsPackageList: TDNMAction;
    actStsNewAnotherPackage: TDNMAction;
    procedure actStSReportExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure actint_StSExecute(Sender: TObject);
    procedure actStsTagOrderExecute(Sender: TObject);
    procedure actStSTagsofStSSupplierUpdate(Sender: TObject);
    procedure actStSClassExecute(Sender: TObject);
    procedure actStSClassListUpdate(Sender: TObject);
    procedure actStSClassUpdate(Sender: TObject);
    procedure actShowTagReportsExecute(Sender: TObject);
    procedure actRefreshTagReportsExecute(Sender: TObject);
    procedure actStsTransferPackageListExecute(Sender: TObject);
    procedure actStsNewHarvestPackageExecute(Sender: TObject);
    procedure actStsNewAnotherPackageExecute(Sender: TObject);
  private
    procedure MakeaStSOrder(Sender: TObject);
    procedure OnStSClassCreate(Sender: TwwDbGrid);
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;
  public
    procedure MakenOpenStSOrder(Sender: TObject);
  Published
    function GetItem(const ActionName: string): TActionHelperItem;

  end;

implementation

uses MainSwitchFrm2, tcConst, AppEnvironment, Preferences, CommonFormLib,
  frmPurchaseOrders, frmSimpleTypes, BusObjSimpleTypes, CommonLib, StSConst,
  BaseListingForm, MAIN, StSProductQtyList, StsTagGrowthHistory, StsTransferPackageList,
  frmStSCreatePackage, frmStSMain;

{$R *.dfm}

procedure TdmStS.actint_StSExecute(Sender: TObject);
begin
  inherited;
  OpenPrefform('Utilities', '' ,1 ,false, STS_CAPTION);
end;

procedure TdmStS.actShowTagReportsExecute(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TStsTagGrowthHistoryGUI');
  OpenERPListForm('TStSProductQtyListGUI');
  if FormStillOpen('TStsTagGrowthHistoryGUI') then
    ShowInLowerHalf(TForm(FindExistingComponent('TStsTagGrowthHistoryGUI')));
  if FormStillOpen('TStSProductQtyListGUI') then
    ShowInUpperHalf(TForm(FindExistingComponent('TStSProductQtyListGUI')));
  mainform.AddToolbarButton(actRefreshTagReports.name);
end;
procedure TdmStS.actRefreshTagReportsExecute(Sender: TObject);
begin
  inherited;
  if FormStillOpen('TStsTagGrowthHistoryGUI') then
    TStsTagGrowthHistoryGUI(FindExistingComponent('TStsTagGrowthHistoryGUI')).RefreshQuery;
  if FormStillOpen('TStSProductQtyListGUI') then
    TStSProductQtyListGUI(FindExistingComponent('TStSProductQtyListGUI')).RefreshQuery;
end;

procedure TdmStS.actStSClassExecute(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TStSClassUnAssignedListGUI' , OnStSClassCreate );
end;
procedure TdmStS.actStSClassListUpdate(Sender: TObject);
begin
  inherited;
  actStSClassList.Caption := STS_CAPTION+' '+ AppEnv.DefaultClass.ClassHeading +' List';
end;

procedure TdmStS.actStSClassUpdate(Sender: TObject);
begin
  inherited;
  actStSClass.Caption := STS_CAPTION+' '+ AppEnv.DefaultClass.ClassHeading;
end;

procedure TdmStS.actStsNewAnotherPackageExecute(Sender: TObject);
var
  frmPackage: TfmStSCreatePackage;
  frmStsMain: TfmStSMain;
begin
  inherited;

  frmStsMain := TfmStSMain.Create(nil);
  try
    frmPackage := TfmStSCreatePackage.Create(nil, modeAnotherPackage, 0);
    try
      if frmPackage.ShowModal = mrOK then
        frmStsMain.ProcessCreatePackage(frmPackage, nil);
    finally
      FreeAndNil(frmPackage);
    end;
  finally
    FreeAndNil(frmStsMain);
  end;
end;

procedure TdmStS.actStsNewHarvestPackageExecute(Sender: TObject);
var
  frmPackage: TfmStSCreatePackage;
  frmStsMain: TfmStSMain;
begin
  inherited;

  frmStsMain := TfmStSMain.Create(nil);
  try
    frmPackage := TfmStSCreatePackage.Create(nil, modeHarvest, 0);
    try
      if frmPackage.ShowModal = mrOK then
        frmStsMain.ProcessCreatePackage(frmPackage, nil);
    finally
      FreeAndNil(frmPackage);
    end;
  finally
    FreeAndNil(frmStsMain);
  end;
end;

procedure TdmStS.OnStSClassCreate(Sender: TwwDbGrid);
begin
  if Sender.datasource.DataSet.findfield('classid')  <> nil then
    if Sender.datasource.DataSet.fieldbyname('classid').asInteger <> 0 then
      OpenERPForm('TfmStSClass',  Sender.datasource.DataSet.fieldbyname('classid').asInteger );
end;
procedure TdmStS.actStSReportExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_SeedToSale));
end;


procedure TdmStS.actStsTagOrderExecute(Sender: TObject);
begin
  inherited;
  MakenOpenStSOrder(Sender);
end;
procedure TdmStS.actStSTagsofStSSupplierUpdate(Sender: TObject);
begin
  inherited;
  actStSTagsofStSSupplier.visible := trim(Appenv.companyprefs.StSSupplier) <> '' ;
  if trim(Appenv.companyprefs.StSSupplier) <> '' then
    actStSTagsofStSSupplier.caption := trim(Appenv.companyprefs.StSSupplier)+' Tags';
end;

procedure TdmStS.actStsTransferPackageListExecute(Sender: TObject);
var
  Form: TfrmTransferPackageList;
  AccessLevel: Integer;
begin
  inherited;
  AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(TfrmTransferPackageList.ClassName);

  Form := TfrmTransferPackageList.Create(nil, trdOut);

  if accesslevel = 6 then begin
    Freeandnil(Form);
    exit;
  end;

  with Form do begin
    if ISMdiParentvisible then begin
      FormStyle := fsMDIChild ;
      BringToFront;
    end else Show;
  end;
end;

procedure TdmStS.MakeaStSOrder(Sender: TObject);
begin
  if sender is TPurchaseGUI then
    TPurchaseGUI(Sender).MakeaStSOrder;
end;
procedure TdmStS.MakenOpenStSOrder(Sender: TObject);
begin
   OpenERPForm('TPurchaseGUI' , 0, MakeaStSOrder);
end;

procedure TdmStS.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  inherited;
  try
      for i := 0 to ActionList.Actioncount - 1 do begin
        TDNMAction(ActionList.Actions[i]).visible := AppEnv.companyprefs.EnableSeedtoSale ;
      end;
  Except
    //
  end;
  actStSClass.Caption := STS_CAPTION+' '+ AppEnv.DefaultClass.ClassHeading;
  actStSClassList.Caption := STS_CAPTION+' '+ AppEnv.DefaultClass.ClassHeading +'List';
  actStSProductQtyList.Caption := STS_CAPTION+' '+NLnLF + 'Stock Qty List';
  actShowTagReports.visible := DevMode;
  actRefreshTagReports.visible := DevMode;
(*  actStSClass.Caption := AppEnv.DefaultClass.ClassHeading + NL+STS_CAPTION;
  actStSClassList.Caption := AppEnv.DefaultClass.ClassHeading +' List'+NL+STS_CAPTION ;*)
end;

procedure TdmStS.DoAddReports(const ReportSelector: TfrmReportSelectorGUI);
begin
  inherited;
  if  AppEnv.companyprefs.EnableSeedtoSale then begin
    if Assigned(ReportSelector) then begin
      ReportSelector.Add(REPORT_GROUP_SeedToSale, STS_CAPTION+' - Strains List'   , 'TStSProductListGUI', 0);
      ReportSelector.Add(REPORT_GROUP_SeedToSale, STS_CAPTION+' - Class List'     , 'TStSClassListGUI'    , 0);
      ReportSelector.Add(REPORT_GROUP_SeedToSale, STS_CAPTION+' - Stock Qty List' , 'TStSProductQtyListGUI'    , 0);
      ReportSelector.Add(REPORT_GROUP_SeedToSale, STS_CAPTION+' - Tag Growth History' , 'TStsTagGrowthHistoryGUI'    , 0);
      ReportSelector.Add(REPORT_GROUP_SeedToSale, STS_CAPTION+' - Tag Activity Log' , 'TStsTagActivityLogGUI'    , 0);
    end;
  end;
end;

function TdmStS.GetItem(const ActionName: string): TActionHelperItem;
var
  I: integer;
begin
  Result := nil;
  if ActionHelper.Count > 0 then for I := 0 to ActionHelper.ActionCount - 1 do
      if Sysutils.SameText(ActionHelper.Items[I].ActionName, ActionName) then begin
        Result := ActionHelper.Items[I];
        Break;
      end;

end;

end.
