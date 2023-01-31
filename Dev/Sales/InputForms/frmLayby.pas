unit frmLayby;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sales, DataState, DB, DBAccess, MyAccess, ERPdbComponents, AppEvnts,
  Wwdbgrid, DMComps, ProgressDialog, ImgList, MemDS, AdvMenus, DNMAction,
  ActnList, SelectionDialog, Menus, ExtCtrls, Shader, wwcheckbox, StdCtrls,
  wwdbdatetimepicker, DBCtrls, DNMSpeedButton, Mask, wwdbedit, ComCtrls,
  wwdblook, ERPDbLookupCombo, Buttons, Wwdbigrd, Grids, DNMPanel, BusObjPOSSale,
  CashSaleBase;

type
  TLaybyGUI = class(TCashSaleBaseGUI)
    qryLaybyPayments: TERPQuery;
    dsLaybyPayments: TDataSource;
    Label5: TLabel;
    edtTotalBalance: TDBEdit;
    qryLaybyPaymentsProductName: TWideStringField;
    qryLaybyPaymentsLinePriceInc: TFloatField;
    qryLaybyPaymentsSaleDate: TDateField;
    qryLaybyPaymentsComments: TWideMemoField;
    qryLaybyPaymentsDescription: TStringField;
    DBEdit1: TDBEdit;
    Label11: TDNMSpeedButton;
    tblMasterPaidAmount: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure qryLaybyPaymentsCommentsGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryLaybyPaymentsCalcFields(DataSet: TDataSet);
    procedure actPreviewExecute(Sender: TObject);
    procedure tblMasterCalcFields(DataSet: TDataSet);
    procedure Label11Click(Sender: TObject);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
  protected
//    LaybySale : TPOSLayby;

    procedure NewTransBusObjinstance;override;
    procedure PaymentsBeforeOpen(Sender : TObject);

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  FormFactory, commonlib, CommonFormLib, LaybyPayments, BusObjPrintDoc,
  AppEnvironment;

const
  csReport = '~|||~ where SaleId = %s union all select SL.* from tblSalesLines SL inner join tblSales S on s.GlobalRef= SL.LayById where S.SaleId=%s ' +
           '~|||~ where clientid=(Select ClientId from tblSales where saleid=%s)'+
           '~|||~ where saleid=%s';

procedure TLaybyGUI.actPreviewExecute(Sender: TObject);
var
  sSaleId : string;
begin
  CashBase.Dirty:= false;
  sSaleId := tblMasterSaleId.AsString;
  PrintTemplateReport( 'Layby Sale',
           Format(csReport, [sSaleId, sSaleId, sSaleId, sSaleId]),
           false, 1);
end;

procedure TLaybyGUI.actPrintExecute(Sender: TObject);
var
 sSaleId : string;
begin
//  fbReportSQLSupplied :=   False;
//  ReportToPrint := 'Layby Sale';
  CashBase.Dirty:= false;
  sSaleId := tblMasterSaleId.AsString;
  PrintTemplateReport( 'Layby Sale',
           Format(csReport, [sSaleId, sSaleId, sSaleId, sSaleId]),
                           not(appEnv.Employee.PreviewAllreport) and not(Devmode),1 );
//  inherited;
//
end;

procedure TLaybyGUI.FormShow(Sender: TObject);
const
  csPayments = 'select SL.ProductName, SL.LinePriceInc, S.SaleDate, S.Comments'#13#10+
               'from tblSalesLines SL'#13#10+
               'inner join tblSales S on S.SaleId=SL.SaleId'#13#10+
               'where SL.laybyid= (select Globalref from tblSales where saleid=%d)';
begin
  inherited;

  if KeyId = 0 then
    Close;  // no nothing - cannot create new

  TitleLabel.Caption := 'Layby';
  Label160.Caption := 'Sale No';
  btnNext.Enabled := false;
  btnCompleted.Enabled := false;
  btnPdf.Visible := false;

//  qryLaybyPayments.ParamByName('ID').AsInteger := KeyId;
//  qryLaybyPayments.SQL.Text := Format('select * from tblsaleslines where Laybyid= (select Globalref from tblSales where saleid=%d)', [KeyId]);
  qryLaybyPayments.SQL.Text := Format(csPayments, [KeyId]);
  qryLaybyPayments.Open;

//
end;

procedure TLaybyGUI.grdTransactionsDblClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TLaybyGUI.Label11Click(Sender: TObject);
begin
  inherited;
//
  OpenERPListForm('TLaybyPaymentsGUI', PaymentsBeforeOpen);
end;

procedure TLaybyGUI.NewTransBusObjinstance;
begin
  CashBase := TPosLayBy.Create(nil);
  inherited;
end;

procedure TLaybyGUI.PaymentsBeforeOpen(Sender: TObject);
begin
  if Sender is TLaybyPaymentsGUI  then
  begin
    (Sender as TLaybyPaymentsGUI).SaleId := tblMasterSaleId.AsInteger;
  end;

end;

procedure TLaybyGUI.qryLaybyPaymentsCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('Description').AsString := DataSet.FieldByName('Comments').AsString;
end;

procedure TLaybyGUI.qryLaybyPaymentsCommentsGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := Sender.AsString;
end;

procedure TLaybyGUI.tblMasterCalcFields(DataSet: TDataSet);
begin
  inherited;
  tblMaster.FieldByName('PaidAmount').AsFloat := tblMaster.FieldByName('TotalAmountInc').AsFloat - tblMaster.FieldByName('Balance').AsFloat;
end;

initialization
  RegisterClassOnce(TLaybyGUI);
  with FormFact do
  begin
    RegisterMe(TLaybyGUI, 'TSalesOrderListGUI_*=SaleID');
  end;
end.
