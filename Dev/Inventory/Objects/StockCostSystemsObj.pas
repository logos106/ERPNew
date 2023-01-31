unit StockCostSystemsObj;

interface 

uses Classes, MyAccess, ERPdbComponents, MyScript, kbmMemTable, ProgressInfoObj;

type 
  TStockCostSystemsObj = class(TObject)
  private 
    procedure PopulateData(const DateSQL: string);
    procedure CalculateAdjValue;
    function GetProductLastCost(const Date: TDateTime; const ProductID: integer): double;
    procedure MemTableStartDefaultSetting(const MemTable: TkbmMemTable);
    procedure MemTableReadyToUseDefaultSetting(const MemTable: TkbmMemTable);
    function getInstock(fiProductID:Integer; AsOn :TDatetime):Double;
    function GetProgressDlg: TProgressInfo;
    (*procedure GetProductsQtysAtDate(const Date: TDateTime; const MemTable: TkbmMemTable);*)
    property ProgressDlg: TProgressInfo read GetProgressDlg;
  public
    destructor Destroy; override;
    procedure CleanTempTable;
    procedure RefreshLastCostAdjTable(const DateSQL: string);
  end;

implementation 

uses pqalib,
  {ProgressDialog,} SysUtils,  Forms, {AppEnvironment,} MySQLConst, Rounding,
  ProductQtyLib, {busobjOrders,} AppEnvironmentVirtual;

{ TStockCostSystemsObj }

procedure TStockCostSystemsObj.CleanTempTable;
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  try
    qry.Connection := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    with qry do begin
      SQL.Clear;
      SQL.Add('DELETE QUICK FROM tblstocklastcostadjustments;');
      Execute;
    end;
  finally 
    FreeAndNil(qry);
  end;
end;

destructor TStockCostSystemsObj.Destroy;
begin
  AppEnvVirt.Obj['ProgressInfo'].Free;
  AppEnvVirt.Obj['ProgressInfo'] := nil;
  inherited;
end;

procedure TStockCostSystemsObj.PopulateData(const DateSQL: string);
var
  strSQL:String;
  tablename :STring;
begin
  TableName := 'tmp_tblstocklastcostadjustments' + AppEnvVirt.Str['CommonDbLib.GetTemporaryTableNameSuffix']   ;
  strSQL := 'Drop table if exists ' + TableName +';' +
            'Create table ' + tablename +
            ' Select PQA.transId, PQa.transLineId, PQA.transType, TT.Description , PQA.TransDate, PQA.ProductID, PQA.DepartmentId, P.Avgcost as CostEx,'+
            SQL4Qty(tInstock) + ' as Qty'+
            ' FROM ' + ProductTables(tsummary, false, true);
  if DateSQL <> '' then strSQL :=strSQL +' Where PQA.TransDate ' + DateSQL;
  strSQL :=strSQL +' group by  PQA.TransId, PQa.transLineId, PQA.Transtype ;';
  {exclude POS not invoiced}
  strSQL :=strSQL +' Delete SCA.* from ' +
                    ' ' + tablename +' SCA '+
                    ' inner join tblpurchaseorders as PO on PO.PurchaseOrderID = SCA.TransID and SCA.TransType in ( '  + POTransTypes +')'+
                    ' where IsNull(PO.InvoiceDate);';
  {get cost from PO}
  strSQL :=strSQL +' update  ' + tablename +' SCA '+
                    ' inner join  tblpurchaselines as POL  on POL.PurchaseOrderID = SCA.TransId and POL.PurchaseLineID = SCA.TransLineId and SCA.TransType in (' + POTranstypes +')' +
                    ' Set SCA.CostEx = POL.LineCost '+
                    ' where ifnull(POL.LineCost,0) <> 0;';
  {get cost from sales}
  strSQL :=strSQL +' update  ' + tablename +' SCA '+
                    ' inner join  tblsaleslines as SL  on SL.SaleID = SCA.TransId and SL.SaleLineID = SCA.TransLineId and SCA.TransType in (' + SalesTranstypes +')' +
                    ' Set SCA.CostEx = SL.LineCost '+
                    ' where ifnull(SL.LineCost,0) <> 0;';
  {write into the tblstocklastcostadjustments table}
  strSQL := strSQL + ' INSERT HIGH_PRIORITY INTO tblstocklastcostadjustments ' +
            ' (TransType,Date,ProductID,ClassID,CostEx, Qty ) ' +
            ' Select Description , TransDate , ProductID , DepartmentId , CostEx ,Qty ' +
            ' from   ' + tablename +' where ifnull(qty,0) <> 0';
  with TERPQuery(AppEnvVirt.Obj['CommonDbLib.TempMyQuery']) do try
    SQL.add(strSQL);
    try
      Execute;
    except
      { This to hide lock wait timeouts that will occure if any user
        is adding/editing sales/purchases. This function is called from
        CleanRefreshTrnsTable which also skips locked records. }

    end;
  finally
      if active then close;
      Free;
  end;

