unit frmStockVarify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, ComCtrls,
  BalanceSheetForm, InventoryAssetVsStockStauts,
  StockValueList , ProductListForm, Buttons, Wwdbigrd, Grids, Wwdbgrid;

type
  TfmStockVarify = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    DNMPanel5: TDNMPanel;
    qryMain: TERPQuery;
    dsMain: TDataSource;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    qryMainDEscription: TWideStringField;
    qryMainPostedCost: TWideStringField;
    qryMainAverageCost: TWideStringField;
    DNMPanel4: TDNMPanel;
    Calendar: TMonthCalendar;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdCancel: TDNMSpeedButton;
    btnRequery: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnRequeryClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fInventoryAssetVsStockStauts : TInventoryAssetVsStockStautsGUI;
    fStockValue : TStockValue;
    fBalanceSheet : TBalanceSheetGUI;
    fProductList : TProductListGUI;
    fiListsDone :Integer;


    Procedure initList (Sender :TObject);
    procedure showDEtails;
    procedure AfterListShow(Sender: TObject);
    Procedure AfterListREfreshQuery(Sender:TObject);
    Procedure AfterListRefreshTotals(Sender:TObject);
  Protected
    procedure DoFormSize(ChangeSize:Boolean);Override;
  public
    Property InventoryAssetVsStockStauts : TInventoryAssetVsStockStautsGUI read fInventoryAssetVsStockStauts write fInventoryAssetVsStockStauts;
    Property StockValue : TStockValue read fStockValue write fStockValue;
    Property BalanceSheet : TBalanceSheetGUI read fBalanceSheet write fBalanceSheet;
    Property ProductList : TProductListGUI read fProductList write fProductList;
  end;


implementation

uses CommonFormLib, BaseListingForm, CommonLib, dmMainGUI, tcConst, LogLib;

{$R *.dfm}


procedure TfmStockVarify.btnRequeryClick(Sender: TObject);
begin
  inherited;
  fiListsDone :=0;
  ProcessingCursor(True);
  try
    initList(fInventoryAssetVsStockStauts); fInventoryAssetVsStockStauts.btnRequery.click;
    initList(fStockValue)                 ; fStockValue.btnRequery.click;
    initList(fBalanceSheet)               ; fBalanceSheet.btnRequery.click;
    initList(fProductList)                ; fProductList.btnRequery.click;
  finally
    Processingcursor(False);
  end;
  showDEtails;
end;
procedure TfmStockVarify.showDEtails;
begin
//  if (not Assigned(fStockValue)) or (not Assigned(fBalanceSheet)) or (not Assigned(fBalanceSheet)) or (not Assigned(fInventoryAssetVsStockStauts)) then
//    exit;

  Self.top := 0;
  Self.left := 20;
  fStockValue.left                  := 2;
  fBalanceSheet.left                := fStockValue.left + fStockValue.width + 2;
  fProductList.left                 := fBalanceSheet.left + fBalanceSheet.width + 2;
  fInventoryAssetVsStockStauts.left := fProductList.left + fProductList.width + 2;
  (*fInventoryAssetVsStockStauts.top  := Mainform.clientheight - fInventoryAssetVsStockStauts.height -2;
  fStockValue.top                   := fInventoryAssetVsStockStauts.top;
  fBalanceSheet.top                 := fInventoryAssetVsStockStauts.top;
  fProductList.top                  := fInventoryAssetVsStockStauts.top;*)

  closedb(qrymain);
  qrymain.SQL.Clear;

  (*if fBalanceSheet.qrymain.Locate('column1' , 'Inventory Asset' , [loPartialKey ]) then lblValues.caption := lblValues.caption + NL +' Balancesheet.Inventory Asset =' + FloattostrF(fBalanceSheet.qrymain.fieldbyname('column2').asFloat ,ffCurrency , 15,2);
  if fBalanceSheet.qrymain.Locate('column1' , 'Total Other Current Asset' , [loPartialKey ]) then lblValues.caption := lblValues.caption + NL +' Balancesheet.Total Other Current Asset =' + FloattostrF(fBalanceSheet.qrymain.fieldbyname('column3').asFloat ,ffCurrency , 15,2);*)
  qrymain.SQL.Add(           'Select "Balance sheet.Inventory Asset" as Description , ' +   Quotedstr(FloattostrF(fBalanceSheet.AssetValue['Inventory Asset'],ffCurrency , 15,2))   +' as PostedCost, "" as AverageCost');
  qrymain.SQL.Add( 'union all Select "Stock Value List" as Description , '              +   Quotedstr(fStockValue.grdMain.ColumnByName('TotalCost').FooterValue)                    +' as PostedCost, ' + Quotedstr(fStockValue.grdMain.ColumnByName('AvgTotalCost').FooterValue)                 +' as AverageCost');
  qrymain.SQL.Add( 'union all Select "Product List Value" as Description , '            +   '"" , '                                                                                                     + Quotedstr(fProductList.grdMain.ColumnByName('ValueAvg').FooterValue)                    +' as AverageCost');
  qrymain.SQL.Add( 'union all Select "Inv As Vs Stock.Balance Sheet" as Description , '               +   Quotedstr(fInventoryAssetVsStockStauts.grdMain.ColumnByName('Balancesheet').FooterValue)+' as PostedCost,"" as AverageCost');
  qrymain.SQL.Add( 'union all Select "Inv As Vs Stock.Stock Value" as Description , '               +    Quotedstr(fInventoryAssetVsStockStauts.grdMain.ColumnByName('StockValue').FooterValue)  +' as PostedCost,"" as AverageCost');

  try
    logtext(Qrymain.sql.text);
    Opendb(qrymain);
  except
    on E:Exception do begin
      logtext(E.Message)
    end;
  end;
