unit undoManufactureSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, BusObjBase,
  wwcheckbox, CustomInputBox;

type
  TundoManufactureSalesGUI = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMainSaledate: TDateField;
    qryMainisinvoice: TWideStringField;
    qryMainissalesorder: TWideStringField;
    qryMainconverted: TWideStringField;
    qryMainTotalAmountinc: TFloatField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryErpfixSL: TERPQuery;
    qryErpfixSLsalelineId: TIntegerField;
    qryErpfixSLlineprice: TFloatField;
    qryErpfixSLlinepriceInc: TFloatField;
    qryErpfixSLlinecost: TFloatField;
    qryErpfixSLlinecostinc: TFloatField;
    qryErpfixSLtotallineamount: TFloatField;
    qryErpfixSLtotallineamountinc: TFloatField;
    qryErpfixSLlinetax: TFloatField;
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    procedure createSalesbackup;
    Procedure TreePriceRecalcCallback(Const Sender: TBusObj; var Abort: Boolean);
    Procedure ProductCostUpdateCallback(Const Sender: TBusObj; var Abort: Boolean);
    function ERPFixSLCost(const SaleslineID: Integer): Double;

  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean;      SelIndex: Integer);override;
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonDbLib, CommonLib, BusObjSales, SalesConst,dateutils, 
  DebugLib;

{$R *.dfm}

procedure TundoManufactureSalesGUI.createSalesbackup;
var
  s:String;
begin
  s:= DoBackuptables(['tblsales' ,'tblsaleslines' ,'tblProctree' ,'tblstockmovementLines' ,'tblstockadjustentrylines'] , '_undoManufactureSales' , true);
  if s<> '' then
    executeSQL(s);
  (*if Tableexists('erpfix_undoVnF_sales') and (MessageDlgXP_Vista('Do you wish to re-create the backup tables?', mtConfirmation, [mbYes, mbNo], 0)= mrno) then exit;

  With TempMyScript do try

    SQL.add('Drop table if exists erpfix_undoVnF_sales;');
    SQL.add('create table erpfix_undoVnF_sales like tblsales;');
    SQL.add('insert into erpfix_undoVnF_sales select * from tblsales;');

    SQL.add('Drop table if exists erpfix_undoVnF_saleslines;');
    SQL.add('create table erpfix_undoVnF_saleslines like tblsaleslines;');
    SQL.add('insert into erpfix_undoVnF_saleslines select * from tblsaleslines;');

    SQL.add('Drop table if exists erpfix_undoVnF_Proctree;');
    SQL.add('create table erpfix_undoVnF_Proctree like tblProctree;');
    SQL.add('insert into erpfix_undoVnF_Proctree select * from tblProctree;');

    SQL.add('Drop table if exists erpfix_undoVnF_stockmovementLines;');
    SQL.add('create table erpfix_undoVnF_stockmovementLines like tblstockmovementLines;');
    SQL.add('insert into erpfix_undoVnF_stockmovementLines select * from tblstockmovementLines;');

    SQL.add('Drop table if exists erpfix_undoVnF_stockadjustentrylines;');
    SQL.add('create table erpfix_undoVnF_stockadjustentrylines like tblstockadjustentrylines;');
    SQL.add('insert into erpfix_undoVnF_stockadjustentrylines select * from tblstockadjustentrylines;');

    execute;
  finally
    Free;
  end;*)
end;


procedure TundoManufactureSalesGUI.DNMSpeedButton1Click(Sender: TObject);
var
  dt:TDatetime;
