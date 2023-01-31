unit BOMWastageReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, BaseInputForm,
  wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBOMWastageReportGUI = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMainSaleLineId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductionItem: TWideStringField;
    qryMainuom: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainProcTreeID: TIntegerField;
    qryMainLevel: TIntegerField;
    qryMainSequencedown: TIntegerField;
    qryMainQuotedProduct: TWideStringField;
    qryMainchangedProduct: TWideStringField;
    qryMainQuotedInfo: TWideMemoField;
    qryMainchangedInfo: TWideMemoField;
    qryMainQuotedQty: TFloatField;
    qryMainVarianceQty: TFloatField;
    qryMainchangedQty: TFloatField;
    qryMainWasteUOMQty: TFloatField;
    qryMainQuotedProcess: TWideStringField;
    qryMainCurrentProcess: TWideStringField;
    qryMainQuoteduration: TWideStringField;
    qryMainCurrentDuration: TWideStringField;
    QrymainTimesheethrs: TWideStringField;
    qryMainQuotedProductCost: TFloatField;
    qryMainCurrentProductcost: TFloatField;
    qryMainQuotedProductPrice: TFloatField;
    qryMainQuotedTotalProductPrice: TFloatField;
    qryMainQuotedProductUnitPrice: TFloatField;
    qryMainCurrentProductPrice: TFloatField;
    qryMainCurrentTotalProductPrice: TFloatField;
    qryMainCurrentProductUnitPrice: TFloatField;
    qryMainQuotedLabourCost: TFloatField;
    qryMainCurrentLabourcost: TFloatField;
    qryMainLineCost: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainSalesLineCost: TFloatField;
    qryMainSalesLinePrice: TFloatField;
    qryMainDiffPriceEx: TFloatField;
    qryMainDiffPriceInc: TFloatField;
    qryMainDiffCost: TFloatField;
    qryMainProfit: TFloatField;
    qryMainProfitPerc: TFloatField;
    qryMainSalesPrice: TFloatField;
    qryMainSalesCost: TFloatField;
    qryMainctr: TIntegerField;
    qryMainID: TIntegerField;
    qryMainBOMGroupedLine: TWideStringField;
    qryMainBOMProductionLine: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMaininputType: TWideStringField;
    qryMainselected: TWideStringField;
    qryMainnodeselected: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormDestroy(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
  private
    Tablename:String;
    fiSaleID: Integer;
    fiSaleLineId:Integer;


  Protected
    procedure SetGridColumns; Override;
    function GetReportTypeID: integer; Override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
  public
    Procedure RefreshQuery; override;
    Property SaleId :Integer read fiSaleID write fiSAleID;
    Property SaleLineId :Integer read fiSaleLineId write fiSaleLineId;


  end;


implementation

uses CommonLib, CommonDbLib, StoredProcedures,  MySQLConst, AppEnvironment, GraphUtil,
  ManufactureLib, tcDataUtils, ProductMovementList, LogLib;

{$R *.dfm}



procedure TBOMWastageReportGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  if PopupForm.classnameis('TfrmParts') then begin
    if SameText(ActiveFieldName, QrymainQuotedproduct.FieldName ) then
      Popupform.keyId := GetProduct(QrymainQuotedproduct.asString)
    else if SameText(ActiveFieldName, Qrymainchangedproduct.FieldName ) then
      Popupform.keyId := GetProduct(Qrymainchangedproduct.asString)
    else
    Popupform.keyId := GetProduct(QrymainProductName.asString);
  end else
  inherited;

end;

procedure TBOMWastageReportGUI.DNMSpeedButton1Click(Sender: TObject);
var
  SQL:String;
begin
  inherited;
  ReportToPrint :=    tcdatautils.GetDefaultReport(GetReportTypeID);
  if ReportToPrint ='' then ReportToPrint := 'Build Profitability';
  SQL:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, '+
        ' Concat("Phone :",CO.PhoneNumber) AS PhoneNumber, Concat("  Fax :",CO.FaxNumber) AS FaxNumber,  '+
        ' CO.ABN FROM tblCompanyInformation AS CO '+
        ' ~|||~{Details}Select T.* ,  '+
       // ' if(SL.UnitofMeasureMultiplier=1 , SL.UnitofMeasureSaleLines , concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , " of " , UOM.BaseUnitName , ")" )) SalesUOM,  '+
        ' SL.LineCost* SL.shipped as TotalLineCost   '+
        ' from ' +Tablename + ' T inner join tblsaleslines SL on T.SaleLineID = SL.SaleLineID '+
        ' inner join tblunitsofmeasure UOM  on SL.UnitOfMeasureID = UOM.UnitID ' +
        ' where T.SaleID = ' + inttostr(QrymainSaleId.asInteger)+
        ' order by T.SAleID desc, T.OrderId, T.SAleLineID, T.SequenceDown, T.Level , ProductionLineID , if(T.BOMProductionLine="T" , 1 , 0) ';
  ReportSQLSupplied:= True;
  PrintTemplateReport(ReportToPrint , SQL, not(Appenv.Employee.ShowPreview) and not(Devmode) ,1 );
end;

procedure TBOMWastageReportGUI.FormCreate(Sender: TObject);
begin
  fiSAleID :=0;
  fiSaleLineId :=0;
  //Tablename := GetUserTemporaryTableName(Self.ClassName);
  Tablename :=CreateUserTemporaryTable('tmp_bomwastagereport');
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('Select ');
  Qrymain.SQL.add('* ');
  Qrymain.SQL.add('from ' + tablename+ ' T');
  //Qrymain.SQL.add('  /*where nodeselected ="T" */' );
  Qrymain.SQL.add('order by T.SAleID desc , T.OrderID, T.SAleLineID, T.SequenceDown, T.Level , T.ProductionLineID , if(T.BOMProductionLine="T" , 1 , 0)');
  //' order by SaleId desc , SalelineID, ProctreeId ';
  inherited;
end;

procedure TBOMWastageReportGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  DestroyUserTemporaryTable(Tablename+'1');
  DestroyUserTemporaryTable(Tablename+'2');
  DestroyUserTemporaryTable(Tablename+'3');
  inherited;
end;

procedure TBOMWastageReportGUI.FormShow(Sender: TObject);
begin
  inherited;
  chkIgnoreDates.visible := (fiSaleID =0) and (fiSaleLineId =0);
  cboDateRange.visible := (fiSaleID =0) and (fiSaleLineId =0);
  lblFrom.visible := (fiSaleID =0) and (fiSaleLineId =0);
  dtFrom.visible := (fiSaleID =0) and (fiSaleLineId =0);
  lblTo.visible := (fiSaleID =0) and (fiSaleLineId =0);
  dtTo.visible := (fiSaleID =0) and (fiSaleLineId =0);
end;

function TBOMWastageReportGUI.GetReportTypeID: integer;
begin
  REsult := 105;
end;

procedure TBOMWastageReportGUI.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);
begin
  inherited;
  if SameText(field.FieldName ,qryMainchangedProduct.FieldName) or
          SameText(field.FieldName ,qryMainchangedQty.FieldName) or
          SameText(field.FieldName ,qryMainWasteUOMQty.FieldName) or
          SameText(field.FieldName ,qryMainCurrentProcess.FieldName) or
          SameText(field.FieldName ,qryMainCurrentDuration.FieldName)  then  begin
            AFont.color := clred;
  end else if (SameText(field.FieldName ,qryMainProductName.FieldName) or
      SameText(field.FieldName ,qryMainLineCost.FieldName) or
      SameText(field.FieldName ,qryMainuom.FieldName) or
      SameText(field.FieldName ,qryMainUnitofMeasureQtySold.FieldName) or
      SameText(field.FieldName ,qryMainUnitofMeasureShipped.FieldName) or
      SameText(field.FieldName ,qryMainSalesLineCost.FieldName) or
      SameText(field.FieldName ,qryMainSalesLinePrice.FieldName) or
      SameText(field.FieldName ,qryMainDiffPriceEx.FieldName) or
      SameText(field.FieldName ,qryMainProfit.FieldName) or
      SameText(field.FieldName ,qryMainProfitPerc.FieldName) or
      SameText(field.FieldName ,qryMainSalesCost.FieldName) or
      SameText(field.FieldName ,qryMainSalesPrice.FieldName) or
      SameText(field.FieldName ,qryMainDiffPriceInc.FieldName) or
      SameText(field.FieldName ,qryMainDiffCost.FieldName) or
      SameText(field.FieldName ,qryMainSaleID.FieldName) or
      SameText(field.FieldName ,qryMainSalelineID.FieldName) or
      SameText(field.FieldName ,qryMainCustomerName.FieldName) or
      SameText(field.FieldName ,qryMainProductionitem.FieldName) or
      SameText(field.FieldName ,qryMainLinePriceInc.FieldName)) and
      (qryMainctr.AsInteger > 1) then begin
      Afont.Color := ABrush.Color;
