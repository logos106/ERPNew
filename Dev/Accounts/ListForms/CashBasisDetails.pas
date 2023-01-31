unit CashBasisDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCashBasisDetailsGUI = class(TBaseListingGUI)
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
    fDateTo: TDateTime;
    fDateFrom: TDateTime;
    fWhereString: string;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }
    property ToDate: TDateTime read fDateTo write fDateTo;
    property FromDate: TDateTime read fDateFrom write fDateFrom;
    property WhereString: string read fWhereString write fWhereString;
  end;


implementation

uses FastFuncs,CashBasis, PayCommon, CommonLib, BusObjSaleBase, SalesConst;

{$R *.dfm}

procedure TCashBasisDetailsGUI.RefreshQuery;
begin
  closedb(qryMain);
  qryMain.SQL.clear;
  qryMain.SQL.add('Select ');
  qryMain.SQL.add('T.Date, ');
  qryMain.SQL.add('T.CashType, ');
  qryMain.SQL.add('T.PaymentID as PaymentNo, ');
  qryMain.SQL.add('T.TransType, ');
  qryMain.SQL.add('If(SaleID=0,PurchaseOrderID,SaleID) as TransNo,  ');
  qryMain.SQL.add('T.TransDate,  ');
  qryMain.SQL.add('T.Taxcode,  ');
  qryMain.SQL.add('T.OriginalAmount, ');
  qryMain.SQL.add('T.TaxableAmountEx,  ');
  qryMain.SQL.add('T.TaxableAmountInc, ');
  qryMain.SQL.add('T.TaxAmount,  ');
  qryMain.SQL.add('T.PaymentID, ');
  qryMain.SQL.add('T.ClassID, ');
  qryMain.SQL.add('T.SaleID, ');
  qryMain.SQL.add('T.PurchaseOrderID  ');

  if Sysutils.SameText(Self.Owner.ClassName, 'TTaxSummaryReportGUI') then begin
    qryMain.SQL.aDD('From ' + CashBasis.CashBasisReturnTempTableName('TaxSummary')+' AS T');
  (* end else if Sysutils.SameText(Self.Owner.ClassName, 'TBASReportGUI') then begin *)
  end else if Sysutils.SameText(Self.Owner.ClassName, 'TfmBASReturn') then begin
    qryMain.SQL.aDD('From ' + CashBasis.CashBasisReturnTempTableName('BAS')+' AS T');
  end else if Sysutils.SameText(Self.Owner.ClassName, 'TfmNZReturn') then begin
    qryMain.SQL.aDD('From ' + CashBasis.CashBasisReturnTempTableName('BAS')+' AS T');
  end else if Sysutils.SameText(Self.Owner.ClassName, 'TfmVATReturn') then begin
    qryMain.SQL.aDD('From ' + CashBasis.CashBasisReturnTempTableName('VAT')+' AS T');
  end;

  if not Empty(fWhereString) then begin
    qryMain.SQL.aDD( ' Where ' + fWhereString);
  end;
  RefreshOrignalSQL;
  inherited;
  TFloatField(qryMain.FieldByName('OriginalAmount')).currency := true;
  TFloatField(qryMain.FieldByName('TaxableAmountEx')).currency := true;
  TFloatField(qryMain.FieldByName('TaxableAmountInc')).currency := true;
  TFloatField(qryMain.FieldByName('TaxAmount')).currency := true;
end;

procedure TCashBasisDetailsGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  AddCalccolumn('TaxAmount', true);
  AddCalccolumn('TaxableAmountEx', true);
  AddCalccolumn('TaxableAmountInc', true);
end;

procedure TCashBasisDetailsGUI.RefreshTotals;
begin
    CalcnShowFooter;
(*  grdMain.ColumnByName('TaxAmount').FooterValue := FloatToStrF(SumField(qryMain, 'TaxAmount'), ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('TaxableAmountEx').FooterValue := FloatToStrF(SumField(qryMain, 'TaxableAmountEx'), ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('TaxableAmountInc').FooterValue := FloatToStrF(SumField(qryMain, 'TaxableAmountInc'),
    ffCurrency, 15, CurrencyRoundPlaces);*)
end;

procedure TCashBasisDetailsGUI.grdMainDblClick(Sender: TObject);
begin
  if (grdMain.GetActiveField.FieldName = 'TransType') then begin
    SubsequentID := Chr(95) + qryMain.FieldByName('TransType').AsString;
    if SameText(qryMain.FieldByName('TransType').AsString,'Cash Sale') then begin
      case TSalesBase.GetSaleType(qryMain.FieldByName('SaleID').AsInteger) of
        stPOS,
        stPOSLayby,
        stPOSLaybyPayment,
        stPOSCashSale: SubsequentID := Chr(95) + 'POS';
      end;
    end;
  end else begin
    SubsequentID := Chr(95) + qryMain.FieldByName('CashType').AsString;
    if SameText(qryMain.FieldByName('CashType').AsString,'Cash Sale') then begin
      case TSalesBase.GetSaleType(qryMain.FieldByName('SaleID').AsInteger) of
        stPOS,
        stPOSLayby,
        stPOSLaybyPayment,
        stPOSCashSale: SubsequentID := Chr(95) + 'POS';
      end;
    end;
  end;
  inherited;
end;

procedure TCashBasisDetailsGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  inherited;

end;

procedure TCashBasisDetailsGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TCashBasisDetailsGUI);

end.
