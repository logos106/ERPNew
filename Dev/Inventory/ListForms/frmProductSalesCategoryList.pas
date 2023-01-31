unit frmProductSalesCategoryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg,
  CommonformLib;

type
  TfmProductSalesCategoryList = class(TBaseListingGUI)
    qryMainCategoryType: TLargeintField;
    qryMainCategory: TWideStringField;
    qryMainTotalAmount: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    grpFiltersExtra: TwwRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure grpFiltersExtraClick(Sender: TObject);
  private
    FGroupExtraFilterString : string;
    FConstSQL :string;
    procedure SetTypeFilter(Sender: TObject);
    procedure SetCategoryFilter(Sender: TObject);
    procedure SetSalesTypeFilter(Sender: TObject);

  protected
    procedure RefreshQuery; override;
  public

  end;


implementation

{$R *.dfm}

uses
  AppEnvironment, ProductSalesDetails, frmProductSalesModelList;

procedure TfmProductSalesCategoryList.FormCreate(Sender: TObject);
begin
  FConstSQL := qryMain.Sql.Text;
  FGroupExtraFilterString := ' AND (S.IsInvoice = ' + QuotedStr('T') + ') ';
  QryMain.SQL.Text := StringReplace(FConstSQL, '@@GROUPFILTEREXTRA@@', FGroupExtraFilterString, [rfReplaceAll]);
  inherited;
  grpFilters.Items.Add(AppEnv.DefaultClass.FirstColumn);
  grpFilters.Items.Add(AppEnv.DefaultClass.SecondColumn);
  grpFilters.Items.Add(AppEnv.DefaultClass.ThirdColumn);
  grpFilters.ItemIndex := 0;
end;

procedure TfmProductSalesCategoryList.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('CategoryType');
end;

procedure TfmProductSalesCategoryList.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  if (sametext(ActiveFieldname , QrymainTotalAmount.fieldname) or
      sametext(ActiveFieldname , QrymainTotalAmountinc.fieldname))  then begin
     CreatenOpenERPListForm('TProductDetailsGUI' , SetTypeFilter);
   end else
   begin
     if grpFilters.ItemIndex = 0 then begin
        CreatenOpenERPListForm('TfmProductSalesModelList' , SetCategoryFilter);
     end;
   end;
end;

procedure TfmProductSalesCategoryList.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '(CategoryType = ' + IntToStr(grpFilters.ItemIndex) + ')';
  inherited;
end;

procedure TfmProductSalesCategoryList.grpFiltersExtraClick(Sender: TObject);
begin
  inherited;
  SetSalesTypeFilter(Sender);
  RefreshQuery;
end;

procedure TfmProductSalesCategoryList.SetTypeFilter(Sender: TObject);
begin
   if not(Sender is TProductDetailsGUI) then exit;
   if grpFilters.ItemIndex = 0 then
     TProductDetailsGUI(Sender).firstcolumn               := qryMain.FieldByName('Category').AsString
   else
   if grpFilters.ItemIndex = 1 then
     TProductDetailsGUI(Sender).secondcolumn               := qryMain.FieldByName('Category').AsString
   else
   if grpFilters.ItemIndex = 2 then
     TProductDetailsGUI(Sender).thirdcolumn               := qryMain.FieldByName('Category').AsString;
end;

procedure TfmProductSalesCategoryList.SetCategoryFilter(Sender: TObject);
begin
   if not(Sender is TfmProductSalesModelList) then exit;
   TfmProductSalesModelList(Sender).FilterCategory      := qryMain.FieldByName('Category').AsString;
   TfmProductSalesModelList(Sender).FGroupExtraFilterString   := FGroupExtraFilterString;
end;

procedure TfmProductSalesCategoryList.SetSalesTypeFilter(Sender: TObject);
begin
  if grpFiltersExtra.ItemIndex = 0 then
     FGroupExtraFilterString := ' AND ((S.IsSalesOrder = ' + QuotedStr('T') + ') AND (S.Converted <> ' + QuotedStr('T') + ' )) '
  else
  if grpFiltersExtra.ItemIndex = 1 then
     FGroupExtraFilterString := ' AND ((S.IsSalesOrder = ' + QuotedStr('T') + ') AND (S.Converted = ' + QuotedStr('T') + ' )) '
  else
  if grpFiltersExtra.ItemIndex = 2 then
     FGroupExtraFilterString := ' AND (S.IsSalesOrder = ' + QuotedStr('T') + ') '
  else
  if grpFiltersExtra.ItemIndex = 3 then
     FGroupExtraFilterString := ' AND (S.IsInvoice = ' + QuotedStr('T') + ') ';
end;

procedure TfmProductSalesCategoryList.RefreshQuery;
begin
  QryMain.SQL.Text := StringReplace(FConstSQL, '@@GROUPFILTEREXTRA@@', FGroupExtraFilterString, [rfReplaceAll]);
  QryMain.Parambyname('FirstDate').asDateTime := FilterdateFrom;
  QryMain.Parambyname('LastDate').asDateTime := filterDateto;
  if chkIgnoreDates.Checked then
    QryMain.Parambyname('UseDate').AsString := 'F'
  else
    QryMain.Parambyname('UseDate').AsString := 'T';
  inherited;

end;

initialization
  RegisterClass(TfmProductSalesCategoryList);

end.
