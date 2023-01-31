{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/09/05  1.00.01 ISB  Added IgnoreDates And Enable Web Search.
 27/10/10  1.00.02 MV   Added Due Date, Ship Date, Date Entered and first line
                        of ShipTo. 
}
unit BackOrderSOForm;

interface

uses
  Windows, Messages, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ImgList, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar, PrintDAT,
  ActnList, SelectionDialog, DNMPanel, wwDialog, Wwlocate, MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, 
  wwdblook, Shader, kbmMemTable, BaseInputForm,BackorderListBase, DAScript,
  MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBackOrderSOGUI = class(TBackorderListBaseGUI)
    btnInvoiceList: TDNMSpeedButton;
    qryMainSaleID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainBackOrder: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainProduct_Description: TWideStringField;
    qryMainLinePrice: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainLineWholesalePrice: TFloatField;
    qryMainLineCost: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMainDeleted: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainConvertFromQuote: TWideStringField;
    qryMainDueDate: TDateField;
    qryMainShipDate: TDateField;
    qryMainDateEntered: TDateField;
    qryMainShippingAddress: TWideStringField;
    qryMainFutureSO: TWideStringField;
    mnuShowStatus: TMenuItem;
    N1: TMenuItem;
    btnShowStatus: TDNMSpeedButton;
    qryMainRep: TWideStringField;
    qryMainEnteredBy: TWideStringField;
    qryMainclass: TWideStringField;
    qryMainTotalLineCost: TFloatField;
    qryMainTotalLineCostinc: TFloatField;
    qryMainTotalLinePrice: TFloatField;
    qryMainTotalLinePriceInc: TFloatField;
    qryMainFirstcolumn: TWideStringField;
    qryMainSecondcolumn: TWideStringField;
    qryMainThirdcolumn: TWideStringField;
    qryMainWarrantyEndsOn: TDateField;
    qryMainWarrantyPeriod: TWideStringField;
    qryMainLineShipDate: TDateTimeField;
    qryMainSalesLinesCustField1: TWideStringField;
    qryMainSalesLinesCustField2: TWideStringField;
    qryMainSalesLinesCustField3: TWideStringField;
    qryMainSalesLinesCustField4: TWideStringField;
    qryMainSalesLinesCustField5: TWideStringField;
    qryMainSalesLinesCustField6: TWideStringField;
    qryMainSalesLinesCustField7: TWideStringField;
    qryMainSalesLinesCustField8: TWideStringField;
    qryMainSalesLinesCustField9: TWideStringField;
    qryMainSalesLinesCustField10: TWideStringField;
    qryMainBalance: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMaininstockQty: TFloatField;
    qryMainAllocatedSOQty: TFloatField;
    qryMainAllocatedBOQty: TFloatField;
    qryMainOnorderQty: TFloatField;
    qryMainonBuildQty: TFloatField;
    qryMainbuildingQty: TFloatField;
    qryMainPrintName: TWideStringField;
    procedure btnInvoiceListClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuShowStatusClick(Sender: TObject);
    procedure btnSmartOrderClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Tablename :String;
  protected
    procedure RefreshQuery; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
    procedure RefreshTotals; override;
    Function ExpressDetailListName:String;Override;
  public
    { Public declarations }
  end;

implementation
 
uses pqalib, SysUtils, frmSalesOrder, DateUtils, CommonLib, Forms, FormFactory,
  BusObjSaleBase, AppEnvironment, BusObjSales, BusObjBase, CommonDbLib,
  Sales, ProductQtyLib, FastFuncs, MySQLConst, tcConst, ThreadObjForOtherDB;
{$R *.dfm}