end;

procedure TfmStockVarify.cmdCancelClick(Sender: TObject);
begin
  inherited;
  ProcessingCursor(True);
  try
    try fInventoryAssetVsStockStauts.close; except end;
    try fStockValue.close;except end;
    try fProductList.close;except end;
    try fBalanceSheet.close;except end;
    self.close;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TfmStockVarify.DoFormSize(ChangeSize: Boolean);
begin
  //inherited;
end;

procedure TfmStockVarify.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GuiPrefs.Node['Options.Calendardate'].asDatetime := Calendar.date;
  inherited;
  action := caFree;
end;

procedure TfmStockVarify.FormCreate(Sender: TObject);
begin
  inherited;
  fiListsDone :=0;
  fInventoryAssetVsStockStauts := nil;
  fStockValue := nil;
  fProductList := nil;
  fBalanceSheet := nil;
end;

procedure TfmStockVarify.FormShow(Sender: TObject);
begin
  inherited;
  Calendar.Date := date;
  inherited;
  if guiprefs.active =False then GuiPrefs.active := True;
  if GuiPrefs.Node.Exists('Options.Calendardate') then Calendar.date:= GuiPrefs.Node['Options.Calendardate'].asDAtetime;
  if not OpenERPListForm('TInventoryAssetVsStockStautsGUI' , initList ,AfterListShow) then begin
    CommonLib.MessageDlgXP_Vista('You must have access to "Asset Vs Stock Status" to use this function.',mtInformation,[mbOk],0);
    exit;
  end;
  if not OpenERPListForm('TStockValue' , initList,AfterListShow) then begin
    CommonLib.MessageDlgXP_Vista('You must have access to "Stock Value" to use this function.',mtInformation,[mbOk],0);
    exit;
  end;
  if not OpenERPListForm('TBalanceSheetGUI' , initList,AfterListShow) then begin
    CommonLib.MessageDlgXP_Vista('You must have access to "Balance Sheet" to use this function.',mtInformation,[mbOk],0);
    exit;
  end;
  if not OpenERPListForm('TProductListGUI' , initList,AfterListShow) then begin
    CommonLib.MessageDlgXP_Vista('You must have access to "Product List" to use this function.',mtInformation,[mbOk],0);
    exit;
  end;

  dtmMainGUI.Maximiseform(nil);
  showDEtails;
  btnRequery.Click;
end;

procedure TfmStockVarify.initList(Sender: TObject);
begin
  if sender is TBaseListingGUI then begin
    TBaseListingGUI(Sender).dtTo.Date := Calendar.Date;
    TBaseListingGUI(Sender).TallerForm;
    TBaseListingGUI(Sender).top  := 0 +  self.height;
  end;
end;
procedure TfmStockVarify.AfterListREfreshQuery(Sender: TObject);
begin
end;
procedure TfmStockVarify.AfterListRefreshTotals(Sender: TObject);
begin
  fiListsDone := fiListsDone +1;
  if fiListsDone >= 4 then begin
    showDEtails;
    fiListsDone :=0;
  end;
end;

procedure TfmStockVarify.AfterListShow(Sender: TObject);
begin
       if sender is  TBalanceSheetGUI                 then fBalanceSheet                := TBalanceSheetGUI(Sender)
  else if sender is  TInventoryAssetVsStockStautsGUI  then fInventoryAssetVsStockStauts := TInventoryAssetVsStockStautsGUI(Sender)
  else if sender is  TProductListGUI                  then fProductList                 := TProductListGUI(Sender)
  else if sender is  TStockValue                      then begin fStockValue            := TStockValue(Sender); TStockValue(Sender).grpfilters.itemindex := 2;end;
  if Sender is TBaselistingGUI then TBAseListingGUI(Sender).onRefreshQuery := AfterListREfreshQuery;
  if Sender is TBaselistingGUI then TBAseListingGUI(Sender).OnRefreshTotals := AfterListRefreshTotals;

end;


initialization
  RegisterClassOnce(TfmStockVarify);

end.
