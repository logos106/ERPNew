unit PickingSlipList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesPrintDocList, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPickingSlipListGUI = class(TSalesPrintDocListGUI)
    procedure FormCreate(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
  private
    TemplateName:String;
  Protected
    procedure IterateselectedRecordsCallback(var abort: Boolean;SelIndex:Integer);Override;
  public
    { Public declarations }
  end;


implementation

uses tcTypes, BusObjPrintDoc, {frmPrintPickingSlips,} CommonLib, BusObjSales,
  BusobjCash, AppEnvironment, tcDataUtils, JSONObject, PrintPickingSlipsLib;

{$R *.dfm}

procedure TPickingSlipListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryMain.Params.ParamByName('Doctype').asString := DoctypetoString(dtPickSlip);
  qryLookupformname.Params.ParamByName('Doctype').asString := DoctypetoString(dtPickSlip);
end;


procedure TPickingSlipListGUI.PrintClick(Sender: TObject);
begin
    TemplateName := tcdatautils.GetDefaultReport(30);
    if TemplateName = '' then TemplateName := 'Picking Slip';
    IterateSelectedrecords(False);
end;

procedure TPickingSlipListGUI.grdMainDblClick(Sender: TObject);
begin
  MessageDlgXP_Vista('This Will Not Update The List.'#13#10'Use "Print Picking Slip" Button At The Bottom Of The Form',
                     mtWarning, [mbOk], 0);
  inherited;
end;

procedure TPickingSlipListGUI.IterateselectedRecordsCallback(var abort: Boolean;SelIndex:Integer);
var
  ssql:String;
  Json: TJsonObject;
begin
    sSQL := PrintPickingSlipsLib.SQL4PickingSlipreport(TemplateName, json, inttoStr(QrymainSaleId.asInteger));
    ReportSQLSupplied := true;
    PrintTemplateReport(TemplateName, sSQL, not(AppEnv.Employee.ShowPreview), 1, json);
    ReportSQLSupplied := false;
             if QrymainIsInvoice.asBoolean    then begin if PrintDoc.PrintDoc(TInvoice.ClassName    , QrymainsaleId.asInteger, dtPickSlip, Self.Classname,PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview),TemplateName )<=0 then exit;
    end else if QrymainIsSalesOrder.asBoolean then begin if PrintDoc.PrintDoc(TSalesOrder.ClassName , QrymainsaleId.asInteger, dtPickSlip, Self.Classname,PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview),TemplateName )<=0 then exit;
    end else if QrymainIsCashSale.asBoolean   then begin if PrintDoc.PrintDoc(TCashSale.ClassName   , QrymainsaleId.asInteger, dtPickSlip, Self.Classname,PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview),TemplateName )<=0 then exit;
    end else begin if PrintDoc.PrintDoc(TSales.Classname , QrymainsaleId.asInteger, dtPickSlip, Self.Classname ,PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview),TemplateName)<=0 then exit;
    end;
end;

initialization
  RegisterClassOnce(TPickingSlipListGUI);
end.
