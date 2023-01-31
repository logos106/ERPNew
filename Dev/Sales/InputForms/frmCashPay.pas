unit frmCashPay;
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 ??/??/?? 1.00.01  ???  Initial Version
 19/12/05 1.00.02  AL   Removed "Instance", added RegisterClass  *Task306*
 18/09/06 1.00.03  BJ   business object introduced
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseInputForm, AppEvnts, DB,  StdCtrls, wwdblook, Grids,
  Wwdbigrd, Wwdbgrid, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton, SelectionDialog,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus , BusObjCash , Busobjbase, MemDS,
  Shader, AdvMenus, ImgList, Mask, DBCtrls, ProgressDialog;

type
  TCashPayGUI = class(TBaseInputGUI)
    qryPayMethod: TERPQuery;
    DSPaymethod: TDataSource;
    grdPayments: TwwDBGrid;
    btnOK: TDNMSpeedButton;
    grdPaymentsIButton: TwwIButton;
    lblRefund: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label142: TLabel;
    Label54: TLabel;
    txtSalesTotal: TDBEdit;
    Label1: TLabel;
    edtPaid: TEdit;
    edtbalance: TEdit;
    cboPayMethods: TwwDBLookupCombo;
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdPaymentsUpdateFooter(Sender: TObject);
    procedure grdPaymentsIButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboPayMethodsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure btnOKClick(Sender: TObject);
    procedure grdPaymentsRowChanged(Sender: TObject);
    procedure grdPaymentsColExit(Sender: TObject);
    procedure grdPaymentsDblClick(Sender: TObject);
    procedure qryPayMethodBeforeOpen(DataSet: TDataSet);
  private
    fdCalcPayments :Double;
    bIsCalcStarted: boolean;   // prevents death spiral
    fSalespayments : TSalesPayments;
    fdTotalSalesAmountinc: Double;
    fbIsRefundTrans: Boolean;
    Procedure CalcPayments(Const Sender: TBusObj; var Abort: boolean);
    Procedure CalcBalance;
    //function CalcPayments: currency;
  public
    Property Salespayments :TSalespayments Read fSalespayments Write fSalespayments;
    Property IsRefundTrans :Boolean read fbIsRefundTrans write fbIsRefundTrans;
  end;

implementation

{$R *.dfm}

uses Forms, Cash, frmRefund, CommonLib, tcConst, SystemLib;

{ TCashPayGUI }

procedure TCashPayGUI.FormPaint(Sender: TObject);
begin
  inherited;

  grdPayments.SizeLastColumn;
end;

procedure TCashPayGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    // assuming that the calling form is using business objects
    // at the moment only cashsale and refund uses it, both are using objets
    if not assigned(fSalespayments) then begin
        CommonLib.MessageDlgXP_Vista('ERP object for the sales payment is not initialised ' , mtWarning , [mbOk] , 0);
        ModalResult := mrCancel;
        Exit;
    end;

    if Owner is TRefundGUI then lblRefund.Visible := true;
    if Owner is TBaseCashGUI then begin
      grdPayments.DataSource   := TBaseCashGUI(Owner).dsPayments;
      cboPayMethods.DataSource := TBaseCashGUI(Owner).dsPayments;
      txtSalesTotal.DataSource := TBaseCashGUI(Owner).DSMaster;
      fdTotalSalesAmountinc    := TBaseCashGUI(Owner).tblMasterTotalAmountInc.asFloat;
    end;
    inherited;
    OpenQueries;
    bIsCalcStarted := false;
    edtbalance.text :=FloatToStrF(fdTotalSalesAmountinc-fdCalcPayments, ffCurrency, 15, CurrencyRoundPlaces);
    SetControlFocus(grdPayments);
    CalcBalance;
  finally
    EnableForm;
  end;   
end;
procedure TCashPayGUI.CalcBalance;
begin

end;

Procedure TCashPayGUI.CalcPayments(Const Sender: TBusObj; var Abort: boolean);
begin
    fdCalcPayments := fdCalcPayments +TSalesPayments(Sender).Amount;
end;

procedure TCashPayGUI.grdPaymentsUpdateFooter(Sender: TObject);
begin
  inherited;
  if bIsCalcStarted then exit;
  bIsCalcStarted := true;
  Try
    fdCalcPayments := 0;
    SalesPayments.IterateREcords(CalcPayments);
    //if not bIsCalcStarted then
    (*grdPayments.ColumnByName('Amount').FooterValue := FloatToStrF(fdCalcPayments, ffCurrency, 15, CurrencyRoundPlaces);*)
    edtPaid.text :=FloatToStrF(fdCalcPayments, ffCurrency, 15, CurrencyRoundPlaces);
    edtbalance.text :=FloatToStrF(fdTotalSalesAmountinc-fdCalcPayments, ffCurrency, 15, CurrencyRoundPlaces);
  Finally
    bIsCalcStarted := False;
  End;
end;

procedure TCashPayGUI.qryPayMethodBeforeOpen(DataSet: TDataSet);
begin
  inherited;
//  qryPayMethod.Parambyname('IsRefundTrans').AsString := BooleanToStr(IsRefundTrans);
end;

procedure TCashPayGUI.grdPaymentsColExit(Sender: TObject);
begin
  inherited;
  CalcBalance;
end;

procedure TCashPayGUI.grdPaymentsDblClick(Sender: TObject);
begin
  inherited;
  if sametext(grdPayments.getactivefield.fieldname, 'amount') then
    if SalesPayments.amount = 0 then begin
      SalesPayments.amount := fdTotalSalesAmountinc-fdCalcPayments;
      SalesPayments.PostDB;
    end;
end;

procedure TCashPayGUI.grdPaymentsIButtonClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      Salespayments.Deleted := True;
      Salespayments.PostDB;
    except
      {Do nothing - raise a silent exception}
    end;
  end;
end;

procedure TCashPayGUI.grdPaymentsRowChanged(Sender: TObject);
begin
  inherited;
  CalcBalance;
end;

procedure TCashPayGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;
  fSalespayments := nil;
  fdTotalSalesAmountinc := 0;
  IsRefundTrans:= False;
end;

procedure TCashPayGUI.cboPayMethodsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  inherited;
  NotInListWarning(Sender);
  Accept := false;
end;

procedure TCashPayGUI.btnOKClick(Sender: TObject);
begin
  inherited;
  if Assigned(Salespayments) then if not Salespayments.Save then Exit;
  ModalResult := mrOK;
end;

Initialization
  RegisterClassOnce(TCashPayGUI);

end.