begin
  inherited;
  createSalesbackup;

    executeSQL( ' update  erpfix_proctree  TSL inner join  tblproctree SL on SL.ProctreeId = TSL.proctreeID' +
                ' Set SL.Cost = TSL.Cost   ' +
                ' where ifnull(SL.Cost ,0)<>  ifnull(TSL.Cost ,0);');


  IterateProcno:= 1;
  iteraterecords(true);
  RefreshQuery;
  dt:= now;
  try
    TimerMsg(lblNote , 'updating the cost in non-manufacture sales lines', 10);
    executeSQL( ' update erpfix_saleslines  TSL inner join tblsaleslines SL on SL.SaleLineId = TSL.saleLineID ' +
                ' Set SL.LineCost = TSL.LineCost , SL.LineCostInc  = TSL.LineCostInc  ' +
                ' where ifnull(SL.LineCost ,0)<>  ifnull(TSL.LineCost ,0);');

    TimerMsg(lblNote , 'updating the cost in Stock transfers and stock adjustments ', 10);

    executeSQL( ' update erpfix_stockmovementlines TSL inner join tblstockmovementlines SL on SL.StockmovementLinesID = TSL.StockmovementLinesID' +
                ' Set SL.Cost = TSL.Cost' +
                ' where ifnull(SL.Cost ,0)<>  ifnull(TSL.Cost ,0);'+

                ' update erpfix_stockadjustentrylines TSL inner join tblstockadjustentrylines SL on SL.StockAdjustEntryLinesID = TSL.StockAdjustEntryLinesID' +
                ' Set SL.Cost = TSL.Cost ' +
              ' where ifnull(SL.Cost ,0)<>  ifnull(TSL.Cost ,0);');
  finally
    MessageDlgXP_Vista('Total Execution time :' +  SecondsToTime(SecondsBetween(dt, now) , true , true), mtInformation, [mbOK], 0);
  end;
end;

procedure TundoManufactureSalesGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  SalesObj : TSales;
begin
  inherited;
  if IterateProcno = 1 then begin
    TimerMsg(lblNote , inttostr(qrymain.RecNo) +' of ' +inttostr(qrymain.RecordCount) );
    if QrymainisInvoice.AsBoolean then  SalesObj := TInvoice.CreateWithNewConn(self)
    else if QrymainisSalesorder.AsBoolean then  SalesObj := TSalesorder.CreateWithNewConn(self)
    else SalesObj := TQuote.CreateWithNewConn(self);
    try
      SalesObj.Load(QrymainSaleId.AsInteger);
      if SalesObj.Count =1 then begin
        SalesObj.AccessManager.AccessLevel:= 1;
        SalesObj.Connection.BeginTransaction;
        try
          SalesObj.InstantiateAllTrees;
          SalesObj.Lines.IterateRecords(ProductCostUpdateCallback);
          SalesObj.Lines.IterateRecords(TreePriceRecalcCallback);
          SalesObj.PostDB;
          SalesObj.Connection.CommitTransaction;
        except
          on E:Exception do begin
            SalesObj.Connection.RollbackTransaction;
          end;
        end;
      end;
    finally
      Freeandnil(SalesObj);
    end;
  end;
end;
procedure TundoManufactureSalesGUI.ProductCostUpdateCallback(const Sender: TBusObj;var Abort: Boolean);
var
  Flag:Boolean;
  fdERPFixSLCost:Double;
begin
  if not(Sender is TSalesLine) then exit;

  Flag:= TSalesLine(Sender).DoFieldChangewhenDisabled;
  TSalesLine(Sender).DoFieldChangewhenDisabled:= True;
  try
  fdERPFixSLCost := ERPFixSLCost(TSalesLine(Sender).ID);
  if fdERPFixSLCost <> 0 then begin
    TSalesLine(Sender).linecost :=fdERPFixSLCost;
    TSalesLine(Sender).postdb;
  end;
  finally
    TSalesLine(Sender).DoFieldChangewhenDisabled := Flag;
  end;

end;

Function TundoManufactureSalesGUI.ERPFixSLCost(Const SaleslineID:Integer):Double;
begin
  result:= 0;
  opendb(qryErpfixSL);
  if qryErpfixSL.Locate('SaleLineId' , SaleslineID , []) then
    REsult :=qryErpfixSLLineCost.AsFloat;
end;

procedure TundoManufactureSalesGUI.TreePriceRecalcCallback(const Sender: TBusObj;  var Abort: Boolean);
var
  Flag:Boolean;
begin
  if not(Sender is TSalesLine) then exit;
  Flag:= TSalesLine(Sender).DoFieldChangewhenDisabled;
  TSalesLine(Sender).DoFieldChangewhenDisabled:= True;
  try
    TSalesLine(Sender).DoContainerEvent(Self, evSalesLineFixTreecost);
  finally
    TSalesLine(Sender).DoFieldChangewhenDisabled := Flag;
  end;

end;
initialization
  RegisterClassOnce(TundoManufactureSalesGUI);

end.

