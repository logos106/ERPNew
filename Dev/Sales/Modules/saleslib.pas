unit saleslib;

interface

uses  BaseInputForm,Forms , ERPdbComponents , ProductQtyLib , busobjbase ,
      classes , busobjsales , busobjsalebase,  BaseTransForm,
      BaseFormForm;

function PrintDeliverydocket(Const SaleID:Integer;clientID:Integer;BOID:String; ownerform:TForm; showPreview:Boolean ;ReportToPrint:String):String;
Function  PrintSalesPickingSlip(ReportName:String;const SaleID:Integer; Const lineClass:String; ownerform:TForm; showPreview:Boolean ):Boolean;
function SalesAddressLabelSQL(const NoOfBoxes :Integer; SaleID:Integer): string;
function SalesDispatchBarcodeSQL(const SaleIDs:String; Const saleLineIDs:String; const BatchIds:String; const ExtraWhere :String =''; mode: TFiltertype= tDetails):String;
function SalesDispatchBarcodeSQLWithoutcompanyInfo(const SaleIDs:String; Const saleLineIDs:String; const BatchIds:String; const ExtraWhere :String =''; mode: TFiltertype= tDetails):String;
Function ProcTreePQABatchIdsToSLPQABatchIDs(Const ProcTreePQABatchIds:String;fconn: TERPConnection):String;
Function SalesSummarySQL(const AProductId:Integer; AClassIds :String ;Invoices,SalesOrders , Quotes , UseNonERPsales:Boolean ; aDatefrom , aDateTo:TDatetime; SelectedProductstbalename :String ; qtytype :Integer =0; IsForReport:Boolean = False):String;
Function UnAllocatedBatchByPalletSQL(const aSaleID, aSaleLineId ,aProductId,  aReporttype:Integer; aCustFLd5:String=''):String;
procedure CheckForSalesTaxBasedon(SalesForm :TBaseTransGUI; Const  aISSalesLocked:Boolean; SaleBase : TSalesBase);


implementation


uses AppEnvironment, tcDataUtils, FastFuncs, CommonLib, Dialogs, Controls,
  frmPrintPickingSlips, BaseListingForm, CommonDbLib, sysutils,
  TemplateReportsLib, DbSharedObjectsObj, tcConst, MySQLConst, Barcodeconst,
  JSONObject, BusObjProcPrefs, frmsaleslineManufactureTotalQtyEdit,
  BusObjProcess, PrintPickingSlipsLib, PrintDeliveryDocketLib, Sales, Cash,
  frmInvoice, frmSalesOrder, frmPurchaseOrders;

type
  TConfirmPrintBackordersGui = class(TObject)
  public
    procedure DoConfirmPrintBackOrders(sender: TObject);
  end;

{ TConfirmPrintBackordersGui }

