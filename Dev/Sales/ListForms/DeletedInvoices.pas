unit DeletedInvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup;

type
  TfrmDeletedInvoicesListGUI = class(TBaseListingGUI)
    btnInvoiceList: TDNMSpeedButton;
    qryMainSaleDate: TDateField;
    qryMainType: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainGlobal: TWideStringField;
    qryMainOriginal: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainConsignmentNote: TWideStringField;
    qryMainPOSMemo: TWideStringField;
    qryMainPickingMemo: TWideMemoField;
    qryMainClassName: TWideStringField;
    qryMainTerms: TWideStringField;
    qryMainHeld: TWideStringField;
    qryMainConvertFromQuote: TWideStringField;
    qryMainConvertFromSO: TWideStringField;
    qryMainComments: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainShipDate: TDateField;
    qryMainPaid: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure btnInvoiceListClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    procedure RefreshQuery; override;
  end;

implementation

uses
  Forms, frmInvoice, InvoiceListForm, CommonLib, BusObjSaleBase, SalesConst;
   
{$R *.dfm}

{ TfrmDeletedInvoicesListGUI }

procedure TfrmDeletedInvoicesListGUI.RefreshQuery;
begin
  fbIgnoreQuerySpeed := false;
  qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;

  inherited;
end;

procedure TfrmDeletedInvoicesListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  inherited;
end;

procedure TfrmDeletedInvoicesListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('Sale Date') + ' DESC CIS ; ' + QuotedStr('SaleID') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('SaleID') + ' DESC CIS';
end;

procedure TfrmDeletedInvoicesListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
  if SameText(qryMain.FieldByName('Type').AsString,'Cash Sale') then begin
    case TSalesBase.GetSaleType(qryMain.FieldByName('SaleID').AsInteger) of
      stPOS,
      stPOSLayby,
      stPOSLaybyPayment,
      stPOSCashSale: SubsequentID := Chr(95) + 'POS';
    end;
  end;
  inherited;
end;

procedure TfrmDeletedInvoicesListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TInvoiceGUI');
  If not Assigned(tmpComponent) then Exit;
  with TInvoiceGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TfrmDeletedInvoicesListGUI.btnInvoiceListClick(Sender: TObject);
var
  InvoiceList: TInvoiceListGUI;
begin
  inherited;
  InvoiceList := TInvoiceListGUI(GetComponentByClassName('TInvoiceListGUI'));
  if Assigned(InvoiceList) then begin
    InvoiceList.FormStyle := fsMDIChild;
    InvoiceList.BringToFront;
    Close;
  end;
end;

initialization
  RegisterClassOnce(TfrmDeletedInvoicesListGUI);
end.
