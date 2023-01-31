unit ContractorPaymentSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, GIFImg,ContractorPaymentSummarySQL;

type
  TContractorPaymentSummaryGUI = class(TBaseListingGUI)
    qryMainPaymentType: TWideStringField;
    qryMainPaymentMethod: TWideStringField;
    qryMainIsCardPayment: TWideStringField;
    qryMainPaymentID: TIntegerField;
    qryMainPaymentDate: TDateTimeField;
    qryMainPaymentAmount: TFloatField;
    qryMainCardAmount: TFloatField;
    qryMainNonCardAmount: TFloatField;
    qryMainClientID: TIntegerField;
    qryMainSupplierPrintName: TWideStringField;
    qryMainBillStreet: TWideStringField;
    qryMainBillStreet2: TWideStringField;
    qryMainBillStreed3: TWideStringField;
    qryMainBillPlace: TWideStringField;
    qryMainBillState: TWideStringField;
    qryMainBillPostCode: TWideStringField;
    qryMainBillCountry: TWideStringField;
    qryMainBusinessNumber: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    ContractorPaymentSummary: TContractorPaymentSummary;
    procedure MakeQrymain;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, ReportTemplateBase, MySQLConst, AppEnvironment, DateUtils;

{ TContractorPaymentSummaryGUI }

procedure TContractorPaymentSummaryGUI.cmdPrintClick(Sender: TObject);
var
  sql: string;
begin
//  inherited;
  ReportToPrint := 'Contractor Payment Summary';
  sql := TReportTemplateBase.GetReportSQL(ReportToPrint);
  if sql = '' then begin
    CommonLib.MessageDlgXP_Vista('Error loading Template "' + ReportToPrint + '", Report SQL is Empty',mtInformation,[mbOk],0);
    exit;
  end;
  if (Pos('1970-01-01',sql) < 1) or (Pos('2999-01-01',sql) < 1) or
     (Pos('1970-01-02',sql) < 1) or (Pos('2999-01-02',sql) < 1) then begin
    CommonLib.MessageDlgXP_Vista('Error loading Template "' + ReportToPrint + '", Report SQL has been altered and does not contain required date Place Holders',mtInformation,[mbOk],0);
    exit;
  end;

  sql := SysUtils.StringReplace(sql,'1970-01-01',FormatDateTime(MysqlDateFormat,dtFrom.Date),[rfReplaceAll]);
  sql := SysUtils.StringReplace(sql,'2999-01-01',FormatDateTime(MysqlDateTimeFormat,(dtTo.Date + 1) - OneSecond),[rfReplaceAll]);

  ReportSQLSupplied := true;
  PrintTemplateReport(ReporttoPrint, sql, (not(Appenv.Employee.ShowPreview) and (not chkPreview.Checked)), 1, nil, '', true);
end;

procedure TContractorPaymentSummaryGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ContractorPaymentSummary := TContractorPaymentSummary.Create;
  makeQrymain;
  AddCalcColumn(qryMainPaymentAmount.FieldName, true);
  AddCalcColumn(qryMainCardAmount.FieldName, true);
  AddCalcColumn(qryMainNonCardAmount.FieldName, true);
end;

procedure TContractorPaymentSummaryGUI.MakeQrymain;
var
  msg:String;
begin
  ContractorPaymentSummary.PopulateReportSQL(qryMain.SQL, msg);
  self.RefreshOrignalSQL();
end;

procedure TContractorPaymentSummaryGUI.RefreshQuery;
begin
  qryMain.Close;
(*  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDate := 0;
    qryMain.ParamByName('DateTo').AsDate := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDate := dtFrom.Date;
    qryMain.ParamByName('DateTo').AsDate := dtTo.Date;
  end;*)
  InitDateFromnDateto;
  inherited;
end;

initialization
  RegisterClass(TContractorPaymentSummaryGUI);

end.
