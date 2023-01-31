unit ManufactureSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader , BusObjBase, wwcheckbox, CustomInputBox;

type
  TManufactureSalesGUI = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMainSaledate: TDateField;
    qryMainisinvoice: TWideStringField;
    qryMainissalesorder: TWideStringField;
    qryMainconverted: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainTotalAmountinc: TFloatField;
    qryMainTotalcostinc: TFloatField;
    qryMainTotalcost: TFloatField;
    qryMainoldTotalcostinc: TFloatField;
    qryMainoldTotalcost: TFloatField;
    qryMainoldTotalAmountinc: TFloatField;
    qryMaincostdiff: TFloatField;
    qryMainPricediff: TFloatField;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
  private
    tablename :String;
    Procedure createSalesbackup;
    Procedure TreePriceRecalcCallback(Const Sender: TBusObj; var Abort: Boolean);
    Procedure ProductCostUpdateCallback(Const Sender: TBusObj; var Abort: Boolean);
    Procedure MakeQry;
  Protected
    Procedure RefreshQuery; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, CommonDbLib, BusObjSales, SalesConst , dateutils;

{$R *.dfm}

procedure TManufactureSalesGUI.MakeQry;
begin
  With TempMyScript do try
        SQL.Add('drop table if exists '+ tablename +';');
        SQL.Add('Create table '+tablename );
        SQL.Add('Select  distinct ');
        SQL.Add('s.SaleId as SaleId,');
        SQL.Add('s.CustomerName as customername,');
        SQL.Add('s.SAledate  as Saledate,');
        SQL.Add('S.isinvoice as isinvoice,');
        SQL.Add('S.issalesorder as issalesorder,');
        SQL.Add('S.converted as converted');
        SQL.Add('from tblsales s');
        SQL.Add('inner join tblsaleslines SL on S.SaleId = Sl.saleID');
        SQL.Add('inner join tblProctree PT on SL.SaleLineID = PT.masterId and PT.mastertype <> "mtProduct"');
        SQL.Add('Group by s.SaleID');
        SQL.Add('order by SaleId desc;') ;
        SQL.Add('Alter table ' + tablename +' add column Totalcostinc double;');
        SQL.Add('Alter table ' + tablename +' add column Totalcost double;');

        SQL.Add('Alter table ' + tablename +' add column oldTotalcostinc double;');
        SQL.Add('Alter table ' + tablename +' add column oldTotalcost double;');

        SQL.Add('Alter table ' + tablename +' add column TotalAmountinc double;');
        SQL.Add('Alter table ' + tablename +' add column oldTotalAmountinc double;');
        SQL.Add('Drop table if exists ' +tablename +'1;');
        SQL.Add('create table  ' +tablename +'1');
        SQL.Add('Select ');
        SQL.Add('SL.saleID, ');
        SQL.Add('Sum(SL.LineCostInc * SL.QtySold) Totalcostinc,  ');
        SQL.Add('Sum(SL.LineCost * SL.QtySold) Totalcost ,  ');
        SQL.Add('Sum(SL.totalLineAmountinc) totalLineAmountinc ');
        SQL.Add('from tblsaleslines SL inner join ' +tablename + ' T on T.saleId = Sl.saleID group by saleID;');
        SQL.Add('update ' +tablename +' T inner join ' +tablename + '1 T1 on T.SAleId = T1.SaleId Set T.Totalcostinc = T1.Totalcostinc , t.Totalcost = T1.Totalcost ,T.TotalAmountinc = T1.totalLineAmountinc;');

    if tableexists('erpfix_sales') and tableexists('erpfix_saleslines')  then begin
        SQL.Add('Drop table if exists ' +tablename +'1;');
        SQL.Add('create table  ' +tablename +'1');
        SQL.Add('Select ');
        SQL.Add('SL.saleID, ');
        SQL.Add('Sum(SL.LineCostInc * SL.QtySold) Totalcostinc,  ');
        SQL.Add('Sum(SL.LineCost * SL.QtySold) Totalcost ,  ');
        SQL.Add('Sum(SL.totalLineAmountinc) totalLineAmountinc ');
        SQL.Add('from erpfix_saleslines SL inner join ' +tablename + ' T on T.saleId = Sl.saleID group by saleID;');
    end;
    SQL.Add('update ' +tablename +' T inner join ' +tablename + '1 T1 on T.SAleId = T1.SaleId Set T.oldTotalcostinc = T1.Totalcostinc , t.oldTotalcost = T1.Totalcost ,T.oldTotalAmountinc = T1.totalLineAmountinc;');
    Execute;
  finally
    Free;
  end;
end;