procedure TBackOrderSOGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Converted <> ' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'FutureSO = ' + QuotedStr('T');
      end;
    2: 
      begin
        GroupFilterString := 'Converted = ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TBackOrderSOGUI.btnInvoiceListClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  if not FormStillOpen('TSalesOrderListGUI') then begin
    tmpComponent := GetComponentByClassName('TSalesOrderListGUI');
    If not Assigned(tmpComponent) then Exit;
    with TForm(tmpComponent) do begin
      FormStyle := fsmdiChild;
      BringToFront;
    end;
  end else begin
    with TForm(FindExistingComponent('TSalesOrderListGUI')) do begin
      Show;
      BringToFront;
    end;
  end;  
  Self.Close;
end;

procedure TBackOrderSOGUI.btnSmartOrderClick(Sender: TObject);
begin
  inherited;
  MakeSmartOrder('SO');
end;

procedure TBackOrderSOGUI.RefreshQuery;
begin
  with ScriptMain do try
    SQL.Clear;
    SQL.Add('truncate ' +tablename +' ;');
    SQL.Add('insert into ' +tablename +' ');
    SQL.add('(SaleID,ClientID,ProductID,ClientTypeID, EmployeeId, SaleDate,Firstcolumn,Secondcolumn,Thirdcolumn,CustomerName,PrintName,GlobalRef,OriginalNo,SalesOrderNumber,PONumber,');
    SQL.add('BackOrder,ProductName,Product_Description,LinePrice,LinePriceInc,LineWholesalePrice,LineCost,LineCostInc,TotalLineCost,TotalLineCostinc,');
    SQL.add('TotalLinePrice,TotalLinePriceInc,WarrantyEndsOn,WarrantyPeriod,LineShipDate,Deleted,Converted,ConvertFromQuote,DueDate,ShipDate,FutureSO,');
    SQL.add('Rep,EnteredBy,class,DateEntered,ShippingAddress,SalesLinesCustField1,SalesLinesCustField2,SalesLinesCustField3,SalesLinesCustField4,');
    SQL.add('SalesLinesCustField5,SalesLinesCustField6,SalesLinesCustField7,SalesLinesCustField8,SalesLinesCustField9,SalesLinesCustField10,Balance)');
    SQL.add('SELECT');
    SQL.add('S.SaleID as SaleID,');
    SQL.add('C.ClientID as ClientID,');
    SQL.add('SL.ProductID as ProductID,');
    SQL.Add('C.ClientTypeID,');
    SQL.add('S.EmployeeID ,');
    SQL.add('S.SaleDate as SaleDate,');
    SQL.add(Firstcolumn('P')  +' as Firstcolumn,');
    SQL.add(Secondcolumn('P') +' as Secondcolumn,');
    SQL.add(Thirdcolumn('P')  +' as Thirdcolumn,');
    //SQL.add('CONCAT_WS(" ", If(InStr(C.Company,'^') -1 >0,Left(C.Company,InStr(C.Company,'^')-1),C.Company),IF(char_length(C.JobName)>0, Concat("(",C.JobName,")"),'')) as CustomerName,');
    SQL.add(SplitField('C', 'Company', 1) +' as CustomerName,');
    SQL.add('C.PrintName as PrintName,');
    SQL.add('S.GlobalRef as GlobalRef,');
    SQL.add('S.OriginalNo as OriginalNo,');
    SQL.add('S.InvoiceDocNumber as SalesOrderNumber,');
    SQL.add('S.PONumber as PONumber,');
    SQL.add('SL.BackOrder as BackOrder,');
    SQL.add('SL.ProductName as ProductName,');
    SQL.add('SL.Product_Description as Product_Description,');
    SQL.add('SL.LinePrice  as LinePrice ,');
    SQL.add('SL.LinePriceInc as LinePriceInc,');
    SQL.add('SL.LineWholesalePrice as LineWholesalePrice,');
    SQL.add('SL.LineCost as LineCost,');
    SQL.add('SL.LineCostInc as LineCostInc,');
    SQL.add('SL.BackOrder*SL.LineCost as TotalLineCost,');
    SQL.add('SL.BackOrder*SL.LineCostInc as TotalLineCostinc,');
    SQL.add('SL.BackOrder*SL.LinePrice as TotalLinePrice,');
    SQL.add('SL.BackOrder*SL.LinePriceInc as TotalLinePriceInc,');
    SQL.add('SL.WarrantyEndsOn as WarrantyEndsOn,');
    SQL.add('SL.WarrantyPeriod as WarrantyPeriod,');
    SQL.add('SL.ShipDate as LineShipDate,');
    SQL.add('S.Deleted as Deleted,');
    SQL.add('S.Converted as Converted,');
    SQL.add('S.QuoteGlobalRef as ConvertFromQuote,');
    SQL.add('S.DueDate as DueDate,');
    SQL.add('S.ShipDate as ShipDate,');
    SQL.add('S.FutureSO as FutureSO,');
    SQL.add('S.Employeename as Rep,');
    SQL.add('S.EnteredBy as EnteredBy,');
    SQL.add('S.Class as class,');
    SQL.add('S.OriginalCreationDate ,');
    SQL.add('SUBSTRING_INDEX(S.ShipTo,char(13),1) ,');
    SQL.add('SL.SalesLinesCustField1,');
    SQL.add('SL.SalesLinesCustField2,');
    SQL.add('SL.SalesLinesCustField3,');
    SQL.add('SL.SalesLinesCustField4,');
    SQL.add('SL.SalesLinesCustField5,');
    SQL.add('SL.SalesLinesCustField6,');
    SQL.add('SL.SalesLinesCustField7,');
    SQL.add('SL.SalesLinesCustField8,');
    SQL.add('SL.SalesLinesCustField9,');
    SQL.add('SL.SalesLinesCustField10,');
    SQL.add('S.Balance ');
    SQL.add('FROM tblSales S');
    SQL.add('INNER JOIN tblSalesLines SL Using(SaleID)');
    SQL.add('INNER JOIN tblParts P ON SL.ProductID=P.PARTSID');
    SQL.add('INNER JOIN tblClients C ON  (S.ClientID = C.ClientID)');
    SQL.add('WHERE S.IsRefund ="F" AND S.IsCashSale="F" AND S.IsInvoice="F" AND SL.Invoiced="F"');
    SQL.add('AND S.IsSalesOrder ="T" And S.IsQuote<>"T" AND  S.Deleted="F"');
    SQL.add('AND S.SaleDate Between '+Quotedstr(formatDateTime(MySQLDateTimeformat , filterDatefrom))  +' AND  '+Quotedstr(formatDateTime(MySQLDateTimeformat , filterDateTo))  +'');
    SQL.add('AND SL.BackOrder <> 0 AND SL.Invoiced = "F"');
    SQL.add('AND   ifnull(S.BOID , "") = ""');
    SQL.add('GROUP BY SL.SaleLineID');
    SQL.add('order by SaleLineID desc;');
    SQL.add('update '+tablename +' T inner join tblclienttype CT  on CT.ClientTypeID = T.ClientTypeID Set T.CustomerType = CT.TypeName;');
    SQL.add('Drop table if exists '+tablename +'1;');
    SQL.add('create table '+tablename +'1 select  T.GlobalRef ,     Sum(IfNull(PP.PayAmount,0)) - Sum(IfNull(PPS.TotalAmountInc,0)) as   TotalPrepay '+
                      ' from '+tablename +' T inner join tblsalesprepayments  as SPP  on SPP.SalesRef = T.GlobalRef '+
                                  ' inner join tblprepayments       as PP   on PP.GlobalRef = SPP.PrepayRef '+
                                  ' inner join tblsales             as PPS  on PPS.SOProgressPaymentGlobalRef = T.GlobalRef'+
                                  ' group by T.globalref;');
    SQL.add('update '+tablename +' T inner join '+tablename +'1 T1 on T.globalref = T1.globalref set T.TotalPrepay = T1.TotalPrepay;');
    SQL.add('Drop table if exists '+tablename +'1;');

    SQL.add('Create table '+tablename + '1  Select T.ProductID as ProductId, '+
                          ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable)  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AvailableQty,'+
                          'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') instockQty,'+
                          'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO)         +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AllocatedSOQty,'+
                          'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO)      +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AllocatedBOQty,'+
                          'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') OnorderQty,'+
                          'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') onBuildQty,'+
                          'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tBuilding)   +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') buildingQty'+
                          '  from '+tablename +' T inner join tblparts P on P.partsId = T.productId inner join  tblpqa PQA on T.productId = PQa.productID group by T.productID;');
    SQL.add('update '+tablename +' T inner join '+tablename +'1 T1 on T.ProductID = T1.ProductID '+
                                  ' Set T.AvailableQty  =T1.AvailableQty,'+
                                      'T.instockQty     =T1.instockQty,'+
                                      'T.AllocatedSOQty =T1.AllocatedSOQty,'+
                                      'T.AllocatedBOQty =T1.AllocatedBOQty ,'+
                                      'T.OnorderQty     =T1.OnorderQty,'+
                                      'T.onBuildQty     =T1.onBuildQty,'+
                                      'T.buildingQty    =T1.buildingQty ;');


    (*SQL.add('update '+tablename +' T inner join tblsalesprepayments  as SPP  on SPP.SalesRef = T.GlobalRef '+
                                  ' inner join tblprepayments       as PP   on PP.GlobalRef = SPP.PrepayRef '+
                                  ' inner join tblsales             as PPS  on PPS.SOProgressPaymentGlobalRef = T.GlobalRef'+
              ' Set T.TotalPrepay = Sum(IfNull(PP.PayAmount,0)) - Sum(IfNull(PPS.TotalAmountInc,0)) ;');*)
    (*SQL.add('update '+tablename + ' T inner join tblparts P on P.partsId = T.productId inner join  tblpqa PQA on T.productId = PQa.productID '+
                          ' Set T.AvailableQty  = Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable)  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+'),'+
                              'T.instockQty     = Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') ,'+
                              'T.AllocatedSOQty = Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO)         +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') ,'+
                              'T.AllocatedBOQty = Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO)      +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') ,'+
                              'T.OnorderQty     = Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') ,'+
                              'T.onBuildQty     = Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') ,'+
                              'T.buildingQty    = Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tBuilding)   +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') ;');*)
  finally
    Execute;
  end;
  inherited;
  btnShowStatus.Visible := qrymain.recordcount >0;
  mnuShowStatus.Visible := qrymain.recordcount >0;
