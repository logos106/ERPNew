
unit frmAssetListGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, DNMPanel,
  wwclearbuttongroup, wwradiogroup, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  GIFImg;

type
  TAssetRegisterListGUI = class(TBaseListingGUI)
    rgDetails: TwwRadioGroup;
    qryMainDepOption: TWideStringField;
    qryMainDepOption2: TWideStringField;
    qryMainAssetCode: TWideStringField;
    qryMainAssetName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainPurchDate: TDateField;
    qryMainDepreciationStartDate: TDateField;
    qryMainPurchCost: TFloatField;
    qryMainAssetType: TWideStringField;
    qryMainLocationDescription: TWideStringField;
    qryMainBrandName: TWideStringField;
    qryMainManufacture: TWideStringField;
    qryMainModel: TWideStringField;
    qryMainSerial: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainQty: TIntegerField;
    qryMainAssetCondition: TWideStringField;
    qryMainColour: TWideStringField;
    qryMainSize: TWideStringField;
    qryMainShape: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainEstimatedValue: TFloatField;
    qryMainReplacementCost: TFloatField;
    qryMainWarrantyType: TWideStringField;
    qryMainWarrantyExpiresDate: TDateField;
    qryMainInsuredBy: TWideStringField;
    qryMainInsurancePolicy: TWideStringField;
    qryMainInsuredUntil: TDateField;
    qryMainBusinessUsePercent: TFloatField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainDepreciationOption: TSmallintField;
    qryMainLife: TFloatField;
    qryMainSalvageType: TSmallintField;
    qryMainSalvage: TFloatField;
    qryMainSalvageFactor: TFloatField;
    qryMainPriorAccumDeprec: TWideStringField;
    qryMainPriorAccumDeprecDate: TWideStringField;
    qryMainPriorAccumDeprecAmount: TFloatField;
    qryMainDisposal: TWideStringField;
    qryMainDisposalDate: TDateTimeField;
    qryMainDisposalBookValue: TFloatField;
    qryMainDisposalAccumDeprec: TFloatField;
    qryMainSalesPrice: TFloatField;
    qryMainFixedAssetCostAccountName: TWideStringField;
    qryMainClearingAccountName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainPARTNAME: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainFixedAssetDepreciationAccountName: TWideStringField;
    qryMainSupplierName: TWideStringField;
    qryMainBARCODE: TWideStringField;
    qryMainDepreciationOption2: TSmallintField;
    qryMainLife2: TFloatField;
    qryMainSalvageType2: TSmallintField;
    qryMainSalvage2: TFloatField;
    qryMainSalvageFactor2: TFloatField;
    qryMainPriorAccumDeprec2: TWideStringField;
    qryMainPriorAccumDeprecDate2: TWideStringField;
    qryMainPriorAccumDeprecAmount2: TFloatField;
    qryMainDisposalDate2: TDateTimeField;
    qryMainDisposalBookValue2: TFloatField;
    qryMainDisposalAccumDeprec2: TFloatField;
    qryMainSalesPrice2: TFloatField;
    qryMainFixedAssetCostAccountName2: TWideStringField;
    qryMainClearingAccountName2: TWideStringField;
    qryMainFixedAssetDepreciationAccountName2: TWideStringField;
    qryMainBusinessUsePercent2: TFloatField;
    qryMainFixedAssetDepreciationAssetAccountName: TWideStringField;
    qryMainFixedAssetDepreciationAssetAccountName2: TWideStringField;
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
    qryMainTotalChildAsset: TFloatField;
    qryMainLastTestDate: TDateField;
    qryMainNextTestDate: TDateField;
    qryMainYear: TWideStringField;
    qryMainMonth: TWideStringField;
    qryMainMonthNo: TIntegerField;
    qryMainDepreciation: TFloatField;
    qryMainTotalDepreciation: TFloatField;
    qryMainBookValue: TFloatField;
    qryMainDate: TDateField;
    qryMainAssetID: TIntegerField;
    qryMainDeprecAsOn: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure rgDetailsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    fsHint:String;
    procedure MakeQrymain;
  Protected
    Procedure SetGridColumns;override;
  public
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  end;

