unit ProductMovementList;

{
 Date     Version  Who  What
 -------- -------- ---  --------------------------------------------------------
 03/11/05 1.00.00  MV   Initial verson.
}

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, wwdblook, wwcheckbox, 
  Shader,  BaseInputForm, kbmMemTable, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductMovementForm = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    cboPart: TwwDBLookupCombo;
    cboPartsQry: TERPQuery;
    QryClasses: TERPQuery;
    QryClassesClassId: TIntegerField;
    QryClassesclassname: TWideStringField;
    qryMainclassname: TWideStringField;
    qryMainID: TIntegerField;
    qryMainPQAID: TIntegerField;
    qryMainPeriod: TDateTimeField;
    qryMainTransType: TWideStringField;
    qryMainformName: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainTransactionNo: TLargeintField;
    qryMainStockmovementEntryglobalref: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainQty: TFloatField;
    qryMainAvailqty: TFloatField;
    qryMainTotalCost: TFloatField;
    qryMainAverageCost: TFloatField;
    qryMainCost: TFloatField;
    qryMainProductID: TIntegerField;
    qryMainClassID: TLargeintField;
    qryMainRunningTotal: TFloatField;
    qryMainRunningTotalAvailable: TFloatField;
    qryMainconverted: TWideStringField;
    qryMaininvID: TIntegerField;
    qryMainSOID: TIntegerField;
    qryMainStSID: TIntegerField;
    Label4: TLabel;
    qryMaincTranstype: TWideStringField;
    qryMainFromStock: TWideStringField;
    qryMainExtraDesc: TWideStringField;
    qryMainavailable: TFloatField;
    qryMaininstock: TFloatField;
    qryMainonbuild: TFloatField;
    qryMaininvbo: TFloatField;
    qryMainSo: TFloatField;
    qryMainBuilding: TFloatField;
    qryMainQtydiff: TFloatField;
    btnShowAtychecking: TDNMSpeedButton;
    qryMainPrice: TFloatField;
    qryMaintotalprice: TFloatField;
    btnListWithformula: TDNMSpeedButton;
    qryMaininstockQty: TFloatField;
    pnlrunnittotalOpt: TDNMPanel;
    Label2: TLabel;
    chkrunnittotalOpt: TwwCheckBox;
    qryMainRunningTotalInstock: TFloatField;
    qryMainSAID: TIntegerField;
    qryMainSTID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cboPartCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;      State: TGridDrawState; Highlight: Boolean; AFont: TFont;      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure cmdshowQtychecking(Sender: TObject);
    procedure TitleLabelDblClick(Sender: TObject);
    procedure btnListWithformulaClick(Sender: TObject);
    procedure chkrunnittotalOptClick(Sender: TObject);
    procedure cboPartsQryBeforeOpen(DataSet: TDataSet);

  private
    fiClassId: Integer;
    invID,SoID:Integer;
    fbisManufacturingProduct:Boolean;
    istoShowQtyChecking:Boolean;
    fsProductIDs:String;

    procedure setClassID(const Value: Integer);
    function isManufacturingProduct:Boolean;
    procedure REmoveQtyCheckfields;
    procedure AddQtyCheckfields;
    procedure BeforeshowStockSummaryFormula(Sender: TObject);
    Procedure MakeQrymain;
    procedure MakeTempTable;
    procedure SetMovementListAsOn(const Value: TDateTime);

    (*procedure DoBeforeExecute(Sender: TObject; var SQL: String;var Omit: Boolean);*)
  protected
    Tablename : STring;
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI);  override;
    Procedure SetGridColumns;override;
  public
    Property ClassId :Integer read fiClassId Write setClassID;
    Property ProductIDs :String read fsProductIDs write fsProductIDs;
    Property MovementListAsOn :TDateTime write SetMovementListAsOn;
    Class Procedure showList(AOwner:Tform; ProductID, DepartmentID:Integer;AsOndate:TDateTime =0);
    Class Procedure showListforProducts(AOwner:Tform; ProductIDs:String;AsOndate:TDateTime =0);
  end;

//var
//  ProductMovementForm: TProductMovementForm;

implementation

uses pqalib,
  CommonDbLib,   AppEnvironment, CommonLib, tcConst, ProductQtyLib, Dateutils,
  FastFuncs, busobjStockMovement, BusobjStockAdjustEntry,
  busobjstockTransferentry, CommonFormLib, BaseFormForm, StockSummaryFormula,
  ProductStockReportLib, tcDataUtils, LogLib, DbSharedObjectsObj , math;

{$R *.dfm}

procedure TProductMovementForm.MakeTempTable;
var
  fiPartsID:Integer;
  function ExtraSQL:String;
  begin
    result := NL+'Update ' + tablename +' Set cTranstype = transType ;' +NL+
                 'Update ' + tablename +' Set cTranstype = ''Layby'' where transType =''TPOSLaybylines'';' +NL+
                 iif(fbisManufacturingProduct , 'Update ' + tablename +' Set cTranstype = ''Sales Order (From Stock)'' where transType =''Sales Order'' and FromStock ="T";', '');
  end;