end;

procedure TBackOrderSOGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TSalesOrderGUI');
  If not Assigned(tmpComponent) then Exit;
  with TSalesOrderGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

function TBackOrderSOGUI.ExpressDetailListName: String;
begin
  REsult := 'TBackOrderSOExpressGUI';
end;

procedure TBackOrderSOGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('SaleDate') + ' DESC CIS ; ' + QuotedStr('SaleID') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('SaleID') + ' DESC CIS';
  qryMain.First;
end;

procedure TBackOrderSOGUI.FormCreate(Sender: TObject);
begin
  Tablename := commondblib.GetUserTemporaryTableName('SOBackorders');
  With ScriptMain do try
    SQL.Clear;
    SQL.Add('Drop table if exists ' +tablename +' ;');
    SQL.Add('Create TABLE ' +tablename +'  (');
    SQL.Add('  ID                     INT(11) NOT NULL AUTO_INCREMENT,');
    SQL.Add('  SaleID                 INT(11) NOT NULL DEFAULT 0,');
    SQL.Add('  ClientID               INT(11) NOT NULL DEFAULT 0,');
    SQL.Add('  EmployeeID             INT(11) DEFAULT 0,');
    SQL.Add('  ProductID              INT(11) DEFAULT 0,');
    SQL.Add('  ClientTypeID           INT(11) DEFAULT 0,');
    SQL.Add('  SaleDate               DATE DEFAULT NULL,');
    SQL.Add('  Firstcolumn            VARCHAR(100) NOT NULL DEFAULT "",');
    SQL.Add('  Secondcolumn           VARCHAR(100) NOT NULL DEFAULT "",');
    SQL.Add('  Thirdcolumn            VARCHAR(100) NOT NULL DEFAULT "",');
    SQL.Add('  CustomerName           VARCHAR(100) DEFAULT NULL,');
    SQL.Add('  PrintName              VARCHAR(100) DEFAULT NULL,');
    SQL.Add('  CustomerType           VARCHAR(50) DEFAULT NULL,');
    SQL.Add('  GlobalRef              VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  OriginalNo             VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesOrderNumber       VARCHAR(30) DEFAULT NULL,');
    SQL.Add('  PONumber               VARCHAR(30) DEFAULT NULL,');
    SQL.Add('  BackOrder              double NOT NULL DEFAULT 0,');
    SQL.Add('  ProductName            VARCHAR(100) DEFAULT NULL,');
    SQL.Add('  Product_Description    VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  LinePrice              double NOT NULL DEFAULT 0,');
    SQL.Add('  LinePriceInc           double NOT NULL DEFAULT 0,');
    SQL.Add('  LineWholesalePrice     double NOT NULL DEFAULT 0,');
    SQL.Add('  LineCost               double NOT NULL DEFAULT 0,');
    SQL.Add('  LineCostInc            double NOT NULL DEFAULT 0,');
    SQL.Add('  TotalLineCost          double NOT NULL DEFAULT 0,');
    SQL.Add('  TotalLineCostinc       double NOT NULL DEFAULT 0,');
    SQL.Add('  TotalLinePrice         double NOT NULL DEFAULT 0,');
    SQL.Add('  TotalLinePriceInc      double NOT NULL DEFAULT 0,');
    SQL.Add('  WarrantyEndsOn         DATE DEFAULT NULL,');
    SQL.Add('  WarrantyPeriod         VARCHAR(100) DEFAULT NULL,');
    SQL.Add('  LineShipDate           datetime DEFAULT NULL,');
    SQL.Add('  Deleted                ENUM("T","F") NOT NULL DEFAULT "F",');
    SQL.Add('  Converted              ENUM("T","F") NOT NULL DEFAULT "F",');
    SQL.Add('  ConvertFromQuote       VARCHAR(255) DEFAULT NULL DEFAULT "",');
    SQL.Add('  DueDate                DATE DEFAULT NULL,');
    SQL.Add('  ShipDate               DATE DEFAULT NULL,');
    SQL.Add('  FutureSO               ENUM("T","F") NOT NULL DEFAULT "F",');
    SQL.Add('  Rep                    VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  EnteredBy              VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  class                  VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  DateEntered            DATE DEFAULT NULL,');
    SQL.Add('  ShippingAddress        VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesLinesCustField1   VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesLinesCustField2   VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesLinesCustField3   VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesLinesCustField4   VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesLinesCustField5   VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesLinesCustField6   VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesLinesCustField7   VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesLinesCustField8   VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesLinesCustField9   VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  SalesLinesCustField10  VARCHAR(255) DEFAULT NULL,');
    SQL.Add('  Balance                double DEFAULT NULL,');
    SQL.Add('  TotalPrepay            double DEFAULT NULL,');
    SQL.Add('  AvailableQty           Double NOT NULL DEFAULT 0,');
    SQL.Add('  instockQty             Double NOT NULL DEFAULT 0,');
    SQL.Add('  AllocatedSOQty         Double NOT NULL DEFAULT 0,');
    SQL.Add('  AllocatedBOQty         Double NOT NULL DEFAULT 0,');
    SQL.Add('  OnorderQty             Double NOT NULL DEFAULT 0,');
    SQL.Add('  onBuildQty             Double NOT NULL DEFAULT 0,');
    SQL.Add('  buildingQty            Double NOT NULL DEFAULT 0,');
    SQL.Add('  PRIMARY KEY (`ID`)');
    SQL.Add(') ENGINE=MyISAM DEFAULT CHARSET=utf8');
  finally
    Execute;
    SQL.Clear;
  end;
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('Select ');
  Qrymain.SQL.add('*');
  Qrymain.SQL.add('From ' + Tablename );

  //NoDateRange := true;
  fbEnableWebSearch := true;
