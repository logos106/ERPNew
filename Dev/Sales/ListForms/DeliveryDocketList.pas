unit DeliveryDocketList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesPrintDocList, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TDeliveryDocketListGUI = class(TSalesPrintDocListGUI)
    chkHide: TCheckBox;
    qryMainNoOfBoxes: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure chkHideClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
  private
    saleshasBOID:boolean;
    MsgOption:Boolean;
    TemplateName:String;
    IterateNo:Integer;
    function AnysaleshasBOID: Boolean;
    procedure Printdeldocket;
    procedure PrintAddressLabel;

  public
    procedure IterateselectedRecordsCallback(var abort: Boolean;SelIndex:Integer);Override;
  end;

implementation

uses AppEnvironment, tcTypes, CommonLib, BusObjSales, BusobjCash,
  BusObjPrintDoc, saleslib, tcDataUtils;

{$R *.dfm}
Function TDeliveryDocketListGUI.AnysaleshasBOID:Boolean;
begin
  saleshasBOID:= False;
  IterateNo:=1;
  try
    IterateRecords(False,'');
  finally
    IterateNo:=0;
  end;
  result := saleshasBOID;
end;
procedure TDeliveryDocketListGUI.IterateselectedRecordsCallback(var abort: Boolean;SelIndex:Integer);
begin
  inherited;
  if IterateNo = 1 then begin
    if QrymainBOID.asString <> '' then begin
      saleshasBOID:= True;
      Abort:= True;
    end;
  end else if IterateNo=2 then begin
    printDeldocket;
    if PrintTemplate.CancelPreviewAll then abort := True;
  end;
end;
procedure TDeliveryDocketListGUI.PrintClick(Sender: TObject);
begin
  inherited;

  if grdMain.SelectedList.Count = 0 then Exit;

  MsgOption := False;
  if AnysaleshasBOID then
    if (AppEnv.CompanyPrefs.ExcludeBOFromPrintinSales)  then
      MsgOption := MessageDlgXP_Vista('Do You Wish to Exclude the Back Ordered Items From Print?' , mtConfirmation , [mbyes, mbno] , 0 ) = mryes ;

  TemplateName := tcdatautils.GetDefaultReport(29);
  PrintTemplate.CancelPreviewAll:= False;
  IterateNo:= 2;
  try
    IterateSelectedrecords(true, 'Printing Del dockets');
  finally
    IterateNo:= 0;
  end;
end;

Procedure TDeliveryDocketListGUI.Printdeldocket;
var
  templname:string;
  sSQL:String;
begin
  templname:=TemplateName;
  if  templname = '' then
    //if (QrymainHoldSale.asBoolean) then templname := 'Delivery Docket Held' else templname := 'Delivery Docket';
    templname := DeliverydocketTemplateForSale(QrymainsaleId.asInteger);

             if QrymainIsInvoice.asBoolean    then begin if PrintDoc.PrintDoc(TInvoice.ClassName    , QrymainsaleId.asInteger, dtDelDock, Self.Classname,PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview) , templname )<=0 then exit;
    end else if QrymainIsSalesOrder.asBoolean then begin if PrintDoc.PrintDoc(TSalesOrder.ClassName , QrymainsaleId.asInteger, dtDelDock, Self.Classname,PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview),templname )<=0 then exit;
    end else if QrymainIsCashSale.asBoolean   then begin if PrintDoc.PrintDoc(TCashSale.ClassName   , QrymainsaleId.asInteger, dtDelDock, Self.Classname,PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview),templname )<=0 then exit;
    end else begin if PrintDoc.PrintDoc(TSales.Classname , QrymainsaleId.asInteger, dtDelDock, Self.Classname ,PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview), templname)<=0 then exit;
    end;

    sSQL :=  ' AND d2.SaleID = ' +IntToStr(QrymainSaleID.asInteger);
    if MsgOption then SSQL := SSQL + ' AND ifnull(d3.shipped,0) <> 0 ';
    ReportSQLSupplied := False;
    PrintTemplateReport(templname, sSQL, not(Appenv.Employee.ShowPreview) and not(devmode), 1, nil, '', true);
    if (Appenv.CompanyPrefs.PrintAddressLabelfromDelPrint) and (Appenv.Employee.PrintAddressLabelfromDelPrint) then
       PrintAddressLabel;
end;
procedure TDeliveryDocketListGUI.PrintAddressLabel;
begin
  if QrymainNoOfBoxes.asInteger = 0 then Exit;
  (*strSQL := '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, ' + ' CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,  ' +
            ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO ' +
            ' ~|||~{Details}' + AddressLabelSQL;*)
  ReportSQLSupplied := true;
  try
    PrintTemplateReport('Address Labels', SalesAddressLabelSQL(QrymainNoOfBoxes.asInteger, QrymainSaleID.AsInteger), not(Appenv.Employee.ShowPreview) and not(devmode), 1);
  finally
    ReportSQLSupplied := False;
  end;
end;

procedure TDeliveryDocketListGUI.chkHideClick(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = chkHide then begin
    Appenv.Employee.PrintAddressLabelfromDelPrint := not(chkHide.checked);
  end;
end;

procedure TDeliveryDocketListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryMain.Params.ParamByName('Doctype').asString := DoctypetoString(dtDelDock);
  qryLookupformname.Params.ParamByName('Doctype').asString := DoctypetoString(dtDelDock);
end;

procedure TDeliveryDocketListGUI.FormShow(Sender: TObject);
begin
  inherited;
  //chkHide.visible := (Appenv.CompanyPrefs.PrintAddressLabelfromDelPrint) and (Appenv.Employee.PrintAddressLabelfromDelPrint);
  chkHide.Checked := not((Appenv.CompanyPrefs.PrintAddressLabelfromDelPrint) and (Appenv.Employee.PrintAddressLabelfromDelPrint));
end;

procedure TDeliveryDocketListGUI.grdMainDblClick(Sender: TObject);
begin
  MessageDlgXP_Vista('This Will Not Update The List.'#13#10'Use "Print Del Docket" Button At The Bottom Of The Form',
                     mtWarning, [mbOk], 0);
  inherited;

end;

initialization
  RegisterClassOnce(TDeliveryDocketListGUI);

end.
