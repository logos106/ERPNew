unit frmProductSalesModelList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg, CommonformLib;

type
  TfmProductSalesModelList = class(TBaseListingGUI)
    qryMainCategoryType: TLargeintField;
    qryMainCategory: TWideStringField;
    qryMainTotalAmount: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FConstSQL : string;
    procedure SetTypeFilter(Sender: TObject);
  protected
      procedure RefreshQuery; override;
  public
    { Public declarations }
    FilterCategory : string;
    FGroupExtraFilterString : string;
  end;



implementation

{$R *.dfm}

uses
  AppEnvironment, ProductSalesDetails;


procedure TfmProductSalesModelList.FormCreate(Sender: TObject);
begin
  FConstSQL := qryMain.SQL.Text;
  If FGroupExtraFilterString = '' then
    FGroupExtraFilterString := ' AND (S.IsInvoice = ' + QuotedStr('T') + ') ';
  qryMain.SQL.Text := StringReplace(FConstSQL, '@@GROUPFILTEREXTRA@@', FGroupExtraFilterString, [rfReplaceAll]);
  inherited;
end;

procedure TfmProductSalesModelList.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('CategoryType');
  Caption := Caption + ' - ' + FilterCategory;
end;


procedure TfmProductSalesModelList.grdMainDblClick(Sender: TObject);
begin
  if (sametext(ActiveFieldname , QrymainTotalAmount.fieldname) or
      sametext(ActiveFieldname , QrymainTotalAmountinc.fieldname))  then begin
     CreatenOpenERPListForm('TProductDetailsGUI' , SetTypeFilter);
   end;
end;

procedure TfmProductSalesModelList.SetTypeFilter(Sender: TObject);
begin
   if not(Sender is TProductDetailsGUI) then exit;
   TProductDetailsGUI(Sender).secondcolumn               := qryMain.FieldByName('Category').AsString;
end;

procedure TfmProductSalesModelList.RefreshQuery;
begin
  If FGroupExtraFilterString = '' then
    FGroupExtraFilterString := ' AND (S.IsInvoice = ' + QuotedStr('T') + ') ';
  qryMain.SQL.Text := StringReplace(FConstSQL, '@@GROUPFILTEREXTRA@@', FGroupExtraFilterString, [rfReplaceAll]);

  QryMain.Parambyname('FirstDate').asDateTime := FilterdateFrom;
  QryMain.Parambyname('LastDate').asDateTime := filterDateto;
  QryMain.Parambyname('Category').AsString := FilterCategory;
  if chkIgnoreDates.Checked then
    QryMain.Parambyname('UseDate').AsString := 'F'
  else
    QryMain.Parambyname('UseDate').AsString := 'T';
  inherited;

end;

initialization
  RegisterClass(TfmProductSalesModelList);

end.