begin
  if ProductIDs <> '' then begin
    ExecuteSQLwithProgress(ChangeQuery( ProductStockReportLib.SQLtoAddDataToProductMovementTable(Tablename, ProductIDs,True , filterdatefrom , filterdateTo)+ExtraSQL) );
  end else begin
    fiPartsID:= 0;
    try
      if  cboPart.text <> '' then fiPartsID:= cboPartsQry.fieldByname('PartsID').asInteger;
      ExecuteSQLwithProgress(ChangeQuery( ProductStockReportLib.SQLtoAddDataToProductMovementTable(Tablename, inttostr(fiPartsID),True , filterdatefrom , filterdateTo)+ExtraSQL));
    finally
        btnListWithformula.Visible := Producthasformula(fipartsID);
    end;
  end;
end;
(*function TProductMovementForm.SQLtoAddDataToProductMovementTable:String;
var
  //ScriptTemp: TERPScript;
  fiPartsID :Integer;
  st:TStringlist;
  filename:String;
  ssql:String;
  QtyRoundTo:Integer;
begin
     QtyRoundTo:= appEnv.CompanyPrefs.QtyRoundTo;
    if cboPart.text <> '' then fiPartsID:= cboPartsQry.fieldByname('PartsID').asInteger else  fiPartsID:= 0;
    try
      ST := TStringlist.create;
      try


        ssql := ' insert into  ' +tablename + ' (TransactionDate,TransType,PQATranstype, FormName,StockMovementEntryglobalref,'+
                                                                'ProductName,FirstColumn,SecondColumn,ThirdColumn,Qty,AvailQty,'+
                                                                'TotalCost,AverageCost,Cost,'+
                                                                'TotalPrice,Price,'+
                                                                'ProductID,ClassID,TransactionNo,TransLineID, RunningTotal,RunningTotalAvailable,'+
                                                                'InvID,SoID,'+
                                                                'available,instock,so,invbo,pobo,OnBuild,building,'+
                                                                'Converted, alloctype) ';
        ssql := ssql +' Select  PQA.TransDate as TransactionDate,' ;
        ssql := ssql +' if(ifnull(SMTT.Description,"")<> "" ,SMTT.Description, if(ifnull(TT.Description,"") = "" , PQA.TransType , TT.Description))  as TransType,' ;
        ssql := ssql +' PQA.TransType as PQATranstype,' ;
        ssql := ssql +' ifnull(TT.formName, SMTT.formname) as formName,' ;
        ssql := ssql +' SM.StockmovementEntryglobalref,' ;
        ssql := ssql +' PQA.ProductName as ProductName,' ;
        ssql := ssql +firstColumn + ' As Firstcolumn,' ;
        ssql := ssql +Secondcolumn + ' As Secondcolumn,' ;
        ssql := ssql +Thirdcolumn + ' As Thirdcolumn,' ;
        ssql := ssql + SQL4Qty(tTransQty) +' as Qty,' ;
        ssql := ssql + SQL4Qty(tAvailable) +' as AvailQty,' ;
        {ST.ADD('P.AvgCost * ' + SQL4Qty(tAvailable) +' as TotalCost,' ;}
        ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost)  * ' + SQL4Qty(tAvailable) +' as totalcost,' ;
        ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost) as AverageCost,' ;
        ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost)  as Cost ,' ;
        ssql := ssql +' P.PRICEINC1 * ' + SQL4Qty(tAvailable) +' as totalPrice,' ;
        ssql := ssql +' P.PRICEINC1  as Price,' ;
        ssql := ssql +' PQA.ProductID ,' ;
        ssql := ssql +' PQA.DepartMentID as ClassID,' ;
        ssql := ssql +' PQA.TransID as TransactionNo,' ;
        ssql := ssql +' PQA.TransLineID as TransLineID,' ;
        ssql := ssql +' 0.0 as RunningTotal, ' ;
        ssql := ssql +' 0.0 as RunningTotalAvailable,' ;
        ssql := ssql +' 0 as InvID,' ;//ssql := ssql +' Inv.SaleId as InvID,' ;
        ssql := ssql +' 0 as  SoID,' ;//ssql := ssql +' So.SaleID as SoID,' ;
       ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable)+',0.0),' + IntToStr(QtyRoundTo)+') AS "Available",';
       ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock)  +',0.0),' + IntToStr(QtyRoundTo)+') AS "InStock",';
       ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO)       +',0.0),' + IntToStr(QtyRoundTo)+') AS "so",';
       ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO)    +',0.0),' + IntToStr(QtyRoundTo)+') AS "InvBo",';
       ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO)     +',0.0),' + IntToStr(QtyRoundTo)+') AS "POBO",';
       ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild)  +',0.0),' + IntToStr(QtyRoundTo)+') AS "OnBuild",';
       ssql := ssql + '0-Round(IF(P.PARTTYPE="INV",' +ProductQtylib.SQL4Qty(tBuilding) +',0.0),' + IntToStr(QtyRoundTo)+') AS "Building",';
        ssql := ssql +' S3.Converted as Converted, PQA.AllocType' ;
        ssql := ssql +' FROM ' + ProductTables(tSummary, False, TRue);
        //ssql := ssql +' LEFT join `tblSales` S on S.SaleId = PQA.TransID and ((PQA.TRansType in ("TSalesOrderline" )  and S.converted = "T") or(PQA.TransType in ("TProcTreePart") and PQA.AllocType = "IN" and S.Converted = "T") )' ;
        //ssql := ssql +' LEFT join `tblSales` Inv on ifnull(Inv.SalesOrderGlobalref,"") =S.globalref' ;
        //ssql := ssql +' LEFT join `tblSales` S2 on S2.SaleId = PQA.TransID and PQA.TRansType in ("TInvoiceLine" )' ;
        //ssql := ssql +' LEFT join `tblSales` SO on ifnull(S2.SalesOrderGlobalref,"") =SO.globalref ' ;
        ssql := ssql +' LEFT join `tblSales` S3 on S3.SaleId = PQA.TransID and ((PQA.TRansType in ("TSalesOrderline" )) or (PQA.TransType in ("TProcTreePart") and PQA.AllocType = "IN"))' ;
        ssql := ssql +' LEFt JOIN `tblStockMovement` SM on SM.StockmovementId = PQA.TransId and PQA.TransType = ' + QuotedStr(TStockMovementLines.classname);
        ssql := ssql +' LEFt JOIN `tblpqatranstypes` as SMTT on SM.StockmovementEntryType = SMTT.TransType' ;
        ssql := ssql +' Where PQA.ProductID = '+IntToStr(fiPartsID) ;
        if IgnoreDates.checked = False then
           ssql := ssql +'  AND PQA.TransDate Between ' +Quotedstr(FormatDateTime(MysqlDateFormat, dtfrom.DateTime)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, incday(dtTo.DateTime)));
        ssql := ssql +'  and ' + SQL4QtyField(tAvailable) +' <> 0' ;
        ssql := ssql +' group by  TransDate , PQA.TransID, PQA.productID, PQA.TRansType, PQA.departmentID, PQA.PQAID' ;
        ssql := ssql +' Union All' ;
        ssql := ssql +' Select  cast(0 as Date) as TransactionDate,' ;
        ssql := ssql +' "Opening Balance" as TransType,' ;
        ssql := ssql +' "" ,' ;
        ssql := ssql +' "" ,' ;
        ssql := ssql +' "",' ;
        ssql := ssql +' PartName,' ;
        ssql := ssql +firstColumn + ',' ;
        ssql := ssql +Secondcolumn + ',' ;
        ssql := ssql +Thirdcolumn + ' ,' ;
        ssql := ssql + '0 ,' ;
        ssql := ssql + '0 ,' ;
        ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost)  ,' ;
        ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost)  ,' ;
        ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost)  ,' ;
        ssql := ssql +' P.PRICEINC1  as totalPrice,' ;
        ssql := ssql +' P.PRICEINC1  as Price,' ;
        ssql := ssql +' PartsId ,' ;
        ssql := ssql +' 0 ,' ;
        ssql := ssql +' 0 ,' ;
        ssql := ssql +' 0 ,' ;
        ssql := ssql +' 0.0 ,' ;
        ssql := ssql +' 0.0 ,' ;
        ssql := ssql +' 0 as InvID,' ;
        ssql := ssql +' 0 as SoID,' ;
        ssql := ssql +' 0,0,0,0,0,0,0,';
        ssql := ssql +' "F" as Converted, "IN"' ;
        ssql := ssql +' FROM `tblparts` P ' ;
        ssql := ssql +' Where PartsId = '+IntToStr(fiPartsID)+';' ;
        ssql := ssql +' update ' +tablename+' t inner join `tblSales` S on S.SaleId = T.TransactionNo and ((T.PQATranstype in ("TSalesOrderline" )  and S.converted = "T") or(T.PQATranstype in ("TProcTreePart") and T.AllocType = "IN" and S.Converted = "T") )'+
                ' INNER  join `tblSales` Inv on ifnull(Inv.SalesOrderGlobalref,"") =S.globalref Set T.InvId = Inv.saleID;' ;
        ssql := ssql +' update ' +tablename+' t inner join `tblSales` S2 on S2.SaleId = T.TransactionNo and T.PQATranstype in ("TInvoiceLine" )'+
                ' INNER join `tblSales` SO on ifnull(S2.SalesOrderGlobalref,"") =SO.globalref Set T.SOID = So.SaleId;' ;
        st.add('Truncate ' +tablename +';');
        st.add(ChangeQuery(ssql));
        {st.add(CreateTemporaryTableusingfile('' , ssql , 'TransactionDate,TransType,PQATranstype, FormName,StockMovementEntryglobalref,'+
                                                                'ProductName,FirstColumn,SecondColumn,ThirdColumn,Qty,AvailQty,TotalCost,AverageCost,Cost,'+
                                                                'ProductID,ClassID,TransactionNo,TransLineID, RunningTotal,RunningTotalAvailable,'+
                                                                'InvID,SoID,Converted' , tablename , filename ));}

        ST.add(ChangeQuery('update  '+ Tablename +'  T ' +
                ' inner join `tblSalesLines` SL on SL.sAlelineId = T.TransLineId and T.PQATranstype  in (' + SalesTransTypes+')' +
                ' set T.cost = Sl.LineCostInc,  TotalCost = Sl.LineCostInc * AvailQty where ifnull(Sl.LineCostinc,0)<>0 ;'));

        ST.add(ChangeQuery('update  '+ Tablename +'  T ' +
                ' inner join `tblSalesLines` SL on SL.sAlelineId = T.TransLineId and T.PQATranstype  in (' + SalesTransTypes+')' +
                ' set T.Price = Sl.LinePriceInc,  TotalPrice = Sl.LinePriceInc * AvailQty where ifnull(Sl.LinePriceInc,0)<>0 ;'));


        ST.add(ChangeQuery('update  '+ Tablename +'  T ' +
                ' inner join `tblpurchaselines` PL on PL.PurchaseLineID = T.TransLineId and T.PQATranstype  in (' + POTranstypes+')' +
                ' set  T.cost =  PL.LineCostInc ,  TotalCost = PL.LineCostInc * AvailQty where ifnull(PL.LineCostinc,0)<>0 ;'));

        ST.add(ChangeQuery('update  '+ Tablename +'  T ' +
                ' inner join `tblpurchaselines` PL on PL.PurchaseLineID = T.TransLineId and T.PQATranstype  in (' + POTranstypes+')' +
                ' set  T.price =  NULL ,  Totalprice = NULL ;'));

        ST.add(ChangeQuery('update  '+ Tablename +'  T ' +
                ' inner join `tblstockmovementlines` SML on SML.StockmovementLinesID = T.TransLineId and T.PQATranstype  in (' + StockMovementtypes+')' +
                ' set  T.cost =  SML.cost , TotalCost = SML.cost * AvailQty where ifnull(SML.Cost,0)<>0 ;'));

        ST.add(ChangeQuery('update  '+ Tablename +'  T ' +
                ' inner join `tblstockmovementlines` SML on SML.StockmovementLinesID = T.TransLineId and T.PQATranstype  in (' + StockMovementtypes+')' +
                ' set  T.PRICE =  NULL, TotalPrice = NULL ;'));

       ST.add(ChangeQuery('update  '+ Tablename +'  T ' +
              ' inner Join `tblproctreepart`        AS PTP  ON PTP.ProcTreePartId = T.TransLineID           and T.PQATRanstype in (' +ManufactureTypes+')' +
              ' inner join `tblproctree`  As PT on PT.ProcTreeId = PTP.ProcTreeID ' +
              ' Set T.cost =  PT.Cost/Quantity , TotalCost = PT.Cost/Quantity * AvailQty where ifnull(PT.Cost,0)<>0 ;'));

       ST.add(ChangeQuery('update  '+ Tablename +'  T ' +
              ' inner Join `tblproctreepart`        AS PTP  ON PTP.ProcTreePartId = T.TransLineID           and T.PQATRanstype in (' +ManufactureTypes+')' +
              ' inner join `tblproctree`  As PT on PT.ProcTreeId = PTP.ProcTreeID ' +
              ' set  T.PRICE =  NULL, TotalPrice = NULL ;'));

       ST.add(ChangeQuery('update  '+ Tablename +'  T ' +
                ' inner join `tblSalesLines` SL on SL.sAlelineId = T.TransLineId and T.Transtype = "Sales Order" ' +
                ' inner join `tblproctree` PT on Sl.SaleLineId	= PT.masterID and PT.ParentID=0 and PT.Mastertype <> "mtProduct" ' +
                ' Set T.FromStock = "T" where PT.PartSource = "psStock" ;'));

        {AppEnv.UtilsClient.DeleteServerFiles(replaceStr(Filename, '.tmp' , '*.tmp'));}
        //ExecuteSQL(St.text);
        REsult := St.Text;
     finally
        AppEnv.UtilsClient.DeleteServerFiles(replaceStr(Filename, '.tmp' , '*.tmp'));
        Freeandnil(st);
      end;
    finally
      btnListWithformula.Visible := Producthasformula(fipartsID)
    end;
