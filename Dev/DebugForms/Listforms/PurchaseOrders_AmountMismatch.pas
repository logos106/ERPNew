unit PurchaseOrders_AmountMismatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, kbmMemTable,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox;

type
  TPurchaseOrders_AmountMismatchGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderID: TIntegerField;
    qryMainType: TWideStringField;
    qryMainTotalAmount: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainTotalLineAmount: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    qryMainLineTax: TFloatField;
    qryMainExInvalid: TFloatField;
    qryMainIncInvalid: TFloatField;
    qryMainTaxInvalid: TFloatField;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PurchaseOrders_AmountMismatchGUI: TPurchaseOrders_AmountMismatchGUI;

implementation

uses CommonLib;

{$R *.dfm}

procedure TPurchaseOrders_AmountMismatchGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainExInvalid.asFloat :=   Round(abs((qryMainTotalAmount.asfloat - qryMainTotalLineAmount.asFloat)),0) ;
  qryMainIncInvalid.asFloat :=   Round(abs((qryMainTotalAmountInc.asfloat - qryMainTotalLineAmountInc.asFloat)),0) ;
  qryMainTaxInvalid.asFloat :=   Round(abs((qryMainTotalTax.asfloat - qryMainLineTax.asFloat)),0) ;
end;

procedure TPurchaseOrders_AmountMismatchGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if (qryMainExInvalid.asFloat>0) or
      (qryMainIncInvalid.asFloat>0) or
      (qryMainTaxInvalid.asFloat>0)  then AFont.Color := clred;
end;

procedure TPurchaseOrders_AmountMismatchGUI.FormShow(Sender: TObject);
begin
  inherited;
  Qrymain.filter :=
        '((qryMainTotalAmount.asfloat - qryMainTotalLineAmount.asFloat) <> 0) or' +
        ' ((qryMainTotalAmountInc.asfloat - qryMainTotalLineAmountInc.asFloat) <>0) or' +
        ' ((qryMainTotalTax.asfloat - qryMainLineTax.asFloat) <>0)';
  Qrymain.filtered :=True;  
end;

initialization
  RegisterClassOnce(TPurchaseOrders_AmountMismatchGUI);
end.
