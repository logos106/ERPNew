// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.
  //20/10/05  1.00.01 DLS Added RegisterClass

unit FixedAssetsListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TFixedAssetsListGUI = class(TBaseListingGUI)
    qryMainAssetID: TAutoIncField;
    qryMainAssetCode: TWideStringField;
    qryMainAssetName: TWideStringField;
    qryMainPurchDate: TDateField;
    qryMainPurchCost: TFloatField;
    qryMainAssetType: TWideStringField;
    qryMainLocationDescription: TWideStringField;
    qryMainClass: TWideStringField;
    qryMainBrandName: TWideStringField;
    qryMainManufacture: TWideStringField;
    qryMainModel: TWideStringField;
    qryMainSerial: TWideStringField;
    qryMainNotes: TWideStringField;
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
    qryMainBusinessUse: TFloatField;
    Label5: TLabel;
    chkBarCodes: TCheckBox;
    pnlBarCode: TDNMPanel;
    lblSelectAll: TLabel;
    lblBarCode: TLabel;
    chkBarAll: TCheckBox;
    edtBarQty: TEdit;
    udBarQty: TUpDown;
    actLabels: TAction;
    btnAssetLabels: TDNMSpeedButton;
    lblBarQty: TLabel;
    chkBarInStock: TCheckBox;
    qryMainActive: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainAssetCondition: TWideStringField;
    qryMainLastTestdate: TDateField;
    qryMainNextTestDate: TDateField;
    qryMainHire: TWideStringField;
    grpHireFilter: TRadioGroup;
    qryMainDescription: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainQty: TLargeintField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure chkBarCodesClick(Sender: TObject);
    procedure chkBarAllClick(Sender: TObject);
    procedure actLabelsExecute(Sender: TObject);
    procedure actLabelsUpdate(Sender: TObject);
    procedure chkBarInStockClick(Sender: TObject); 
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grpHireFilterClick(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
    Procedure WriteGuiPrefExtra; override;
    procedure ReadnApplyGuiPrefExtra; override;
    procedure BuildQuery;
  public
    { Public declarations }
  end;

//var
//  FixedAssetsListGUI: TFixedAssetsListGUI;

implementation
 
uses  CommonDbLib, CommonLib, CommonFormLib;
{$R *.dfm}

procedure TFixedAssetsListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  FixedAssetsListGUI := nil;
end;

procedure TFixedAssetsListGUI.grpHireFilterClick(Sender: TObject);
begin
  inherited;
  ApplyQueryFilter;
end;

procedure TFixedAssetsListGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TfmFixedAsset' , 0);
(*Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TFixedAssetGUI');
    if Assigned(Form) then begin //if has acess
      with TFixedAssetGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;*)
end;

procedure TFixedAssetsListGUI.ReadnApplyGuiPrefExtra;
var
  x: integer;
begin
  inherited;
  if (grpHireFilter.Visible) and (grpHireFilter.Items.Count > 0) then begin
    if GuiPrefs.Node.Exists('grpHireFilter') then begin
      x := GuiPrefs.Node['grpHireFilter.ItemIndex'].asInteger;
      if x > 0 then if grpHireFilter.Items.Count >= x then grpHireFilter.ItemIndex := x - 1;
    end;
  end;
end;

procedure TFixedAssetsListGUI.RefreshQuery;
begin
  inherited;
  //
end;

procedure TFixedAssetsListGUI.WriteGuiPrefExtra;
begin
  inherited;
  if (grpHireFilter.Visible) and (grpHireFilter.Items.Count > 0) then begin
    GuiPrefs.Node['grpHireFilter.ItemIndex'].asInteger := grpHireFilter.ItemIndex + 1;
  end;
end;

procedure TFixedAssetsListGUI.chkBarCodesClick(Sender: TObject);
begin
  inherited;
  LblNote.Visible := not chkBarCodes.Checked;  // "Double click on any field to get more info..."
  pnlBarCode.Visible := chkBarCodes.Checked;
  if chkBarCodes.Checked then begin
    grdMain.Options := grdMain.Options + [dgMultiSelect];
    grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoShiftSelect]
  end else begin
    grdMain.UnselectAll;
    grdMain.Options := grdMain.Options - [dgMultiSelect];
  end;