end;*)
procedure TProductMovementForm.RefreshQuery;
var
  s:String;
begin
  Disableform;
  try
    fbisManufacturingProduct := isManufacturingProduct;
    MakeTempTable;
    inherited;
    qryMain.FieldByName('ThirdColumn').DisplayLabel   := AppEnv.DefaultClass.ThirdColumn;
    qryMain.FieldByName('SecondColumn').DisplayLabel  := AppEnv.DefaultClass.SecondColumn;
    qryMain.FieldByName('FirstColumn').DisplayLabel   := AppEnv.DefaultClass.FirstColumn;
    TFloatField(qryMain.FieldByName('Total Cost')).DisplayFormat := AppEnv.RegionalOptions.CurrencySymbol+'#,###,##0.00';
    PopulateFilterCombo;
    RefreshTotals;
    s:= qrymain.Filter;
    try
      if classId <> 0 then begin
        if s<> '' then s := '('+Qrymain.Filter +') and ';
        s:= s +'( ClassID = ' + IntToStr(ClassID)+')';
        ClassId := 0;
      end;
    finally
      if s <> '' then s := '(' + s +') or (TransType = ' +quotedstr('Opening Balance')+')';
      Qrymain.filter := s;
      Qrymain.filtered := Qrymain.filter <> '';
    end;
    Logtext(Qrymain.SQLtext);
  finally
    EnableForm;
  end;
