unit backorderInvoiceExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpress, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TbackorderInvoiceExpressGUI = class(TBaseListExpressGUI)
    qryMainSaleID: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainSalesOrderNumber: TWideStringField;
    qryMainBackOrder: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainUnitofMeasureSaleLines: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainLinePrice: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainTotalLinePrice: TFloatField;
    qryMainTotalLinePriceInc: TFloatField;
    qryMainRep: TWideStringField;
    qryMainclass: TWideStringField;
    btnInvoiceList: TDNMSpeedButton;
    qryMainStatus: TWideStringField;
    qryMaincomments: TWideMemoField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainPrintName: TWideStringField;
    procedure btnInvoiceListClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    Function ExpressDetailListName:String;Override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, dateutils, CommonFormLib, frmInvoice;

{$R *.dfm}
{ TbackorderInvoiceExpressGUI }

procedure TbackorderInvoiceExpressGUI.btnInvoiceListClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TInvoicelistExpressGUI');
  Self.Close;
end;

procedure TbackorderInvoiceExpressGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TInvoiceGUI' , 0);
(*Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TInvoiceGUI');
  If not Assigned(tmpComponent) then Exit;
  with TInvoiceGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;*)
end;

function TbackorderInvoiceExpressGUI.ExpressDetailListName: String;
begin
  REsult := 'TBackOrdersListGUI';
end;

procedure TbackorderInvoiceExpressGUI.RefreshQuery;
var
  ToDate, FromDate: TDateTime;
begin
  if chkIgnoreDates.Checked then begin
    ToDate   := IncYear(Now(), 1000);
    FromDate := 0;
  end else begin
    ToDate   := filterDateto;
    FromDate := FilterDateFrom;
  end;
  qryMain.Params.ParamByName('txtfrom').AsDateTime:= FromDate;
  qryMain.Params.ParamByName('txtto').AsDateTime:= ToDate;
  inherited;
end;
initialization
  RegisterClassOnce(TbackorderInvoiceExpressGUI);
end.