(*  end else if SameText(field.FieldName ,qryMainDiffPriceEx.FieldName) or
      SameText(field.FieldName ,qryMainProfit.FieldName) or
      SameText(field.FieldName ,qryMainProfitPerc.FieldName) or
      SameText(field.FieldName ,qryMainSalesCost.FieldName) or
      SameText(field.FieldName ,qryMainSalesPrice.FieldName) or
      SameText(field.FieldName ,qryMainDiffPriceInc.FieldName) or
      SameText(field.FieldName ,qryMaindiffCost.FieldName) then begin
      Afont.Color := clred;*)
  end else if qryMainnodeselected.AsBoolean =false then begin
    Afont.Color := clInactiveCaption;
  end else if   qryMainBOMGroupedLine.AsBoolean then begin
      Afont.Color := ColorAdjustLuma(Afont.Color,150  , False);
  end else if   qryMainBOMProductionLine.AsBoolean then begin
      if qryMainctr.AsInteger = 1 then Afont.Style := Afont.Style  +[fsBold];
  end;
  if SameText(field.FieldName ,qryMainWasteUOMQty.FieldName) and (qryMainWasteUOMQty.asFloat =0) then begin
    Afont.Color := ABrush.Color;
  end;
end;


procedure TBOMWastageReportGUI.grdMainDblClick(Sender: TObject);
function ProductID:Integer;
begin
    (*if SameText(ActiveFieldName, QrymainQuotedproduct.FieldName ) then
      result := GetProduct(QrymainQuotedproduct.asString)
    else if SameText(ActiveFieldName, Qrymainchangedproduct.FieldName ) then
      result:= GetProduct(Qrymainchangedproduct.asString)
    else
      result:= GetProduct(QrymainProductName.asString);*)
    result:= GetProduct(QrymainProductName.asString);