(*  if Qrymain.active then Qrymain.Close;
  Qrymain.SQL.text:=     StringReplace(StringReplace(StringReplace(Qrymain.SQL.text,
                      '" " as Firstcolumn'  ,Firstcolumn('tblParts') +' as Firstcolumn'  , [rfIgnoreCase]),
                      '" " as Secondcolumn' ,Secondcolumn('tblParts')+' as Secondcolumn' , [rfIgnoreCase]),
                      '" " as Thirdcolumn'  ,Thirdcolumn('tblParts') +' as Thirdcolumn'  , [rfIgnoreCase]);*)
  qryMainFirstcolumn.DisplayLabel := AppEnv.DefaultClass.FirstColumn;
  qryMainSecondcolumn.DisplayLabel:= AppEnv.DefaultClass.Secondcolumn;
  qryMainThirdcolumn.DisplayLabel := AppEnv.DefaultClass.Thirdcolumn;
  inherited;
  AddCalccolumn('BackOrder', false);
  AddCalccolumn('TotalLineCost', true);
  AddCalccolumn('TotalLineCostinc', true);
  AddCalccolumn('TotalLinePrice', true);
  AddCalccolumn('TotalLinePriceInc', true);
  ShowChartViewOnPopup := True;  
end;

procedure TBackOrderSOGUI.FormDestroy(Sender: TObject);
begin
  commondblib.DestroyUserTemporaryTable(Tablename);
  inherited;