end;

procedure TFixedAssetsListGUI.chkBarAllClick(Sender: TObject);
begin
  inherited;
  if chkBarAll.Checked then begin
    grdMain.SelectAll;
  end else begin
    grdMain.UnselectAll;
  end;
end;

procedure TFixedAssetsListGUI.actLabelsExecute(Sender: TObject);
var
  RecCount, i, j: integer;
  iCount: integer;
  qry: TERPQuery;
  bOk: boolean;
  iCode: integer;
  sSQL: string;
begin
  DisableForm;
  try
    inherited;
    bOk := true;
    Val(edtBarQty.Text, iCount, iCode);
    if (iCode <> 0) or (iCount = 0) then begin
      CommonLib.MessageDlgXP_Vista('Number of Labels to Print is Invalid', mtWarning, [mbOK], 0);
      bOk := false;
    end;

    if bOk then begin
      qry           := TERPQuery.Create(self);
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      Processingcursor(True);
      try
        qry.SQl.Clear;
        qry.SQL.Add('TRUNCATE TABLE tblfixedassetlabelstoprint;');
        qry.Execute;
        for i := 0 to grdMain.SelectedList.Count - 1 do begin
          qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
          if chkBarInStock.Checked then begin
            iCount := qryMain.FieldByName('Qty').AsInteger;
          end;
          for j := 0 to iCount - 1 do begin
            qry.SQL.Clear;
            qry.Sql.Add('INSERT HIGH_PRIORITY INTO tblfixedassetlabelstoprint (AssetID) VALUES (' +
              qryMain.FieldByName('AssetID').AsString + ')');
            qry.Execute;
          end;
        end;
        qry.SQL.Clear;
        qry.Sql.Add('SELECT COUNT(*) as RecordCount FROM tblfixedassetlabelstoprint;');
        //qry.Prepared := true;
        qry.Active := true;
        RecCount := qry.FieldByName('RecordCount').AsInteger;
        qry.Active := false;
        if RecCount <> 0 then begin
          PrintTemplateReport('Fixed Asset Label', sSQL, false, 0);
        end;
      finally
        Processingcursor(False);
        qry.Close;
        FreeAndNil(qry);
      end;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TFixedAssetsListGUI.actLabelsUpdate(Sender: TObject);
begin
  inherited;
  actLabels.Enabled := chkBarCodes.Checked;
end;

procedure TFixedAssetsListGUI.actRefreshQryExecute(Sender: TObject);
begin
  BuildQuery;
  inherited;

end;

procedure TFixedAssetsListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  BuildQuery;
  case grpFilters.ItemIndex of
    0:
      begin {Active}
        GroupFilterString := '(Active = "T")';
      end;
    1:
      begin {Inactive}
        GroupFilterString := '(Active = "F")';
      end;
    2:
      begin {All}
        GroupFilterString := '';
      end;
  end;
  case grpHireFilter.ItemIndex of
    0:
      begin {All Types}

      end;
    1:
      begin {HireOnly}
        if GroupFilterString <> '' then
          GroupFilterString := GroupFilterString + ' and ';
        GroupFilterString := GroupFilterString + '(Hire = "T")';
      end;
    2:
      begin {Exclude Hire}
        if GroupFilterString <> '' then
          GroupFilterString := GroupFilterString + ' and ';
        GroupFilterString := GroupFilterString + '(Hire <> "T")';
      end;
  end;
  inherited;
  RefreshQuery;
end;

procedure TFixedAssetsListGUI.chkBarInStockClick(Sender: TObject);
begin
  inherited;
  edtBarQty.Text := '1';
  edtBarQty.Enabled := not chkBarInStock.Checked;
  udBarQty.Enabled := not chkBarInStock.Checked;
end;

