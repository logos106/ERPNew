// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.

unit frmFixedAssetsDetailsGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, DNMPanel,
  wwclearbuttongroup, wwradiogroup, wwdblook, wwdbdatetimepicker,
  ProgressDialog,  Shader, kbmMemTable;

type
  TfrmFixedAssetsDetails = class(TBaseListingGUI)
    rgDetails: TwwRadioGroup;
    qryAssetType: TERPQuery;
    DNMPanel1: TDNMPanel;
    Label4: TLabel;
    cboAssetType: TwwDBLookupCombo;
    Label5: TLabel;
    chkAll: TCheckBox;
    qryMainDetails: TLargeIntField;
    qryMainAssetName: TWideStringField;
    qryMainAssetCode: TWideStringField;
    qryMainPurchaseDate: TDateField;
    qryMainAssetType: TWideStringField;
    qryMainLocation: TWideStringField;
    qryMainTotalDepreciation: TFloatField;
    qryMainPurchaseCost: TFloatField;
    qryMainReplacementCost: TFloatField;
    qryMainLifeYears: TFloatField;
    qryMainSalvage: TFloatField;
    qryMainDisposed: TWideStringField;
    qryMainDisposalDate: TDateTimeField;
    qryMainDisposalBookValue: TFloatField;
    qryMainDepreciationOption: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainPartName: TWideStringField;
    qryMainBusinessUse: TFloatField;
    qryMainAssetID: TIntegerField;
    qryMainDate: TDateField;
    procedure rgDetailsClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure chkAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboAssetTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure RefreshQuery; override;

  end;

//var
//  frmFixedAssetsDetails: TfrmFixedAssetsDetails;

implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib;

{ TfrmFixedAssetsDetails }

