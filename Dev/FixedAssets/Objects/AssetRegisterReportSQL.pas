unit AssetRegisterReportSQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TAssetRegisterReport = Class(TReportWithDateRangeBase)
  private
     fiFilterIndex: Integer;
     fiItemIndex: Integer;

  protected
  public
    constructor Create; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  published
    property FilterIndex: Integer read fiFilterIndex write fiFilterIndex;
    property ItemIndex: Integer read fiItemIndex write fiItemIndex;

  End;

implementation

uses CommonLib, SysUtils, DateUtils, ERPDbComponents, JSONObject, CommonDbLib, MySQLConst,
      ProfitAndLossSQL, LogLib, PQALib, ProductQtyLib, tcConst, busobjStockMovement, LogUtils;
{ TPartClass }

constructor TAssetRegisterReport.Create;
begin
  inherited;
  fiItemIndex := 0;
  fiFilterIndex := 0;
  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
end;

function TAssetRegisterReport.PopulateReportSQL(SQL: TStrings; var msg: string): Boolean;
var
  fsDateFrom: String;
  fsDateTo: String;
begin
  Result := inherited;

  fsDateFrom := FormatDateTime(MysqlDateFormat, DateFrom);
  fsDateTo := FormatDateTime(MysqlDateFormat, DateTo);

  SQL.Clear;
  SQL.Add('SELECT ');
  SQL.Add('CASE FA.DepreciationOption ' +
                  '  WHEN 1 THEN "No Depreciation" ' +
                  '  WHEN 2 THEN "Straight Line" ' +
                  '  WHEN 3 THEN "Declining Balance" ' +
                  '  ELSE "No Depreciation" ' +
                  'END AS "DepOption",');
  SQL.Add('CASE FA.DepreciationOption2 ' +
                  '  WHEN 1 THEN "No Depreciation" ' +
                  '  WHEN 2 THEN "Straight Line" ' +
                  '  WHEN 3 THEN "Declining Balance" ' +
                  '  ELSE "No Depreciation" ' +
                  'END AS "DepOption2",');
  SQL.Add('CONCAT(FADD1.Month, "-", FADD1.Year ) AS DeprecAsOn,');
  SQL.Add('FA.AssetID AS  AssetID,');
  SQL.Add('FA.AssetCode AS AssetCode,');
  SQL.Add('FA.AssetName AS AssetName,');
  SQL.Add('FA.Description AS Description,');
  SQL.Add('FA.PurchDate AS PurchDate,');
  SQL.Add('FA.DepreciationStartDate AS DepreciationStartDate,');
  SQL.Add('FA.PurchCost AS PurchCost,');
  SQL.Add('FA.AssetType AS AssetType,');
  SQL.Add('FA.LocationDescription AS LocationDescription,');
  SQL.Add('FA.BrandName AS BrandName,');
  SQL.Add('FA.Manufacture AS Manufacture,');
  SQL.Add('FA.Model AS Model,');
  SQL.Add('FA.Serial AS Serial,');
  SQL.Add('FA.Notes AS Notes,');
  SQL.Add('FA.Qty AS Qty,');
  SQL.Add('FA.AssetCondition AS AssetCondition,');
  SQL.Add('FA.Colour AS Colour,');
  SQL.Add('FA.Size AS Size,');
  SQL.Add('FA.Shape AS Shape,');
  SQL.Add('FA.Status AS Status,');
  SQL.Add('FA.EstimatedValue AS EstimatedValue,');
  SQL.Add('FA.ReplacementCost AS ReplacementCost,');
  SQL.Add('FA.WarrantyType AS WarrantyType,');
  SQL.Add('FA.WarrantyExpiresDate AS WarrantyExpiresDate,');
  SQL.Add('FA.InsuredBy AS InsuredBy,');
  SQL.Add('FA.InsurancePolicy AS InsurancePolicy,');
  SQL.Add('FA.InsuredUntil AS InsuredUntil,');
  SQL.Add('FA.BusinessUsePercent AS BusinessUsePercent,');
  SQL.Add('FA.CUSTFLD1 AS CUSTFLD1,');
  SQL.Add('FA.CUSTFLD2 AS CUSTFLD2,');
  SQL.Add('FA.CUSTFLD3 AS CUSTFLD3,');
  SQL.Add('FA.CUSTFLD4 AS CUSTFLD4,');
  SQL.Add('FA.CUSTFLD5 AS CUSTFLD5,');
  SQL.Add('FA.CUSTFLD6 AS CUSTFLD6,');
  SQL.Add('FA.CUSTFLD7 AS CUSTFLD7,');
  SQL.Add('FA.CUSTFLD8 AS CUSTFLD8,');
  SQL.Add('FA.CUSTFLD9 AS CUSTFLD9,');
  SQL.Add('FA.CUSTFLD10 AS CUSTFLD10,');
  SQL.Add('FA.CUSTFLD11 AS CUSTFLD11,');
  SQL.Add('FA.CUSTFLD12 AS CUSTFLD12,');
  SQL.Add('FA.CUSTFLD13 AS CUSTFLD13,');
  SQL.Add('FA.CUSTFLD14 AS CUSTFLD14,');
  SQL.Add('FA.CUSTFLD15 AS CUSTFLD15,');
  SQL.Add('FA.DepreciationOption AS DepreciationOption,');
  SQL.Add('FA.Life AS Life,');
  SQL.Add('FA.SalvageType AS SalvageType,');
  SQL.Add('FA.Salvage AS Salvage,');
  SQL.Add('FA.SalvageFactor AS SalvageFactor,');
  SQL.Add('FA.PriorAccumDeprec AS PriorAccumDeprec,');
  SQL.Add('FA.PriorAccumDeprecDate AS PriorAccumDeprecDate,');
  SQL.Add('FA.PriorAccumDeprecAmount AS PriorAccumDeprecAmount,');
  SQL.Add('FA.Disposal AS Disposal,');
  SQL.Add('FA.DisposalDate AS DisposalDate,');
  SQL.Add('FA.DisposalBookValue AS DisposalBookValue,');
  SQL.Add('FA.DisposalAccumDeprec AS DisposalAccumDeprec,');
  SQL.Add('FA.SalesPrice AS SalesPrice,');
  SQL.Add('FA.FixedAssetCostAccountName AS FixedAssetCostAccountName,');
  SQL.Add('FA.ClearingAccountName AS ClearingAccountName,');
  SQL.Add('FA.Active AS Active,');
  SQL.Add('FA.PARTNAME AS PARTNAME,');
  SQL.Add('FA.ProductPrintName AS ProductPrintName,');
  SQL.Add('FA.FixedAssetDepreciationAccountName AS FixedAssetDepreciationAccountName,');
  SQL.Add('FA.SupplierName AS SupplierName,');
  SQL.Add('FA.BARCODE AS BARCODE,');
  SQL.Add('FA.DepreciationOption2 AS DepreciationOption2,');
  SQL.Add('FA.Life2 AS Life2,');
  SQL.Add('FA.SalvageType2 AS SalvageType2,');
  SQL.Add('FA.Salvage2 AS Salvage2,');
  SQL.Add('FA.SalvageFactor2 AS SalvageFactor2,');
  SQL.Add('FA.PriorAccumDeprec2 AS PriorAccumDeprec2,');
  SQL.Add('FA.PriorAccumDeprecDate2 AS PriorAccumDeprecDate2,');
  SQL.Add('FA.PriorAccumDeprecAmount2 AS PriorAccumDeprecAmount2,');
  SQL.Add('FA.DisposalDate2 AS DisposalDate2,');
  SQL.Add('FA.DisposalBookValue2 AS DisposalBookValue2,');
  SQL.Add('FA.DisposalAccumDeprec2 AS DisposalAccumDeprec2,');
  SQL.Add('FA.SalesPrice2 AS SalesPrice2,');
  SQL.Add('FA.FixedAssetCostAccountName2 AS FixedAssetCostAccountName2,');
  SQL.Add('FA.FixedAssetCostAccountID2 AS FixedAssetCostAccountID2,');
  SQL.Add('FA.ClearingAccountName2 AS ClearingAccountName2,');
  SQL.Add('FA.ClearingAccountID2 AS ClearingAccountID2,');
  SQL.Add('FA.FixedAssetDepreciationAccountName2 AS FixedAssetDepreciationAccountName2,');
  SQL.Add('FA.FixedAssetDepreciationAccountID2 AS FixedAssetDepreciationAccountID2,');
  SQL.Add('FA.BusinessUsePercent2 AS BusinessUsePercent2,');
  SQL.Add('FA.FixedAssetDepreciationAssetAccountName AS FixedAssetDepreciationAssetAccountName,');
  SQL.Add('FA.FixedAssetDepreciationAssetAccountName2 AS FixedAssetDepreciationAssetAccountName2,');
  SQL.Add('FA.CUSTDATE1 AS CUSTDATE1,');
  SQL.Add('FA.CUSTDATE2 AS CUSTDATE2,');
  SQL.Add('FA.CUSTDATE3 AS CUSTDATE3,');
  SQL.Add('FA.TotalChildAsset AS TotalChildAsset,');
  SQL.Add('FA.LastTestDate AS LastTestDate,');
  SQL.Add('FA.NextTestDate AS NextTestDate,');
  SQL.Add('FADD1.Year AS Year,');
  SQL.Add('FADD1.Month AS Month,');
  SQL.Add('FADD1.MonthNo AS MonthNo,');
  SQL.Add('FADD1.Depreciation AS Depreciation,');
  SQL.Add('FADD1.TotalDepreciation AS TotalDepreciation,');
  SQL.Add('FADD1.BookValue AS BookValue,');
  SQL.Add('FADD1.Date AS Date');

  SQL.Add('FROM tblFixedAssets AS FA');
  if fiItemIndex = 0 then begin
    SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails  AS FADD1 on FA.AssetID = FADD1.AssetID AND STR_TO_DATE(CONCAT("01-", MONTH,"-", YEAR), "%d-%M-%Y") > ' + QuotedStr(fsDateFrom));
  end else begin
    SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails2 AS FADD1 on FA.AssetID = FADD1.AssetID AND STR_TO_DATE(CONCAT("01-", MONTH,"-", YEAR), "%d-%M-%Y") > ' + QuotedStr(fsDateFrom));
  end;

  SQL.Add('WHERE (' + IntToStr(fiFilterIndex) + ' = 0 ) ' +
          ' OR ((' + IntToStr(fiFilterIndex) + ' = 1) AND (FA.Active = "T" AND PurchDate BETWEEN ' + QuotedStr(fsDateFrom) + ' AND ' + QuotedStr(fsDateTo) + ') )'+
          ' OR ((' + IntToStr(fiFilterIndex) + ' = 2) AND (FA.Active = "T" AND FA.Disposal = "T" AND (DisposalDate BETWEEN ' + QuotedStr(fsDateFrom) + ' AND ' + QuotedStr(fsDateTo) + ') OR (DisposalDate2 BETWEEN ' + QuotedStr(fsDateFrom) + ' AND ' + QuotedStr(fsDateFrom) + ')))');

  if Search <> '' then SQL.Add(' AND ' + Search);

  if OrderBy <> '' then SQL.Add('ORDER BY ' + OrderBy) else SQL.Add('ORDER BY AssetName;');;

end;

initialization
  RegisterClass(TAssetRegisterReport);

end.
