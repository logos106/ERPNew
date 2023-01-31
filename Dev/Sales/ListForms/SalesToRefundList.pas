unit SalesToRefundList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesToRefundListGUI = class(TBaseListingGUI)
    qryMainSaleno: TWideStringField;
    qryMainSaleId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmountinc: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainSaleDate: TDateField;
    qryMainType: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainshipdate: TDateField;
    qryMainheld: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainterms: TWideStringField;
    qryMainComments: TWideMemoField;
    qryMainClientID: TIntegerField;
    qryMainPrintName: TWideStringField;
    qryMainIsPOS: TWideStringField;
    qryMainIsCashSale: TWideStringField;
    qryMainIsInvoice: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
  private
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TSalesToRefundListGUI }

procedure TSalesToRefundListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainType.AsString;
  inherited;
end;

procedure TSalesToRefundListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('DateFrom').AsDateTime := FilterDateFrom;
  Qrymain.ParamByName('Dateto').AsDateTime := FilterDateTo;
  inherited;
end;

procedure TSalesToRefundListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainclientID.FieldName);
end;

initialization
  RegisterClassOnce(TSalesToRefundListGUI);

end.

