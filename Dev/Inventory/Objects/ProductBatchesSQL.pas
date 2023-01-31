unit ProductBatchesSQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TProductBatches = Class(TReportWithDateRangeBase)
  private
    fsTablename: String;
    fiFilterIndex: Integer;
    fiProductID: Integer;
    fiClassID: Integer;
    procedure Populatedata;

  protected
  public
    constructor Create; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  published
    property FilterIndex: Integer   read fiFilterIndex    write fiFilterIndex;
    property ProductID: Integer     read fiProductID      write fiProductID;
    property ClassID: Integer       read ficlassID        write ficlassID;

  End;

implementation

uses CommonLib, SysUtils, DateUtils, ERPDbComponents, JSONObject, CommonDbLib, MySQLConst,
      ProfitAndLossSQL, LogLib, PQALib, ProductQtyLib, tcConst, busobjStockMovement;
{ TPartClass }

constructor TProductBatches.Create;
begin
  inherited;
  fsTablename := commondbLib.GetUserTemporaryTableName('Batches' );

  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
end;

procedure TProductBatches.Populatedata;
var
  TempScript: TERPScript;

  function Qtyfield:String;
  begin
    Result := '';
               if fiFilterIndex = 0 then begin {Available}      Result := Result + 'Round(' + SQL4Qty(tAvailable , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                Result := Result + 'Round(' + SQL4Qty(tAvailable , 'PQA', DetailQtyfield(tDetails,true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty,';
      end else if fiFilterIndex = 1 then begin  {Stock In}      Result := Result + 'Round(' + SQL4Qty(tins       , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                Result := Result + 'Round(' + SQL4Qty(tins       , 'PQA', DetailQtyfield(tDetails,true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty,';
      end else if fiFilterIndex = 2 then begin  {Stock Out}     Result := Result + 'Round(' + SQL4Qty(touts      , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                Result := Result + 'Round(' + SQL4Qty(touts      , 'PQA', DetailQtyfield(tDetails,true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty';
      end else if fiFilterIndex = 3 then begin  {On SO}         Result := Result + 'Round(' + SQL4Qty(tSO        , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                Result := Result + 'Round(' + SQL4Qty(tSO        , 'PQA', DetailQtyfield(tDetails,true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty,';
      end else if fiFilterIndex = 4 then begin  {On Build Raw}  Result := Result + 'Round(' + SQL4Qty(tOnBuild   , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                Result := Result + 'Round(' + SQL4Qty(tOnBuild   , 'PQA', DetailQtyfield(tDetails,true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty,';
      end else if fiFilterIndex = 5 then begin  {Building}      Result := Result + 'Round(' + SQL4Qty(tBuilding  , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                Result := Result + 'Round(' + SQL4Qty(tBuilding  , 'PQA', DetailQtyfield(tDetails,true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty,';
      end else begin                                            Result := Result + '0.00 AS Qty, ';
                                                                Result := Result + '0.00 AS UOMQty, ';
      end;
  end;

begin
  TempScript := TERPScript.Create(nil);
  try

  With TempScript do begin
    Connection := CommonDbLib.GetSharedMyDacConnection;
    SQL.clear;
    SQL.Add('DROP TABLE IF EXISTS ' + fsTablename + ' ;');
    SQL.Add('CREATE TABLE ' + fsTablename + '  ( ' +
	          ' ID                INT(11) NOT  NULL AUTO_INCREMENT, '+
            ' PartsClassUOMID   VARCHAR(255) NULL DEFAULT NULL, '+
	          ' GLevel            INT(11)      NULL DEFAULT 0, '+
	          ' PartsID           INT(11)      NULL DEFAULT 0, '+
	          ' transid           INT(11)      NULL DEFAULT 0, '+
	          ' ClassId           INT(11)      NULL DEFAULT 0, '+
	          ' UOMID             INT(11)      NULL DEFAULT 0, '+
	          ' Transtype         VARCHAR(100) NULL DEFAULT NULL, '+
	          ' PARTNAME          VARCHAR(255) NULL DEFAULT NULL, '+
	          ' ProductPrintName  VARCHAR(255) NULL DEFAULT NULL, '+
	          ' classname         VARCHAR(255) NULL DEFAULT "", '+
	          ' UOM               VARCHAR(255) NULL DEFAULT NULL, '+
	          ' Batchno           VARCHAR(255) NULL DEFAULT NULL, '+
	          ' TruckLoadNo       VARCHAR(10)  NULL DEFAULT NULL, '+
	          ' ExpiryDate        DATETIME     NULL DEFAULT NULL, '+
	          ' SMEglobalref      VARCHAR(255) NULL DEFAULT NULL, '+
	          ' SMEType           VARCHAR(255) NULL DEFAULT NULL, '+
	          ' TransTypeDesc     VARCHAR(100) NULL DEFAULT NULL, '+
	          ' FormName          VARCHAR(100) NULL DEFAULT NULL, '+
	          ' Alloctype         VARCHAR(10)  NULL DEFAULT NULL, '+
	          ' Qty               DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMQty            DOUBLE       NULL DEFAULT NULL, '+
	          ' InStockQty        DOUBLE       NULL DEFAULT NULL, '+
	          ' AvailableQty      DOUBLE       NULL DEFAULT NULL, '+
	          ' AllocatedSOQty    DOUBLE       NULL DEFAULT NULL, '+
	          ' AllocatedBOQty    DOUBLE       NULL DEFAULT NULL, '+
	          ' OnOrderQty        DOUBLE       NULL DEFAULT NULL, '+
	          ' SOBOQty           DOUBLE       NULL DEFAULT NULL, '+
	          ' OnBuildQty        DOUBLE       NULL DEFAULT NULL, '+
	          ' BuildingQty       DOUBLE       NULL DEFAULT NULL, '+
	          ' insQty            DOUBLE       NULL DEFAULT NULL, '+
	          ' OutsQty           DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMInStockQty     DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMAvailableQty   DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMAllocatedSOQty DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMAllocatedBOQty DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMOnOrderQty     DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMSOBOQty        DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMOnBuildQty     DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMBuildingQty    DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMinsQty         DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMOutsQty        DOUBLE       NULL DEFAULT NULL, '+
	          ' Quantity          DOUBLE       NULL DEFAULT NULL, '+
	          ' QtyDescription    VARCHAR(255) NULL DEFAULT NULL, '+
            ' CUSTFLD6          DOUBLE       NULL DEFAULT NULL, '+
	          ' PRIMARY KEY (ID), '+
	          ' INDEX GLevel (GLevel), '+
	          ' INDEX Transtype_transid (Transtype, transid)  '+
	          ' ) COLLATE="utf8_general_ci" ENGINE=MyISAM ; ');

    SQL.Add('INSERT IGNORE INTO  ' + fsTablename +
            ' (GLevel, QtyDescription, PartsID,PARTNAME, ProductPrintName, ClassId,classname, uomid, UOM, Batchno,TruckLoadNo, ExpiryDate, CUSTFLD6, Quantity,'+
            ' TransTypeDesc, TransType, transid, FormName, Alloctype,'+
            ' Qty, UOMQty, InStockQty, AvailableQty, AllocatedSOQty, AllocatedBOQty, OnOrderQty, SOBOQty, OnBuildQty, BuildingQty, insQty, OutsQty,'+
            ' UOMInStockQty, UOMAvailableQty, UOMAllocatedSOQty, UOMAllocatedBOQty, UOMOnOrderQty,UOMSOBOQty, UOMOnBuildQty, UOMBuildingQty, UOMinsQty, UOMOutsQty) '+
            ' SELECT ' +
            '2                     AS GLevel, ' +
            'TT.Description        AS QtyDescription, ' +
            'P.PartsID             AS PartsID, ' +
            'P.PARTNAME            AS PARTNAME, ' +
            'P.ProductPrintName    AS ProductPrintName, ' +
            'PC.ClassId            AS ClassId, ' +
            'PC.classname          AS classname, ' +
            'PQA.uomid             as uomid , ' +
            'PQA.UOM               AS UOM, ' +
            'PQABatch.Value        AS Batchno, ' +
            'PQABatch.TruckLoadNo  AS TruckLoadNo, ' +
            'PQABatch.ExpiryDate   AS ExpiryDate, ' +
            'PQABatch.CUSTFLD6     as CUSTFLD6,' +
            'IF(PQA.Alloctype="OUT", 0-PQABatch.UOMQty, PQABatch.UOMQty) AS Quantity,' +
            'TT.Description        AS TransTypeDesc, ' +
            'PQA.transtype         AS transtype, ' +
            'PQA.transId           AS transid, ' +
            'TT.formName           AS FormName, ' +
            'PQA.Alloctype         AS Alloctype, ' +
            Qtyfield +
            'Round(' + SQL4Qty(tInstock   , 'PQA', DetailQtyfield(tDetails)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "InStockQty",' +
            'Round(' + SQL4Qty(tAvailable , 'PQA', DetailQtyfield(tDetails)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "AvailableQty",' +
            'Round(' + SQL4Qty(tSO        , 'PQA', DetailQtyfield(tDetails)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "AllocatedSOQty",' +
            'Round(' + SQL4Qty(tInvBO     , 'PQA', DetailQtyfield(tDetails)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "AllocatedBOQty",' +
            'Round(' + SQL4Qty(tPOBO      , 'PQA', DetailQtyfield(tDetails)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "OnOrderQty",' +
            'Round(' + SQL4Qty(tSOBO      , 'PQA', DetailQtyfield(tDetails)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "SOBOQty",' +
            'Round(' + SQL4Qty(tOnBuild   , 'PQA', DetailQtyfield(tDetails)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "OnBuildQty",' +
            'Round(' + SQL4Qty(tBuilding  , 'PQA', DetailQtyfield(tDetails)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "BuildingQty",' +
            'Round(' + SQL4Qty(tins       , 'PQA', DetailQtyfield(tDetails)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "insQty",' +
            'Round(' + SQL4Qty(touts      , 'PQA', DetailQtyfield(tDetails)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "OutsQty",' +
            'Round(' + SQL4Qty(tInstock   , 'PQA', DetailQtyfield(tDetails, true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "UOMInStockQty",' +
            'Round(' + SQL4Qty(tAvailable , 'PQA', DetailQtyfield(tDetails, true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "UOMAvailableQty",' +
            'Round(' + SQL4Qty(tSO        , 'PQA', DetailQtyfield(tDetails, true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "UOMAllocatedSOQty",' +
            'Round(' + SQL4Qty(tInvBO     , 'PQA', DetailQtyfield(tDetails, true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "UOMAllocatedBOQty",' +
            'Round(' + SQL4Qty(tPOBO      , 'PQA', DetailQtyfield(tDetails, true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "UOMOnOrderQty",' +
            'Round(' + SQL4Qty(tSOBO      , 'PQA', DetailQtyfield(tDetails, true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "UOMSOBOQty",' +
            'Round(' + SQL4Qty(tOnBuild   , 'PQA', DetailQtyfield(tDetails, true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "UOMOnBuildQty",' +
            'Round(' + SQL4Qty(tBuilding  , 'PQA', DetailQtyfield(tDetails, true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "UOMBuildingQty",' +
            'Round(' + SQL4Qty(tins       , 'PQA', DetailQtyfield(tDetails, true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "UOMinsQty",' +
            'Round(' + SQL4Qty(touts      , 'PQA', DetailQtyfield(tDetails, true)) + ',' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "UOMOutsQty" ' +
            'FROM ' + ProductTables(tDetails, true, True) + ' ' +
            'WHERE P.Active <> "F" AND PC.ACtive <> "F" AND P.Batch <> "F" ' +
            IIF(fiProductID <> 0, ' AND PQA.ProductId = ' + IntToStr(ProductID), IIF(fiProductID <> 0, ' AND PQA.ProductId =' + IntToStr(fiProductID), ' ' )) +
            IIF(fiClasSID <> 0, ' AND PQA.DepartmentID = ' + IntToStr(fiClasSID), ' ') +
            'AND PQA.TransDate BETWEEN ' + Quotedstr(FormatDateTime(MysqlDateFormat, DateFrom)) + ' AND ' + Quotedstr(FormatDateTime(MysqlDateFormat, DateTo)) + ' ' +
            'GROUP BY PQA.DepartmentID, ' +
                            'P.PartsID, ' +
                            'PQA.UOMID, ' +
                            'PQA.transid, ' +
                            'IFNULL(PQABatch.Value, ""), ' +
                            'IFNULL(TruckLoadNo, ""), ' +
                            'IFNULL(PQABatch.ExpiryDate, 0), ' +
                            'PQA.TransType ' +
            'ORDER BY Classname, PARTNAME, ProductPrintName, UOM, Batchno, TruckLoadNo, ExpiryDate, GLevel, transtype, transid;');

    SQL.Add('UPDATE ' + fstablename + ' T INNER JOIN tblStockMovement SM ON SM.StockmovementId = T.TransId AND T.TransType = ' + QuotedStr(TStockMovementLines.Classname) +
                        ' SET T.SMEglobalref = SM.StockmovementEntryglobalref , T.SMEType = SM.StockmovementEntryType;');

    SQL.Add('INSERT IGNORE INTO ' + fsTablename +
                 ' (GLevel, QtyDescription, PartsID, PARTNAME, ProductPrintName, ClassId, ClassName, uomid, UOM, Batchno, TruckLoadNo, ExpiryDate, CUSTFLD6, Quantity,' +
                 ' Qty, UOMQty, InStockQty, AvailableQty, AllocatedSOQty, AllocatedBOQty, OnOrderQty, SOBOQty, OnBuildQty, BuildingQty, insQty, OutsQty,' +
                 ' UOMInStockQty, UOMAvailableQty, UOMAllocatedSOQty, UOMAllocatedBOQty, UOMOnOrderQty, UOMSOBOQty, UOMOnBuildQty, UOMBuildingQty, UOMinsQty, UOMOutsQty) ' +
            'SELECT 1 AS GLevel, "In-stock" AS QtyDescription, PartsID, PARTNAME, ProductPrintName, ClassId, Classname,uomid, UOM, Batchno, TruckLoadNo, ExpiryDate, ' +
                 ' SUM(CUSTFLD6) AS CUSTFLD6,SUM(Quantity) AS Quantity,' +
                 ' SUM(Qty), ' +
                 ' SUM(UOMQty), ' +
                 ' SUM(InStockQty), ' +
                 ' SUM(AvailableQty), ' +
                 ' SUM(AllocatedSOQty), ' +
                 ' SUM(AllocatedBOQty), ' +
                 ' SUM(OnOrderQty), ' +
                 ' SUM(SOBOQty), ' +
                 ' SUM(OnBuildQty), ' +
                 ' SUM(BuildingQty), ' +
                 ' SUM(insQty), ' +
                 ' SUM(OutsQty), ' +
                 ' SUM(UOMInStockQty), ' +
                 ' SUM(UOMAvailableQty), ' +
                 ' SUM(UOMAllocatedSOQty), ' +
                 ' SUM(UOMAllocatedBOQty), ' +
                 ' SUM(UOMOnOrderQty), ' +
                 ' SUM(UOMSOBOQty), ' +
                 ' SUM(UOMOnBuildQty), ' +
                 ' SUM(UOMBuildingQty), ' +
                 ' SUM(UOMinsQty), SUM(UOMOutsQty) ' +
                 ' FROM '+ fstablename +
                 ' WHERE Glevel = 2' +
                 ' GROUP BY Classid, PartsID, UOMID, Batchno, TruckLoadNo, ExpiryDate;');

    SQL.Add('INSERT IGNORE INTO ' + fsTablename +
                 ' (GLevel, QtyDescription, PartsID,PARTNAME, ProductPrintName, ClassId, classname, uomid, UOM,CUSTFLD6, Quantity,' +
                 ' Qty, UOMQty, InStockQty, AvailableQty, AllocatedSOQty, AllocatedBOQty, OnOrderQty, SOBOQty, OnBuildQty, BuildingQty, insQty, OutsQty, ' +
                 ' UOMInStockQty, UOMAvailableQty, UOMAllocatedSOQty, UOMAllocatedBOQty, UOMOnOrderQty, UOMSOBOQty, UOMOnBuildQty, UOMBuildingQty, UOMinsQty,UOMOutsQty) ' +
            'SELECT 0 AS GLevel, "In-stock" AS QtyDescription, PartsID, PARTNAME, ProductPrintName, ClassId, Classname,uomid, UOM, ' +
                 ' SUM(CUSTFLD6) AS CUSTFLD6, SUM(Quantity) AS Quantity, ' +
                 ' SUM(Qty), ' +
                 ' SUM(UOMQty), ' +
                 ' SUM(InStockQty), ' +
                 ' SUM(AvailableQty), ' +
                 ' SUM(AllocatedSOQty), ' +
                 ' SUM(AllocatedBOQty), ' +
                 ' SUM(OnOrderQty), ' +
                 ' SUM(SOBOQty), ' +
                 ' SUM(OnBuildQty), ' +
                 ' SUM(BuildingQty), ' +
                 ' SUM(insQty), ' +
                 ' SUM(OutsQty), ' +
                 ' SUM(UOMInStockQty), ' +
                 ' SUM(UOMAvailableQty), ' +
                 ' SUM(UOMAllocatedSOQty), ' +
                 ' SUM(UOMAllocatedBOQty), ' +
                 ' SUM(UOMOnOrderQty), ' +
                 ' SUM(UOMSOBOQty), ' +
                 ' SUM(UOMOnBuildQty),' +
                 ' SUM(UOMBuildingQty), ' +
                 ' SUM(UOMinsQty),SUM(UOMOutsQty) ' +
                 ' FROM ' + fstablename +
                 ' WHERE Glevel = 2' +
                 ' GROUP BY Classid, PartsID, UOMID;');
    SQL.Add('UPDATE ' + fstablename + ' T SET T.PartsClassUOMID = CONCAT(PartsID, "-", ClassId, "-", UOMID);');

    LogText(SQL.Text);
    Execute;
  end;

  finally
    TempScript.Free;
  end;
end;

function TProductBatches.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  Result := inherited;

  Populatedata;

  SQL.Clear;
  SQL.Add('SELECT ');
  SQL.Add('*');
  SQL.Add('FROM '+ fstablename +  ' T ');

  if Search <> '' then SQL.Add(' WHERE ' + Search);

  if OrderBy <> '' then SQL.Add('ORDER BY ' + OrderBy)
  else SQL.Add('ORDER BY Classname, PARTNAME, ProductPrintName, UOM, Batchno, TruckLoadNo, ExpiryDate, GLevel, transtype, transid;');


end;
initialization
  RegisterClass(TProductBatches);

end.