procedure TManufactureSalesGUI.createSalesbackup;
begin
  if Tableexists('erpfix_sales') and (MessageDlgXP_Vista('Do you wish to re-create the backup tables?', mtConfirmation, [mbYes, mbNo], 0)= mrno) then exit;

  With TempMyScript do try

    SQL.add('Drop table if exists erpfix_sales;');
    SQL.add('create table erpfix_sales like tblsales;');
    SQL.add('insert into erpfix_sales select * from tblsales;');

    SQL.add('Drop table if exists erpfix_saleslines;');
    SQL.add('create table erpfix_saleslines like tblsaleslines;');
    SQL.add('insert into erpfix_saleslines select * from tblsaleslines;');

    SQL.add('Drop table if exists erpfix_Proctree;');
    SQL.add('create table erpfix_Proctree like tblProctree;');
    SQL.add('insert into erpfix_Proctree select * from tblProctree;');

    SQL.add('Drop table if exists erpfix_stockmovementLines;');
    SQL.add('create table erpfix_stockmovementLines like tblstockmovementLines;');
    SQL.add('insert into erpfix_stockmovementLines select * from tblstockmovementLines;');

    SQL.add('Drop table if exists erpfix_stockadjustentrylines;');
    SQL.add('create table erpfix_stockadjustentrylines like tblstockadjustentrylines;');
    SQL.add('insert into erpfix_stockadjustentrylines select * from tblstockadjustentrylines;');

    execute;
  finally
    Free;
  end;

end;

procedure TManufactureSalesGUI.DNMSpeedButton1Click(Sender: TObject);
var
  dt:tdatetime;
begin
  inherited;
  dt:= now;
  try

  if qrymain.RecordCount=0 then exit;

  if grdmain.SelectedList.Count =0 then
    if MessageDlgXP_Vista('No Product selected for recalculation. Do you wish to select aal products?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit
    else grdmain.selectall;
  createSalesbackup;
  IterateProcno:= 1;
  IterateselectedRecords(true);
  RefreshQuery;

  TimerMsg(lblNote , 'updating the cost in non-manufacture sales lines', 10);
  executeSQL( ' update tblparts P inner join tblsaleslines SL on P.PARTSID = Sl.productId ' +
              ' Set SL.LineCost = P.cost1 , SL.LineCostInc  = P.cost1  + P.cost1 *SL.LineTaxRate /100 ' +
              ' where ifnull(SL.LineCost ,0)<>  ifnull(P.COST1,0)');

  TimerMsg(lblNote , 'updating the cost in Stock transfers and stock adjustments ', 10);
  executeSQL( ' update tblparts P inner join tblstockmovementlines SL on P.PARTSID = Sl.productId' +
              ' Set SL.Cost = P.cost1' +
              ' where ifnull(SL.Cost ,0)<>  ifnull(P.COST1,0);'+
              ' update tblparts P inner join tblstockadjustentrylines SL on P.PARTSID = Sl.productId' +
              ' Set SL.Cost = P.cost1' +
              ' where ifnull(SL.Cost ,0)<>  ifnull(P.COST1,0);');
  finally
    MessageDlgXP_Vista('Total Execution time :' +  SecondsToTime(SecondsBetween(dt, now) , true , true), mtInformation, [mbOK], 0);
  end;
end;
procedure TManufactureSalesGUI.FormCreate(Sender: TObject);
begin
  tablename := GetUserTemporaryTableName('BOMSales');
  Qrymain.SQL.Text := 'Select * from ' +tablename ;
  inherited;
end;

procedure TManufactureSalesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (qrymainPricediff.AsFloat <> 0) or (Qrymaincostdiff.asfloat <> 0) then
    AFont.Color := clgreen;
end;

procedure TManufactureSalesGUI.grpFiltersClick(Sender: TObject);
begin
  if grpfilters.ItemIndex =0 then
    GroupFilterString := 'Pricediff <> 0 or costdiff <> 0'
  else
    GroupFilterString := '';
  inherited;

end;

procedure TManufactureSalesGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
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
procedure TManufactureSalesGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  Qrymainpricediff.AsFloat := abs(qrymaintotalamountinc.AsFloat  - qrymainoldtotalamountinc.AsFloat);
  Qrymaincostdiff.AsFloat := abs(qrymaintotalcostinc.AsFloat  - qryMainoldTotalcostinc.AsFloat);
end;

procedure TManufactureSalesGUI.RefreshQuery;
begin
  MakeQry;
  inherited;
end;

Procedure TManufactureSalesGUI.TreePriceRecalcCallback(Const Sender: TBusObj; var Abort: Boolean);
var
  Flag:Boolean;
begin
  if not(Sender is TSalesLine) then exit;
  Flag:= TSalesLine(Sender).DoFieldChangewhenDisabled;
  TSalesLine(Sender).DoFieldChangewhenDisabled:= True;
  try
    TSalesLine(Sender).DoContainerEvent(Self, evSalesLineCalcTreecost);
  finally
    TSalesLine(Sender).DoFieldChangewhenDisabled := Flag;
  end;
end;
Procedure TManufactureSalesGUI.ProductCostUpdateCallback(Const Sender: TBusObj; var Abort: Boolean);
var
  Flag:Boolean;
begin
  if not(Sender is TSalesLine) then exit;

  Flag:= TSalesLine(Sender).DoFieldChangewhenDisabled;
  TSalesLine(Sender).DoFieldChangewhenDisabled:= True;
  try
  TSalesLine(Sender).linecost :=TSalesLine(Sender).product.BuyQty1Cost;
  TSalesLine(Sender).postdb;
  finally
    TSalesLine(Sender).DoFieldChangewhenDisabled := Flag;
  end;
end;

initialization
  RegisterClassOnce(TManufactureSalesGUI);

end.

