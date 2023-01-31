unit SalesAnalysisGraphDrilldownSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesAnalysisGraphDrilldown, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader;

type
  TSalesAnalysisGraphDrilldownSalesGUI = class(TSalesAnalysisGraphDrilldownGUI)
    qryMainSaleID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainsalestype: TWideStringField;
    qryMaintotalAmountinc: TFloatField;
    qryMainemployeename: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainLeadEmployeeName: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TSalesAnalysisGraphDrilldownSalesGUI.FormShow(Sender: TObject);
begin
  Qrymain.DisableControls;
  try
    if Qrymain.Active then Qrymain.Close;
    Qrymain.SQL.Clear;
    Qrymain.SQL.Add('Select');
    Qrymain.SQL.Add('S.OriginalNo,');
    Qrymain.SQL.Add('S.SaleID,');
    Qrymain.SQL.add('contacts.EmployeeName as LeadEmployeeName,');
    Qrymain.SQL.Add('S.CustomerName,');
    Qrymain.SQL.Add('S.SaleDate,');
    Qrymain.SQL.Add('if(S.IsQuote="T", "Quote" , if(S.IsSalesOrder="T", "Sales Order" , if(S.IsCashSale="T", "Cash Sale" , if(S.ISInvoice="T", "Invoice" ,"Sale" )))) as salestype,');
    Qrymain.SQL.Add('S.totalAmountinc,');
    Qrymain.SQL.Add('S.employeename');
    Qrymain.SQL.Add('from tblsales s');
    Qrymain.SQL.add('Left join ' +    contactTablename + ' contacts on contacts.ClientID = S.ClientID');
    Qrymain.SQL.Add('where S.deleted ="F" and S.cancelled ="F"');
    if IdsTofilter <> '' then Qrymain.SQL.Add(' and S.Originalno in ( ' + IdsTofilter +') ');
    Qrymain.SQL.Add('Order by Originalno desc , saleDate desc');
    inherited;
  finally
    Qrymain.EnableControls;
  end;
  lblDateComments.caption := 'This is the ''Drill down'' of the ''Sales Analysis Chart'',  Count of ' + Quotedstr(qrymainoriginalno.displaylabel)+' here reflects the count in the Chart.';
  lblDateComments.refresh;
  qrymainoriginalno.index := 0;
  guiprefs.DbGridElement[grdmain].AddField(qrymainoriginalno.fieldname);
  qrymainoriginalno.index := 0;
end;
procedure TSalesAnalysisGraphDrilldownSalesGUI.grdMainTitleButtonClick(
  Sender: TObject; AFieldName: string);
begin
  //inherited;
  if qrymainoriginalno.visible then
    TimerMsg(FilterLabel , 'Sorting on the grid is disabled as the records are grouped on ' + quotedstr(QrymainOriginalno.DisplayLabel))
  else inherited;
end;

initialization
  RegisterClassOnce(TSalesAnalysisGraphDrilldownSalesGUI);

end.

