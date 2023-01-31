unit ProductSalesListFormSold;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProductSalesListForm, DB, DAScript, MyScript, ERPdbComponents, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, DNMSpeedButton, wwdblook, Shader, DNMPanel, ProductSalesListFormBase,
  BaseListingForm, CustomInputBox;

type
  TProductSalesListFormSoldGUI = class(TProductSalesListFormBaseGUI)
    grpPreferredLevel: TRadioGroup;
    qryMainLinesID: TIntegerField;
    qryMainClass: TWideStringField;
    qryMainClassId: TIntegerField;
    qryMainPartsID: TIntegerField;
    qryMainPREFEREDSUPP: TWideStringField;
    qryMainPartName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainShipped: TFloatField;
    qryMainAvgPrice: TFloatField;
    qryMainAvgCost: TFloatField;
    qryMainMarkup: TFloatField;
    qryMainMargin: TFloatField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainInStockQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMainSalesOrders: TFloatField;
    qryMainInvoiceBO: TFloatField;
    qryMainPreferredLevel: TFloatField;
    qryMainReorderPoint: TFloatField;
    qryMainReorderAmount: TFloatField;
    qryMainAttrib1Sale: TFloatField;
    qryMainAttrib2Sale: TFloatField;
    qryMainAttrib1SaleRate: TFloatField;
    qryMainMAAQ: TFloatField;
    qryMainDiscontinued: TWideStringField;
    qryMainOnOrder: TFloatField;
    procedure qryMainFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure grpPreferredLevelClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnExpressDetailClick(Sender: TObject);
  private
    procedure beforeShowNotSold(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses pqalib, CommonLib, ProductQtyLib, CommonFormLib, AppContextObj, DateUtils, tcConst;

{$R *.dfm}

procedure TProductSalesListFormSoldGUI.btnExpressDetailClick(Sender: TObject);
begin
  inherited;
  OpenERpListForm('TProductSalesListFormNotSoldGUI', beforeShowNotSold);
  Self.Close;
end;

procedure TProductSalesListFormSoldGUI.FormCreate(Sender: TObject);
begin
    Qrymain.SQL.clear;
    Qrymain.SQl.add('SELECT');
    Qrymain.SQl.add('PC.ID AS LinesID,');
    Qrymain.SQl.add('PC.Classname as Class,');
    Qrymain.SQl.add('PC.ClassId as ClassId,');
    Qrymain.SQl.add('P.PartsID AS PartsID,');
    Qrymain.SQl.add('P.PREFEREDSUPP as PREFEREDSUPP,');
    Qrymain.SQl.add('PartName AS PartName,');
    Qrymain.SQl.add('PARTSDESCRIPTION AS Description,');
    Qrymain.SQl.add('PT.TypeDesc AS PartType,');
    QryMain.SQL.Add('Sum(SL.QtySold) as OnOrder,');
    Qrymain.SQl.add('Sum(SL.Shipped) AS Shipped,');
    Qrymain.SQl.add('Avg(SL.LinePrice) AS "Avg Price",');
    Qrymain.SQl.add('Avg(SL.LineCost) AS "Avg Cost",');
    Qrymain.SQl.add('if (Sum(SL.LineCost) > 0, (Sum(SL.LinePrice)-Sum(SL.LineCost))  / Sum(SL.LineCost) * 100, 0) AS "Markup",');
    Qrymain.SQl.add('(Sum(SL.LinePrice-SL.LineCost))  / Sum(SL.LinePrice) * 100 AS "Margin",');
    Qrymain.SQl.add(Firstcolumn + ' AS "FirstColumn",');
    Qrymain.SQl.add(Secondcolumn + ' AS "SecondColumn",');
    Qrymain.SQl.add(Thirdcolumn + ' AS "ThirdColumn",');
    Qrymain.SQl.add(SQL4Qty(tInStock)+' as InStockQty,');
    Qrymain.SQl.add(SQL4Qty(tAvailable)+' as AvailableQty,');
    Qrymain.SQl.add(SQL4Qty(tSO     )+' as "Sales Orders",');
    Qrymain.SQl.add(SQL4Qty(tInvBO  )+' as "Invoice BO",');
    Qrymain.SQl.add('PC.ReorderPoint AS "Reorder Point",');
    Qrymain.SQl.add('PC.ReorderAmount AS "Reorder Amount",');
    Qrymain.SQl.add('PC.PreferredLevel AS PreferredLevel,');
    Qrymain.SQl.add('P.Attrib1Sale as Attrib1Sale,');
    Qrymain.SQl.add('P.Attrib2Sale as Attrib2Sale,');
    Qrymain.SQl.add('P.Attrib1SaleRate as Attrib1SaleRate,');
    Qrymain.SQl.add('P.Discontinued as Discontinued');
    Qrymain.SQl.add('From ' + ProductTables(tSummary));
    Qrymain.SQl.add('INNER JOIN tblSalesLines SL ON PQA.TransLineID = SL.SaleLineID ');
    Qrymain.SQl.add('and PQA.transtype in (' + SalesTransTypes +')');
    Qrymain.SQl.add('INNER JOIN tblSales S ON S.SaleID = SL.SaleID');
    Qrymain.SQl.add('INNER JOIN tblparttypes PT ON P.PARTTYPE = PT.TypeCode');
    Qrymain.SQl.add('WHERE P.Active = "T"');
    Qrymain.SQl.add('AND S.Deleted <> "T"');
    Qrymain.SQl.add('AND (PC.ClassID = :ClassID or :ClassID=0)');
    Qrymain.SQl.add('AND (S.SaleDate Between  :Datefrom And  :Dateto)');
    Qrymain.SQl.add('GROUP BY PartsID, ClassID');
    Qrymain.SQl.add('ORDER BY "Weekly Profit" desc');
    inherited;
    AddCalccolumn(QrymainShipped.fieldName      , False);
    AddCalccolumn(QrymainSalesOrders.fieldName  , False);
    AddCalccolumn(QrymainInvoiceBO.fieldName    , False);
    ShowChartViewOnPopup := True;
    cboClassQry.Connection := qryMain.Connection;
end;

procedure TProductSalesListFormSoldGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpPreferredLevel.hint := 'MAAQ = Monthly Average Activity Quantity' +NL;
  grpPreferredLevel.showhint := True;
  grdmain.Hint := 'MAAQ(Monthly Average Activity Quantity) = '+NL+
                  '          (Product''s Total ''Shipped Qty'' + ''Invoice Back Order Qty''  + ''Sales Order Qty'' during the period selected) /  '+NL+
                  '          No of months between the Period selected'+NL;
end;

procedure TProductSalesListFormSoldGUI.grdMainDblClick(Sender: TObject);
begin
    if TField(grdMain.GetActiveField).FieldName = 'On Order' then begin
        AppContext['PartDrillInfo'].IntVar['Department'] := cboClassQry.FieldByName('ClassID').AsInteger;
    end else if TField(grdMain.GetActiveField).FieldName = 'Sales Orders' then begin
        AppContext['PartDrillInfo'].IntVar['Department'] := cboClassQry.FieldByName('ClassID').AsInteger;
    end else if TField(grdMain.GetActiveField).FieldName = 'Invoice BO' then begin
        AppContext['PartDrillInfo'].IntVar['Department'] := cboClassQry.FieldByName('ClassID').AsInteger;
    end;
    inherited
end;

procedure TProductSalesListFormSoldGUI.grpPreferredLevelClick(Sender: TObject);
begin
    case grpPreferredLevel.ItemIndex of
      1:  GroupFilterString := ' PreferredLevel < MAAQ ' ;
      2:  GroupFilterString := ' PreferredLevel > MAAQ';
      else GroupFilterString := ' ';
    end;
  inherited grpFiltersClick(Sender);
end;

procedure TProductSalesListFormSoldGUI.beforeShowNotSold(Sender: TObject);
begin
  CopyParamsto(Sender);
  if sender is TProductSalesListFormBaseGUI then TProductSalesListFormBaseGUI(Sender).ClassID := cboclassQry.FieldByName('ClassID').AsInteger;
end;


procedure TProductSalesListFormSoldGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  QrymainMAAQ.AsFloat :=   (QrymainShipped.AsFloat + QrymainInvoiceBO.AsFloat + QrymainSalesOrders.AsFloat) * 30 / (Daysbetween(FilterDateTo,FilterDateFrom));
end;

procedure TProductSalesListFormSoldGUI.qryMainFilterRecord(DataSet: TDataSet; var Accept: Boolean);
var
  PreferredLevel: double;
  Shipped: double;
  InvoiceBO: double;
  SalesOrders: double;
begin
  inherited;
  Accept := false;

    PreferredLevel := DataSet.FieldByName('PreferredLevel').AsFloat;
    Shipped        := DataSet.FieldByName('Shipped').AsFloat;
    InvoiceBO      := DataSet.FieldByName('Invoice BO').AsFloat;
    SalesOrders    := DataSet.FieldByName('Sales Orders').AsFloat;

    case grpPreferredLevel.ItemIndex of
      1:
        begin
          if PreferredLevel < ((Shipped + InvoiceBO + SalesOrders) * 30 / (dtTo.Date - dtFrom.Date)) then Accept := true;
        end;

      2:
        begin
          if PreferredLevel > ((Shipped + InvoiceBO + SalesOrders) * 30 / (dtTo.Date - dtFrom.Date)) then Accept := true;
        end;

      else Accept := true;
    end;

end;

procedure TProductSalesListFormSoldGUI.RefreshQuery;
begin
  opendb(cboClassQry);
  Qrymain.ParamByname('ClassID').asInteger := cboClassQry.FieldByName('ClassID').asInteger;
  Qrymain.ParamByname('Datefrom').AsDatetime  := FilterDateFrom;
  Qrymain.ParamByname('Dateto').AsDatetime    := FilterDateTo;
  inherited;
  TimerMsg(FilterLabel , 'List of Products SOLD within the date range specified');
end;

procedure TProductSalesListFormSoldGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainClassid.Fieldname);
  RemoveFieldfromGrid(QrymainLinesID.Fieldname);
  RemoveFieldfromGrid(QrymainPArtsID.Fieldname);
end;

initialization
  RegisterClassOnce(TProductSalesListFormSoldGUI);
end.

