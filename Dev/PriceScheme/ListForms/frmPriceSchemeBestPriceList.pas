unit frmPriceSchemeBestPriceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, DAScript,
  MyScript, wwcheckbox, CustomInputBox;

type
  TfmPriceSchemeBestPriceList = class(TBaseListingGUI)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    ComboSchemeTotalMax_LastId: integer;
    ComboSchemeTotalMax_LastResult: double;
    SchemePrice_LastId: integer;
    SchemePrice_LastResult: double;
    TempTableName: string;
    procedure BuildQuery;
    function ComboSchemeTotalMax(const aSchemeId: integer): double;
    function SchemePrice(const aSchemeId: integer): double;
  published
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  fmPriceSchemeBestPriceList: TfmPriceSchemeBestPriceList;

implementation

{$R *.dfm}

uses
  CommonLib, CommonDbLib, BusObjPriceScheme, FastFuncs, tcConst;

{ TfmPriceSchemeBestPriceList }

procedure TfmPriceSchemeBestPriceList.BuildQuery;
var
  cmd: TERPCommand;
  qry: TERPQuery;
begin
  cmd:= TERPCommand.Create(nil);
  qry:= TERPQuery.Create(nil);
  try
    cmd.Connection:= GetSharedMyDacConnection;
    qry.Connection:= GetSharedMyDacConnection;
    if not TableExists(TempTableName) then begin
      cmd.SQL.Add('CREATE TABLE ' + TempTableName + ' (');
      cmd.SQL.Add('ID INT(11) AUTO_INCREMENT,');
      cmd.SQL.Add('PriceSchemeId INT default NULL,');
      cmd.SQL.Add('SchemeNumber Varchar(255) default NULL,');
      cmd.SQL.Add('SchemeName Varchar(255) default NULL,');
      cmd.SQL.Add('SchemeTypeID INT default NULL,');
      cmd.SQL.Add('SchemeType Varchar(255) default NULL,');
      cmd.SQL.Add('ProductName Varchar(255) default NULL,');
      cmd.SQL.Add('ProductDescription Varchar(255) default NULL,');
      cmd.SQL.Add('ListPrice Double default NULL,');
      cmd.SQL.Add('SalePrice Double default NULL,');
      cmd.SQL.Add('SaveUpTo Double default NULL,');
      cmd.SQL.Add('PRIMARY KEY (`ID`)) ENGINE=MyISAM;');
      cmd.Execute;
    end
    else begin
      cmd.SQL.Text:= 'DELETE FROM ' + TempTableName;
      cmd.Execute;
    end;


    cmd.SQL.Clear;
    cmd.SQL.Add('INSERT INTO ' + TempTableName);
    cmd.SQL.Add('(`PriceSchemeId`,`SchemeNumber`,`SchemeName`,`SchemeTypeId`,`SchemeType`,`ProductName`,`ProductDescription`,`ListPrice`,`SalePrice`)');
    cmd.SQL.Add('SELECT ps.PriceSchemeId, ps.SchemeNumber, ps.SchemeName, ps.SchemeType as SchemeTypeId,');
    cmd.SQL.Add('CASE');
    cmd.SQL.Add('WHEN ps.SchemeType = 0 THEN "List Price"');
    cmd.SQL.Add('WHEN ps.SchemeType = 1 THEN "Buy Qty for free Qty"');
    cmd.SQL.Add('WHEN ps.SchemeType = 2 THEN "Buy Qty for Discount"');
    cmd.SQL.Add('WHEN ps.SchemeType = 3 THEN "Buy Qty for Discount on One"');
    cmd.SQL.Add('WHEN ps.SchemeType = 4 THEN "Buy Qty for Price"');
    cmd.SQL.Add('WHEN ps.SchemeType = 5 THEN "Buy For Credit"');
    cmd.SQL.Add('WHEN ps.SchemeType = 6 THEN "Buy Combination for Price"');
    cmd.SQL.Add('END as SchemeType,');
    cmd.SQL.Add('pli.ProductName, p.PartsDescription as ProductDescription, pli.ListPrice,');
    cmd.SQL.Add('CASE');
    cmd.SQL.Add('WHEN ps.SchemeType = 0 THEN ListPrice');
    cmd.SQL.Add('WHEN ps.SchemeType = 1 THEN ROUND(ListPrice * (1 - (ps.DiscountOrQtyFree /  spi.QuantityThreshold)),'+inttostr(CurrencyRoundPlaces)+')');
    cmd.SQL.Add('WHEN ps.SchemeType = 2 THEN Round(ListPrice * (1 - ps.DiscountOrQtyFree),'+inttostr(CurrencyRoundPlaces)+')');
    cmd.SQL.Add('WHEN ps.SchemeType = 3 THEN Round(ListPrice * (1 - ps.DiscountOrQtyFree),'+inttostr(CurrencyRoundPlaces)+')');
    cmd.SQL.Add('WHEN ps.SchemeType = 4 THEN Round(ps.Price / spi.QuantityThreshold,'+inttostr(CurrencyRoundPlaces)+')');
    cmd.SQL.Add('WHEN ps.SchemeType = 5 THEN Round(((spi.QuantityThreshold * ListPrice) - ps.Credit) / spi.QuantityThreshold,'+inttostr(CurrencyRoundPlaces)+')');
    cmd.SQL.Add('WHEN ps.SchemeType = 6 THEN 0');
    cmd.SQL.Add('END as SalePrice');
    cmd.SQL.Add('FROM tblPriceScheme ps, tblSchemePriceListItem spi, tblPriceList pl, tblPriceListItem pli, tblParts p');
    cmd.SQL.Add('WHERE ps.PriceSchemeID = spi.PriceSchemeId');
    cmd.SQL.Add('AND spi.PriceListId = pl.PriceListId');
    cmd.SQL.Add('AND pl.PriceListId = pli.PriceListId');
    cmd.SQL.Add('AND pli.ProductId = p.PartsID');
    case grpFilters.ItemIndex of
      0: cmd.SQL.Add('AND ps.Active = "T"'); {active price schemes}
      1: cmd.SQL.Add('AND ps.Active = "F"'); {inactive price schemes}
    end;

    cmd.SQL.Add('ORDER BY ps.PriceSchemeId, pli.ProductName');
    cmd.Execute;

    qry.SQL.Text:= 'SELECT * FROM ' + TempTableName;
    qry.Open;
    while not qry.Eof do begin
      qry.Edit;
      if qry.FieldByName('SchemeTypeId').AsInteger = Ord(pstCombo) then
        qry.FieldByName('SalePrice').AsFloat:=
          Round((SchemePrice(qry.FieldByName('PriceSchemeId').AsInteger) /
                 ComboSchemeTotalMax(qry.FieldByName('PriceSchemeId').AsInteger)) *
                qry.FieldByName('ListPrice').AsFloat,CurrencyRoundPlaces);
      qry.FieldByName('SaveUpTo').AsFloat:=
        qry.FieldByName('ListPrice').AsFloat - qry.FieldByName('SalePrice').AsFloat;
      qry.Post;
      qry.Next;
    end;

  finally
    cmd.Free;
    qry.Free;
  end;