procedure TFixedAssetsListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TFixedAssetsListGUI.BuildQuery;
begin
  qrymain.sql.Clear;
  if grpFilters.ItemIndex = 3 then
  begin // summary
    qryMain.SQL.Add('Select');
    qryMain.SQL.Add('"" as GlobalRef,');
    qryMain.SQL.Add('tblfixedassets.AssetId as AssetID,');
    qryMain.SQL.Add('"" as AssetCode,');
    qryMain.SQL.Add('tblfixedassets.assetname as AssetName,');
    qryMain.SQL.Add('"" as Description,');
    qryMain.SQL.Add('Date(0) as PurchDate,');
    qryMain.SQL.Add('0.0 as PurchCost,');
    qryMain.SQL.Add('tblfixedassets.AssetType as AssetType,');
    qryMain.SQL.Add('"" as LocationDescription,');
    qryMain.SQL.Add('tblclass.ClassName as Class,');
    qryMain.SQL.Add('"" as BrandName,');
    qryMain.SQL.Add('"" as Manufacture,');
    qryMain.SQL.Add('"" as Model,');
    qryMain.SQL.Add('"" as Serial,');
    qryMain.SQL.Add('"" as Notes,');
    qryMain.SQL.Add('"" as SalesDescription,');
    qryMain.SQL.Add('cast(sum(tblfixedassets.Qty) as signed) as Qty,');
    qryMain.SQL.Add('"" as AssetCondition,');
    qryMain.SQL.Add('"" as Colour,');
    qryMain.SQL.Add('"" as Size,');
    qryMain.SQL.Add('"" as Shape,');
    qryMain.SQL.Add('"" as Status,');
    qryMain.SQL.Add('sum(tblfixedassets.EstimatedValue) as EstimatedValue,');
    qryMain.SQL.Add('sum(tblfixedassets.ReplacementCost) as ReplacementCost,');
    qryMain.SQL.Add('"" as WarrantyType,');
    qryMain.SQL.Add('Date(0) as WarrantyExpiresDate,');
    qryMain.SQL.Add('"" as InsuredBy,');
    qryMain.SQL.Add('""  as InsurancePolicy,');
    qryMain.SQL.Add('Date(0) as InsuredUntil,');
    qryMain.SQL.Add('0.0 as "BusinessUse (%)",');
    qryMain.SQL.Add('""  as CUSTFLD1,');
    qryMain.SQL.Add('""  as CUSTFLD2,');
    qryMain.SQL.Add('""  as CUSTFLD3,');
    qryMain.SQL.Add('""  as CUSTFLD4,');
    qryMain.SQL.Add('""  as CUSTFLD5,');
    qryMain.SQL.Add('""  as CUSTFLD6,');
    qryMain.SQL.Add('""  as CUSTFLD7,');
    qryMain.SQL.Add('""  as CUSTFLD8,');
    qryMain.SQL.Add('""  as CUSTFLD9,');
    qryMain.SQL.Add('""  as CUSTFLD10,');
    qryMain.SQL.Add('""  as CUSTFLD11,');
    qryMain.SQL.Add('""  as CUSTFLD12,');
    qryMain.SQL.Add('""  as CUSTFLD13,');
    qryMain.SQL.Add('""  as CUSTFLD14,');
    qryMain.SQL.Add('""  as CUSTFLD15,');
    qryMain.SQL.Add('"T" as Active,');
    qryMain.SQL.Add('Date(0) as LastTestdate,');
    qryMain.SQL.Add('Date(0) as NextTestDate,');
    qryMain.SQL.Add('IfNull(tblAssetHire.Active,"F") as Hire');
    qryMain.SQL.Add('FROM tblfixedassets');
    qryMain.SQL.Add('LEFT Join tblclass using(ClassID)');
    qryMain.SQL.Add('left Join tblAssetHire on tblAssetHire.AssetId = tblfixedassets.AssetId');
    if grpHireFilter.ItemIndex = 1 then
      qryMain.SQL.Add('where tblAssetHire.Active="T"')
    else if grpHireFilter.ItemIndex = 2 then
      qryMain.SQL.Add('where tblAssetHire.Active="F" or tblassethire.Active is null');
    qryMain.SQL.Add('group by tblfixedassets.assetname');
    qryMain.SQL.Add('order by tblfixedassets.AssetName');
  end
  else
  begin
    qryMain.SQL.Add('Select');
    qryMain.SQL.Add('tblfixedassets.GlobalRef as GlobalRef,');
    qryMain.SQL.Add('tblfixedassets.AssetID as AssetID,');
    qryMain.SQL.Add('tblfixedassets.AssetCode as AssetCode,');
    qryMain.SQL.Add('tblfixedassets.AssetName as AssetName,');
    qryMain.SQL.Add('tblfixedassets.Description as Description,');
    qryMain.SQL.Add('tblfixedassets.PurchDate as PurchDate,');
    qryMain.SQL.Add('tblfixedassets.PurchCost as PurchCost,');
    qryMain.SQL.Add('tblfixedassets.AssetType as AssetType,');
    qryMain.SQL.Add('tblfixedassets.LocationDescription as LocationDescription,');
    qryMain.SQL.Add('tblclass.ClassName as Class,');
    qryMain.SQL.Add('tblfixedassets.BrandName as BrandName,');
    qryMain.SQL.Add('tblfixedassets.Manufacture as Manufacture,');
    qryMain.SQL.Add('tblfixedassets.Model as Model,');
    qryMain.SQL.Add('tblfixedassets.Serial as Serial,');
    qryMain.SQL.Add('SUBSTRING(tblfixedassets.Notes,1,255) as Notes,');
    qryMain.SQL.Add('case when tblfixedassets.ASSETNAME is null then ""');
    qryMain.SQL.Add('else (select PartsDescription from tblParts where PARTNAME = tblfixedassets.ASSETNAME)');
    qryMain.SQL.Add('end  SalesDescription,');
    qryMain.SQL.Add('cast(tblfixedassets.Qty as signed) as Qty,');
    qryMain.SQL.Add('tblfixedassets.AssetCondition as AssetCondition,');
    qryMain.SQL.Add('tblfixedassets.Colour as Colour,');
    qryMain.SQL.Add('tblfixedassets.Size as Size,');
    qryMain.SQL.Add('tblfixedassets.Shape as Shape,');
    qryMain.SQL.Add('tblfixedassets.Status as Status,');
    qryMain.SQL.Add('tblfixedassets.EstimatedValue as EstimatedValue,');
    qryMain.SQL.Add('tblfixedassets.ReplacementCost as ReplacementCost,');
    qryMain.SQL.Add('tblfixedassets.WarrantyType as WarrantyType,');
    qryMain.SQL.Add('tblfixedassets.WarrantyExpiresDate as WarrantyExpiresDate,');
    qryMain.SQL.Add('tblfixedassets.InsuredBy as InsuredBy,');
    qryMain.SQL.Add('tblfixedassets.InsurancePolicy as InsurancePolicy,');
    qryMain.SQL.Add('tblfixedassets.InsuredUntil as InsuredUntil,');
    qryMain.SQL.Add('tblfixedassets.BusinessUsePercent as "BusinessUse (%)",');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD1 as CUSTFLD1,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD2 as CUSTFLD2,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD3 as CUSTFLD3,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD4 as CUSTFLD4,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD5 as CUSTFLD5,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD6 as CUSTFLD6,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD7 as CUSTFLD7,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD8 as CUSTFLD8,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD9 as CUSTFLD9,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD10 as CUSTFLD10,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD11 as CUSTFLD11,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD12 as CUSTFLD12,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD13 as CUSTFLD13,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD14 as CUSTFLD14,');
    qryMain.SQL.Add('tblfixedassets.CUSTFLD15 as CUSTFLD15,');
    qryMain.SQL.Add('tblfixedassets.Active as Active,');
    qryMain.SQL.Add('tblfixedassets.LastTestdate as LastTestdate,');
    qryMain.SQL.Add('tblfixedassets.NextTestDate as NextTestDate,');
    qryMain.SQL.Add('IfNull(tblAssetHire.Active,"F") as Hire');
    qryMain.SQL.Add('FROM tblfixedassets');
    qryMain.SQL.Add('LEFT Join tblclass using(ClassID)');
    qryMain.SQL.Add('left Join tblAssetHire on tblAssetHire.AssetId = tblfixedassets.AssetId');
    qryMain.SQL.Add('order by tblfixedassets.AssetName');

  end;
end;

procedure TFixedAssetsListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TFixedAssetsListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TFixedAssetsListGUI);
end.