procedure TfrmFixedAssetsDetails.RefreshQuery;
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  if not chkAll.Checked then begin
    qryMain.ParamCheck := true;
  end else begin
    qryMain.ParamCheck := false;
  end;

  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('  FA.AssetID, 1 AS Details, AssetName AS "Asset Name", FA.AssetCode AS "Asset Code",');
  qryMain.SQL.Add('  FA.PurchDate AS "Purchase Date",');
  qryMain.SQL.Add('  FA.AssetType AS "Asset Type", SPACE(200) AS "Location",');
  qryMain.SQL.Add('  FADD.Depreciation AS "Total Depreciation",');
  qryMain.SQL.Add('  FADD.Date AS "Date",');
  qryMain.SQL.Add('FA.PurchCost AS "Purchase Cost", FA.ReplacementCost AS "Replacement Cost",');
  case rgDetails.ItemIndex of
    0: 
      begin
        qryMain.SQL.Add('FA.Life AS "Life (Years)",');
        qryMain.SQL.Add('FA.Salvage AS "Salvage", FA.Disposal AS "Disposed", FA.DisposalDate AS "Disposal Date",');
        qryMain.SQL.Add('FA.DisposalBookValue AS "Disposal BookValue",');
      end;

    1: 
      begin
        qryMain.SQL.Add('FA.Life2 AS "Life (Years)",');
        qryMain.SQL.Add('FA.Salvage2 AS "Salvage", FA.Disposal AS "Disposed", FA.DisposalDate2 AS "Disposal Date",');
        qryMain.SQL.Add('FA.DisposalBookValue2 AS "Disposal BookValue",');
      end;
  end;

  qryMain.SQL.Add('SPACE(200) AS "Depreciation Option",');
  qryMain.SQL.Add('SPACE(200) AS "Department", SPACE(200) AS "Part Name",');
  qryMain.SQL.Add('FA.BusinessUsePercent AS "Business Use"');

  qryMain.SQL.Add('FROM tblfixedassets AS FA');
  case rgDetails.ItemIndex of
    0:
      begin
        qryMain.SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails AS FADD Using(AssetID)');
      end;

    1: 
      begin
        qryMain.SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails2 AS FADD Using(AssetID)');
      end;
  end;

  if not chkAll.Checked then begin
    qryMain.SQL.Add('WHERE FA.Active = "T" AND FA.AssetType = :xAssetType');
  end else begin
    qryMain.SQL.Add('WHERE FA.Active = "T"');
  end;

  //  qryMain.SQL.Add('GROUP BY FA.AssetID');

  qryMain.SQL.Add('UNION ALL');

  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('FA.AssetID, 0 AS Details, AssetName AS "Asset Name", AssetCode AS "Asset Code", FA.PurchDate AS "Purchase Date",');
  qryMain.SQL.Add('AssetType AS "Asset Type", LocationDescription AS "Location",');
  qryMain.SQL.Add('SUM(FADD.Depreciation) AS "Total Depreciation", FA.PurchDate AS "Date",');
  qryMain.SQL.Add('FA.PurchCost AS "Purchase Cost", FA.ReplacementCost AS "Replacement Cost",');

  case rgDetails.ItemIndex of
    0: 
      begin
        qryMain.SQL.Add('Life AS "Life (Years)", FA.Salvage AS "Salvage", FA.Disposal AS "Disposed",');
        qryMain.SQL.Add('FA.DisposalDate AS "Disposal Date",');
        qryMain.SQL.Add('FA.DisposalBookValue AS "Disposal BookValue",');
        qryMain.SQL.Add('CASE FA.DepreciationOption');
        qryMain.SQL.Add('  WHEN 1 THEN "No Depreciation"');
        qryMain.SQL.Add('  WHEN 2 THEN "Straight Line"');
        qryMain.SQL.Add('  WHEN 3 THEN "Declining Balance"');
        qryMain.SQL.Add('  ELSE "No Depreciation"');
        qryMain.SQL.Add('END AS "Depreciation Option",');
      end;

    1: 
      begin
        qryMain.SQL.Add('Life2 AS "Life (Years)", FA.Salvage2 AS "Salvage", FA.Disposal AS "Disposed", FA.DisposalDate2 AS "Disposal Date",');
        qryMain.SQL.Add('FA.DisposalBookValue2 AS "Disposal BookValue",');
        qryMain.SQL.Add('CASE FA.DepreciationOption2');
        qryMain.SQL.Add('  WHEN 1 THEN "No Depreciation"');
        qryMain.SQL.Add('  WHEN 2 THEN "Straight Line"');
        qryMain.SQL.Add('  WHEN 3 THEN "Declining Balance"');
        qryMain.SQL.Add('  ELSE "No Depreciation"');
        qryMain.SQL.Add('END AS "Depreciation Option",');
      end;
  end; // End of case directive.

  qryMain.SQL.Add('C.ClassName AS "Department", FA.PartName AS "Part Name",');
  qryMain.SQL.Add('FA.BusinessUsePercent AS "Business Use"');

  qryMain.SQL.Add('FROM tblfixedassets AS FA');
  case rgDetails.ItemIndex of
    0: 
      begin
        qryMain.SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails AS FADD Using(AssetID)');
      end;

    1: 
      begin
        qryMain.SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails2 AS FADD Using(AssetID)');
      end;
  end;

  qryMain.SQL.Add('INNER JOIN tblfixedassetpercentages AS FAP ON FAP.AssetID=FA.AssetID');
  qryMain.SQL.Add('INNER JOIN tblclass AS C on FAP.ClassID = C.ClassID');
  if not chkAll.Checked then begin
    qryMain.SQL.Add('WHERE (FA.Active = "T" AND FA.AssetType = :xAssetType2)');
  end else begin
    qryMain.SQL.Add('WHERE (FA.Active = "T")');
  end;

  qryMain.SQL.Add('GROUP BY FA.AssetID');
  qryMain.SQL.Add('ORDER BY Details;');

  // Parse parameters if required.
  if not chkAll.Checked then begin
    qryMain.Params.ParamByName('xAssetType').AsString  := cboAssetType.Text;
    qryMain.Params.ParamByName('xAssetType2').AsString := cboAssetType.Text;
  end;

  inherited;
end;

procedure TfrmFixedAssetsDetails.rgDetailsClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmFixedAssetsDetails.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Details = 0';
      end;
    1: 
      begin
        GroupFilterString := 'Details >= 0';
      end;
  end;
  inherited;
end;

procedure TfrmFixedAssetsDetails.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMain.FieldByName('Details').AsInteger = 0 then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TfrmFixedAssetsDetails.chkAllClick(Sender: TObject);
begin
  inherited;
  if chkAll.Checked then begin
    Label4.Enabled       := false;
    cboAssetType.Enabled := false;
  end else begin
    Label4.Enabled       := true;
    cboAssetType.Enabled := true;
  end;

  RefreshQuery;
end;

procedure TfrmFixedAssetsDetails.FormShow(Sender: TObject);
begin
  inherited;
  if ErrorOccurred then Exit;
  qryAssetType.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryAssetType.Open;
  if qryAssetType.RecordCount > 0 then begin
    cboAssetType.Text := qryAssetType.FieldByName('AssetTypeCode').AsString;
  end else begin
    chkAll.Checked := true;
    RefreshQuery;
  end;
end;

procedure TfrmFixedAssetsDetails.cboAssetTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;
initialization
  RegisterClassOnce(TfrmFixedAssetsDetails);
end.