end;

procedure TfmPriceSchemeBestPriceList.RefreshQuery;
var
  x: integer;
begin
  qryMain.Close;
  BuildQuery;
  inherited;
  grdMain.RemoveField('PriceSchemeId');
  grdMain.RemoveField('SchemeTypeId');
  for x:= 0 to qryMain.Fields.Count -1 do begin
    if qryMain.Fields[x] is TFloatField then
      TFloatField(qryMain.Fields[x]).Currency:= true;

  end;
end;

procedure TfmPriceSchemeBestPriceList.FormShow(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

function TfmPriceSchemeBestPriceList.ComboSchemeTotalMax(
  const aSchemeId: integer): double;
var
  qry: TERPQuery;
begin
  if aSchemeId <> ComboSchemeTotalMax_LastId then begin
    ComboSchemeTotalMax_LastId:= aSchemeId;
    qry:= CommonDbLib.TempMyQuery;
    try
      qry.SQL.Add('SELECT  MAX(ListPrice)');
      qry.SQL.Add('FROM tblPriceListItem, tblSchemePriceListItem');
      qry.SQL.Add('WHERE tblPriceListItem.PriceListId = tblSchemePriceListItem.PriceListId');
      qry.SQL.Add('AND tblPriceListItem.PriceListId IN');
      qry.SQL.Add('(SELECT PriceListId FROM tblSchemePriceListItem WHERE tblSchemePriceListItem.PriceSchemeId = ' + IntToStr(aSchemeId) + ')');
      qry.SQL.Add('GROUP BY tblSchemePriceListItem.PriceListId');
      ComboSchemeTotalMax_LastResult:= 0;
      qry.Open;
      while not qry.Eof do begin
        ComboSchemeTotalMax_LastResult:= ComboSchemeTotalMax_LastResult + qry.Fields[0].AsFloat;
        qry.Next;
      end;
    finally
      qry.Free;
    end;
  end;
  result:= ComboSchemeTotalMax_LastResult;
end;

procedure TfmPriceSchemeBestPriceList.FormCreate(Sender: TObject);
begin
  inherited;
  ComboSchemeTotalMax_LastId:= 0;
  ComboSchemeTotalMax_LastResult:= 0;
  SchemePrice_LastId:= 0;
  SchemePrice_LastResult:= 0;
  TempTableName:= GetUserTemporaryTableName('PriceSchemeBestPrice');
  qryMain.SQL.Text:= 'SELECT * FROM ' + TempTableName;
  RefreshOrignalSQL;
end;

procedure TfmPriceSchemeBestPriceList.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(TempTableName);
  inherited;
end;

function TfmPriceSchemeBestPriceList.SchemePrice(
  const aSchemeId: integer): double;
begin
  if SchemePrice_LastId <> aSchemeId then begin
    SchemePrice_LastId:= aSchemeId;
    SchemePrice_LastResult:= TPriceScheme.PriceForSchemeId(aSchemeId);
  end;
  result:= SchemePrice_LastResult;
end;

procedure TfmPriceSchemeBestPriceList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TfmPriceSchemeBestPriceList);

end.