implementation

{$R *.dfm}

uses
   AppEnvironment, CommonLib, FastFuncs, DNMLib, MySQLConst,dateutils, LogLib;

{ TAssetRegisterListGUI }

procedure TAssetRegisterListGUI.MakeQrymain;
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT ');
  qryMain.SQL.Add('CASE FA.DepreciationOption ' +
                  '  WHEN 1 THEN "No Depreciation" ' +
                  '  WHEN 2 THEN "Straight Line" ' +
                  '  WHEN 3 THEN "Declining Balance" ' +
                  '  ELSE "No Depreciation" ' +
                  'END AS "DepOption",');

  qryMain.SQL.Add('CASE FA.DepreciationOption2 ' +
                  '  WHEN 1 THEN "No Depreciation" ' +
                  '  WHEN 2 THEN "Straight Line" ' +
                  '  WHEN 3 THEN "Declining Balance" ' +
                  '  ELSE "No Depreciation" ' +
                  'END AS "DepOption2",');
  qryMain.SQL.Add('CONCAT(FADD1.Month ,"-",FADD1.Year ) as DeprecAsOn,');
  qryMain.SQL.Add('FA.AssetID AS  AssetID,');
  qryMain.SQL.Add('FA.AssetCode	as	AssetCode,');
  qryMain.SQL.Add('FA.AssetName	as	AssetName,');
  qryMain.SQL.Add('FA.Description	as	Description,');
  qryMain.SQL.Add('FA.PurchDate	as	PurchDate,');
  qryMain.SQL.Add('FA.DepreciationStartDate	as	DepreciationStartDate,');
  qryMain.SQL.Add('FA.PurchCost	as	PurchCost,');
  qryMain.SQL.Add('FA.AssetType	as	AssetType,');
  qryMain.SQL.Add('FA.LocationDescription	as	LocationDescription,');
  qryMain.SQL.Add('FA.BrandName	as	BrandName,');
  qryMain.SQL.Add('FA.Manufacture	as	Manufacture,');
  qryMain.SQL.Add('FA.Model	as	Model,');
  qryMain.SQL.Add('FA.Serial	as	Serial,');
  qryMain.SQL.Add('FA.Notes	as	Notes,');
  qryMain.SQL.Add('FA.Qty	as	Qty,');
  qryMain.SQL.Add('FA.AssetCondition	as	AssetCondition,');
  qryMain.SQL.Add('FA.Colour	as	Colour,');
  qryMain.SQL.Add('FA.Size	as	Size,');
  qryMain.SQL.Add('FA.Shape	as	Shape,');
  qryMain.SQL.Add('FA.Status	as	Status,');
  qryMain.SQL.Add('FA.EstimatedValue	as	EstimatedValue,');
  qryMain.SQL.Add('FA.ReplacementCost	as	ReplacementCost,');
  qryMain.SQL.Add('FA.WarrantyType	as	WarrantyType,');
  qryMain.SQL.Add('FA.WarrantyExpiresDate	as	WarrantyExpiresDate,');
  qryMain.SQL.Add('FA.InsuredBy	as	InsuredBy,');
  qryMain.SQL.Add('FA.InsurancePolicy	as	InsurancePolicy,');
  qryMain.SQL.Add('FA.InsuredUntil	as	InsuredUntil,');
  qryMain.SQL.Add('FA.BusinessUsePercent	as	BusinessUsePercent,');
  qryMain.SQL.Add('FA.CUSTFLD1	as	CUSTFLD1,');
  qryMain.SQL.Add('FA.CUSTFLD2	as	CUSTFLD2,');
  qryMain.SQL.Add('FA.CUSTFLD3	as	CUSTFLD3,');
  qryMain.SQL.Add('FA.CUSTFLD4	as	CUSTFLD4,');
  qryMain.SQL.Add('FA.CUSTFLD5	as	CUSTFLD5,');
  qryMain.SQL.Add('FA.CUSTFLD6	as	CUSTFLD6,');
  qryMain.SQL.Add('FA.CUSTFLD7	as	CUSTFLD7,');
  qryMain.SQL.Add('FA.CUSTFLD8	as	CUSTFLD8,');
  qryMain.SQL.Add('FA.CUSTFLD9	as	CUSTFLD9,');
  qryMain.SQL.Add('FA.CUSTFLD10	as	CUSTFLD10,');
  qryMain.SQL.Add('FA.CUSTFLD11	as	CUSTFLD11,');
  qryMain.SQL.Add('FA.CUSTFLD12	as	CUSTFLD12,');
  qryMain.SQL.Add('FA.CUSTFLD13	as	CUSTFLD13,');
  qryMain.SQL.Add('FA.CUSTFLD14	as	CUSTFLD14,');
  qryMain.SQL.Add('FA.CUSTFLD15	as	CUSTFLD15,');
  qryMain.SQL.Add('FA.DepreciationOption	as	DepreciationOption,');
  qryMain.SQL.Add('FA.Life	as	Life,');
  qryMain.SQL.Add('FA.SalvageType	as	SalvageType,');
  qryMain.SQL.Add('FA.Salvage	as	Salvage,');
  qryMain.SQL.Add('FA.SalvageFactor	as	SalvageFactor,');
  qryMain.SQL.Add('FA.PriorAccumDeprec	as	PriorAccumDeprec,');
  qryMain.SQL.Add('FA.PriorAccumDeprecDate	as	PriorAccumDeprecDate,');
  qryMain.SQL.Add('FA.PriorAccumDeprecAmount	as	PriorAccumDeprecAmount,');
  qryMain.SQL.Add('FA.Disposal	as	Disposal,');
  qryMain.SQL.Add('FA.DisposalDate	as	DisposalDate,');
  qryMain.SQL.Add('FA.DisposalBookValue	as	DisposalBookValue,');
  qryMain.SQL.Add('FA.DisposalAccumDeprec	as	DisposalAccumDeprec,');
  qryMain.SQL.Add('FA.SalesPrice	as	SalesPrice,');
  qryMain.SQL.Add('FA.FixedAssetCostAccountName	as	FixedAssetCostAccountName,');
  qryMain.SQL.Add('FA.ClearingAccountName	as	ClearingAccountName,');
  qryMain.SQL.Add('FA.Active	as	Active,');
  qryMain.SQL.Add('FA.PARTNAME	as	PARTNAME,');
  qryMain.SQL.Add('FA.ProductPrintName	as	ProductPrintName,');
  qryMain.SQL.Add('FA.FixedAssetDepreciationAccountName	as	FixedAssetDepreciationAccountName,');
  qryMain.SQL.Add('FA.SupplierName	as	SupplierName,');
  qryMain.SQL.Add('FA.BARCODE	as	BARCODE,');
  qryMain.SQL.Add('FA.DepreciationOption2	as	DepreciationOption2,');
  qryMain.SQL.Add('FA.Life2	as	Life2,');
  qryMain.SQL.Add('FA.SalvageType2	as	SalvageType2,');
  qryMain.SQL.Add('FA.Salvage2	as	Salvage2,');
  qryMain.SQL.Add('FA.SalvageFactor2	as	SalvageFactor2,');
  qryMain.SQL.Add('FA.PriorAccumDeprec2	as	PriorAccumDeprec2,');
  qryMain.SQL.Add('FA.PriorAccumDeprecDate2	as	PriorAccumDeprecDate2,');
  qryMain.SQL.Add('FA.PriorAccumDeprecAmount2	as	PriorAccumDeprecAmount2,');
  qryMain.SQL.Add('FA.DisposalDate2	as	DisposalDate2,');
  qryMain.SQL.Add('FA.DisposalBookValue2	as	DisposalBookValue2,');
  qryMain.SQL.Add('FA.DisposalAccumDeprec2	as	DisposalAccumDeprec2,');
  qryMain.SQL.Add('FA.SalesPrice2	as	SalesPrice2,');
  qryMain.SQL.Add('FA.FixedAssetCostAccountName2	as	FixedAssetCostAccountName2,');
  qryMain.SQL.Add('FA.FixedAssetCostAccountID2	as	FixedAssetCostAccountID2,');
  qryMain.SQL.Add('FA.ClearingAccountName2	as	ClearingAccountName2,');
  qryMain.SQL.Add('FA.ClearingAccountID2	as	ClearingAccountID2,');
  qryMain.SQL.Add('FA.FixedAssetDepreciationAccountName2	as	FixedAssetDepreciationAccountName2,');
  qryMain.SQL.Add('FA.FixedAssetDepreciationAccountID2	as	FixedAssetDepreciationAccountID2,');
  qryMain.SQL.Add('FA.BusinessUsePercent2	as	BusinessUsePercent2,');
  qryMain.SQL.Add('FA.FixedAssetDepreciationAssetAccountName	as	FixedAssetDepreciationAssetAccountName,');
  qryMain.SQL.Add('FA.FixedAssetDepreciationAssetAccountName2	as	FixedAssetDepreciationAssetAccountName2,');
  qryMain.SQL.Add('FA.CUSTDATE1	as	CUSTDATE1,');
  qryMain.SQL.Add('FA.CUSTDATE2	as	CUSTDATE2,');
  qryMain.SQL.Add('FA.CUSTDATE3	as	CUSTDATE3,');
  qryMain.SQL.Add('FA.TotalChildAsset	as	TotalChildAsset,');
  qryMain.SQL.Add('FA.LastTestDate	as	LastTestDate,');
  qryMain.SQL.Add('FA.NextTestDate	as	NextTestDate,');
  qryMain.SQL.Add('FADD1.Year as Year,');
  qryMain.SQL.Add('FADD1.Month as Month,');
  qryMain.SQL.Add('FADD1.MonthNo as MonthNo,');
  qryMain.SQL.Add('FADD1.Depreciation as Depreciation,');
  qryMain.SQL.Add('FADD1.TotalDepreciation as TotalDepreciation,');
  qryMain.SQL.Add('FADD1.BookValue as BookValue,');
  qryMain.SQL.Add('FADD1.Date as Date');


  qryMain.SQL.Add('FROM tblfixedassets AS FA');
        if rgDetails.ItemIndex = 0 then begin
          qryMain.SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails AS FADD1 on FA.AssetID = FADD1.AssetID AND STR_TO_DATE(CONCAT("01-", MONTH,"-",YEAR),"%d-%M-%Y")> :DateFrom');
          fsHint:= 'Deprec #1 ';
        end else begin
          qryMain.SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails2 AS FADD1 on FA.AssetID = FADD1.AssetID AND STR_TO_DATE(CONCAT("01-", MONTH,"-",YEAR),"%d-%M-%Y")> :DateFrom');
          fsHint:= 'Deprec #2';
        end;
        qryMain.SQL.Add('WHERE (:filteridex = 0 ) '+
                        ' or ((:filteridex = 1) and (FA.Active = "T" AND PurchDate between :dateFrom and :Dateto) )'+
                        ' or ((:filteridex = 2) and (FA.Active = "T" AND FA.Disposal = "T" AND (DisposalDate between :dateFrom and :Dateto) OR  (DisposalDate2 between :dateFrom and :Dateto)))');

        qryMain.SQL.Add('ORDER BY AssetName;');
  RefreshOrignalSQL;
