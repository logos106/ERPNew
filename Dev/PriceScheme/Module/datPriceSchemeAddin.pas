unit datPriceSchemeAddin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGUIDatamodule, ImgList, ActnList, Menus, DNMAction, ActionsObj,
  AdvMenus, frmReportSelectorFrm;

type
  TdtmPriceSchemeAddin = class(TdtmGUI)
    ActionList: TActionList;
    actPriceSchemeList: TDNMAction;
    MainMenu: TAdvMainMenu;
    mnuPriceSchemes: TMenuItem;
    PriceSchemeList1: TMenuItem;
    actPriceLists: TDNMAction;
    PriceLists1: TMenuItem;
    actPriceSchemeReports: TDNMAction;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure actPriceSchemeReportsExecute(Sender: TObject);
  private
    procedure PosHandler(const Sender: TObject; const Event: string; const Data: Pointer);
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;
  public
  published
    function GetItem(const ActionName: string): TActionHelperItem;
  end;

var
  dtmPriceSchemeAddin: TdtmPriceSchemeAddin;

implementation

{$R *.dfm}

uses
  FastFuncs, GlobalEventsObj, CommonLib,
  AddinPackageInfoObj, SchemeSaleLinePriceObj,
  tcConst, MainSwitchFrm2;

var
  SaleLinePriceRecList: TSaleLinePriceRecList;

{ TdtmPriceScheduleAddin }

procedure TdtmPriceSchemeAddin.DataModuleCreate(Sender: TObject);
begin
  //LoadImagefromAppMainImageList := True;
  inherited;
  GlobalEvents.RegisterHandler(self,'','','',GEVENT_POS_AfterSaleListPriceChange,PosHandler);
  GlobalEvents.RegisterHandler(self,'','','',GEVENT_POS_CheckForListRedisplay,PosHandler);
  GlobalEvents.RegisterHandler(self,'','','',GEVENT_POS_AfterSaleListLineDelete,PosHandler);

end;
procedure TdtmPriceSchemeAddin.DataModuleDestroy(Sender: TObject);
begin
  GlobalEvents.DeregisterHandlers(self);
  inherited;
end;

function TdtmPriceSchemeAddin.GetItem(
  const ActionName: string): TActionHelperItem;
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

procedure TdtmPriceSchemeAddin.PosHandler(const Sender: TObject;
  const Event: string; const Data: Pointer);
begin
  if not Assigned(SaleLinePriceRecList) then
    SaleLinePriceRecList:= TSaleLinePriceRecList.Create;
  SaleLinePriceRecList.SaleDate:= now;
  if Sysutils.SameText(Event, GEVENT_POS_AfterSaleListPriceChange) then
    SaleLinePriceRecList.CalcSalePrices(Sender, Data, true)
  else if Sysutils.SameText(Event, GEVENT_POS_AfterSaleListLineDelete) then
    SaleLinePriceRecList.CalcSalePrices(Sender, Data, false)
  else if Sysutils.SameText(Event, GEVENT_POS_CheckForListRedisplay) then
    SaleLinePriceRecList.CheckSalesListRefresh(Sender);
end;

procedure TdtmPriceSchemeAddin.DoAddReports(Const ReportSelector: TfrmReportSelectorGUI);
begin
  if Assigned(ReportSelector) then begin
    ReportSelector.Add(REPORT_GROUP_SALES, 'Price Scheme Best Price', 'TfmPriceSchemeBestPriceList', 0);
    ReportSelector.Add(REPORT_GROUP_PRICE_SCHEMES, 'Price Scheme Best Price', 'TfmPriceSchemeBestPriceList', 0);
  end;
end;

procedure TdtmPriceSchemeAddin.actPriceSchemeReportsExecute(
  Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_PRICE_SCHEMES));
end;

initialization
  if Assigned(AddinInfo) then
    AddinInfo.GuiDataModuleClass:= TdtmPriceSchemeAddin;

finalization
  SaleLinePriceRecList.Free;

end.