(*var
  cmd: TERPCommand;
begin
  cmd := TERPCommand.Create(nil);
  try
    cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
    with cmd do begin//PO's AND Stock Adjustment's
      //Sale
      SQL.Clear;
      SQL.Add('INSERT HIGH_PRIORITY INTO tblstocklastcostadjustments (TransType,Date,Qty,ProductID,ClassID,CostEx) ');
      SQL.Add('SELECT ');
      SQL.Add('"Sale        " AS TransType, ');
      SQL.Add('SaleDate AS TranDate, ');
      SQL.Add('-Shipped AS Qty, ');
      SQL.Add('ProductID,ClassID, ');
      SQL.Add('LineCost as CostEx ');
      SQL.Add('FROM tblsales ');
      SQL.Add('INNER JOIN tblsaleslines Using(SaleID) ');
      SQL.Add('WHERE ((IsInvoice="T" OR IsRefund="T" OR IsCashSale="T") ');
      SQL.Add('AND (tblsales.IsQuote<>"T" AND IsSalesOrder<>"T" AND IsVoucher<>"T" AND IsLayby<>"T" AND IsLaybyTOS<>"T" AND IsLaybyPayment<>"T")) ');
      SQL.Add('AND Shipped<>0');
      SQL.Add('AND tblsales.SaleDate ' + DateSQL);
      SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
      Execute;

      //PO
      SQL.Clear;
      SQL.Add('INSERT HIGH_PRIORITY INTO tblstocklastcostadjustments (TransType,Date,Qty,ProductID,ClassID,CostEx) ');
      SQL.Add('SELECT ');
      SQL.Add('"PO" AS TransType, ');
      SQL.Add('InvoiceDate AS TranDate, ');
      SQL.Add('Shipped AS Qty, ');
      SQL.Add('ProductID,ClassID, ');
      SQL.Add('LineCost as CostEx ');
      SQL.Add('FROM tblPurchaseOrders ');
      SQL.Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
      SQL.Add('WHERE (PARTTYPE = "INV" OR PARTTYPE = "GRP") ');
      SQL.Add('AND tblPurchaseLines.Invoiced="T" ');
      SQL.Add('AND tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F" AND not IsNull(InvoiceDate) ');
      SQL.Add('AND Shipped<>0');
      SQL.Add('AND tblPurchaseOrders.InvoiceDate ' + DateSQL);
      SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
      Execute;

      //Stock Adjust
      {SQL.Clear;
      SQL.Add('INSERT HIGH_PRIORITY INTO tblstocklastcostadjustments (TransType,Date,Qty,ProductID,ClassID,CostEx) ');
      SQL.Add('SELECT ');
      SQL.Add('"StockAdj" AS TranDate, ');
      SQL.Add('CreationDate as Date, ');
      SQL.Add('Qty, ');
      SQL.Add('ProductID, ');
      SQL.Add('ClassID, ');
      SQL.Add('Cost as CostEx ');
      SQL.Add('FROM tblstockadjust ');
      SQL.Add('INNER JOIN tblstockadjustment ON tblstockadjustment.StockAdjustmentNo = tblstockadjust.StockAdjustmentNo ');
      SQL.Add('WHERE tblstockadjust.Deleted<>"T" AND Qty <> 0 ');
      SQL.Add('AND Qty<>0');
      SQL.Add('AND tblstockadjust.CreationDate ' + DateSQL);
      Execute;}

      SQL.Clear;
      SQL.Add('INSERT HIGH_PRIORITY INTO tblstocklastcostadjustments (TransType,Date,Qty,ProductID,ClassID,CostEx) ');
      SQL.Add('SELECT');
      SQL.Add('"StockAdj" AS TransType,');
      SQL.Add('SM.Movementdate as Date,');
      SQL.Add('Qty,');
      SQL.Add('ProductID,');
      SQL.Add('ClassID,');
      SQL.Add('Cost as CostEx');
      SQL.Add('FROM tblStockmovement as SM');
      SQL.Add('INNER JOIN tblStockmovementLines  as SML ON SM.StockMovementId = SML.StockMovementID and SM.StockmovementEntryType = "StockAdjustEntry"');
      SQL.Add('WHERE SM.Deleted<>"T" AND Qty <> 0');
      SQL.Add('AND Qty<>0');
      SQL.Add('AND   SM.Movementdate  ' + DateSQL);
      Execute;

      {//Groups
      SQL.Clear;
      SQL.Add('INSERT HIGH_PRIORITY INTO tblstocklastcostadjustments (TransType,Date,Qty,ProductID,ClassID,CostEx) ');
      SQL.Add('SELECT ');
      SQL.Add('"Groups" AS TransType, ');
      SQL.Add('BuildDate AS TranDate, ');
      SQL.Add('(BuildQty-UnBuildQty) AS Qty, ');
      SQL.Add('GroupPartID,ClassID, ');
      SQL.Add('0 as CostEx ');
      SQL.Add('FROM tblgroupbuild ');
      SQL.Add('INNER JOIN tblparts on tblparts.PARTSID=GroupPartID ');
      SQL.Add('WHERE (tblgroupbuild.Deleted<>"T") ');
      SQL.Add('AND BuildDate ' + DateSQL);
      Execute;}

     { //Group Builds
      SQL.Clear;
      SQL.Add('INSERT HIGH_PRIORITY INTO tblstocklastcostadjustments (TransType,Date,Qty,ProductID,ClassID,CostEx) ');
      SQL.Add('SELECT ');
      SQL.Add('"Group Builds" AS TransType, ');
      SQL.Add('BuildDate AS TranDate, ');
      SQL.Add('-(BuildQty-UnBuildQty) AS Qty, ');
      SQL.Add('tblgroupbuildlines.PartsID,ClassID, ');
      SQL.Add('0 as CostEx ');
      SQL.Add('FROM tblgroupbuildlines ');
      SQL.Add('INNER JOIN tblgroupbuild on BuildID=GroupBuildID ');
      SQL.Add('INNER JOIN tblparts on tblparts.PARTSID=tblgroupbuildlines.PartsID ');
      SQL.Add('WHERE (tblgroupbuild.Deleted<>"T") ');
      SQL.Add('AND BuildDate ' + DateSQL);
      Execute;}

    { //V Groups
      SQL.Clear;
      SQL.Add('INSERT HIGH_PRIORITY INTO tblstocklastcostadjustments (TransType,Date,Qty,ProductID,ClassID,CostEx) ');
      SQL.Add('SELECT ');
      SQL.Add('"V Groups" AS TransType, ');
      SQL.Add('BuildDate AS TranDate, ');
      SQL.Add('BuildQty AS Qty, ');
      SQL.Add('GroupPartID,ClassID, ');
      SQL.Add('0 as CostEx ');
      SQL.Add('FROM tblvargroupbuild ');
      SQL.Add('INNER JOIN tblparts on tblparts.PARTSID=GroupPartID ');
      SQL.Add('WHERE (tblvargroupbuild.BuildStatus="B") ');
      SQL.Add('AND BuildDate ' + DateSQL);

      Execute;}

      {//V Group Builds
      SQL.Clear;
      SQL.Add('INSERT HIGH_PRIORITY INTO tblstocklastcostadjustments (TransType,Date,Qty,ProductID,ClassID,CostEx) ');
      SQL.Add('SELECT ');
      SQL.Add('"V Group Builds" AS TransType, ');
      SQL.Add('BuildDate AS TranDate, ');
      SQL.Add('-BuildQty AS Qty, ');
      SQL.Add('tblvargroupbuildlines.PartsID,ClassID, ');
      SQL.Add('0 as CostEx ');
      SQL.Add('FROM tblvargroupbuildlines ');
      SQL.Add('INNER JOIN tblvargroupbuild on BuildID=GroupBuildID ');
      SQL.Add('INNER JOIN tblparts on tblparts.PARTSID=tblvargroupbuildlines.PartsID ');
      SQL.Add('WHERE (tblvargroupbuild.BuildStatus="B") ');
      SQL.Add('AND BuildDate ' + DateSQL);
      Execute;}

    end;
  finally
    FreeAndNil(cmd);
  end;*)