end;


procedure TAssetRegisterListGUI.RefreshQuery;
var
  fs:String;
begin
  fs:= '';
  if not HaveDateRangeSelection then begin
        if AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Full Year' then begin
          Qrymain.parambyname('datefrom').asDatetime := GetCurrentFiscalYearStart;
          fs:= fsHint+ ' Since ' + FormatDateTime('MMMM YYYY',GetCurrentFiscalYearStart)+ '(Current Financial Year). Depreciation Calculation Conventions is "Full Year"';
        end else if AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Half Year' then begin
          if incmonth(GetCurrentFiscalYearStart,6) >Date() then begin
            Qrymain.parambyname('datefrom').asDatetime := GetCurrentFiscalYearStart;
            fs:= fsHint+ ' Since ' + FormatDateTime('MMMM YYYY',GetCurrentFiscalYearStart)+ '(Current Financial Year). Depreciation Calculation Conventions is "Half Year"';
          end else begin
            Qrymain.parambyname('datefrom').asDatetime := incmonth(GetCurrentFiscalYearStart,6);
            fs:= fsHint+ ' Since ' + FormatDateTime('MMMM YYYY',incmonth(GetCurrentFiscalYearStart,6))+ '(6 Months of Current Financial Year). Depreciation Calculation Conventions is "Half Year"';;
          end;
        end else if AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Full Month' then begin
          Qrymain.parambyname('datefrom').asDatetime :=startofthemonth(date());
          fs:= fsHint+ ' Since ' + FormatDateTime('MMMM YYYY',Date())+' (Start of Current Month) . Depreciation Calculation Conventions is "Monthly"';
        end;
        if grpFilters.ItemIndex=0 then
        else if grpFilters.ItemIndex=1 then fs:= replaceStr(fs  , 'Since' , 'Purchase Date and Month/Year of Depreciation >= ')
        else if grpFilters.ItemIndex=2 then fs:= replaceStr(fs  , 'Since' , 'Disposal Date and Month/Year of Depreciation >= ');
  end else begin
    Qrymain.parambyname('datefrom').asDatetime :=FilterDatefrom;
    fs:= fsHint+ ' Since ' + FormatDateTime('MMMM YYYY',FilterDateFrom)+' and ' + FormatDateTime('MMMM YYYY',FilterdateTo)+' (User Selected Date Range)';
      if grpFilters.ItemIndex=0 then
      else if grpFilters.ItemIndex=1 then fs:= replaceStr(fs  , 'Since' , 'Purchase Date and Month/Year of Depreciation between ')
      else if grpFilters.ItemIndex=2 then fs:= replaceStr(fs  , 'Since' , 'Disposal Date and Month/Year of Depreciation between ')
  end;
  Qrymain.parambyname('Dateto').asDatetime :=FilterDateTo;
  qrymain.ParamByName('filteridex').asInteger := grpFilters.ItemIndex;
  clog(Qrymain.SQLText);
  if fs <> '' then showcontrolhint(grdmain, fs);
  inherited;
end;

procedure TAssetRegisterListGUI.RefreshTotals;
begin
  inherited;
  //
end;

procedure TAssetRegisterListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  MakeQrymain;
end;

procedure TAssetRegisterListGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  case grpFilters.ItemIndex of
    // Asset Register
    0: HaveDateRangeSelection := False;
    // Show Additions within a Date Range.
    1:  HaveDateRangeSelection := True;
    // Show Disposals within a Date Range.
    2:  HaveDateRangeSelection:= true;
  end;
  RefreshQuery;
end;

procedure TAssetRegisterListGUI.rgDetailsClick(Sender: TObject);
begin
  MakeQrymain;
  RefreshQuery;
end;
procedure TAssetRegisterListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Assets');
  RemoveFieldfromGrid(qryMainAssetID.fieldname);
end;

initialization
  RegisterClassOnce(TAssetRegisterListGUI);
end.