procedure TConfirmPrintBackordersGui.DoConfirmPrintBackOrders(sender: TObject);
begin
  if MessageDlgXP_Vista('Do You Wish to Exclude the Back Ordered Items From Print?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    TDeliveryDocketReportSQL(sender).ExcludeBackorders := true
  else
    TDeliveryDocketReportSQL(sender).ExcludeBackorders := false;
end;


Function SalesSummarySQL(const AProductId:Integer; AClassIds :String ;Invoices,SalesOrders , Quotes , UseNonERPsales:Boolean ; aDatefrom , aDateTo:TDatetime; SelectedProductstbalename :String ; qtytype :Integer =0; IsForReport:Boolean = False):String;
var
  s:String;
  ctr:Integer;

  Procedure Addfilter(Const fs:String);
  begin
      if s <> '' then s := s + ' OR ';
      s:= s+fs;
  end;
  function Qtytypefield(Preficomma :Boolean= False) :String;
  begin
    result := '';

           if Qtytype =1 then Result := 'DATE_FORMAT(saleDate,"%Y-%m-%d")   '
      else if Qtytype =2 then Result := 'DATE_FORMAT(saleDate,"%Y-%m")    '
      else if Qtytype =3 then Result := 'DATE_FORMAT(saleDate,"%Y-%m")    ';
    if Preficomma AND (REsult <> '') then begin
      Result := REsult +' as Qty_Date , '+NL;
           if Qtytype =1 then Result := Result +'convert(Date(S.saleDate), datetime) as QtyDate ,    '
      else if Qtytype =2 then Result := Result +'convert(LAST_DAY(s.saleDate), datetime)  as QtyDate ,    '
      else if Qtytype =3 then Result := Result +'convert(LAST_DAY(s.saleDate), datetime)  as QtyDate ,    '
    end;
  end;
begin
      Result   := '';
      for ctr:= 1 to 2 do begin
        if (ctr =1 ) or (IsForReport) then begin
              if ctr =2 then Result   := Result   +NL+' union all  Select Details, Class , PreferredLevel , ReOrderPoint , ReOrderAmount , productname , productprintname , null as Qty_Date ,convert(QtyDate, datetime) as QtyDate, sum(TotalQty) from ('+NL;
              Result   := Result   + 'SELECT '+inttostr(ctr)+'            as details,' + NL ;
              Result   := Result   +'S.Class              as Class,   ' + NL ;
              if IsForReport then begin
                Result   := Result   +'PC.PreferredLevel  as PreferredLevel,   ' + NL ;
                Result   := Result   +'PC.ReOrderPoint    as ReOrderPoint,   ' + NL ;
                Result   := Result   +'PC.ReOrderAmount   as ReOrderAmount,   ' + NL ;
              end;
              Result   := Result   +'SL.productname       as productname,  '+ NL ;
              Result   := Result   +'SL.productprintname  as productprintname,  '+ NL ;
              Result   := Result   + iif((ctr=1)  , Qtytypefield(true)  , 'null as Qty_Date , null as QtyDate , ')+ NL ;
              Result   := Result   + ' SUM(SL.Shipped)    AS TotalQty '+ NL ;
              Result   := Result   +' FROM tblsaleslines       sl JOIN tblsales       s ON sl.SaleID = s.SaleID '+
                                    ' inner join tblproductclasses PC on PC.ClassID = s.ClassID   and PC.productId = SL.productId';
              if SelectedProductstbalename <> '' then Result   := Result   +' inner join ' + SelectedProductstbalename  +' T on T.partsID = SL.productId';
              Result   := Result   +' WHERE S.Deleted <> "T"'  ;
              if AProductId <> 0 then Result   := Result   +' AND SL.ProductID = ' + IntToStr(AProductId) ;
              if (AClassIds  <> '') and (AClassIds  <> '0') then Result   := Result   +' AND S.ClassId in (' + AClassIds+')';
              s:= '';
              if Invoices      then addFilter('(S.IsInvoice = "T" or  S.IsCashSale ="T" or S.IsRefund ="T" or S.IsPOS ="T")');
              if SalesOrders   then addFilter('S.IsSalesOrder="T"');
              if Quotes        then addFilter('S.IsQuote="T"');
              if s <> '' then s:='(' + s + ')';
              if (Invoices or SalesOrders) and (not(quotes) ) then s:='(' + s+ ' and S.converted="F"' +')';
              if s<> '' then Result   := Result   +'  AND ' + s;
              Result   := Result   +' AND (SaleDate >= "' + FormatDateTime(MySQLDateTimeFormat, aDateFrom) + '")';
              if ADAteTo <> 0 then  Result   := Result   +' and (SaleDate <= "' + FormatDateTime(MySQLDateTimeFormat, aDateTo) + '")';
              REsult := result + ' group by ' + iif((ctr=1) and (Qtytype in [1,2,3]), Qtytypefield(False)  +',', ' ') +'SL.ProductId, S.ClassID';
              {non erp slaes }
              if UseNonERPsales then begin
                Result   := Result   +' union all ';
              Result   := Result   + 'SELECT '+inttostr(ctr)+' as details,' + NL ;
              Result   := Result   +'S.Class              as Class,   ' + NL ;
              if IsForReport then begin
                Result   := Result   +'PC.PreferredLevel  as PreferredLevel,   ' + NL ;
                Result   := Result   +'PC.ReOrderPoint    as ReOrderPoint,   ' + NL ;
                Result   := Result   +'PC.ReOrderAmount   as ReOrderAmount,   ' + NL ;
              end;
              Result   := Result   +'SL.productname       as productname,  '+ NL ;
              Result   := Result   +'SL.productprintname  as productprintname,  '+ NL ;
              Result   := Result   + iif((ctr=1) , Qtytypefield(true)  , 'null as Qty_Date , null as QtyDate , ')+ NL ;
              Result   := Result   + ' SUM(SL.Shipped)    AS TotalQty '+ NL ; // dene
                Result   := Result   +' FROM tblnonerpsaleslines sl JOIN tblnonerpsales s ON sl.SaleID = s.SaleID  '+
                                    ' inner join tblproductclasses PC on PC.ClassID = s.ClassID   and PC.productId = SL.productId';
                if SelectedProductstbalename <> '' then Result   := Result   +' inner join ' + SelectedProductstbalename  +' T on T.PartsID = SL.productId';
                Result   := Result   +' WHERE ifnull(SL.Shipped,0)<> 0';
                if AProductId <> 0 then Result   := Result   +' and sl.ProductID = ' + IntToStr(AProductId) ;
                if (AClassIds  <> '') and (AClassIds  <> '0') then Result   := Result   +' AND S.ClassId in (' + AClassIds+')';
                s:= '';
                if Invoices    then addFilter('(S.IsInvoice = "T" or  S.IsCashSale ="T" or S.IsRefund ="T" or S.IsPOS ="T")');
                if SalesOrders then addFilter('S.IsSalesOrder="T"');
                if Quotes      then addFilter('S.IsQuote="T"');
                if s<> '' then Result   := Result   +'  AND ' + '(' + s + ')';;
                Result   := Result   +' AND (SaleDate >= "' + FormatDateTime(MySQLDateTimeFormat, aDateFrom) + '")';
                if ADAteTo <> 0 then  Result   := Result   +' and (SaleDate <= "' + FormatDateTime(MySQLDateTimeFormat, aDateTo) + '")';
                REsult := result + ' group by ' + iif((ctr=1) and (Qtytype in [1,2,3]), Qtytypefield(False)  +',', ' ') +'SL.ProductId, S.ClassID';
                if ctr =2 then Result   := Result   +NL+' ) aaa  group by Class , productname , QtyDate';
              end;
            end;
      end;

      REsult := result + ' Order by productprintname, Class , ' + iif(Qtytype in [1,2,3] , 'QtyDate  ,' , '')+ ' Details  ';
end;
function SalesDispatchBarcodeSQL(const SaleIDs:String; Const saleLineIDs:String; const BatchIds:String; const ExtraWhere :String =''; mode: TFiltertype= tDetails):String;
begin
  REsult := companyInfoSQL('CompanyInfo') +
            '~|||~{Details}' +  SalesDispatchBarcodeSQLWithoutcompanyInfo(SaleIDs,saleLineIDs,BatchIds,ExtraWhere ,mode) +
            //' ~|||~ {RelatedParts} select * from tblsalesbatches' +
            '~|||~{RelatedParts}select ' +
            'slpqad.PQADetailID as batchid,SB.* , SB.UOMWeight* SB.RelatedProductQty as TareWeight ' +
            'from tblsalesbatches SB ' +
            'inner join tblpqadetails PQAD on /*SB.SalesPQADetailsID*/SB.ManPQAdetailsID = PQAD.PQADetailID  and PQAD.PQAType ="Batch" ' +
            'inner join tblpqa pqa on PQAD.pqaid = pqa.pqaid  and pqa.transtype = "TProcTreePart" and pqa.Alloctype ="IN" ' +
            'inner join tblproctreepart PTP on PTP.ProcTreePartId = pqa.translineid ' +
            'inner join tblproctree PT on Pt.proctreeId  = PTP.proctreeId ' +
            'inner join tblsaleslines SL on SL.SaleLineId = PT.MasterId ' +
            'inner join tblpqa slpqa on SL.salelineId = slpqa.TransLineID and slpqa.transtype = "TSalesOrderLine" ' +
            'inner join tblpqadetails slpqad on slpqad.pqaid = slpqa.pqaid and slpqad.pqatype ="Batch" and slpqad.value = pqad.value ' +
            iif(trim(SaleIDs    )<> '',  ' and  SL.sAleID              in ( ' + SaleIDs +')'     ,'')+
            iif(trim(saleLineIDs)<> '',  ' and  SL.SaleLineID         in ( ' + saleLineIDs +')' ,'')+
            iif(trim(BatchIds   )<> '',  ' and  SB.SalesPQADetailsID  in ( ' + BatchIds +')'    ,'')+
            '~|||~' +  ColumnHeadingsSQL('columnHeadings' , '' , true)+
            '~|||~{CasenumberSummary}Select  S.saleId, sl.saleLineid, sl.productname,PQABatch.custfld3 Casenumber, count(PQAbatch.PQADetailid) as nos , sum(PQAbatch.UOMQty) as Totalqty '+
            ' From tblSales S ' +
            ' inner join tblsaleslines SL on S.saleId = SL.saleID ' +
            TransTables(tDetails , 'SL' , 'SaleId' , 'SaleLineId' , SalesTransTypes)+
            ' where ifnull(PQABatch.custfld3,"")<> "" and (S.isinvoice ="T" or S.ISSalesOrder ="T" )'+
            iif(trim(SaleIDs    )<> '',  ' and  S.sAleID              in ( ' + SaleIDs +')'     ,'')+
            iif(trim(saleLineIDs)<> '',  ' and  SL.SaleLineID         in ( ' + saleLineIDs +')' ,'')+
            ' group by SaleId, salelineId, PQABatch.custfld3';
end;

function SalesDispatchBarcodeSQLWithoutcompanyInfo(const SaleIDs:String; Const saleLineIDs:String; const BatchIds:String; const ExtraWhere :String =''; mode: TFiltertype= tDetails):String;
begin
REsult :=   'Select T.* ,'+
            WeightFields( 'TotalUOMWeight'  , 'UOMWeight'       )+'  ,  ' +
            WeightFields( 'TareWeight'      , 'TareWeight'      )+'  ,  ' +
            WeightFields( 'ContainerWt'     , 'ContainerWt'     )+'  ,  ' +
            WeightFields( 'PalletWt'        , 'PalletWt'        )+'  ,  ' +
            WeightFields( 'GrossWeight'     , 'GrossWeight'     )+'  ,  ' +
            WeightFields( 'NetWeight'       , 'NetWeight'     )+'  ,  ' +
            WeightFields( 'GrossWeightCalc' , 'GrossWeightCalc' )+
            ' From ( '+
                    'Select S.customername, SL.productID, SL.Product_Description,P.Description as ProductDescription, P.PARTSDESCRIPTION_Memo as PARTSDESCRIPTION_Memo,SL.saleLineId,  S.Shipdate, S.saleDate, S.SaleID,  S.InvoiceDocNumber , SL.productname,   ' +
                    ' SL.UnitofMeasureSaleLines, PQABatch.Value as Batchno , PQABatch.expirydate, PQABatch.uomQty , PQABatch.BOUOMQty  as BOUOMQty, PQABatch.mstimestamp MFGDatetime , Date(PQABatch.mstimestamp) MFGDate, ' +
                    ' concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") as UOM ,  SL.UnitofMeasureQtySold , SL.UnitofMeasureShipped ,  ' +
                    ' SL.UnitofMeasureBackorder ,   ' +
                    ' convert(concat(' +Quotedstr(Barcode_Prefix_SLBatch) +',"-",SL.SaleLineID , "-" ,  PQABatch.Value), char(1000))  as SaleProductBatchBarcode,   ' +
                    ' ifnull((Select Sum(UOMQTY) from tblsalesdispatchlines SDL where  SDL.saleID = SL.saleID and SDL.salelineId = SL.salelineID and SDL.BatchNo = PQABatch.Value ),0) as TotalDispatched,   ' +
                    ' if(ifnull(PQABatch.uomQty,0) =0 ,PQABatch.BOuomQty ,PQABatch.uomQty) - ifnull((Select Sum(UOMQTY) from tblsalesdispatchlines SDL where  SDL.saleID = SL.saleID and SDL.salelineId = SL.salelineID and SDL.BatchNo = PQABatch.Value ),0) as Tobedispatched ,  ' +
                    ' convert(Concat("P",YEAR(CURRENT_DATE()), "00", S.SaleID, "00",  pqabatch.Value, "-", Format(pqabatch.UOMQty,2)), char(1000)) as Barcode ,  ' +
                    ' P.CUSTFLD1 as ProductCUSTFLD1,  ' +
                    ' P.CUSTFLD2 as ProductCUSTFLD2,  ' +
                    ' P.CUSTFLD3 as ProductCUSTFLD3,  ' +
                    ' P.CUSTFLD4 as ProductCUSTFLD4,  ' +
                    ' P.CUSTFLD5 as ProductCUSTFLD5,  ' +
                    ' P.CUSTFLD6 as ProductCUSTFLD6,  ' +
                    ' P.CUSTFLD7 as ProductCUSTFLD7,  ' +
                    ' P.CUSTFLD8 as ProductCUSTFLD8,  ' +
                    ' P.CUSTFLD9 as ProductCUSTFLD9,  ' +
                    ' P.CUSTFLD10 as ProductCUSTFLD10,  ' +
                    ' P.CUSTFLD11 as ProductCUSTFLD11,  ' +
                    ' P.CUSTFLD12 as ProductCUSTFLD12,  ' +
                    ' P.CUSTFLD13 as ProductCUSTFLD13,  ' +
                    ' P.CUSTFLD14 as ProductCUSTFLD14,  ' +
                    ' P.CUSTFLD15 as ProductCUSTFLD15,  ' +
                    ' P.CUSTDATE1 as ProductCUSTDATE1,  ' +
                    ' P.CUSTDATE2 as ProductCUSTDATE2,  ' +
                    ' P.CUSTDATE3 as ProductCUSTDATE3,  ' +
                    ' SL.SalesLinesCustField1 as SalesLinesCustField1,' +
                    ' SL.SalesLinesCustField2 as SalesLinesCustField2,' +
                    ' SL.SalesLinesCustField3 as SalesLinesCustField3,' +
                    ' SL.SalesLinesCustField4 as SalesLinesCustField4,' +
                    ' SL.SalesLinesCustField5 as SalesLinesCustField5,' +
                    ' SL.SalesLinesCustField6 as SalesLinesCustField6,' +
                    ' SL.SalesLinesCustField7 as SalesLinesCustField7,' +
                    ' SL.SalesLinesCustField8 as SalesLinesCustField8,' +
                    ' SL.SalesLinesCustField9 as SalesLinesCustField9,' +
                    ' SL.SalesLinesCustField10 as SalesLinesCustField10,' +
                    ' P.PRODUCTCODE,  ' +
                    ' PQABatch.PQADetailID as batchID, ' +
                    ' PQABatch.Qty ,  ' +
                    ' PQABatch.uomQty * UOM.Weight as TotalUOMWeight ,  ' +
                    ' PQABatch.uomQty * UOM.Volume as TotalUOMVolume ,  ' +
                    ' (PQABatch.uomQty * UOM.Volume)* :CubicMeterToBroadFeet as TotalUOMVolumeinBoardFeet ,  ' +
                    //WeightFields( '  (PQABatch.uomQty * UOM.Weight) ' , 'UOMWeight')+'  ,  ' +
                    ' PQABatch.CUSTFLD1 as BatchCUSTFLD1 ,  ' +
                    ' PQABatch.CUSTFLD3 as BatchCUSTFLD3 ,  ' +
                    ' PQABatch.CUSTFLD4 as BatchCUSTFLD4,  ' +
                    ' PQABatch.CUSTFLD6 as GrossWeight,  ' +
                    ' PQABatch.CUSTFLD7 as NetWeight,  ' +
                    ' S.PONumber, S.ShipTo,  ' +
                    ' convert(concat(pqabatch.Value , "-",P.CUSTFLD1 , "-",P.CUSTFLD2,  "-",P.CUSTFLD3,"-",Format(pqabatch.uomQty,2),"-",P.CUSTFLD4),char(1000)) as combinedBarCode,'+
                    ' (Select Sum(SB.UOMWeight* SB.RelatedProductQty) from tblsalesbatches SB where SB.SalesPQADetailsID = PQABatch.PQADetailID) as TareWeight , '+

                    ' round((Select SB.UOMWeight* SB.RelatedProductQty from tblsalesbatches SB inner join tblsaleslines SL on SB.SaleLineId = SL.SaleLineId and SL.iscontainer ="T" where SB.SalesPQADetailsID = PQABatch.PQADetailID),'+ inttostr(TcConst.GeneralRoundPlaces)+') as ContainerWt , '+
                    ' round((Select SB.UOMWeight* SB.RelatedProductQty from tblsalesbatches SB inner join tblsaleslines SL on SB.SaleLineId = SL.SaleLineId and SL.isPallet    ="T" where SB.SalesPQADetailsID = PQABatch.PQADetailID),'+ inttostr(TcConst.GeneralRoundPlaces)+') as PalletWt , '+

                    ' round((Select SB.RelatedProductQty from tblsalesbatches SB inner join tblsaleslines SL on SB.SaleLineId = SL.SaleLineId and SL.iscontainer ="T" where SB.SalesPQADetailsID = PQABatch.PQADetailID),'+ inttostr(TcConst.GeneralRoundPlaces)+') as ContainerQty , '+
                    ' round((Select SB.RelatedProductQty from tblsalesbatches SB inner join tblsaleslines SL on SB.SaleLineId = SL.SaleLineId and SL.isPallet    ="T" where SB.SalesPQADetailsID = PQABatch.PQADetailID),'+ inttostr(TcConst.GeneralRoundPlaces)+') as PalletQty , '+

                    //' (Select Sum(SB.UOMWeight* SB.RelatedProductQty) from tblsalesbatches SB where SB.SalesPQADetailsID = PQABatch.PQADetailID) + PQABatch.uomQty * UOM.Weight as GrossWeight '+
                    iif(ProcPrefs.RoundBatchQtyinProgressBatchCreator  ,
                      ' TRUNCATE((Select Sum(SB.UOMWeight* SB.RelatedProductQty) from tblsalesbatches SB where SB.SalesPQADetailsID = PQABatch.PQADetailID) + PQABatch.uomQty * UOM.Weight , 0) as GrossWeightcalc ' ,
                    ' (Select Sum(SB.UOMWeight* SB.RelatedProductQty) from tblsalesbatches SB where SB.SalesPQADetailsID = PQABatch.PQADetailID) + PQABatch.uomQty * UOM.Weight as GrossWeightcalc ')+
                    iif(mode >= tExtraDetails   , ',PBin.binLocation , PBin.BinNumber, PQABins.PqadetailId as binId','')+
                    iif(mode >= tDetailswithSno , ',PQASN.value as Serialnumber, PQASN.PqadetailId as SNID','')+
                    ' From tblSales S ' +
                    ' inner join tblsaleslines SL on S.saleId = SL.saleID ' +
                    ' inner join tblunitsofmeasure UOM on UOM.UnitID = SL.UnitOfMeasureID ' +
                    TransTables(Mode , 'SL' , 'SaleId' , 'SaleLineId' , SalesTransTypes)+
                    ' Where (S.isinvoice ="T" or S.ISSalesOrder ="T" )'+
                    iif(trim(SaleIDs    )<> '',  ' and  S.sAleID              in ( ' + SaleIDs +')'     ,'')+
                    iif(trim(saleLineIDs)<> '',  ' and  SL.SaleLineID         in ( ' + saleLineIDs +')' ,'')+
                    iif(trim(BatchIds   )<> '',  ' and  PQABatch.PQADetailID  in ( ' + BatchIds +')'    ,'')+
                    iif(trim(ExtraWhere) <> '',  ' and ' + ExtraWhere                                   ,'')+
            ' ) as T';

end;
Function ProcTreePQABatchIdsToSLPQABatchIDs(Const ProcTreePQABatchIds:String;fconn: TERPConnection):String;
var
  Qry:TERPQuery;
begin
  result := '';
  if ProcTreePQABatchIds = '' then exit;
  if fconn = nil then fconn := commondblib.GetSharedMyDacConnection;
  Qry := DbSharedObj.GetQuery(fconn);
  try
    Qry.SQL.Text := 'Select slpqabatch.PQADetailID '+
                    ' from tblpqadetails ManpqaBatch '+
                    ' inner join tblpqa MANPQA on ManpqaBatch.PQAID  = ManPQA.PQAID '+
                    ' inner join tblproctreepart ptp on ptp.ProcTreePartId = ManPQA.TranslineID and ManPQA.transtype in ("TProcTreePart") and ManPQA.alloctype ="IN" '+
                    ' inner join tblproctree PT on PT.ProcTreeId = ptp.ProcTreeId '+
                    ' inner join tblpqa slpqa on slpqa.TransLineID = PT.masterId and slpqa.transtype = "TSalesOrderLine" and SLPQA.alloctype ="OUT" '+
                    ' inner join tblpqadetails slpqabatch on slpqabatch.pqaid = slpqa.pqaid and slpqabatch.Value = ManpqaBatch.value '+
                    ' where ManpqaBatch.pqadetailId in ('+ ProcTreePQABatchIds+')';
    Qry.Open;
    result:= Qry.GroupConcat('PQADetailID');
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
function SalesAddressLabelSQL(const NoOfBoxes :Integer; SaleID:Integer): string;
var
  I: Integer;
begin
  Result := '';
  if NoOfBoxes =0 then exit;
  for I := 1 to NoOfBoxes do begin
    if Result <> '' then Result := Result + chr(13) + ' union ' + chr(13);
    Result := Result + 'Select *, ' + QuotedStr(IntToStr(I) + ' of ' + IntToStr(NoOfBoxes)) + ' as Description  from tblSales S where SaleId = ' + IntToStr(SaleID);
  end;
  result := companyInfoSQL('CompanyInfo') +
            ' ~|||~{Details}' + result +
            '~|||~{Products}Select  SaleLineID,ProductName,Product_Description,Product_Description_Memo,UnitofMeasureQtySold,UnitofMeasureShipped,'+
                                    ' UnitofMeasureBackorder,concat(UnitofMeasureSaleLines,"(" , UnitofMeasureMultiplier,")") as UOM, TotalLineAmount,'+
                                    ' TotalLineAmountInc '+
                                    ' from tblsaleslines Where SaleId = ' + IntToStr(SaleID);

end;

Function PrintDeliverydocket(Const SaleID:Integer;clientID:Integer;BOID:String; ownerform:TForm; showPreview:Boolean ;ReportToPrint:String):String;
var
  dd: TDeliveryDocketReportSQL;
  conf: TConfirmPrintBackordersGui;
  sql: string;
//  TemplateName: string;
//  SSQL:String;
//  Json: TJsonObject;
//  function Transtype:String;
//  begin
//    result :='';
//    With tempMyquery do try
//      SQL.add('Select IsSalesOrder, IsInvoice, IsQuote  from tblsales where saleID = ' +inttostr(SaleID));
//      open;
//           if fieldByname('IsInvoice').asboolean    then result := Tinvoiceline.classname
//      else if fieldByname('IsSalesOrder').asboolean then result := TSalesOrderLine.classname
//      else if fieldByname('IsQuote').asboolean      then result := TQuoteLine.classname;
//    finally
//      ClosenFree;
//    end;
//  end;
begin
  dd := TDeliveryDocketReportSQL.Create;
  conf := TConfirmPrintBackordersGui.Create;
  try
    dd.OnExcludeBackordersVerify := conf.DoConfirmPrintBackOrders;
    dd.SaleId := SaleID;
    dd.ReportToPrint := ReportToPrint;
    dd.ReportSQLSupplied := TBaseInputGUI(ownerform).fbReportSQLSupplied;
    sql := dd.GetReportSQL;
    TBaseInputGUI(ownerform).fbReportSQLSupplied := dd.ReportSQLSupplied;
    result := dd.TemplateName;
//  SSQL := '';
//   TemplateName := ReportToPrint;
//   Try
//     if TemplateName = '' then   TemplateName:= tcDataUtils.GetTemplate(tcDataUtils.clientDefaultDeliveryTemplateID(clientID));
//     if TemplateName = '' then  if OwnerForm is TBaseInputGUI then TemplateName := (*TBaseInputGUI(ownerform).*)tcdatautils.GetDefaultReport(29);
//     if TemplateName = '' then if IssaleOnHold(saleID) then TemplateName := 'Delivery Docket Held' else TemplateName := 'Delivery Docket';
//    if sametext(Copy(templateName+ '              ' , 1, 14), 'Bill of Lading') then begin
//      sSQL :=  '~|||~where S.SAleId = ' +IntToStr(SaleID);
//      if appenv.CompanyPrefs.RemoveHideOnPrintProductFromReports then sSQL := sSQL + ' AND (P.HideOnPrint = "F"  and   (SL.IsRelatedProduct = "F" or ( SL.IsRelatedProduct = "T" and RP.HideRelated  = "F" and RP.ISContainer="F" and RP.IsPallet="F")))';
//      sSQL := sSQL + 'order by   if(ifnull(P.PRODUCTAttrib1,0)>0 , if(ifnull( UOM.Weight,0)>= ifnull(P.PRODUCTAttrib1,0) , 1 , 2) , if(ifnull(P.generalnotes,"") <> "" , 3 , 4)) , P.PRODUCTAttrib1, RQ ';
//      TBaseInputGUI(ownerform).fbReportSQLSupplied:= False;
//    end else if not(SameText(trim(TemplateName) , 'Delivery Docket With Details')) then begin
//      sSQL :=  '~|||~~|||~AND d2.SaleID = ' +IntToStr(SaleID);
//      if (AppEnv.CompanyPrefs.ExcludeBOFromPrintinSales) and (BOID <> '')  then
//        if MessageDlgXP_Vista('Do You Wish to Exclude the Back Ordered Items From Print?' , mtConfirmation , [mbyes, mbno] , 0 ) = mryes then
//          SSQL := SSQL + ' AND ifnull(d3.shipped,0) <> 0 ';
//          TBaseInputGUI(ownerform).fbReportSQLSupplied:= False;
//    end else begin
//      TBaseInputGUI(ownerform).fbReportSQLSupplied:= True;
//      sSQL:= PrintPickingSlipsLib.SQL4PickingSlipreport(ReportToPrint,Json, IntToStr(SaleID), Transtype);
//    end;
    // Binny : the last parameter 'json' to PrintTemplateReport function is only applicable for picking slips.
    // the same SQL is used for Delivery dockets as well , but the last SQLs are not applicable
    if OwnerForm is TBaseInputGUI then TBaseInputGUI(ownerform).PrintTemplateReport(result, SQL, not showPreview, 1)
    else if OwnerForm is TBaseListingGUI then TBaseListingGUI(ownerform).PrintTemplateReport(result, SQL, not showPreview, 1);
  finally
    conf.Free;
    dd.Free;
//    REsult :=  TemplateName;
  end;
end;

Function  PrintSalesPickingSlip(ReportName:String;const SaleID:Integer; Const lineClass:String; ownerform:TForm; showPreview:Boolean ):Boolean;
var
  TemplateName: string;
  sSQL :String;
  Json: TJsonObject;
begin
  TemplateName := ReportName;
  if TemplateName = '' then
    if OwnerForm is TBaseInputGUI then TemplateName := (*TBaseInputGUI(ownerform).*)tcdatautils.GetDefaultReport(30);

  if TemplateName = '' then TemplateName := 'Picking Slip';
  sSQL:= PrintPickingSlipsLib.SQL4PickingSlipreport(TemplateName,json, IntToStr(SaleID), Lineclass);

  if OwnerForm is TBaseInputGUI then    begin
      TBaseInputGUI(ownerform).fbReportSQLSupplied := true;
      TBaseInputGUI(ownerform).PrintTemplateReport(TemplateName, sSQL, not ShowPreview, 1, json);
      TBaseInputGUI(ownerform).fbReportSQLSupplied := False;
  end else if OwnerForm is TBaseListingGUI then  begin
      TBaseListingGUI(ownerform).ReportSQLSupplied := true;
      TBaseListingGUI(ownerform).PrintTemplateReport(TemplateName, sSQL, not ShowPreview, 1, json);
      TBaseListingGUI(ownerform).ReportSQLSupplied := False;
  end;

  Result := true;

end;
Function UnAllocatedBatchByPalletSQL(const aSaleID, aSaleLineId ,aProductId,  aReporttype:Integer; aCustFLd5:String = ''):String;
begin
result := companyInfoSQL('CompanyInfo')+
        NL+' ~|||~{Batchnos}Select s.saleId, s.saleDate, S.customername, S.PONumber,  ' +
        ' sl.salelineid,sl.productId,  sl.ProductName , concat(sl.UnitofMeasureSaleLines , "(" , sl.UnitofMeasureMultiplier , ")") uom,  ' +
        ' sl.UnitofMeasureQtySold , sl.UnitofMeasureShipped , sl.UnitofMeasureBackorder,  ' +
        ' pqad.Value as Batchno, pqad.ExpiryDate , pqad.CUSTFLD1 , pqad.CUSTFLD2, pqad.CUSTFLD3 , pqad.CUSTFLD4 , pqad.CUSTFLD5 ,pqad.UOMQty , pqad.PQADetailID , '+
        WeightFields( ' UOM.Weight * pqad.UOMQty' , 'NettWeight')+',' +
        Firstcolumn +' as col1, '+
        Secondcolumn+' as col2, '+
        Thirdcolumn +' as col3, '+
        WeightFields( ' UOM.Weight * pqad.UOMQty  + ' +
        ' (Select  sum(sb.RelatedProductQty* uom.weight) ' +
        ' from tblsalesbatches sb   ' +
        ' inner join tblsaleslines sl on sb.SaleLineId = sl.SaleLineID  ' +
        ' inner join tblunitsofmeasure uom on uom.UnitID = sl.UnitOfMeasureID  ' +
        ' where sb.salesPQAdetailsID =  pqad.PQADetailID ' +
        iif(aReporttype =1 , ' and  sb.RelatedParentLineRef = ' +Quotedstr(getGlobalref('tblsaleslines' , 'SaleLineId' ,aSaleLineId )) ,
                                         ' and SL.saleID= ' + inttostr(aSaleID))+')' , ' GrossWeight')+' ,' +
        WeightFields( ' (Select  sum(sb.RelatedProductQty* uom.weight) ' +
        ' from tblsalesbatches sb   ' +
        ' inner join tblsaleslines sl on sb.SaleLineId = sl.SaleLineID  ' +
        ' inner join tblunitsofmeasure uom on uom.UnitID = sl.UnitOfMeasureID  ' +
        ' where sb.salesPQAdetailsID =  pqad.PQADetailID ' +
        iif(aReporttype =1 , ' and  sb.RelatedParentLineRef = ' +Quotedstr(getGlobalref('tblsaleslines' , 'SaleLineId' ,aSaleLineId )) ,
                                         ' and SL.saleID= ' + inttostr(aSaleID))+')','TareWeight' )+

        ' from tblsales s  ' +
        ' inner join tblsaleslines sl on s.saleId = sl.saleId  ' +
        ' inner join tblparts p on p.partsId = sl.productId ' +
        ' inner join tblpqa pqa on sl.salelineid = pqa.TransLineID and pqa.transtype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine")  ' +
        ' inner join tblpqadetails pqad on pqa.PQAID = pqad.PQAID and pqad.PQAType ="BATCH"  ' +
        ' inner join tblunitsofmeasure UOM on pqa.UOMID = UOM.UnitID  ' +
        iif(aReporttype =1 , ' Where Sl.saleLineId = ' + inttostr(aSaleLineId) ,
                                         ' Where S.saleID= ' + inttostr(aSaleID)+' and pqad.CUSTFLD5 = ' + Quotedstr(aCustFLD5))+
        ' Order by SaleLineId ' +
        NL+' ~|||~{SalesRelatedProducts}Select  sb.salesPQAdetailsID , sb.dateCreated , sb.Productname, sb.uom, sb.RelatedProductQty, sb.RelatedParentLineRef  ,  '+
        WeightFields( '  sb.RelatedProductQty* uom.weight ', 'TareWeight')+
        ' from tblsalesbatches sb   ' +
        ' inner join tblsaleslines sl on sb.SaleLineId = sl.SaleLineID  ' +
        ' inner join tblunitsofmeasure uom on uom.UnitID = sl.UnitOfMeasureID  ' +
        ' inner join tblsales S on S.saleId = SL.saleId '+
        iif(aReporttype =1 , ' Where sb.RelatedParentLineRef = ' +Quotedstr(getGlobalref('tblsaleslines' , 'SaleLineId' ,aSaleLineId )) ,
                                         ' Where S.saleID= ' + inttostr(aSaleID))+
        ' Order by sb.RelatedParentLineRef , sl.saleLineId,  sb.RelatedParentLineRef , sb.Productname  ' +
        NL+' ~|||~{ProductRelatedProducts}Select Distinct RP.* from tblrelatedparts RP ' +
        ' inner join tblsaleslines SL on SL.productId = RP.parentId ' +
        iif(aReporttype =1 , ' where ParentId = ' + inttostr(aProductID),
                                         ' where SL.saleID= ' + inttostr(aSaleID))+
        ' Order by RP.parentId ' +
        NL+' ~|||~'+ColumnHeadingsSQL('ColumnHeadings');
end;

procedure CheckForSalesTaxBasedon(SalesForm :TBaseTransGUI; Const  aISSalesLocked:Boolean; SaleBase : TSalesBase);
begin
  with SalesForm do begin
    if (SaleBase.Lines.ProductId>0) then begin
      if not(aISSalesLocked) then begin
        if SaleBase.Lines.SalesTaxBasedonProductPrice then begin
          grdtransactions.ColumnByName(tblDetails.Findfield('LinePrice').fieldname).Readonly := true;
          grdtransactions.ColumnByName(tblDetails.findfield('LinePriceInc').fieldname).Readonly := true;

          grdtransactions.ColumnByName(tblDetails.findfield('DiscountedPrice').fieldname).Readonly := False;
          grdtransactions.ColumnByName(tblDetails.findfield('DiscountedPriceInc').fieldname).Readonly := False;


          grdtransactions.ColumnByName(tblDetails.findfield('TotalLineamount').fieldname).Readonly := true;
          grdtransactions.ColumnByName(tblDetails.findfield('TotalLineamountInc').fieldname).Readonly := true;

          grdtransactions.ColumnByName(tblDetails.findfield('TotalDiscountedPrice').fieldname).Readonly := False;
          grdtransactions.ColumnByName(tblDetails.findfield('TotalDiscountedPriceInc').fieldname).Readonly := False;

          if tblDetails.findfield('LinePrice').Visible then begin
              if not tblDetails.findfield('DiscountedPrice').Visible then tblDetails.findfield('DiscountedPrice').Index := tblDetails.findfield('LinePrice').Index+1;
              grdTransactions.AddField(tblDetails.findfield('DiscountedPrice').Fieldname);
              guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetails.findfield('DiscountedPrice').Fieldname);
          end;
          if tblDetails.findfield('TotalLineamount').Visible then begin
              if not tblDetails.findfield('TotalDiscountedPrice').Visible then tblDetails.findfield('TotalDiscountedPrice').Index := tblDetails.findfield('TotalLineAmount').Index+1;
              grdTransactions.AddField(tblDetails.findfield('TotalDiscountedPrice').Fieldname);
              guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetails.findfield('TotalDiscountedPrice').Fieldname);
          end;
          if tblDetails.findfield('LinePriceinc').Visible then begin
              if not tblDetails.findfield('DiscountedPriceinc').Visible then tblDetails.findfield('DiscountedPriceinc').Index := tblDetails.findfield('LinePriceinc').Index+1;
              grdTransactions.AddField(tblDetails.findfield('DiscountedPriceinc').Fieldname);
              guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetails.findfield('DiscountedPriceinc').Fieldname);
          end;
          if tblDetails.findfield('TotalLineamountInc').Visible then begin
              if not tblDetails.findfield('TotalDiscountedPriceinc').Visible then tblDetails.findfield('TotalDiscountedPriceinc').Index := tblDetails.findfield('TotalLineAmountinc').Index+1;
              grdTransactions.AddField(tblDetails.findfield('TotalDiscountedPriceinc').Fieldname);
              guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetails.findfield('TotalDiscountedPriceinc').Fieldname);
          end;
        end else begin
          grdtransactions.ColumnByName(tblDetails.Findfield('LinePrice').fieldname).Readonly := False;
          grdtransactions.ColumnByName(tblDetails.findfield('LinePriceInc').fieldname).Readonly := False;
          grdtransactions.ColumnByName(tblDetails.findfield('TotalLineamount').fieldname).Readonly := False;
          grdtransactions.ColumnByName(tblDetails.findfield('TotalLineamountInc').fieldname).Readonly := False;
        end;
      end;
    end;
  end;
end;


end.
