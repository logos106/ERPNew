unit VS1LicenseLevelsnModules;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, VS1LicenseLevelsnModulesSQL;

type
  TVS1LicenseLevelsnModulesGUI = class(TBaseListingGUI)
    qryMainTYPE: TLargeintField;
    qryMainLicenseLevel: TIntegerField;
    qryMainLicenseOrder: TIntegerField;
    qryMainModuleId: TIntegerField;
    qryMainModuleName: TWideStringField;
    qryMainmoduledescription: TWideStringField;
    qryMainIsExtra: TWideStringField;
    qryMainREquiredLevel: TWideStringField;
    qryMainPrice: TFloatField;
    qryMaindiscount: TFloatField;
    qryMainDiscountedPrice: TFloatField;
    qryMainLicenseLevelDescprion: TWideStringField;
    qryMainDiscountfrom: TDateTimeField;
    qryMainDiscountto: TDateTimeField;
    DNMPanel1: TDNMPanel;
    cboRegion: TwwDBLookupCombo;
    Label1: TLabel;
    qryRegions: TMyQuery;
    qryRegionsRegion: TWideStringField;
    qryRegionsRegionID: TIntegerField;
    qryMainRegion: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure qryRegionsAfterOpen(DataSet: TDataSet);
    procedure cboRegionCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    VS1LicenseLevelsnModules : TVS1LicenseLevelsnModules;
    Procedure MakeQrymain;
    procedure Populategrpfilters;
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    Procedure RefreshQuery;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, BusObjVS1_Cloud, AppEnvironment, DbSharedObjectsObj,
  CommonDbLib;


{$R *.dfm}

procedure TVS1LicenseLevelsnModulesGUI.cboRegionCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  VS1LicenseLevelsnModules.Regionname := qryRegionsRegion.asString;
  MakeQrymain;
  RefreshQuery;
end;

procedure TVS1LicenseLevelsnModulesGUI.FormCreate(Sender: TObject);
begin
  VS1LicenseLevelsnModules := TVS1LicenseLevelsnModules.Create;
  VS1LicenseLevelsnModules.Regionname := qryRegionsRegion.asString;
  MakeQrymain;
  Populategrpfilters;
  inherited;
  HaveDateRangeSelection := False;
  DisableSortoncolumtitleclick := true;
  DisableAlternatingRowcolor;
end;

procedure TVS1LicenseLevelsnModulesGUI.FormDestroy(Sender: TObject);
begin
  VS1LicenseLevelsnModules.Free;
  inherited;
end;

procedure TVS1LicenseLevelsnModulesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
       if qrymainlicenselevel.asInteger = 1 then DoHighlightColumn($00D9FFD9 ,Afont,ABrush)
  else if qrymainlicenselevel.asInteger = 2 then DoHighlightColumn($00B3FFB3 ,Afont,ABrush)
  else if qrymainlicenselevel.asInteger = 3 then DoHighlightColumn($0059FF59 ,Afont,ABrush);
  if Field is TFloatfield then
    if TFloatfield(Field).asFloat =0 then
      Afont.color := Abrush.color;
end;

procedure TVS1LicenseLevelsnModulesGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  if sametext(grpFilters.items[grpFilters.itemindex], 'All') then
  else begin
    GroupFilterString := 'LicenseLevel =' + inttostr(Tvs1_licenselevels.IDToggle(grpFilters.items[grpFilters.itemindex]));
  end;
  inherited;
end;

procedure TVS1LicenseLevelsnModulesGUI.IterateselectedRecordsCallback(
  var Abort: boolean; SelIndex: Integer);
begin
  inherited;

end;

procedure TVS1LicenseLevelsnModulesGUI.MakeQrymain;
var
  msg:String;
begin
  VS1LicenseLevelsnModules.PopulateReportSQL(qryMain.SQL, msg);
  self.RefreshOrignalSQL();

end;

Procedure TVS1LicenseLevelsnModulesGUI.Populategrpfilters;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.sql.text :='Select LicenseOrder, Description from tblVS1_LicenseLevels order by LicenseOrder';
    qry.open;
    if qry.recordcount =0 then exit;
    grpFilters.items.clear;
    qry.first;
    while qry.eof = false do begin
      grpFilters.items.add(qry.fieldbyname('Description').asString);
      qry.next;
    end;
    grpFilters.items.add('All');
    grpFilters.columns := grpFilters.Items.count;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TVS1LicenseLevelsnModulesGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if qryRegions.active = false then begin
    qryRegions.Connection :=qrymain.connection;
    qryRegions.Open;
  end;
end;

procedure TVS1LicenseLevelsnModulesGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainDiscountedPrice.asfloat := qryMainPrice.asfloat  - qryMaindiscount.asfloat;
end;

procedure TVS1LicenseLevelsnModulesGUI.qryRegionsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryRegions.Locate('Region',AppEnv.CompanyPrefs.CompanyRegion,[]);
  VS1LicenseLevelsnModules.Regionname := qryRegionsRegion.asString;
end;

procedure TVS1LicenseLevelsnModulesGUI.RefreshQuery;
begin
  if qryRegions.active = false then begin
    qryRegions.Connection :=qrymain.connection;
    qryRegions.Open;
  end;
  inherited;
end;

procedure TVS1LicenseLevelsnModulesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainTYPE.fieldname);
  RemoveFieldfromGrid(qryMainLicenseLevel.fieldname);
  RemoveFieldfromGrid(qryMainLicenseOrder.fieldname);
  RemoveFieldfromGrid(qryMainModuleId.fieldname);
end;

initialization
  RegisterClass(TVS1LicenseLevelsnModulesGUI);

end.