end;

procedure TProductMovementForm.RefreshTotals;
var
  Qtys, instockQtys, ACosts, RTotal, RTotalinstock,Atotal, totAvg, totCost: double;
begin
  Qtys := 0.00;
  instockQtys := 0.00;
  ACosts := 0.00;
  RTotal := 0;
  RTotalinstock := 0;
  ATotal:= 0;
  totAvg := 0;
  totCost := 0;
  showProgressbar('Calculating Running Balance', Qrymain.recordcount, false);
  try
      qryMain.DisableControls;
      try
        qryMain.Last;
        while not qryMain.Bof do begin
          if sametext(Qrymaintranstype.asString,'Opening Balance') then begin
            Qtys    := 0;
            instockQtys    := 0;
            ACosts  := 0;
            RTotal  := 0;
            RTotalinstock  := 0;
            Atotal:= 0;
          end else begin
            Qtys    := Qtys + qryMain.FieldByName('Qty').AsCurrency;
            instockQtys := Qtys + qryMain.FieldByName('instockQty').AsCurrency;
            ACosts  := ACosts + qryMain.FieldByName('Total Cost').AsCurrency;
            RTotal  := RTotal + qryMain.FieldByName('Qty').AsFloat;
            RTotalinstock  := RTotalinstock + qryMain.FieldByName('instockQty').AsFloat;
            Atotal:= Atotal + qryMain.FieldByName('AvailQty').AsFloat;
            totAvg := totAvg + qryMain.FieldByName('AverageCost').AsCurrency;
            totCost := totCost + qryMain.FieldByName('Cost').AsCurrency;
          end;
          if qryMain.state in [dsEdit,dsinsert] then else qryMain.Edit;
          qryMain.FieldByName('RunningTotal').AsFloat := Round(RTotal,(*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces);
          qryMain.FieldByName('RunningTotalInstock').AsFloat := Round(RTotalinstock,(*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces);
          qryMain.FieldByName('RunningTotalAvailable').AsFloat := Round(ATotal,(*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces);
          if qryMain.state in [dsEdit,dsinsert] then qryMain.Post;
          qryMain.Prior;
          StepProgressbar( inttostr(Qrymain.recordcount-Qrymain.recno)+ ' of ' + inttostr(Qrymain.recordcount));
        end;
      finally
        qryMain.First;
        qryMain.EnableControls;
      end;
  finally
    HideProgressbar;
  end;
  grdMain.ColumnByName('Qty').FooterValue         := FloatToStrF(Qtys, ffFixed, 15, 2);
  grdMain.ColumnByName('instockQty').FooterValue  := FloatToStrF(instockQtys, ffFixed, 15, 2);
  grdMain.ColumnByName('Total Cost').FooterValue  := FloatToStrF(ACosts, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('AverageCost').FooterValue := FloatToStrF(totAvg, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Cost').FooterValue := FloatToStrF(totCost, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TProductMovementForm.FormCreate(Sender: TObject);
begin
  istoShowQtyChecking:= False;
  NonSearchMode := True;
  invID:= 0;
  SOID:=0;
//  tablename := CommonDbLib.GetUserTemporaryTableName('tmp_ProductMovement');
  ClassID :=0;
  fsProductIDs:= '';
  MakeQrymain;
  inherited;
  UseSortinSearch := False;
  DisableSortoncolumtitleclick:= TRue;
  ShowChartViewOnPopup := True;
  if not ErrorOccurred then begin
    cboPartsQry.Connection := qryMain.Connection;
    cboPartsQry.Open;
    cboPartsQry.first;
  end;
  showcontrolhint(pnlrunnittotalOpt ,'When Checked , ' + qrymainRunningTotal.displaylabel +' is Calculated based on the "Instock Qty"' + NL +
                                     'When Un-Checked , ' + qrymainRunningTotal.displaylabel +' is Calculated based on the "Actual Stock with Manufacturing Qty"' );
end;

procedure TProductMovementForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  REmoveQtyCheckfields;
  DestroyUserTemporaryTable(tablename);
  inherited;
end;

procedure TProductMovementForm.FormShow(Sender: TObject);
begin
    inherited;
    btnShowAtychecking.visible := False;
    {$IFDEF DevMode}
      btnShowAtychecking.visible := true;
    {$ENDIF}
    (*if cboPartsQry.active = false then cboPartsQry.open;
    cboPart.Text :=cboPartsQry.fieldByname('PartName').asSTring;
    RefreshQuery;*)
    pnlHeader.Caption := 'Product Movement';
    grdmain.hint := 'Total cost = Product''s Current Average Cost * Transaction Qty';
    grdmain.showhint := true;
    try DoHideProgressbar; except end;
end;

procedure TProductMovementForm.cboPartCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TProductMovementForm.cboPartsQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cboPartsQry.Connection := Listconnection;
end;

procedure TProductMovementForm.cmdshowQtychecking(Sender: TObject);
begin
  inherited;
  if istoShowQtyChecking then istoShowQtyChecking:= False  else istoShowQtyChecking := True;
  if istoShowQtyChecking then AddQtyCheckfields else REmoveQtyCheckfields;
  if istoShowQtyChecking then btnShowAtychecking.caption := 'Hide Qty checking' else btnShowAtychecking.caption := 'Show Qty Checking';
end;

procedure TProductMovementForm.btnListWithformulaClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TStockSummaryFormulaGUI' ,BeforeshowStockSummaryFormula);
end;
procedure TProductMovementForm.BeforeshowStockSummaryFormula(Sender: TObject);
begin
  if not(Sender is TStockSummaryFormulaGUI) then exit;
  TStockSummaryFormulaGUI(Sender).ProductId := cboPartsQry.FieldByname('PArtsID').asInteger;
end;

procedure TProductMovementForm.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  inherited;

  RefreshTotals;
end;

procedure TProductMovementForm.AddQtyCheckfields;
begin
    grdmain.AddField('fieldname');
    grdmain.AddField('available');
    grdmain.AddField('instock');
    grdmain.AddField('onbuild');
    grdmain.AddField('invbo');
    grdmain.AddField('So');
    grdmain.AddField('POBO');
    grdmain.AddField('Building');
    grdmain.AddField('QtyDiff');
end;

procedure TProductMovementForm.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if (Sysutils.SameText(qryMain.FieldByname('TransType').asString , TStockTransferEntry.Transtype)) then begin
    Popupform.KeyId:= TStockTransferEntry.IDToggle(QrymainStockmovementEntryglobalref.asString);
  end else if (Sysutils.SameText(qryMain.FieldByname('TransType').asString , TStockAdjustEntry.Transtype)) then begin
    Popupform.KeyId := TStockAdjustEntry.IDToggle(QrymainStockmovementEntryglobalref.asString);
  end;
  if Popupform.KeyId = 0 then inherited;
end;

procedure TProductMovementForm.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid('ProductID');
    RemoveFieldfromGrid('classid');
    RemoveFieldfromGrid('ID');
    RemoveFieldfromGrid('Formname');
    RemoveFieldfromGrid('Transtype');
    RemoveFieldfromGrid('StockMovementEntryGlobalref');
    RemoveFieldfromGrid('FromStock');
    if not devmode then
      RemoveFieldfromGrid('PQAID');
    (*RemoveFieldfromGrid('Availqty');*)
    RemoveFieldfromGrid('qty');
    REmoveQtyCheckfields;
    qryMainPeriod.Displayformat := FormatSettings.ShortDateformat;
    if ProductIDs <> '' then begin
      AddFieldtoGrid(Qrymainproductname.FieldName, 0);
      grdmain.groupfieldname :='Productname';
    end else  begin
      RemoveFieldfromGrid(Qrymainproductname.FieldName);
      grdmain.groupfieldname :='';
    end;
end;
procedure TProductMovementForm.SetMovementListAsOn(const Value: TDateTime);
begin
  if Value =0 then exit;
  dtFrom.date := 0;
  dtTo.Date := Value;
  dtTo.Visible := True;
  lblTo.Visible := True;
  lblTo.Caption := 'As On ';
end;

Class Procedure TProductMovementForm.showListforProducts(AOwner:Tform; ProductIDs:String;AsOndate:TDateTime =0);
var
  form :TProductMovementForm;
begin
  form := TProductMovementForm(GetComponentByClassName('TProductMovementForm' , True , AOwner));
  if form = nil then exit;
    form.ClassId := 0;
    form.ProductIDs :=  ProductIDs;
    form.FormStyle := fsMDIChild;
    form.MovementListAsOn := AsOndate;
    form.Bringtofront;
end;
class procedure TProductMovementForm.showList(AOwner:Tform; ProductID,DepartmentID: Integer;AsOndate:TDateTime =0);
var
  form :TProductMovementForm;
begin
  form := TProductMovementForm(GetComponentByClassName('TProductMovementForm' , True , AOwner));
  if form = nil then exit;
  With form do try
    if (cboPartsQry.active =False) or (cboPartsQry.Locate('PartsID' , ProductID , [])= false) then begin
      closedb(cboPartsQry);
      cboPartsQry.parambyname('PartsId').asInteger :=  ProductID;
      Opendb(cboPartsQry);
      cboPartsQry.Locate('PartsID' , ProductID , []);
    end;
    cboPart.text  := cboPartsQry.fieldByname('Partname').asstring;
    ClassId := DepartmentID;
    FormStyle := fsMDIChild;
    MovementListAsOn := AsOndate;
    Bringtofront;
  finally
      //Free;
  end;
end;

procedure TProductMovementForm.TitleLabelDblClick(Sender: TObject);
begin
  inherited;
  btnShowAtychecking.visible := true;
end;

procedure TProductMovementForm.chkrunnittotalOptClick(Sender: TObject);
begin
  inherited;
  RefreshTotals;
end;

procedure TProductMovementForm.setClassID(const Value: Integer);
begin
  fiClassId := Value;
end;

procedure TProductMovementForm.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(tablename);
  inherited;

end;

procedure TProductMovementForm.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  (*if Sysutils.SameText(Field.FieldName , 'Period') then
    if QrymainPeriod.asDateTime = 0 then*)
  if not (Samevalue(Qrymainqty.asFloat , Qrymaininstockqty.asfloat , 0.001)) then
        if (Sysutils.SameText(Field.FieldName , 'RunningTotal')) or
           (Sysutils.SameText(Field.FieldName , 'RunningTotalInstock')) then
              DoGreenhighlight(AFont,ABrush);

  if QrymainTransType.asString = 'Opening Balance' then
    if (Sysutils.SameText(Field.FieldName , 'cTransType')) or
        (Sysutils.SameText(Field.FieldName , 'RunningTotal')) or
        (Sysutils.SameText(Field.FieldName , 'RunningTotalAvailable')) then else
      Afont.color := aBrush.color;
  if istoShowQtyChecking then begin
    {hide 0 qtys}
         if SameText(Field.fieldname,'available')     and (field.AsFloat =0) then Afont.color := aBrush.color
    else if SameText(Field.fieldname,'instock')       and (field.AsFloat =0) then Afont.color := aBrush.color
    else if SameText(Field.fieldname,'onbuild')       and (field.AsFloat =0) then Afont.color := aBrush.color
    else if SameText(Field.fieldname,'invbo')         and (field.AsFloat =0) then Afont.color := aBrush.color
    else if SameText(Field.fieldname,'So')            and (field.AsFloat =0) then Afont.color := aBrush.color
    else if SameText(Field.fieldname,'POBO')          and (field.AsFloat =0) then Afont.color := aBrush.color
    else if SameText(Field.fieldname,'Building')      and (field.AsFloat =0) then Afont.color := aBrush.color
    else if SameText(Field.fieldname,'QtyDiff')       and (field.AsFloat =0) then Afont.color := aBrush.color;
   {invalid record in red}
    if (QrymainQtydiff.asFloat <> 0)  then begin
             if SameText(Field.fieldname,'available')     then aBrush.color := clRed
        else if SameText(Field.fieldname,'instock')       then aBrush.color := clRed
        else if SameText(Field.fieldname,'onbuild')       then aBrush.color := clRed
        else if SameText(Field.fieldname,'invbo')         then aBrush.color := clRed
        else if SameText(Field.fieldname,'So')            then aBrush.color := clRed
        else if SameText(Field.fieldname,'POBO')          then aBrush.color := clRed
        else if SameText(Field.fieldname,'Building')      then aBrush.color := clRed
        else if SameText(Field.fieldname,'QtyDiff')       then aBrush.color := clRed;
    end else begin
          {all qty fields in yellow background}
           if SameText(Field.fieldname,'available')     then aBrush.color:= clinfobk
      else if SameText(Field.fieldname,'instock')       then aBrush.color:= clinfobk
      else if SameText(Field.fieldname,'onbuild')       then aBrush.color:= clinfobk
      else if SameText(Field.fieldname,'invbo')         then aBrush.color:= clinfobk
      else if SameText(Field.fieldname,'So')            then aBrush.color:= clinfobk
      else if SameText(Field.fieldname,'POBO')          then aBrush.color:= clinfobk
      else if SameText(Field.fieldname,'Building')      then aBrush.color:= clinfobk
      else if SameText(Field.fieldname,'QtyDiff')       then aBrush.color:= clinfobk;
    end;
  end;
end;
procedure TProductMovementForm.REmoveQtyCheckfields;
begin
    RemoveFieldfromGrid('fieldname');
    RemoveFieldfromGrid('available');
    RemoveFieldfromGrid('instock');
    RemoveFieldfromGrid('onbuild');
    RemoveFieldfromGrid('invbo');
    RemoveFieldfromGrid('So');
    RemoveFieldfromGrid('POBO');
    RemoveFieldfromGrid('Building');
    RemoveFieldfromGrid('QtyDiff');
end;
procedure TProductMovementForm.grdMainDblClick(Sender: TObject);
var
  ID:Integer;
  Function SalesOrderExists(SoID:Integer):Boolean;
  begin
    With commondblib.TempMyQuery do try
      SQL.add('Select saleId from tblsales where SaleId =' +intTostr(SOID)+'  and issalesorder = '+Quotedstr('T'));
      open;
      result := recordcount =1;
    finally
      closenFree;
    end;
  end;
  Function FromStock:Boolean;
  var
    qry: TERPQuery;
  begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      with Qry do begin
        SQL.text := ' Select PT.ProcTreeId ' +
            ' from tblSales s ' +
            ' inner join tblSalesLines SL on S.SaleId = Sl.SaleId ' +
            ' inner join tblProcTree PT on PT.masterId = Sl.SaleLineID  and PT.mastertype <> "mtproduct"  and ifnull(PT.PArentID,0) =0 ' +
            ' Where S.SaleId = '+IntToStr(Id)+' and PT.Partsource = "psStock"';
        open;
        result := recordcount > 0;
      end;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
  end;
begin
    invID:= 0;
    SOID:= 0;
  if (Sysutils.SameText(grdmain.getactiveField.FieldName  , 'InvID')) and (QrymainInvId.asInteger<> 0) then begin
    Id:= QrymainInvId.asInteger;
    invID:= id;
    if Qrymain.Locate('transactionno;Transtype' , varArrayof([invId, 'Invoice']) , []) then  begin
      soID:=QrymainInvId.asInteger;
      grdmain.SetActiveField('Transactionno');
    end else begin
      MessageDlgXP_Vista('Invoice #' +IntToStr(Id) +' Has Been Deleted  Or Missing.' , mtInformation , [mbok], 0);
      OpenERPForm('TInvoiceGUI' , Id)
    end;
  end else if (Sysutils.SameText(grdmain.getactiveField.FieldName  , 'SOID')) and (QrymainSoId.asInteger<> 0) then begin
    Id:= QrymainSoId.asInteger;
    soid:= id;
    if Qrymain.Locate('transactionno;Transtype' , varArrayof([Id, 'Sales Order']) , []) then begin
      grdmain.SetActiveField('Transactionno');
      invID:=  QrymainSoId.asInteger;
    end else if Qrymain.Locate('transactionno;Transtype' , varArrayof([Id, 'Sales Order (Man)']) , []) then begin
      grdmain.SetActiveField('Transactionno');
      invID:=  QrymainSoId.asInteger;
    end else if FromStock then begin
      MessageDlgXP_Vista('Sales Order #' +IntToStr(Id) +' Has Taken Quantity Out Of Stock.'  , mtInformation , [mbok], 0);
    end else begin
      if not SalesOrderExists(ID) then
        MessageDlgXP_Vista('Sales Order #' +IntToStr(Id) +' Has Been Deleted Or Missing.' , mtInformation , [mbok], 0)
      else OpenERPForm('TSalesOrderGUI' , Id);
    end;
(*  end else if sametext(Qrymaintranstype.asString , 'Purchase Order') then begin
      OpenERPForm('TPurchaseGUI' , qrymaintransactionNo.asinteger)*)
  end else
  inherited;

end;

(*procedure TProductMovementForm.DoBeforeExecute(Sender: TObject;var SQL: String; var Omit: Boolean);
begin
  inherited;
  stepProgressbar;
end;*)

function TProductMovementForm.isManufacturingProduct: Boolean;
var
  fiPartsID:Integer;
begin
  if cboPart.text <> '' then fiPartsID:= cboPartsQry.fieldByname('PartsID').asInteger else  fiPartsID:= 0;
  if fiPartsID =0 then result := False
  else begin
    with TempMyQuery do try
      SQL.Add('select * from tblProcTree where masterID = ' +intTostr(fiPartsID)+
                  ' and ifnull(ParentID,0) =0 ' +
                  ' and 	Mastertype = "mtProduct"');
      open;
      result := Recordcount > 0;
    finally
        if active then close;
        Free;
    end;
  end;
end;

procedure TProductMovementForm.MakeQrymain;
begin
  tablename := CommonDbLib.CreateUserTemporaryTable('tmp_ProductMovement');
  ExecuteSQL('Alter table ' + tablename +' Add column cTranstype varchar(255) null default null;');

  if qrymain.Active then qrymain.close;

  qrymain.SQL.clear;
  qryMain.SQL.Add('SELECT ');
  qryMain.SQL.Add('ID as ID, ');
  qryMain.SQL.Add('PQAID as PQAID, ');
  qryMain.SQL.Add('ProductName as ProductName,');
  qryMain.SQL.Add('ProductID as ProductID,');
  qryMain.SQL.Add('TransactionDate as Period, ');
  qryMain.SQL.Add('TransType as TransType,');
  qryMain.SQL.Add('cTransType as cTransType,');
  qryMain.SQL.Add('formName as formName, ');
  qryMain.SQL.Add('CONVERT(ifnull(SAID, ifnull(STID, TransactionNo)), SIGNED) as TransactionNo,');
  qryMain.SQL.Add('StockmovementEntryglobalref as StockmovementEntryglobalref, ');
  qryMain.SQL.Add('SAID as SAID, ');
  qryMain.SQL.Add('STID as STID, ');
  qryMain.SQL.Add('FirstColumn as FirstColumn, ');
  qryMain.SQL.Add('SecondColumn as SecondColumn, ');
  qryMain.SQL.Add('ThirdColumn as ThirdColumn,');
  qryMain.SQL.Add('FromStock as FromStock,');
  qryMain.SQL.Add('Qty as Qty, ');
  qryMain.SQL.Add('instockQty as instockQty, ');
  qryMain.SQL.Add('Availqty as Availqty, ');
  qryMain.SQL.Add('TotalCost as "Total Cost", ');
  qryMain.SQL.Add('Cost as "Cost", ');
  qryMain.SQL.Add('AverageCost as "AverageCost", ');
  qryMain.SQL.Add('P.ClassID as ClassID, ');
  qryMain.SQL.Add('RunningTotal as RunningTotal , ');
  qryMain.SQL.Add('RunningTotalInstock as RunningTotalInstock, ');
  qryMain.SQL.Add('RunningTotalAvailable as RunningTotalAvailable ,  ');
  qryMain.SQL.Add('invId,  ');
  qryMain.SQL.Add('available,  ');
  qryMain.SQL.Add('instock,  ');
  qryMain.SQL.Add('onbuild,  ');
  qryMain.SQL.Add('invbo,  ');
  qryMain.SQL.Add('Price,  ');
  qryMain.SQL.Add('totalprice,  ');
  qryMain.SQL.Add('So,  ');
  qryMain.SQL.Add('Building,  ');
  qryMain.SQL.Add('converted,  ');
  qryMain.SQL.Add('soID ,');
  qryMain.SQL.Add('StSID ,');
  qryMain.SQL.Add('ExtraDesc as ExtraDesc');
  qryMain.SQL.Add('FROM ' + tablename +' as P');
  qryMain.SQL.Add('Order by  P.ProductName ,P.ProductId,  P.TransactionDate DESC, PQAID desc, id desc'); {incase so with tree created and converted on the same day , sorting id desc will give so first as these transactions(of tree) doesn;t store the time in PQA }

end;

procedure TProductMovementForm.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
(*  qryMaincTranstype.asString := qryMainTranstype.asString;
  if Sametext(qryMainTranstype.asString , 'TPOSLaybylines') then
    qryMaincTranstype.asString := 'Layby';
  if fbisManufacturingProduct then
    if qryMainTransType.asString = 'Sales Order' then
      if qryMainFromStock.asBoolean then
        qryMaincTranstype.asString := 'Sales Order (From Stock)';*)
  if istoShowQtyChecking then
      QrymainQtydiff.asFloat    := Qrymainavailable.asFloat   - (Qrymaininstock.asFloat   +Qrymainonbuild.asFloat   -Qrymaininvbo.asFloat   -QrymainSo.asFloat    - QrymainBuilding.asFloat);
end;

initialization
  RegisterClassOnce(TProductMovementForm);

finalization
  UnRegisterClass(TProductMovementForm);
end.