end;

procedure TBackOrderSOGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  if  (FormFact.Identifier = 'OriginalNo') then
    Popupform.KeyID := TSalesBase.IDToggle(qryMain.Fields.FieldByName(FormFact.Identifier).AsString)
  else inherited;

end;

procedure TBackOrderSOGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'ClientId,SaleId,EmployeeId,ProductId');
   if  AppEnv.CompanyPrefs.ShowSalesWarrantyEndsOn then begin
    grdmain.AddField('WarrantyEndsOn');
   end else begin
    RemoveFieldfromGrid('WarrantyEndsOn');
   end;

   if  AppEnv.CompanyPrefs.ShowSalesWarrantyPeriod then begin
    grdmain.AddField('WarrantyPeriod');
   end else begin
    RemoveFieldfromGrid('WarrantyPeriod');
   end;

  if Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption) <> '' then
    grdmain.ColumnByName('WarrantyEndsOn').DisplayLabel :=
      Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption);

  if Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption) <> '' then
    grdmain.ColumnByName('WarrantyPeriod').DisplayLabel :=
      Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption);

end;

procedure TBackOrderSOGUI.mnuShowStatusClick(Sender: TObject);
var
  SalesOrderObj:TSalesOrder;
begin
  if qryMainSaleID.asInteger =0 then exit;
  
  SalesOrderObj:=TSalesOrder.create(Self);
  Try
    SalesOrderObj.connection := TMyDacDataConnection.Create(SalesOrderObj);
    SalesOrderObj.connection.Connection := CommonDBLib.GetNewMyDacConnection(Self);
    SalesOrderObj.Load(qrymainsaleID.ASInteger);
    if not SalesOrderObj.Lock then Exit;
    SalesOrderObj.connection.BeginTransaction;
    if TBaseSaleGUI.showStock(SalesOrderObj, self.Color , nil , self) then begin
      SalesOrderObj.connection.CommitTransaction;
    end else begin
      SalesOrderObj.connection.RollbackTransaction;
    end;
  Finally
      FreeAndNil(SalesOrderObj);
  end;
end;

{}
procedure TBackOrderSOGUI.RefreshTotals;
begin
  inherited;
 CalcnShowFooter;
end;

initialization
  RegisterClassOnce(TBackOrderSOGUI);
end.