end;
begin
  if SameText(ActiveFieldName ,  QrymainDiffCost.fieldname) then begin
    TimerMsg(lblnote,'Cost Differenece = Current Cost from the Tree -  Cost From Tree when was ''finalised for production''.');
  end else if SameText(ActiveFieldName ,  QrymainDiffPriceEx.fieldname) or SameText(ActiveFieldName ,  QrymainDiffPriceInc.fieldname) then begin
    TimerMsg(lblnote,'Price Differenece = Current Price from the Tree -  Price From Tree when was ''finalised for production''.');
  end else if SameText(ActiveFieldName ,  QrymainProfit.fieldname) or SameText(ActiveFieldName ,  QrymainProfitPerc.fieldname)   then begin
    TimerMsg(lblnote,'Profit = Total Price - Total Cost, Profit Percentage = Profit / Total Price');
  end else if SameText(ActiveFieldName , QrymainUnitofMeasureQtySold.FieldName) or sameText(Activefieldname, QrymainUnitofMeasureshipped.FieldName) then begin
            ProcessingCursor(True);
            try
                 TProductMovementForm.showList(Self,ProductID, 0);
                 exit;
            finally
              ProcessingCursor(False);
            end;

  end else begin
    inherited;
  end;

end;

procedure TBOMWastageReportGUI.RefreshQuery;
var
  ctr:Integer;
  saleLineID:Integer;
