unit RelatedProductSelection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs , RelatedProducts, RelatedCustomerListForm, DAScript, MyScript,
  ERPdbComponents, DB, SelectionDialog, kbmMemTable, CustomInputBox, Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, wwDialog, Wwlocate,
  ExtCtrls, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook,
  DNMSpeedButton, Shader, DNMPanel , IntegerListObj;

type
  TRelatedProductSelectionGUI = class(TRelatedProductsGUI)
    chkShowRelatedProductSelectioninSale: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkAdvancedPrintingClick(Sender: TObject);
  private
    fsSelectedProductIds: String;
    fSelectedProductIds: TIntegerlist;
    procedure setSelectedProductIds(const Value: String);

  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Property SelectedProductIds :String read fsSelectedProductIds write setSelectedProductIds;
  end;


implementation

uses AppEnvironment, CommonLib, tcConst;

{$R *.dfm}
procedure TRelatedProductSelectionGUI.chkAdvancedPrintingClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkShowRelatedProductSelectioninSale then
    Appenv.employee.ShowRelatedProductSelectioninSale :=chkShowRelatedProductSelectioninSale.Checked ;
end;

procedure TRelatedProductSelectionGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fSelectedProductIds := TIntegerlist.Create;
  SelectedProductIds := '';
end;

procedure TRelatedProductSelectionGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(fSelectedProductIds);
  inherited;
end;

procedure TRelatedProductSelectionGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  if IterateProcNo = 2 then begin
    if SelectedProductIds <> '' then begin
      if fSelectedProductIds.InList(QrymainProductID.asinteger) then
        grdmain.selectrecord;
    end;
    exit;
  end;
  inherited;
end;

procedure TRelatedProductSelectionGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  if SelectedProductIds <> '' then begin
    IterateProcNo := 2;
    IterateRecords;
  end else   inherited;

  if SelectedProductIds <> '' then
    listtimermsg('Selected Products are already added to the transaction.'+ NL +
                 'Selecting them again will not add them again.'+ NL +
                 'Selecting Product(s) that are not allready added, will be added to the Sales');
end;

procedure TRelatedProductSelectionGUI.setSelectedProductIds(const Value: String);
begin
  fsSelectedProductIds := Value;
  fSelectedProductIds.CommaText :=Value;
end;

initialization
  RegisterClassOnce(TRelatedProductSelectionGUI);

end.
