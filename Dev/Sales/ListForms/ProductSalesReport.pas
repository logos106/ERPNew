unit ProductSalesReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductSalesReportGUI = class(TBaseListingGUI)
    qryMainDocNumber: TWideStringField;
    qryMainShipdate: TDateField;
    qryMaincustomername: TWideStringField;
    qryMainShiptoName: TWideStringField;
    qryMainShipToAddress1: TWideStringField;
    qryMainShipToAddress2: TWideStringField;
    qryMainShipToAddress3: TWideStringField;
    qryMainShipToCity: TWideStringField;
    qryMainShipToState: TWideStringField;
    qryMainShipToPostCode: TWideStringField;
    qryMainShipttoemail: TWideStringField;
    qryMainShiptophone: TWideStringField;
    qryMainSalestatus: TWideStringField;
    qryMainRushorder: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainPartbarcode: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainQtyshipped: TFloatField;
    qryMainSpecialInstruction: TWideStringField;
    qryMainQtySold: TFloatField;
    qryMainTransactionType: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainSaleLineID: TIntegerField;
    qryMaincomments: TWideMemoField;
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;

  private
    function MainSQL: String;
    function ReportInfo: String;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, MySQLConst;

{$R *.dfm}
{ TProductSalesReportGUI }
function TProductSalesReportGUI.ReportInfo:String;
begin
  if (Qrymain.filter <> '') and (Qrymain.Filtered) then
    result := quotedstr('Extra Filter Applied : ' + Qrymain.filter ) +' as ReportFilter'
  else result := Quotedstr('') +' as ReportFilter';

  result :=replacestr(result,']','');
  result :=replacestr(result,'[','');
  result :=replacestr(result,'((' , '(');
  result :=replacestr(result , '))' , ')');

  Result := 'Select ' +Quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,FilterDateFrom )) +' as Datefrom , ' +
            Quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,FilterDateTo )) +' as Dateto , '  + result;
end;
procedure TProductSalesReportGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + Qrymain.FieldByName('TransactionType').AsString;
  inherited;

end;

function TProductSalesReportGUI.MainSQL:String;
begin
  Result := Qrymain.sql.Text;
  result := replacestr(Result  , ':Datefrom' , Quotedstr(formatDateTime(MysqlDateTimeFormat ,FilterDateFrom )));
  result := replacestr(Result  , ':DateTo' , Quotedstr(formatDateTime(MysqlDateTimeFormat ,FilterDateTo )));
  if (Qrymain.filter <> '') and (Qrymain.Filtered) then
    result := replacestr(Result  , 'order by ' , ' having ' + replacestr(replacestr(Qrymain.filter,']',''),'[','') +' order by  ');
end;
procedure TProductSalesReportGUI.cmdPrintClick(Sender: TObject);
begin
  //inherited;
  ReportSQLSupplied:= true;
  PrintTemplateReport('Product Sales Report' , '{compInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, ' +
                                               'CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO' +
                                               '~|||~{details}' +mainSQL +
                                               '~|||~{ReportInfo}'+ ReportInfo , False , 1);
end;

procedure TProductSalesReportGUI.RefreshQuery;
begin
  Qrymain.ParamByName('DateFrom').AsDatetime := FilterDateFrom;
  Qrymain.ParamByName('DateTo').AsDatetime := FilterDateTo;
  inherited;
end;

procedure TProductSalesReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainSaleLineId.fieldname);
end;

initialization
  RegisterClassOnce(TProductSalesReportGUI);

end.