end;
function TStockCostSystemsObj.getInstock(fiProductID:Integer; AsOn :TDatetime):double;
begin
  REsult := 0;
  with TERPQuery(AppEnvVirt.Obj['CommonDbLib.TempMyQuery']) do try
    SQL.add(ProductQtylib.SQL4ProductAvailableQty(asOn , '', tSummary, fiProductID, 0, '',0,'','','',tInStock));
    Open;
    if recordcount > 0 then result := fieldByname('qty').asFloat;
  finally
    if Active then close;
    Free;
  end;
end;
procedure TStockCostSystemsObj.CalculateAdjValue;
var
  qryProductID, qry: TERPQuery;
  MyScript: TERPScript;
  (*MemProductClosingQty, *)MemProductID, Memqry: TkbmMemTable;
  InStock, TempQty, LastCost: double;
//  ProgressDialog: TProgressDialog;
  BulkSQL: TStrings;
begin
  qryProductID := TERPQuery.Create(nil);
  qry := TERPQuery.Create(nil);
//  ProgressDialog := TProgressDialog.Create(nil);
  MemProductID := TkbmMemTable.Create(nil);
  Memqry := TkbmMemTable.Create(nil);
  (*MemProductClosingQty := TkbmMemTable.Create(nil);*)
  MyScript := TERPScript.Create(nil);
  BulkSQL := TStringList.Create;
  (*MemTableStartDefaultSetting(MemProductClosingQty);*)
  MemTableStartDefaultSetting(MemProductID);
  MemTableStartDefaultSetting(Memqry);
  try
    ProgressDlg.Caption  := 'Please Wait .......';
    ProgressDlg.MinValue := 0;
    ProgressDlg.Step     := 1;
    qry.Connection          := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qryProductID.Connection := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    MyScript.Connection     := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

    (*GetProductsQtysAtDate(AppEnv.CompanyPrefs.SummarisedTransDate, MemProductClosingQty);*)
    (*MemTableReadyToUseDefaultSetting(MemProductClosingQty);*)

    with qryProductID do begin
      SQL.Clear;
      SQL.Add('SELECT DISTINCT ProductID From tblstocklastcostadjustments;');
      Open;
    end;
    MemProductID.LoadFromDataSet(qryProductID, [mtcpoStructure, mtcpoProperties]);
    MemTableReadyToUseDefaultSetting(MemProductID);
    if (MemProductID.RecordCount <> 0) then begin
      ProgressDlg.MaxValue := MemProductID.RecordCount + 1;
      ProgressDlg.Execute;
      ProgressDlg.StepIt;
      MemProductID.First;
      BulkSQL.Clear;
      while not MemProductID.Eof do begin
        with qry do begin
          SQL.Clear;
          SQL.Add('SELECT * From tblstocklastcostadjustments ');
          SQL.Add('WHERE ProductID=' + MemProductID.Fields[0].AsString + ' ');
          SQL.Add('Order By Date; ');
          Open;
        end;
        Memqry.LoadFromDataSet(qry, [mtcpoStructure, mtcpoProperties]);
        MemTableReadyToUseDefaultSetting(Memqry);
        qry.Close;
        with Memqry do begin
          if (Memqry.RecordCount <> 0) then begin
            (*InStock := 0;
            if MemProductClosingQty.Locate('ProductID', MemProductID.Fields[0].AsInteger, []) then InStock := MemProductClosingQty.FieldByName('Qty').AsFloat;*)
            InStock := getInstock( MemProductID.Fields[0].AsInteger , Date);
            InStock := InStock - Memqry.FieldByName('Qty').AsFloat;
            Memqry.First;
            LastCost := GetProductLastCost(Memqry.FieldByName('Date').AsDateTime - 1, Memqry.FieldByName('ProductID').AsInteger);
            while not Memqry.Eof do begin
              InStock := InStock + Memqry.FieldByName('Qty').AsFloat;
              if Sysutils.SameText(Memqry.FieldByName('TransType').AsString, 'PO') or Sysutils.SameText(Memqry.FieldByName('TransType').AsString, 'StockAdj') then begin
                Memqry.Edit;
                Memqry.FieldByName('QtyonHand').AsFloat := InStock;
                if Memqry.FieldByName('Qty').AsFloat > Memqry.FieldByName('QtyonHand').AsFloat then TempQty := InStock
                else TempQty := Memqry.FieldByName('Qty').AsFloat;
                Memqry.FieldByName('OldAssetValue').AsFloat := ((Memqry.FieldByName('QtyonHand').AsFloat - TempQty) * LastCost) + (TempQty * Memqry.FieldByName('CostEx').AsFloat);
                Memqry.FieldByName('NewAssetValue').AsFloat := (Memqry.FieldByName('QtyonHand').AsFloat) * Memqry.FieldByName('CostEx').AsFloat;
                Memqry.FieldByName('AdjValue').AsFloat := Memqry.FieldByName('NewAssetValue').AsFloat - Memqry.FieldByName('OldAssetValue').AsFloat;
                LastCost := Memqry.FieldByName('CostEx').AsFloat;
                if Rounding.RoundCurrency(Memqry.FieldByName('AdjValue').AsFloat) > 0 then BulkSQL.Add('UPDATE tblstocklastcostadjustments SET ' +
                    'OldAssetValue= ' + FloatToStr(Memqry.FieldByName('OldAssetValue').AsFloat) + ', ' +
                    'QtyonHand= ' + FloatToStr(Memqry.FieldByName('QtyonHand').AsFloat) + ', ' +
                    'NewAssetValue= ' + FloatToStr(Memqry.FieldByName('NewAssetValue').AsFloat) + ', ' +
                    'AdjValue= ' + FloatToStr(RoundCurrency(Memqry.FieldByName('AdjValue').AsFloat)) + ' ' +
                    'WHERE AdjID= ' + IntToStr(Memqry.FieldByName('AdjID').AsInteger) + ';');
              end;
              Memqry.Next;
            end;
          end;
        end;
        //Application.ProcessMessages;
        ProgressDlg.StepIt;
        MemProductID.Next;
      end;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM `tblstocklastcostadjustments`  WHERE `TransType` <> "PO";');
      qry.Execute;
      MyScript.SQL := BulkSQL;
      BulkSQL.Clear;
      MemProductID.EmptyTable;
      Memqry.EmptyTable;
      //Application.ProcessMessages;
      MyScript.Execute;
      //Application.ProcessMessages;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM tblstocklastcostadjustments  WHERE AdjValue = 0;');
      qry.Execute;
    end;
  finally
    FreeAndNil(qryProductID);
    FreeAndNil(qry);
    FreeAndNil(MemProductID);
    FreeAndNil(Memqry);
    ProgressDlg.CloseDialog;