begin
  closeDb(qrymain);
  With TStringlist.create do try
    Add('Drop table if exists ' +tablename +'1;');
    Add('Create table ' +tablename +'1');
     Add('select S.SaleId,S.customername,SL.SaleLineId,SL.ProductName, SL.BOMGroupedLine, SL.BOMProductionLine ,'+
          ' Convert(if(SL.UnitofMeasureMultiplier =1 , SL.UnitofMeasureSaleLines , concat(SL.UnitofMeasureSaleLines , " ( " , SL.UnitofMeasureMultiplier , " of " ,  UOM.BaseUnitName , " )")),char(100)) uom, '+
          'SL.UnitOfMeasureID,SL.Shipped, SL.TotalLineAmountInc,SL.totalLineAmount,SL.LineTaxRate,'+
          ' SL.UnitofMeasureQtySold ,SL.UnitofMeasureShipped,SL.LineCost,SL.LinePriceInc,SL.LineCost * SL.Shipped as SalesLineCost,SL.TotalLineAmount as SalesLinePrice '+
          ' from tblsaleslines SL inner join tblsales s on S.SAleId = SL.saleId  /*  and (SL.BOMGroupedLine ="F" or SL.BOMProductionLine ="T" )*/ '+ {(BOMGroupedLine and BOMProductionLine  are commented since teh consumption recport shows all )}
          ' inner join tblunitsofmeasure UOM on SL.UnitOfMeasureID = UOM.UnitID'+
          ' where (SL.SaleID=' + inttostr(fiSaleID) + ' or ' + inttostr(fiSaleID) + '=0)  and (SL.SaleLineId=' + inttostr(fiSaleLineId) + ' or ' + inttostr(fiSaleLineId) + '=0)');
    if (fiSaleID =0) and (fiSaleLineId =0) then
      Add('and S.saledate between ' + Quotedstr(formatdateTime(MysqlDateTimeFormat , FilterDateFrom))  +' and ' + Quotedstr(formatdateTime(MysqlDateTimeFormat , FilterDateTo))  +' ');
      Add(';');
    Add('Alter table ' +tablename +'1 Add index SaleLineID (SaleLineID), Add index SaleId (SaleID);');

    Add('Drop table if exists ' +tablename +'2;');
    Add('Create table ' +tablename +'2');
    Add('select distinct  PTC.masterID, PTC.ProctreeId, PTC.Sequencedown,PTC.level, PTC.Info from tblproctreeclean PTC inner join ' + tablename +'1 as T1 on T1.saleLineId = PTC.MasterId where PTC.mastertype <> "mtProduct"  and T1.BOMProductionLine <> "T" union  ');
    Add('select distinct  PT.masterID , PT.ProctreeID , PT.Sequencedown ,PT.level , PT.Info from tblproctree      PT inner  join ' + tablename +'1 as T1 on T1.saleLineID = PT.MasterId  where PT.mastertype <> "mtProduct"  and T1.BOMGroupedLine <>"T"; ');
    Add('Alter table ' +tablename +'2 Add index masterID (masterID);');
    Add('Alter table ' +tablename +'2 Add index ProctreeId (ProctreeId);');

    Add('Drop table if exists ' +tablename +'3;');
    Add('Create table ' +tablename +'3');
    Add('Select Distinct  PP.ID, PP.ProcTreeId ,  PP.ProcessStepID ,  PS.Description   from tblprocesspart       PP  inner join tblprocessstep  PS on  PS.ID =  PP.ProcessStepID union  ');
    Add('Select Distinct PPC.ID,PPC.ProcTreeId , PPC.ProcessStepID , PSC.Description   from tblprocesspartclean PPC  inner join tblprocessstep PSC on PSC.ID = PPC.ProcessStepID order by proctreeID;');
    Add('Alter table ' +tablename +'3 Add index ProctreeId (ProctreeId);');

    Add('Drop table if exists ' +tablename +';');
    Add('Create table ' +tablename );
    Add('Select distinct');
    Add('T1.SaleId,');
    Add('T1.customername,');
    Add('T1.BOMGroupedLine,');
    Add('T1.BOMProductionLine ,');
    Add('T1.SaleLineId,');
    Add('T1.ProductName,');
    Add('T1.UOM uom,');
    Add('T1.UnitofMeasureQtySold ,');
    Add('T1.UnitofMeasureShipped,');
    Add('Ids.ProcTreeID ,');
    Add('PP.Id ProcesspartId,');
    Add('PT.TreeRootId ,');
    Add('PT.ParentID ,');
    Add('PT.inputType ,');
    Add('PT.selected ,');
    Add('Ids.Level,');
    Add('Convert(if(ifnull(PT.Sequencedown,0)=0, PTC.Sequencedown  , PT.Sequencedown ),signed)  Sequencedown,');
    Add('Convert(TreeNodeCaption(ids.Level, PTC.caption ) ,char(255)) as QuotedProduct,');
    Add('PTC.info as QuotedInfo,');
    Add('PT.info as changedInfo,');
    Add('Convert(if(ids.level=0, "" , if(PTC.Caption=PT.Caption,"" , if(ifnull(PT.Caption,"")="" , "Deleted" , TreeNodeCaption(ids.level, PT.caption)))),char(255)) as changedProduct,');
  //Add('if(PTC.Caption=PT.Caption,"" , if(ifnull(PT.Caption,"")="" , "Deleted" , concat(Repeat("  " ,ids.level), ifnull(PT.Caption,"")))) as changedProduct,');

    (*Add('if(ifnull(PTC.ParentID,0)=0 , PTC.ManufactureQty , PTC.Quantity) QuotedQty,');
    Add('if(if(ifnull(PT.ParentID,0)=0 , PT.ManufactureQty , PT.Quantity) = if(ifnull(PTC.ParentID,0)=0 , PTC.ManufactureQty , PTC.Quantity) , NULL , if(ifnull(PT.ParentID,0)=0 , PT.ManufactureQty , PT.Quantity)) changedQty,');*)
    Add('PTC.TotalQty QuotedQty,');
    Add('if(PT.TotalQty = PTC.TotalQty , NULL , PT.TotalQty)  changedQty,');
    Add('Pt.WasteUOMQty as WasteUOMQty,');

    Add('if(ifnull(PPc.ID,0)<> 0 , ProcessPartIds.Description,NULL) QuotedProcess,');
    Add('if(ifnull(PP.ID,0)<> 0 and ifnull(PPC.ProcessStepID,0)<> ifnull(PP.ProcessStepID,0), ProcessPartIds.Description,NULL) CurrentProcess,');

    Add('Convert(SEC_TO_TIME(PPC.Duration),char) Quoteduration,');
    Add('Convert(SEC_TO_TIME(if(PP.Duration = PPC.Duration, '+
                              'if(ifnull(PPC.ProcessStepID,0)= ifnull(PP.ProcessStepID,0),NULL , PP.duration) ,'+
                              'if(ifnull(PP.ID,0)<> 0 , ifnull(PP.duration,0) , '+
                              'if(ifnull(ppc.id,0)<>0 and ifnull(pp.ID,0)=0 , 0 ,  PP.Duration)))),char) CurrentDuration ,');

    Add('if(ifnull(PTC.ProcTreeId,0)<> 0 , PTC.Cost,NULL) QuotedProductCost,');
    Add('if(ifnull(PT.ProcTreeId,0)<> 0 , PT.Cost,NULL) CurrentProductcost,');

    Add('if(ifnull(PTC.ProcTreeId,0)<> 0 , PTC.ProductUnitPrice,NULL) QuotedProductUnitPrice,');
    Add('if(ifnull(PT.ProcTreeId,0)<> 0 , PT.ProductUnitPrice,NULL) CurrentProductunitPrice,');

    Add('if(ifnull(PTC.ProcTreeId,0)<> 0 , PTC.Price,NULL) QuotedProductPrice,');
    Add('if(ifnull(PT.ProcTreeId,0)<> 0 , PT.Price,NULL) CurrentProductPrice,');

    Add('if(ifnull(PTC.ProcTreeId,0)<> 0 , PTC.ProductUnitPrice * PTC.TotalQty,NULL) QuotedTotalProductPrice,');
    Add('if(ifnull(PT.ProcTreeId,0)<> 0 , PT.ProductUnitPrice * PT.TotalQty,NULL) CurrentTotalProductPrice,');

    Add('if(ifnull(PPC.ID,0)<> 0 , PPC.HourlyLabourRate,NULL) QuotedLabourCost,');
    Add('if(ifnull(PP.ID,0)<> 0 , PP.HourlyLabourRate,NULL) CurrentLabourcost,');

    Add('T1.LineCost,');
    Add('T1.LinePriceInc,');

    Add('T1.SalesLineCost,');
    Add('T1.SalesLinePrice,');
    Add('if(ifnull(Ids.level,0)>0 , null ,  Ptc.Cost*ifnull(T1.Shipped,0)) as QuotedCost,');