//    FreeAndNil(ProgressDialog);
    FreeAndNil(MyScript);
    FreeAndNil(BulkSQL);
  end;
end;

function TStockCostSystemsObj.GetProductLastCost(const Date: TDateTime; const ProductID: integer): double;
begin
  with TERPQuery.Create(nil) do try
      Connection := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
      SQL.Clear;
      Sql.Add('SELECT IF(IsNull(InvoiceDate),ReceivedDate,InvoiceDate) as OrderedDates,');
      Sql.Add('"PO" as Type, ');
      Sql.Add('tblPurchaseOrders.PurchaseOrderID,LineCost as Cost,Shipped,LandedCostsPerItem ');
      Sql.Add('FROM tblPurchaseOrders ');
      Sql.Add('INNER JOIN tblPurchaseLines ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
      Sql.Add('WHERE tblPurchaseLines.Invoiced="T" ');
      Sql.Add('And tblPurchaseOrders.IsPO="T" And tblPurchaseOrders.Deleted="F" ');
      Sql.Add('And ProductID = ' + IntToStr(ProductID) + ' AND Shipped <> 0 ');
      Sql.Add('HAVING OrderedDates<=' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');

      Sql.Add('Union All');

      (*Sql.Add('SELECT ');
      Sql.Add('CreationDate as OrderedDates, ');
      Sql.Add('"ST" as Type, ');
      Sql.Add('tblstockadjustment.StockAdjustmentNo as StockAdjustmentNo, ');
      Sql.Add('Cost, ');
      Sql.Add('Qty, ');
      Sql.Add('0.00 as NA ');
      Sql.Add('FROM tblstockadjust ');
      Sql.Add('INNER JOIN tblstockadjustment ON tblstockadjustment.StockAdjustmentNo = tblstockadjust.StockAdjustmentNo ');
      Sql.Add('WHERE tblstockadjust.Deleted<>"T" AND  ProductID = ' + IntToStr(ProductID) + ' AND Qty <> 0 ');
      Sql.Add('HAVING OrderedDates<=' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');
      Sql.Add('Order by OrderedDates desc,PurchaseOrderID desc,Type ');
      SQL.Add('LIMIT 1');
      *)
      Sql.Add('SELECT');
      Sql.Add('SM.Movementdate as OrderedDates,');
      Sql.Add('"ST" as Type,');
      Sql.Add('SM.StockMovementId,');
      Sql.Add('Cost,');
      Sql.Add('Qty,');
      Sql.Add('0.00 as NA');
      Sql.Add('FROM tblStockmovement as SM');
      Sql.Add('INNER JOIN tblStockmovementLines  as SML ON SM.StockMovementId = SML.StockMovementID and SM.StockmovementEntryType = "StockAdjustEntry"');
      Sql.Add('WHERE SM.Deleted<>"T" AND  ProductID = ' + IntToStr(ProductID) + ' AND Qty <> 0 ');
      Sql.Add('HAVING SM.Movementdate<=' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');
      Sql.Add('Order by OrderedDates desc,PurchaseOrderID desc,Type ');
      SQL.Add('LIMIT 1');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Cost').AsFloat;
      end else begin
        Result := 0.00;
      end;
    finally
      Free;
    end;
end;


function TStockCostSystemsObj.GetProgressDlg: TProgressInfo;
begin
  result := TProgressInfo(AppEnvVirt.Obj['ProgressInfo']);
end;

procedure TStockCostSystemsObj.RefreshLastCostAdjTable(const DateSQL: string);
begin
  CleanTempTable;
  PopulateData(DateSQL);
  CalculateAdjValue;
  //Application.ProcessMessages;
end;

procedure TStockCostSystemsObj.MemTableReadyToUseDefaultSetting(const MemTable: TkbmMemTable);
begin
  MemTable.Open;  
  MemTable.AutoAddIndexes := true;
  MemTable.AutoReposition := true;
  MemTable.EnableIndexes := true;
  MemTable.UpdateIndexes;
  MemTable.EnableControls;
  MemTable.SortOn(MemTable.SortFields, []);
end;

procedure TStockCostSystemsObj.MemTableStartDefaultSetting(const MemTable: TkbmMemTable);
begin
  MemTable.Close;
  MemTable.Standalone := true;
  MemTable.DesignActivation := true;
  MemTable.AttachedAutoRefresh := true;
  MemTable.EmptyTable;
  MemTable.Performance := mtpfFast;
  MemTable.DisableControls;
  MemTable.EnableIndexes := false;
end;

(*procedure TStockCostSystemsObj.GetProductsQtysAtDate(const Date: TDateTime; const MemTable: TkbmMemTable);
var
  qryTemp: TERPQuery;
  TmpTableName: string;
begin
  TmpTableName := GetUserTemporaryTableName('ProductsQtysAtDate');
  qryTemp := TERPQuery.Create(nil);
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    DestroyUserTemporaryTable(TmpTableName);
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('CREATE TABLE `' + TmpTableName + '` (`ID` int(11) NOT NULL auto_increment, `ProductID` int(11) default NULL,' +
      '`Qty` double NOT NULL default "0", PRIMARY KEY  (`ID`),KEY `ProductIndex` (`ProductID`)) ENGINE=InnoDB;');
    qryTemp.Execute;

    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('INSERT HIGH_PRIORITY INTO ' + TmpTableName + ' (ProductID,Qty) ');
    // Groups
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT tblgroupbuild.GroupPartID,Sum(BuildQty-UnBuildQty+0.00) as QTY FROM tblgroupbuild  ');
    qryTemp.SQL.Add('INNER JOIN tblparts on tblparts.PARTSID=GroupPartID ');
    qryTemp.SQL.Add('WHERE (tblgroupbuild.Deleted<>"T") ');
    qryTemp.SQL.Add('AND PARTTYPE="GRP" ');
    qryTemp.SQL.Add('AND tblgroupbuild.BuildDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');
    qryTemp.SQL.Add('GROUP BY tblgroupbuild.GroupPartID');

    qryTemp.Execute;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('INSERT HIGH_PRIORITY INTO ' + TmpTableName + ' (ProductID,Qty) ');

    // Group Builds
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT tblgroupbuildlines.PartsID,-Sum((BuildQty-UnBuildQty+0.00)*Qty) as QTY FROM tblgroupbuildlines ');
    qryTemp.SQL.Add('INNER JOIN tblgroupbuild on BuildID=GroupBuildID INNER JOIN tblparts on tblparts.PARTSID=tblgroupbuildlines.PartsID ');
    qryTemp.SQL.Add('WHERE (tblgroupbuild.Deleted<>"T") ');
    qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    qryTemp.SQL.Add('AND tblgroupbuild.BuildDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');
    qryTemp.SQL.Add('GROUP BY tblgroupbuildlines.PartsID');

    qryTemp.Execute;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('INSERT HIGH_PRIORITY INTO ' + TmpTableName + ' (ProductID,Qty) ');

    // V Groups
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT tblvargroupbuild.GroupPartID,Sum(BuildQty+0.00) as QTY FROM tblvargroupbuild  ');
    qryTemp.SQL.Add('INNER JOIN tblparts on tblparts.PARTSID=GroupPartID ');
    qryTemp.SQL.Add('WHERE (tblvargroupbuild.BuildStatus="B") ');
    qryTemp.SQL.Add('AND PARTTYPE="GRP" ');
    qryTemp.SQL.Add('AND tblvargroupbuild.BuildDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');
    qryTemp.SQL.Add('GROUP BY tblvargroupbuild.GroupPartID ');

    qryTemp.Execute;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('INSERT HIGH_PRIORITY INTO ' + TmpTableName + ' (ProductID,Qty) ');

    // V Group Builds
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT tblvargroupbuildlines.PartsID,-Sum((BuildQty+0.00)*Qty) as QTY FROM tblvargroupbuildlines ');
    qryTemp.SQL.Add('INNER JOIN tblvargroupbuild on BuildID=GroupBuildID INNER JOIN tblparts on tblparts.PARTSID=tblvargroupbuildlines.PartsID ');
    qryTemp.SQL.Add('WHERE (tblvargroupbuild.BuildStatus="B") ');
    qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    qryTemp.SQL.Add('AND tblvargroupbuild.BuildDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');
    qryTemp.SQL.Add('GROUP BY tblvargroupbuildlines.PartsID');

    qryTemp.Execute;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('INSERT HIGH_PRIORITY INTO ' + TmpTableName + ' (ProductID,Qty) ');

    //Shipped Sales
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT ProductID,-Sum(Shipped) as QTY FROM tblsaleslines INNER JOIN tblsales Using(SaleID) WHERE ((IsInvoice="T" OR IsRefund="T" OR IsCashSale="T") ');
    qryTemp.SQL.Add('AND ( tblsales.IsQuote<>"T" AND IsSalesOrder<>"T" AND IsVoucher<>"T" AND IsLayby<>"T" AND IsLaybyTOS<>"T" AND IsLaybyPayment<>"T")) ');
    qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    qryTemp.SQL.Add('AND tblsales.SaleDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');
    qryTemp.SQL.Add('GROUP BY ProductID');

    qryTemp.Execute;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('INSERT HIGH_PRIORITY INTO ' + TmpTableName + ' (ProductID,Qty) ');

    //Received PO
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT ProductID,Sum(Shipped) as QTY FROM tblpurchaselines INNER JOIN tblpurchaseorders Using(PurchaseOrderID) WHERE (IsPO="T")  ');
    qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    qryTemp.SQL.Add('AND tblpurchaselines.ReceivedDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');
    qryTemp.SQL.Add('GROUP BY ProductID');

    qryTemp.Execute;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('INSERT HIGH_PRIORITY INTO ' + TmpTableName + ' (ProductID,Qty) ');

    //Stock Adjustments
    {qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT ProductID,Sum(Qty) as QTY FROM tblstockadjustment INNER JOIN tblstockadjust Using(StockAdjustmentNo) ');
    qryTemp.SQL.Add('WHERE tblstockadjust.Deleted="F"');
    qryTemp.SQL.Add('AND (char_length(BinLocation)=0 OR IsNull(BinLocation)) AND (char_length(BinNumber)=0 OR IsNull(BinNumber))  AND (char_length(BatchNo)=0 OR IsNull(BatchNo)) ');
    qryTemp.SQL.Add('AND tblstockadjust.CreationDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');
    qryTemp.SQL.Add('GROUP BY  ProductID');}

    qryTemp.SQL.Add('SELECT ProductID,Sum(Qty) as QTY  ');
    qryTemp.Sql.Add('FROM tblStockmovement as SM');
    qryTemp.Sql.Add('INNER JOIN tblStockmovementLines  as SML ON SM.StockMovementId = SML.StockMovementID and SM.StockmovementEntryType = "StockAdjustEntry"');
    qryTemp.SQL.Add('WHERE SM.Deleted="F"');
    qryTemp.SQL.Add('AND SM.MovementDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Date)) + ' ');
    qryTemp.SQL.Add('GROUP BY  ProductID');
    qryTemp.Execute;
    
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT ProductID,Sum(Qty) as Qty FROM `' + TmpTableName + '` Group By ProductID;');
    qryTemp.Open;
    MemTable.LoadFromDataSet(qryTemp, [mtcpoStructure, mtcpoProperties]);
    qryTemp.Close;
  finally
    DestroyUserTemporaryTable(TmpTableName);
    FreeAndNil(qryTemp);
  end;
end; *)

end.