//    Add('if(ifnull(Ids.level,0)>0 , null ,  Pt.Cost*ifnull(T1.Shipped,0) ) as SalesCost , ') ;
    Add('IF(IFNULL(Ids.level, 0) > 0, NULL, T1.LineCost * IFNULL(T1.Shipped, 0)) AS SalesCost, ');
    Add('IF(IFNULL(Ids.level, 0) > 0, NULL, T1.SalesLinePrice) AS SalesPrice, ');
    Add('IF(IFNULL(Ids.level, 0) > 0, NULL, T1.SalesLinePrice - T1.LineCost * IFNULL(T1.Shipped, 0)) AS Profit, ');
    Add('IF(IFNULL(Ids.level, 0) > 0, NULL, (T1.SalesLinePrice - T1.LineCost * IFNULL(T1.Shipped, 0)) / T1.SalesLinePrice) * 100 AS ProfitPerc, ');

    Add('if(ifnull(Ids.level,0)>0 , null ,   T1.TotalLineAmount - Pt.price) DiffPriceEx,');
    Add('if(ifnull(Ids.level,0)>0 , null ,   T1.TotalLineAmountInc  - (Pt.price+Pt.price*T1.linetaxrate)) DiffPriceinc,');
    Add('if(ifnull(Ids.level,0)>0 , null ,  T1.LineCost*ifnull(T1.Shipped,0)-Ptc.Cost /**ifnull(T1.Shipped,0)*/  ) DiffCost');

    Add('from');
    Add(tablename +'1 as T1 ');

    {distinct proctreeIds from both active and clean tables}
    Add('inner join 	'+tablename +'2 Ids on Ids.MasterId = T1.SaleLineID');

    Add('Left join tblproctree PT on PT.ProcTreeId = Ids.ProctreeID');
    Add('left join  tblproctreeclean PTC   on PTC.ProcTreeId = Ids.procTreeID');

    {distinct processparts from both active and clean}
    Add('Left join  '+tablename +'3 ProcessPartIDs on  ProcessPartIDs.ProctreeId = Ids.ProcTreeID');

    Add('Left join (tblprocesspart PP   inner join tblprocessstep PS on PP.ProcessStepID  = PS.ID )on  ProcessPartIds.ProcTreeId = PP.ProcTreeId and ProcessPartIds.processstepID = PP.ProcessStepID');
    Add('Left join tblprocesspartclean PPC  on  ProcessPartIds.ProcTreeId = PPC.ProcTreeId and ProcessPartIds.processstepID = PPC.ProcessStepID');

    Add('order by T1.SAleId desc , T1.SalelineID, if(ifnull(PT.Sequencedown,0)=0, PTC.Sequencedown  , PT.Sequencedown ) ,PT.Sequencedown , PTC.Sequencedown, PP.ID, PPC.ID;');

    Add('Alter table '+tablename +' add column Timesheethrs varchar(100);');
    Add('Alter table '+tablename +' Add index ProcesspartId (ProcesspartId);');
    Add('update '+tablename +' T  Set T.Timesheethrs =  Convert(SEC_TO_TIME((Select Sum(TIMEDIFF(ifnull(timeend , CURRENT_TIMESTAMP()) , timestart)) from tblprocessparttimesheet PTT where  T.ProcesspartId = PTT.ProcessPartID)), char) ;');
    Add('Alter table  '+tablename +' add column  VarianceQty double;');
    Add('update '+tablename +' T  Set VarianceQty = changedQty- QuotedQty   where ifnull(QuotedQty,0)<>0 and ifnull(changedQty,0)<>0;');

    Add('Drop table if exists ' +tablename +'1;');
    Add('Drop table if exists ' +tablename +'2;');
    Add('Drop table if exists ' +tablename +'3;');
    Add('alter table '+tablename +' Add column ctr int(11);');
    Add('ALTER TABLE ' +tablename +' 	ADD COLUMN `ID` INT(10) NOT NULL AUTO_INCREMENT ,	ADD PRIMARY KEY (`ID`);');
    Add('update ' +tablename +' 	set DiffCost = NULL where round(ifnull(DiffCost,0),' +inttostr(CommonLib.CurrencyRoundPlaces) +')=0;');
    Add('update ' +tablename +' 	set DiffPriceex = NULL where Round(ifnull(DiffPriceex,0),' +inttostr(CommonLib.CurrencyRoundPlaces) +')=0;');
    Add('update ' +tablename +' 	set DiffPriceinc = NULL where round(ifnull(DiffPriceinc,0),' +inttostr(CommonLib.CurrencyRoundPlaces) +')=0;');
    Add('Alter table ' +tablename +' Add column ProductionItem Varchar(255) after ProductName;');
    Add('Alter table ' +tablename +' Add column ProductionLineID int(11);');
    Add('update ' +tablename +' T   '+
        ' inner join tblsalesgroupedlines SGL on SGL.BOMGroupedLineID = T.SaleLineId    '+
        ' inner join tblsaleslines SL on SL.SaleLineID = SGL.BOMProductionLineID  '+
        ' Set T.ProductionItem = SL.ProductName , T.ProductionLineID  = SGL.BOMProductionLineID  where T.BOMGroupedLine ="T";');
    Add('update ' +tablename +' T   '+
        '  set T.ProductionLineID = T.SaleLineId where BOMProductionLine ="T";');
    Add('Alter table ' +tablename +' Add column orderID int(11);');
    Add('update ' +tablename +'  Set OrderId = SaleLineID;');
    Add('Drop table if Exists  ' +tablename +'1;');
    Add('create table ' +tablename +'1 '+
        ' Select BOMProductionLineID , max(BOMGroupedLineID) BOMGroupedLineID '+
        ' from tblsalesgroupedlines  SGL '+
        ' inner join ' +tablename +' T on SGL.BOMProductionLineID = T.saleLineID where T.BOMProductionLine ="T" group by BOMProductionLineID;');
    Add('update ' +tablename +' T '+
        ' inner join ' +tablename +'1 T1 on T.SaleLineId = T1.BOMProductionLineID '+
        ' Set T.OrderId  = T1.BOMGroupedLineID '+
        ' where T.BOMProductionLine ="T";');
    Add('Alter table ' +tablename +' add column nodeselected Enum("T","F") default "F";');
    (*Add('Alter table ' +tablename +' add column parentId int(11);');
    Add('update ' +tablename +'  T inner join tblProctree PT on T.proctreeId = PT.proctreeID Set T.ParentId = Pt.ParentID;');*)
    Add('Alter table ' +tablename +'  Add index ProctreeId (ProctreeId);');
    Add('Alter table ' +tablename +'  Add index PArentID (PArentID);');
    Add('Alter table ' +tablename +'  Add index TreeRootId (TreeRootId);');
    (*Add('Alter table ' +tablename +' add column Selected Enum("T", "F") default "F";');
    Add('update ' +tablename +'  T inner join tblProctree PT on T.proctreeId = PT.proctreeID Set T.selected = Pt.Selected;');*)
    clog(text);
    ExecuteSQLwithProgress(text);
    ChecknUpdateInTreeNodesSelected(Tablename  , 'nodeselected');

  finally
    Free;
  end;

  with TempMyquery do try
    SQL.Clear;
    SQL.Add('Select * from ' + tablename+' order by saleId, saleLineID');
    open;
    if recordcount > 0 then begin
      ctr:= 1;
      first;
      saleLineID := 0;
      while Eof = False do begin
        if saleLineID <> Fieldbyname('SaleLineID').AsInteger then begin
          ctr:= 0;
          saleLineID :=  fieldByname('SaleLineID').AsInteger;
        end;
        if saleLineID <> fieldByname('SaleLineID').AsInteger then ctr:= 1 else ctr := ctr+1;
        Edit;
        Fieldbyname('ctr').AsInteger := ctr;
        post;
        Next;
      end;
    end;
  finally
    ClosenFree;
  end;
  inherited;
end;




procedure TBOMWastageReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymainlevel.FieldName);
  RemoveFieldfromGrid(QrymainproctreeId.FieldName);
  RemoveFieldfromGrid(qryMainSequencedown.FieldName);
  RemoveFieldfromGrid(Qrymainctr.FieldName);
  RemoveFieldfromGrid(QrymainID.FieldName);
  //RemoveFieldfromGrid(QrymainSaleLineID.FieldName);
  RemoveFieldfromGrid(QrymainLinecost.FieldName);
  RemoveFieldfromGrid(QrymainSalesLinecost.FieldName);
  RemoveFieldfromGrid(qryMainBOMGroupedLine.FieldName);
  RemoveFieldfromGrid(qryMainBOMProductionLine.FieldName);
  if not(devmode) then begin
    RemoveFieldfromGrid(qryMainInputType.FieldName);
    RemoveFieldfromGrid(qryMainselected.FieldName);
    RemoveFieldfromGrid(qryMainnodeselected.FieldName);
  end;
end;



initialization
  RegisterClassOnce(TBOMWastageReportGUI);

end.

