unit frmSalesPrnBase;
{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 25/05/05  1.00.01 BJ   'Raise exception' is changed to MessageDlg for user messages
 07/09/05  1.00.02 DSP  Added a 'Class' field to the grid.
 14/09/05  1.00.03 IJB  Changed creation/free of qryUpdate query in
                        btnPreviewPrintClick to prevent Access Violations.
 19/10/05  1.00.04 DLS  Added RegisterClass
 20/02/06  1.00.05 DSP  Added password to email authentication.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, AppEvnts, DB,
   Grids, Wwdbigrd, Wwdbgrid, DNMPanel, SelectionDialog, Buttons, DNMSpeedButton, Menus, AdvMenus,
  ImgList, ActnList, {Psock,} DBAccess, MyAccess,ERPdbComponents, DataState, KbmMemTable,
  EmailUtils, BusObjPrintDoc, MemDS,  BusObjBase, Shader, dmGUIStylers,
  XMLDoc, XMLIntf, busobjsales, BaseInputForm,  ProgressDialog,
  wwDialog, Wwlocate, PrintDAT, wwdbdatetimepicker, wwdblook, DAScript, MyScript,
  wwcheckbox, CustomInputBox, frmReportingOptions, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
 TSaleIds = record
    SaleIds: String;
    CustomerID: Integer;
    CustomerName: string;
    EmailAddress :String;
    XMLFileName :String;
    FTPAddress: string;
    FTPUserName: string;
    FTPPassword: string;
  end;


  TSalesPrnBaseGUI = class(TBaseListingGUI)
    QrymainSaleID: TAutoIncField;
    QrymainInvoiceDocNumber: TWideStringField;
    QrymainCustomerName: TWideStringField;
    QrymainSaleDate: TDateField;
    QrymainPrintFlag: TWideStringField;
    QrymainClientID: TIntegerField;
    QrymainEditedFlag: TWideStringField;
    QrymainGlobalRef: TWideStringField;
    QrymainTypeName: TWideStringField;
    QrymainClass: TWideStringField;
    QrymainSendXMLInvoices: TWideStringField;
    QrymainEmailXML: TWideStringField;
    QrymainBOID: TWideStringField;
    QrymainPrintedBy: TWideStringField;
    btnSelect: TDNMSpeedButton;
    chkEmail: TCheckBox;
    chkFax: TCheckBox;
    Label6: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    chkPrintAsOnedocument: TCheckBox;
    Label5: TLabel;
    Bevel3: TBevel;
    lblFilterOption: TLabel;
    grpFilterOptions: TRadioGroup;
    qryMainShipDate: TDateField;
    qryMainconverted: TWideStringField;
    qryMainEmailFlag: TWideStringField;
    qryMainEmailedBy: TWideStringField;
    DNMPanel2: TDNMPanel;
    Label8: TLabel;
    chkPrintfilter: TwwCheckBox;
    qryMainFTPAddress: TWideStringField;
    qryMainFTPUserName: TWideStringField;
    qryMainFTPPassword: TWideStringField;
    btnImport: TDNMSpeedButton;
    procedure btnSelectClick(Sender: TObject);
    procedure LoadTemplate(const SaleIDs:String; const  ClientID: integer; const bPrint, bSave: boolean;
      const DoClose: boolean = true; const FileName: string = '');
      reintroduce;
    procedure cmdPrintClick(Sender: TObject);
    procedure chkPreviewClick(Sender: TObject);
    procedure chkPrintAsOnedocumentClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grpFilterOptionsClick(Sender: TObject);
    procedure chkPrintfilterClick(Sender: TObject);
    procedure btnEmailXMLClick(Sender: TObject);
    procedure btnFTPXMLClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);

  private
    { Private declarations }
    fsReportName: string;
    fsFax: boolean;
    PrintOK: Boolean;

    fPrintDoc :TBusObjPrintDoc;
    Doc             : IXMLDocument;
    HeaderNode: IXMLNode;
    CurNode         : IXMLNode;
    SaleIDs :Array of TSaleIds;
    fOptsForm: TfmReportingOptions;
    fSavedSilent: boolean;
    function EmailSale(const SaleID: integer; IsFirst: boolean = true):Boolean;
    function Faxsale(const SaleID: integer):Boolean;
    procedure SaveXML(Const Sender: TBusObj;  var Abort: Boolean);
    procedure CreateHeader;
    Procedure EMailXML;
    function SelectedclientID:Integer;
    Procedure DocSalesPrinted(const Previewed:Boolean);
    Function PrintAsOnedcument(selclientID:Integer; DoPrint:boolean):Boolean ;
//    function QrymainSQL: string;
    procedure FTPXML;
    function getOptsForm: TfmReportingOptions;
    function EMailMessageText(asaleID:Integer) :String;Overload;
  protected
    PrintCount: integer;
    continuousreportname:String;
    function getReportType: String;virtual;
    function getDocumentName: string;Virtual;
    Procedure RefreshReportstoPrint;Virtual;
    function getSalesObj: TSales;Virtual;Abstract;
    Procedure PrintExtraReports(Sender:TObject);Virtual;
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Procedure ExtrgrpFilters;Virtual;
    Procedure PrintSelectedTrans(Sender:TObject; selclientID: Integer; IsFirst: boolean = true); virtual;

    procedure DoExtraPrintOptions; virtual;
    procedure DoAutoSend;
    procedure DoExport;
    procedure DoEmailXML;
    procedure DoFTPXML;
    procedure DoEmailJson;
    procedure DoImportListJson;

    property OptsForm: TfmReportingOptions read getOptsForm write fOptsForm;
    function EMailMessageText(asaleID:Integer;sl:TStringlist): String;Overload;Virtual;
    Procedure initchkShowEmailOptions;Override;

  public
    Property ReportType :String read getReportType;
    Property DocumentName:string read getDocumentName;
    Property SalesObj :TSales read getSalesObj;
    procedure RefreshQuery;Override;
  end;

implementation

uses FastFuncs, DnMLib,  CommonDbLib, FaxObj, DNMExceptions,
  BusObjConst, tcDataUtils,AppEnvironment, Commonlib,systemlib,
  MySQLConst, tcTypes, dateutils, frmInvoicesPrn, tcConst, IdFTP, URLObj,
  SalesXMLUtils, CorrespondenceObj, frmSalesOrderPrn, BusObjClient,
  ObjectSerialiser, JsonObject, JsonObjectUtils, BusObjCash, IntegerListObj,
  BusObjSaleBase, DbSharedObjectsObj, MemoDialog, EmailExtraUtils, SalesConst,
  TemplateReportsLib;

const
  HIGHLIGHTLOCATEDEF = $00DFFFFE; // a very light yellow rw

{$R *.dfm}


procedure TSalesPrnBaseGUI.grpFilterOptionsClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TSalesPrnBaseGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('PrintOptions') then begin
    chkPreview.checked  := StrToboolean(GuiPrefs.Node['PrintOptions.ShowPreview'].AsString);
    chkEmail.checked    := StrToboolean(GuiPrefs.Node['PrintOptions.SendEmail'].AsString);
    chkfax.checked      := StrToboolean(GuiPrefs.Node['PrintOptions.SendFax'].AsString);
    chkPrintAsOnedocument.checked := StrToboolean(GuiPrefs.Node['PrintOptions.PrintAsOneDocument'].AsString);
    if not(chkPreview.checked) and not(chkEmail.checked ) and not(chkfax.checked) then chkPreview.checked:= True;//atleast one has to be selectd
    chkPrintfilter.checked  := StrToboolean(GuiPrefs.Node['PrintOptions.PrintFromanywhere'].AsString);
  end;
end;

procedure TSalesPrnBaseGUI.RefreshQuery;
begin
  Processingcursor(True);
  try
    closeDb(Qrymain);
    InitDateFromnDateto('xFrom' ,'xTo');
    if chkPrintfilter.Checked then Qrymain.Params.ParamByName('PrintedFromAnyForm').asString  := 'T' else Qrymain.Params.ParamByName('PrintedFromAnyForm').asString  := 'F';
    Qrymain.Params.ParamByName('FilterOption').asInteger := grpFilterOptions.itemindex;
    inherited;
  finally
    Processingcursor(False);
  end;
end;


procedure TSalesPrnBaseGUI.RefreshReportstoPrint;
begin

end;

function TSalesPrnBaseGUI.getDocumentName: string;
begin

end;

function TSalesPrnBaseGUI.getOptsForm: TfmReportingOptions;
begin
  if not assigned(fOptsForm) then
    fOptsForm := TfmReportingOptions.Create(Self);
  Result := fOptsForm;
end;

procedure TSalesPrnBaseGUI.btnEmailXMLClick(Sender: TObject);
var
  i: integer;
  ctr,fCtr:Integer;
  FFlag :Boolean;
  CustomersWithoutXMLEmail: string;
begin
  inherited;
  DisableForm;
  try
    CustomersWithoutXMLEmail := '';
    if Qrymain.RecordCount = 0 then Exit;
    Setlength(SaleIDs , 0);
    try
      Qrymain.DisableControls;
      if GrdMain.SelectedList.Count = 0 then Exit;
        for i := 0 to GrdMain.SelectedList.Count - 1 do begin
          if not Qrymain.BookmarkValid(GrdMain.SelectedList.Items[i]) then Continue;
          Qrymain.GotoBookmark(GrdMain.SelectedList.Items[i]);
          {store the SaleIDs and client email addresses to send email the xml invoices }
          if (ReportType = 'Invoice') {and (QrymainSendXMLInvoices.asBoolean)} and
             (QrymainEmailXML.asString <> '' ) then begin
            fFlag := False;
            fctr:=0;
            for ctr := 0 to High(SaleIDs) do
                if SaleIDs[ctr].customerId = QrymainClientID.asInteger then begin
                    fFlag := True;
                    fctr := ctr;
                End;
            if fFlag then begin
                if SaleIDs[fctr].SaleIds <> '' then SaleIDs[fctr].SaleIds := SaleIDs[fctr].SaleIds + ',';
                SaleIDs[fctr].SaleIds :=SaleIDs[fctr].SaleIds + QrymainSaleID.asString;
            end else begin
                Setlength(SaleIDs , High(SaleIDs)+2);
                SaleIDs[High(SaleIDs)].SaleIds      := QrymainSaleID.asString;
                SaleIDs[High(SaleIDs)].CustomerId   := QrymainClientID.asInteger;
                SaleIDs[High(SaleIDs)].EmailAddress := QrymainEmailXML.asString;
            end;
          end
          else begin
            if CustomersWithoutXMLEmail <> '' then
              CustomersWithoutXMLEmail := CustomersWithoutXMLEmail + ', ';
            CustomersWithoutXMLEmail := CustomersWithoutXMLEmail + QrymainCustomerName.AsString;
          end;

        end;

        if CustomersWithoutXMLEmail <> '' then begin
          CommonLib.MessageDlgXP_Vista('The following customers do not have XML Email addresses:' + #13#10 +
            CustomersWithoutXMLEmail,mtInformation,[mbOk],0);
          exit;
        end;


        EmailXML;

    finally
      qryMain.EnableControls;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesPrnBaseGUI.btnFTPXMLClick(Sender: TObject);
var
  i: integer;
  ctr,fCtr:Integer;
  FFlag :Boolean;
  CustomersWithoutFTPDetails: string;
begin
  inherited;
  DisableForm;
  try
    CustomersWithoutFTPDetails := '';
    if Qrymain.RecordCount = 0 then Exit;
    Setlength(SaleIDs , 0);
    try
      Qrymain.DisableControls;
      if GrdMain.SelectedList.Count = 0 then Exit;
        for i := 0 to GrdMain.SelectedList.Count - 1 do begin
          if not Qrymain.BookmarkValid(GrdMain.SelectedList.Items[i]) then Continue;
          Qrymain.GotoBookmark(GrdMain.SelectedList.Items[i]);
          {store the SaleIDs and client email addresses to send email the xml invoices }
          if (QrymainFTPAddress.asString <> '') and (QrymainFTPUserName.asString <> '') and (QrymainFTPPassword.asString <> '') then begin
            fFlag := False;
            fctr:=0;
            for ctr := 0 to High(SaleIDs) do
                if SaleIDs[ctr].CustomerId = QrymainClientID.asInteger then begin
                    fFlag := True;
                    fctr := ctr;
                End;
            if fFlag then begin
                if SaleIDs[fctr].SaleIds <> '' then SaleIDs[fctr].SaleIds := SaleIDs[fctr].SaleIds + ',';
                SaleIDs[fctr].SaleIds := SaleIDs[fctr].SaleIDs + qryMainSaleID.asString;
            end else begin
                Setlength(SaleIDs , High(SaleIDs)+2);
                SaleIDs[High(SaleIDs)].SaleIds      := qryMainSaleID.asString;
                SaleIDs[High(SaleIDs)].CustomerId   := QrymainClientID.asInteger;
                SaleIDs[High(SaleIDs)].CustomerName := QrymainCustomerName.AsString;
                SaleIDs[High(SaleIDs)].FTPAddress := QrymainFTPAddress.AsString;
                SaleIDs[High(SaleIDs)].FTPUserName := QrymainFTPUserName.AsString;
                SaleIDs[High(SaleIDs)].FTPPassword := QrymainFTPPassword.AsString;
            end;
          end
          else begin
            if CustomersWithoutFTPDetails <> '' then
              CustomersWithoutFTPDetails := CustomersWithoutFTPDetails + ', ';
            CustomersWithoutFTPDetails := CustomersWithoutFTPDetails + qryMainCustomerName.AsString;
          end;

        end;

        if CustomersWithoutFTPDetails <> '' then begin
          CommonLib.MessageDlgXP_Vista('The following Customers do not have FTP details fully configured:' + #13#10 +
            CustomersWithoutFTPDetails,mtInformation,[mbOk],0);
          exit;
        end;


        FTPXML;

    finally
      qryMain.EnableControls;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesPrnBaseGUI.btnImportClick(Sender: TObject);
begin
  inherited;
  DoImportListJson;
end;

procedure TSalesPrnBaseGUI.btnSelectClick(Sender: TObject);
begin
  if btnSelect.Caption = 'Select All' then begin
    grdmain.SelectAll;
    btnSelect.Caption := 'Unselect All'
  end else begin
    grdMain.UnSelectAll;
    btnSelect.Caption := 'Select All'
  end;
end;


Procedure   TSalesPrnBaseGUI.CreateHeader;
begin
    doc.Active := true;
    doc.Version := XMLDocVersion;
    doc.Encoding := XMLDocEncoding;
    HeaderNode:= doc.AddChild(XMLDocRoot);
    HeaderNode.Attributes['DataVersion'] := getUserVersion;
end;

Procedure TSalesPrnBaseGUI.EMailXML;
var
    Ctr:Integer;
    Filename :String;
    fSales: TSales;
    InvoiceDoc: IXMLDocument;
    Corres: TCorrespondenceGui;
begin
    if high(SaleIDs) = -1  then Exit;
    fSales := SalesObj;
    try
      With fSales do begin
          For ctr := 0 to high(SaleIDs) do begin
              LoadSelect('SaleId in (' +SaleIDs[ctr].SaleIds +')');
              if count > 0 then begin
                  doc:= TXMLDocument.Create(nil);
                  Try
                      CreateHeader;
                      Curnode := HeaderNode.Addchild(XMLDocRequest);
                      Curnode.Attributes['OnError'] := XMLDocRequestStopError;
                      Curnode.Attributes['DataObject'] := fSales.Classname;
                      IterateRecords(SaveXML);
                  Finally
                      InvoiceDoc := SalesXMLUtils.CustomerXMLInvoiceDoc(Doc);
                      try
                        Filename := GetAppTempDir + '\' +'ERPSalesData_' +FormatDatetime('yyyymmddhhnnss' , now) +Trim(IntToStr(ctr)) + '.XML';
                        //Doc.XML.SaveToFile(FileName);
                        InvoiceDoc.XML.SaveToFile(FileName);
                        SaleIDs[ctr].XMLFileName := FileName;
                      finally
                        InvoiceDoc := nil;
                      end;
                  end;
              end;
          end;
      end;
    Finally
        FreeandNil(fSales);
    end;
    For ctr := 0 to high(SaleIDs) do begin
        if SaleIDs[ctr].XMLFileName <> '' then begin
          Corres := TCorrespondenceGui.Create;
          try
            Corres.Subject := 'XML ' +reporttype +' #' + SaleIDs[ctr].SaleIds ;
            Corres.RecipientList := SaleIDs[ctr].EmailAddress;
            Corres.MessageText := 'This XML '+reportType +'(s) email has been sent to you from ' + GetCompanyName;
            if fileExists(SaleIDs[ctr].XMLFileName) then
              Corres.AttachmentList.Add(SaleIDs[ctr].XMLFileName);
            Corres.Execute(True, True);
            DeleteFiles(SystemLib.ExeDir, replaceStr(SaleIDs[ctr].XMLFileName,SystemLib.ExeDir,''));
          finally
            Corres.Free;
          end;
      end;
    end;
End;
procedure TSalesPrnBaseGUI.ExtrgrpFilters;
begin
  // descendants will override it if required
end;

procedure TSalesPrnBaseGUI.SaveXML(Const Sender: TBusObj;  var Abort: Boolean);
var
    ClassNode: IXMLNode;
begin
    ClassNode := CurNode.Addchild(Sender.XMLNodeName);
    Sender.SavingXMLTofile := true;
    Sender.SaveToXMLNode(ClassNode);
end;

procedure TSalesPrnBaseGUI.LoadTemplate(const SaleIDs:String; const  ClientID: integer; const bPrint, bSave: boolean;
  const DoClose: boolean = true; const FileName: string = '');
var
  sSQL: string;
  x:Integer;
  Jsonctr:Integer;
  Json: TJsonObject;
Procedure AddMasterSourceDetails(masterds, detailds, masterfields , detailfields:String);
begin
        if Jsonctr =0 then  Json:= JO;
        Jsonctr := Jsonctr +1;
        Json.O[IntToStr(Jsonctr)].S['master']:= masterds;
        Json.O[IntToStr(Jsonctr)].S['detail']:= detailds;
        Json.O[IntToStr(Jsonctr)].S['masterfields']:=masterfields;
        Json.O[IntToStr(Jsonctr)].S['detailfields']:= detailfields;
end;
begin
  Jsonctr:= 0;
  sSQL:= '';
  if chkChooseRpt.Checked and (PrintCount < 2) then begin
    if chkPrintAsOnedocument.checked then begin
        fsReportName := continuousreportname;
    end else begin
      LoadReportTypes;
      if dlgReportSelect.Execute then begin
        fsReportName := dlgReportSelect.SelectedItems.Text;
        if not Empty(fsReportName) then begin
          fsReportName := TemplateNameToTemplateClassName(Trim(fsReportName));
        end else begin
          fsReportName := tcdatautils.GetDefaultReport(GetReportTypeID);
        end;
      end;
    end;
  end else begin

    if (self is TInvoicesPrnGUI) and (sametext(TInvoicesPrnGUI(Self).qryMainTranstype.asString  , 'Invoice')) then
      if Empty(fsReportName) then
        if ClientID <> 0 then
          fsReportName := CustomerInvoiceReportName(ClientID)
    else if (self is TSalesOrderPrnGUI) then
      if Empty(fsReportName) then
        if ClientID <> 0 then
          fsReportName := TClient.DefaultSOTemplateName(ClientID);


    if not Empty(fsReportName) then begin
      ReportToPrint := TemplateNameToTemplateClassName(Trim(fsReportName));
    end else begin
      ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
    end;
  end;

  if Empty(ReportToPrint) then ReportToPrint := Trim(fsReportName);


 {Binny - TODO
 the main template will work, but many of the invioce templates will not work
 expecially the ones that need fbReportSQLSupplied , eg :Invoice with details
 needs to replicate the sql population from basetrans}

{mainSQL}  sSQL := ' AND d2.SaleId in ('+  SaleIDs+') ';

  if Sametext(Trim(ReportToPrint) ,'Invoice Grouped') or (sametext(Trim(reporttoPrint) , 'InvoiceGroup')) then begin
    sSQL := sSQL + ' AND d3.ProductName <>"Memo Only"' +
                    ' GROUP By d2.SaleID,ProductID,d3.LinePrice,d3.UnitofMeasureSaleLines;'+
                    '~|||~ and SaleId in ('+SaleIDs +')' ;{{ShippedProducts}
  end;
  if not(Sametext(ReportToPrint, 'Invoice with details')) then
        sSQL := sSQL +'~|||~ where TTC.SaleID in ( ' +SaleIDs +') group by TTCL.`SubTaxCode`'+{TaxDetails}
                        '~|||~ and Trans.SaleID in (' +SaleIDs+')' ;{ClientCustomFields}

  if (self is TInvoicesPrnGUI) and (sametext(TInvoicesPrnGUI(Self).QrymainTranstype.asString  , 'Invoice')) then sSQL := sSQL + '~|||~where s.SaleId in ( ' +SaleIDs +')';{EarlyPayment}

  if (self is TInvoicesPrnGUI) and (sametext(TInvoicesPrnGUI(Self).QrymainTranstype.asString  , 'Cash Sale')) then begin
    sSQL := sSQL + '~|||~where TC.Transtype = ''CashSale'' and TC.TransId in ( ' +SaleIDs +')';{TransComments}
    if TemplateContainsSection('Payments',self.ReportToPrint,x) then AddSQLPortion(sSQL , x , 'and SaleID in ( ' +SaleIDs +')');
  end else begin
    sSQL := sSQL + '~|||~Where  S.SaleId in ( ' +SaleIDs +')';{ShippingAddress}
    sSQL := sSQL + '~|||~Where  SalesId in ( ' +SaleIDs +')';{ShippingDetails}
    sSQL := sSQL + '~|||~where TC.Transtype = ''Invoice'' and TC.TransId in ( ' +SaleIDs +')';{TransComments}
  end;

{StockLevels}
{------------}if TemplateContainsSection('StockLevels',self.ReportToPrint,x)  then begin
                AddSQLPortion(sSQL , x , ' and SL.SaleID  in ( ' + SaleIDs+') '+
                                        ' group by PC.ClassID, PC.ClassName , PC.ProductID   '+
                                        ' Order by  ClassName , PartName'  );
                if TemplateContainsSection('SQL',self.ReportToPrint,x)  then AddMasterSourceDetails('SQL','StockLevels','ProductId','PartsID');
              end;
{ETADetails}
{------------}if TemplateContainsSection('ETADetails',self.ReportToPrint,x)  then begin
                  AddSQLPortion(sSQL , x , ' and SL.SaleID   in ( ' + SaleIDs+') ' +
                                  ' GROUP BY PL.PurchaseOrderID , PL.Class , PL.ProductID;');
                  if TemplateContainsSection('SQL',self.ReportToPrint,x)  then AddMasterSourceDetails('SQL','ETADetails','ProductId','PL.ProductID');
              end;
{Packages}
{------------}if TemplateContainsSection('Packages',self.ReportToPrint,x) then begin
                  AddSQLPortion(sSQL , x , ' and SL.SaleID   in ( ' + SaleIDs+') ' );
                  if TemplateContainsSection('SQL',self.ReportToPrint,x)  then AddMasterSourceDetails('SQL','Packages','saleLineId','pack.saleLineId')
              end;
{FormulaDetails}
{------------}if TemplateContainsSection('FormulaDetails',self.ReportToPrint,x)  then begin
                    AddSQLPortion(sSQL , x , ' Where SL.SaleID   in ( ' + SaleIDs+') ') ;
                    if TemplateContainsSection('SQL',self.ReportToPrint,x)  then AddMasterSourceDetails('SQL','FormulaDetails','SaleLineId','sl.saleLineId')
              end;

{InvioceSalesOrder}
{------------}if  TemplateContainsSection('InvioceSalesOrder',self.ReportToPrint,x) then begin
                AddSQLPortion(sSQL , x ,  ' where invoice.saleId   in ( ' + SaleIDs+') ' );
              end;

  if not bSave then begin

    PrintTemplateReport(ReportToPrint, sSQL, bPrint, 1 , nil , '', true);
  end else begin
    if Empty(FileName) then begin
      SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'PDF');
    end else begin
      if fsFax then begin
        SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'GraphicFile',FileName);
      end else begin
        SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'PDF', FileName);
      end;
    end;
  end;
  //ReportToPrint := '';
end;

procedure TSalesPrnBaseGUI.chkPreviewClick(Sender: TObject);
begin
  inherited;
  if Tcheckbox(Sender).checked then begin
    if sender <> chkPreview then chkPreview.checked :=False;
    if sender <> chkEmail   then chkEmail.checked :=False;
    if sender <> chkFax     then chkFax.checked :=False;
  end;
//  if not(chkPreview.checked) and not(chkEmail.checked ) and not(chkfax.checked) then chkPreview.checked:= True;//atleast one has to be selectd
  if Sender = chkEmail then begin
    if chkPrintAsOnedocument.Checked and chkEmail.Checked then begin
      CommonLib.MessageDlgXP_Vista('Can not email when printing as one document, disabling email.', mtInformation , [mbOK], 0);
      chkEmail.Checked:= false;
    end;
  end;
end;

procedure TSalesPrnBaseGUI.chkPrintAsOnedocumentClick(Sender: TObject);
begin
  inherited;
  RefreshReportstoPrint;
  if chkPrintAsOnedocument.Checked and chkEmail.Checked then begin
    CommonLib.MessageDlgXP_Vista('Can not email when printing as one document, disabling email.', mtInformation , [mbOK], 0);
    chkEmail.Checked:= false;
  end;
end;

procedure TSalesPrnBaseGUI.chkPrintfilterClick(Sender: TObject);
begin
  inherited;
  if chkPrintfilter.Checked then
    grpFilters.Hint := 'The transaction will show as ''Printed'' if its ''Printed'' or ''Previewed'' from any form.' + NL
  else
    grpFilters.Hint := 'Filter is Applicable only if Printed from this list.  Preview doesn''t flag the record as printed' +NL;

  if screen.activecontrol = chkPrintfilter then
    RefreshQuery;
end;

procedure TSalesPrnBaseGUI.cmdExportClick(Sender: TObject);
begin
  try
    OptsForm.ActionList.AddDivider('Export');
    OptsForm.ActionList.Add('Export', 'Export List to File', DoExport, false, true); //DoExport, false, true);
    OptsForm.ActionList.Add('Auto Send', 'Based on the Selected Customers Correspondence Methods', DoAutoSend, false, true);


    OptsForm.ActionList.AddDivider('Email');
    OptsForm.ActionList.Add('Email XML', 'Email Selected Items as XML', DoEmailXML, false, true);//DoEmailXML, false, true);
    OptsForm.ActionList.Add('Email JSON', 'Email Selected Items as JSON', DoEmailJSON, false, true);


    OptsForm.ActionList.AddDivider('FTP');
    OptsForm.ActionList.Add('FTP XML', 'FTP Selected Items as XML', DoFTPXML, false, true); //DoFTPXML, false, true);

//    DoExtraPrintOptions;

    OptsForm.ShowModal;
  finally
    FreeAndNil(fOptsForm);
  end;
end;

procedure TSalesPrnBaseGUI.cmdPrintClick(Sender: TObject);
var
  SavedPrintDialogPref:boolean;
  selclientID:Integer;

  //qryUpdate: TERPQuery;
begin
  SavedPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
  try
  PrintCount:= 0;
  PrintOk:= False;
  DisableForm;
  try
    if Qrymain.RecordCount = 0 then Exit;
    selclientID:= SelectedClientID;
    Setlength(SaleIDs , 0);
    try
      Qrymain.DisableControls;
      if GrdMain.SelectedList.Count = 0 then Exit;

      if chkEmail.Checked then
        if CommonLib.MessageDlgXP_Vista('"Email" is Selected,' + NL +'All Selected Sales Will be Emailed to The Customers.'+NL+NL+'Do you Wish to Continue?',mtconfirmation,[mbyes,mbNo],0) = mrno then exit;


      if chkPreview.Checked then
        CommonLib.MessageDlgXP_Vista('"Show Preview" is Selected so "Printed" Will not be Flagged Even if you Print from the Print Preview Screen.',mtInformation,[mbOk],0);

      PrintSelectedTrans(sender , selclientID);
    finally
//      if (Sender = btnSend) or (Sender = cmdprint )  then EmailXML;
      if (Sender = cmdprint )  then
        EmailXML;
      //FreeandNil(qryUpdate);
      Qrymain.EnableControls;
      Qrymain.Close;
      Qrymain.Open;
    end;
  finally
    EnableForm;
    if PrintOk then begin
      grdmain.unSelectall;
      //self.close;
    end;
  end;
  finally
    AppEnv.Employee.ShowPrintDialog:= SavedPrintDialogPref;
  end;
end;


function TSalesPrnBaseGUI.getReportType: String;
begin

end;

procedure TSalesPrnBaseGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'PrintFlag = ' + QuotedStr('T');
      end;
    1:
      begin
        GroupFilterString := 'PrintFlag = ' + QuotedStr('F');
      end;
    2:
      begin
      end;
  end;
  ExtrgrpFilters;
  inherited;
end;

procedure TSalesPrnBaseGUI.initchkShowEmailOptions;
begin
  inherited;
  chkShowEmailOptions.visible := true;
end;

function TSalesPrnBaseGUI.EMailMessageText(asaleID:Integer): String;
var
  st:TStringlist;
begin
  st:= TStringlist.create;
  try
    result := EMailMessageText(aSaleID,st);
  finally
    Freeandnil(st);
  end;

end;

function TSalesPrnBaseGUI.EMailMessageText(asaleID:Integer;sl: TStringlist): String;
begin
  result := 'This report email has been sent to you from ' + GetCompanyName;
end;

function TSalesPrnBaseGUI.EmailSale(const SaleID: integer; IsFirst: boolean):Boolean;
var
  RecipientAddress, OutGoingFileName: string;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;
  lSilent, lSecret, aSilent : boolean;
  FieldName: string;
begin
  Result := False;
  chkEmail.Caption := 'Emailing'; //, ' + WAITMSG;
  RecipientAddress := '';
  OutGoingFileName := '';
  if IsFirst then
    fSavedSilent := false;

  Corres:= TCorrespondenceGui.Create;
  try
    FieldName := '';
    case TSalesBase.GetSaleType(Qrymain.FieldByName('SaleID').AsInteger) of
      TSaleType.stNone:;
      TSaleType.stInvoice: FieldName := 'MainContactForInvoice';
      TSaleType.stCashsale: FieldName := 'MainContactForCashSale';
      TSaleType.stSalesOrder: FieldName := 'MainContactForSalesOrder';
      TSaleType.stPOS: FieldName := 'MainContactForPOS';
      TSaleType.stPOSLayby: FieldName := 'MainContactForPOS';
      TSaleType.stPOSLaybyPayment: FieldName := 'MainContactForPOS';
      TSaleType.stQuote: FieldName := 'MainContactForQuote';
      TSaleType.stPOSCashSale: FieldName := 'MainContactForPOS';
      TSaleType.stCustomerReturn: FieldName := 'MainContactForRefund';
    end;

    if FieldName <> '' then
      RecipientAddress := GetContactEmails(Qrymain.FieldByName('ClientID').AsInteger, FieldName);

    lSecret := not IsFirst;
    lSilent := true;
    if RecipientAddress = '' then
    begin
      if CommonLib.MessageDlgXP_Vista(Qrymain.FieldByName('CustomerName').AsString +
        ' does not have an email address to send to.' +#13#10+
        'Do you wish to load the email program anyway?', mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
      lSilent := false;
    end;

    try
      // String defined here because it is easy to change when this code is applied to
      // other forms. (ie, Quote instead of Invoice etc)
      chkEmail.Visible := true;
      LoadTemplate(IntToStr(SaleID), Qrymain.FieldByName('ClientID').AsInteger, true, true);

      if ReportToPrint = '' then begin
        result:= false;
        CommonLib.MessageDlgXP_Vista('Could not find the Report Template to use.', mtInformation , [mbOK], 0);
        exit;
      end;

      chkEmail.Caption := 'Emailing'; //, ' + WAITMSG;

      Corres.Subject := ReportType + ' #' +
        Qrymain.FieldByName('InvoiceDocNumber').AsString + ' for ' + Qrymain.FieldByName('CustomerName').AsString;

      Corres.RecipientList := RecipientAddress;
      //Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;
      Corres.MessageText := EMailMessageText(saleID);

      OutGoingFileName := getOutGoingFileName('',' ' + ReportType + ' #' + Qrymain.FieldByName('InvoiceDocNumber').AsString , '.PDF');
      if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin
        copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
          PChar( Commonlib.TempDir  + OutGoingFileName), false);
      end;

      // Wait For OS Copy
      Sleep(1000);
      Application.ProcessMessages;


      if FileExists( Commonlib.TempDir  + OutGoingFileName) then
        Corres.AttachmentList.Add( Commonlib.TempDir  + OutGoingFileName);
      ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(ReportToPrint));
      if lSilent then begin
        if IsFirst then begin
          { single email or first of a series .. }
          if not EmailShortSendMode(aSilent,lSecret, 104, DoNotAskMsg , DoOnDoNotAskMsgCheck) then
            exit
          else begin
            fSavedSilent := aSilent;
          end;
        end
        else begin
          { this is a series of emails .. }
          if fSavedSilent then begin
            { don't ask the guestion again, just send }
          end else begin
            if not EmailShortSendMode(aSilent,lSecret, 104, DoNotAskMsg , DoOnDoNotAskMsgCheck)  then
              exit
            else begin
              fSavedSilent := aSilent;
            end;
          end;
        end;
      end;

      //if Corres.Execute(True) then begin
      if Corres.Execute(aSilent, lSecret) then begin
        TransactionID := Qrymain.FieldByName('InvoiceDocNumber').AsString;
        UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
        EmailDate := Now;

        // ReportType already defined at start of procedure
        TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' +
          Qrymain.FieldByName('InvoiceDocNumber').AsString + ' for ' + Qrymain.FieldByName('CustomerName').AsString;
        qryEmailedList := TERPQuery.Create(nil);
        qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' +
            TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
            EmailDate) + '", "' + ReportType + '", "' + TransactionDescription +
            '")');
          qryEmailedList.Execute;
        finally
          DeleteFiles( Commonlib.TempDir , '*.PDF');
          FreeandNil(qryEmailedList);
        end;
        Result := True;
      end;

      DeleteFiles( Commonlib.TempDir , '*.PDF');
      DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
//      chkEmail.Visible := false;
    except
//      chkEmail.Visible := false;
    end;
  finally
    Corres.Free;
    chkEmail.Caption := 'Email';
  end;
end;

function TSalesPrnBaseGUI.Faxsale(const SaleID: integer):Boolean;
var
  Fax: TFaxObj;
  FaxNo: string;
begin
  Result := False;
  inherited;
  FaxNo := GetClientFaxNumber(Qrymain.FieldByName('ClientID').AsInteger);
  if Empty(FaxNo) then begin
    CommonLib.MessageDlgXP_Vista(Qrymain.FieldByName('CustomerName').AsString +
      ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
      'Please Review Customer information to Add an Fax Number.', mtWarning,
      [mbOK], 0);
      Exit;
  end else begin
    chkEmail.Visible := true;
    chkEmail.Caption := 'Adding to Fax Spool...';
    fsFax          := true;
    LoadTemplate(IntToStr(SaleID), Qrymain.FieldByName('ClientID').AsInteger, true,
      true, false, reporttype + '_' + Qrymain.FieldByName('GlobalRef').AsString);
    Fax := TFaxObj.Create;
    try
      Fax.NoCoverSheet := true;
      Fax.AddToFaxSpool(AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName,
        Qrymain.FieldByName('CustomerName').AsString, FaxNo, Reporttype,
        Qrymain.FieldByName('GlobalRef').AsString, '',
        ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
    finally
      FreeandNil(Fax);
    end;
    chkEmail.Visible := false;
    DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
    Result := True;
  end;
end;


procedure TSalesPrnBaseGUI.FTPXML;
var
  Ctr:Integer;
  Filename :String;
  fInvoices: TInvoice;
  ftp: TIdFTP;
  url: TURLObj;
  prog: TProgressDialog;
begin
  if high(SaleIDs) = -1  then Exit;
  prog := TProgressDialog.Create(nil);
  try
    prog.Caption := 'Uploading XML to FTP Sites';
    prog.MaxValue := high(SaleIDs);
    prog.Step := 1;
    prog.Value := 1;
    prog.Message := 'Exporting XML ..';
    prog.Execute;
    fInvoices := TInvoice.Create(self);
    try
      With fInvoices do begin
          For ctr := 0 to high(SaleIDs) do begin
              LoadSelect('SaleId in (' + SaleIDs[ctr].SaleIds +')');
              if count > 0 then begin
                  doc:= TXMLDocument.Create(nil);
                  Try
                      CreateHeader;
                      Curnode := HeaderNode.Addchild(XMLDocRequest);
                      Curnode.Attributes['OnError'] := XMLDocRequestStopError;
                      Curnode.Attributes['DataObject'] := fInvoices.Classname;
                      IterateRecords(SaveXML);
                  Finally
                      Filename := GetAppTempDir + '\' +'TrueERP_Invoice_List_' +FormatDatetime('yyyymmddhhnnss' , now) +Trim(IntToStr(ctr)) + '.xml';
                      Doc.XML.SaveToFile(FileName);
                      SaleIDs[ctr].XMLFileName := FileName;
                  end;
              end;
              prog.StepIt;
          end;
      end;
    Finally
      FreeandNil(fInvoices);
    end;
    prog.Message := 'Uploading ...';
    prog.Value := 1;
    ftp := TIdFTP.Create(nil);
    url := TURLObj.Create();
    try

      For ctr := 0 to high(SaleIDs) do begin
        if SaleIDs[ctr].XMLFileName <> '' then begin

          url.URL := SaleIDs[ctr].FTPAddress;
          ftp.Host := url.Host;
          ftp.Username := SaleIDs[ctr].FTPUserName;
          ftp.Password := SaleIDs[ctr].FTPPassword;
          try
            fileName := url.Path;
            if (fileName <> '') and (copy(fileName,Length(fileName),1) <> '/') then
              fileName := fileName + '/';
            fileName := fileName + ExtractFileName(SaleIDs[ctr].XMLFileName);
            ftp.Connect;
            ftp.Put(SaleIDs[ctr].XMLFileName,fileName);
            ftp.Disconnect;
            DeleteFiles(ExtractFilePath(SaleIDs[ctr].XMLFileName), replaceStr(SaleIDs[ctr].XMLFileName,SystemLib.ExeDir,''));
          except
            on e: exception do begin
              CommonLib.MessageDlgXP_Vista('Error sending XML Invoice to ' + SaleIDs[ctr].CustomerName +
              #13#10 + 'Error message: ' + e.Message,mtWarning,[mbOK],0);
            end;
          end;

        end;
        prog.StepIt;
      end;

    finally
      ftp.Free;
      url.Free;
    end;
  finally
    prog.Free;
  end;
end;

procedure TSalesPrnBaseGUI.SetGridColumns;
begin
  inherited;
    //RemoveFieldfromGrid(QrymainSaleID.FieldName);
    RemoveFieldfromGrid(QrymainClientID.FieldName);
    RemoveFieldfromGrid(QrymainEditedFlag.FieldName);
    RemoveFieldfromGrid(QrymainGlobalRef.FieldName);
    RemoveFieldfromGrid(QrymainSendXMLInvoices.FieldName);
    RemoveFieldfromGrid(QrymainEmailXML.FieldName);
    RemoveFieldfromGrid(QrymainBOID.FieldName);
end;

procedure TSalesPrnBaseGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['PrintOptions.ShowPreview'].AsString        := BooleanToStr(chkPreview.checked);
  GuiPrefs.Node['PrintOptions.SendEmail'].AsString          := BooleanToStr(chkEmail.checked);
  GuiPrefs.Node['PrintOptions.SendFax'].AsString            := BooleanToStr(chkfax.checked);
  GuiPrefs.Node['PrintOptions.PrintAsOneDocument'].AsString := BooleanToStr(chkPrintAsOnedocument.checked);
  GuiPrefs.Node['PrintOptions.PrintFromanywhere'].AsString  := BooleanToStr(chkPrintfilter.checked);
end;

function TSalesPrnBaseGUI.SelectedclientID: Integer;
var
  i:Integer;
begin
  result := 0;
  if GrdMain.SelectedList.Count > 0 then begin
        for i := 0 to GrdMain.SelectedList.Count - 1 do begin
          Qrymain.GotoBookmark(GrdMain.SelectedList.Items[i]);
          if result =0 then result :=Qrymain.FieldByName('ClientID').AsInteger;
          if result = Qrymain.FieldByName('ClientID').AsInteger then continue
          else begin
              result :=0;
              Exit;
          end;
        end;
  end;
end;


procedure TSalesPrnBaseGUI.DoAutoSend;
begin
  if grdMain.SelectedList.Count = 0 then begin
    CommonLib.MessageDlgXP_Vista('Nothing is selected in the list', mtInformation, [mbOk],0);
    exit;
  end;

  inherited cmdPrintClick(cmdPrint);
end;

procedure TSalesPrnBaseGUI.DocSalesPrinted(const Previewed:Boolean);
var
  i:Integer;
begin
  if GrdMain.SelectedList.Count > 0 then begin
        for i := 0 to GrdMain.SelectedList.Count - 1 do begin
          Qrymain.GotoBookmark(GrdMain.SelectedList.Items[i]);
          if Qrymain.fieldByname('SaleID').asinteger <> 0 then begin
              fPrintDoc := TBusObjPrintDoc.Create(self);
              Try
                fPrintDoc.Printdoc(DocumentName,   Qrymain.FieldByName('SaleID').AsInteger, dtMain, Self.Classname , PreviewToDocumentOutputType(Previewed) , fsReportName);
              finally
                Freeandnil(fPrintDoc);
              end;
          end;
        end;
  end;
end;

procedure TSalesPrnBaseGUI.DoEmailJson;
var
  i: integer;
  IdList: TIntegerList;
//  sd: TSaveDialog;
  tmpFileName: string;
  qry: TERPQuery;
  CashSale: TCashSale;
  SalesOrder : TSalesOrder;
  Invoice: TInvoice;
  Sale: TSalesBase;
  JSONSerialiser: TJSONSerialiser;
  list: TJsonObject;
  Corres: TCorrespondenceGui;
  prog: TProgressDialog;
begin
  DisableForm;
  try
    if Qrymain.RecordCount = 0 then begin
      CommonLib.MessageDlgXP_Vista('Nothing has been selected',mtInformation,[mbOk],0);
      Exit;
    end;

    Invoice := nil;
    CashSale := nil;
    SalesOrder := nil;
    IdList := TIntegerList.Create;
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    list := JO;
    Corres := TCorrespondenceGui.Create;
    prog := TProgressDialog.Create(nil);
    try
      SelectedIDs('SaleId',IdList,false);
      qry.SQL.Text := 'select * from tblSales where SaleId = :SaleId';
      prog.Caption := 'Exporting Sales as JSON';
      prog.MaxValue := IdList.Count;
      prog.Step := 1;
      prog.Value := 1;
      prog.Message := 'Exporting JSON ..';
      prog.Execute;

      tmpFileName := SystemLib.GetAppTempDir + '\Sales_' + FormatDateTime('yyyy-mm-dd_hh-nn-ss',now) +'.json';

      for I := 0 to IdList.Count - 1 do begin
        Sale := nil;
        qry.ParamByName('SaleId').AsInteger := IdLIst[i];
        qry.Open;
        try
          if qry.FieldByName('IsInvoice').AsBoolean then begin
            if not Assigned(Invoice) then begin
              Invoice := TInvoice.CreateWithSharedConn(nil);
            end;
            Invoice.Load(IdList[i]);
            Sale := Invoice;
          end
          else if qry.FieldByName('IsCashSale').AsBoolean then begin
            if not Assigned(CashSale) then begin
              CashSale := TCashSale.CreateWithSharedConn(nil);
            end;
            CashSale.Load(IdList[i]);
            Sale := CashSale;
          end
          else if qry.FieldByName('IsSalesOrder').AsBoolean then begin
            if not Assigned(SalesOrder) then begin
              SalesOrder := TSalesOrder.CreateWithSharedConn(nil);
            end;
            SalesOrder.Load(IdList[i]);
            Sale := SalesOrder;
          end;


          if Assigned(Sale) then begin
            JSONSerialiser:= TJSONSerialiser.Create;
            try
              list.A['List'].Add(JSONSerialiser.SerialiseObject(Sale));
            finally
              JSONSerialiser.Free;
            end;
          end;
        finally
          qry.Close;
        end;
        prog.StepIt;
      end;

//      list.SaveToFile(tmpFileName);
      RemoveFields(list,'ID,GlobalRef');
      JsonToFileFormated(list,tmpFileName);
      prog.CloseDialog;
      Corres.Subject := 'Sales List';
      Corres.MessageText := 'Sales List';
      Corres.AttachmentList.Add(tmpFileName);

      { we don't have email address so don't send silent! }
      Corres.Execute(False);

    finally
      IdList.Free;
      qryMain.EnableControls;
      DbSharedObj.ReleaseObj(qry);
      Invoice.Free;
      CashSale.Free;
      SalesOrder.Free;
      list.Free;
      Corres.Free;
      prog.Free;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesPrnBaseGUI.DoEmailXML;
begin
  btnEmailXMLClick(Self);
end;

procedure TSalesPrnBaseGUI.DoExport;
begin
  inherited cmdExportClick(cmdExport);
end;

procedure TSalesPrnBaseGUI.DoExtraPrintOptions;
begin

end;

procedure TSalesPrnBaseGUI.DoFTPXML;
begin
  btnFTPXMLClick(Self);
end;

procedure TSalesPrnBaseGUI.DoImportListJson;
var
  od: TOpenDialog;
  jsonFileName: string;
  list, errList, json: TJsonObject;
  x: integer;
  JSONDesrialiser: TJSONDeserialiser;
  obj: TObject;
  errMsg: TStringList;
  prog: TProgressDialog;

  procedure AddErr(msg: string; j: TJsonObject);
  begin
    if not Assigned(errMsg) then errMsg := TStringList.Create;
    if not Assigned(errList) then errList := JO;
    if errMsg.Count > 0 then errMsg.Add('');
    errMsg.Add(msg);
    if Assigned(j) then
      errList.A['List'].Add(j);
  end;

begin
  od := TOpenDialog.Create(nil);
  try
    od.Filter := 'JSON files (*.json)|*.JSON|All files (*.*)|*.*';
    if od.Execute then
      jsonFileName := od.FileName
    else
      exit;
  finally
    od.Free;
  end;

  list := JO;
  JSONDesrialiser:= TJSONDeserialiser.Create;
  prog := TProgressDialog.Create(nil);
  try
    JSONDesrialiser.DatabaseConnection := CommonDbLib.GetNewMyDacConnection(nil);
    JSONDesrialiser.RawMode := true;
    try
      list.LoadFromFile(jsonFileName);
      prog.Caption := 'Importing Sales as JSON';
      prog.MaxValue := List.A['List'].Count + 1;
      prog.Step := 1;
      prog.Value := 1;
      prog.Message := 'Importing JSON ..';
      prog.Execute;
      json := nil;
      for x := 0 to list.A['List'].Count -1 do begin
        if not JSONDesrialiser.DatabaseConnection.InTransaction then
          JSONDesrialiser.DatabaseConnection.StartTransaction;
        try
          json := list.A['List'].Items[x].AsObject;

          Obj:= JSONDesrialiser.DeserialiseObject(json);
          if not JSONDesrialiser.IsConsistent then begin
            JSONDesrialiser.DatabaseConnection.Rollback;
            AddErr('Error populating object: ' + JSONDesrialiser.Messages.CommaText, json);
            continue;
          end;

          if Assigned(Obj) then begin
            if Obj is TSalesBase then begin
              if not TSalesBase(Obj).Save then begin
                JSONDesrialiser.DatabaseConnection.Rollback;
                AddErr('Error Saving Sale: ' + TSalesBase(Obj).ResultStatus.Messages, json);
                continue;
              end;
            end
            else begin
              JSONDesrialiser.DatabaseConnection.Rollback;
              AddErr('Error - Unknown data type: ' + obj.ClassName, json);
              continue;
            end;
          end;


          if JSONDesrialiser.DatabaseConnection.InTransaction then
            JSONDesrialiser.DatabaseConnection.Commit;
        except
          on e: exception do begin
            if JSONDesrialiser.DatabaseConnection.InTransaction then
              JSONDesrialiser.DatabaseConnection.Rollback;
            AddErr('Exception processing sale: ' + e.Message, json);
          end;

        end;

        prog.StepIt;
      end;
      prog.CloseDialog;
    finally
      if JSONDesrialiser.DatabaseConnection.InTransaction then
        JSONDesrialiser.DatabaseConnection.Rollback;
    end;

    if Assigned(errMsg) then begin
      JsonFileName := ChangeFileExt(JsonFileName,'_error.json');
      JsonToFileFormated(errList,JsonFileName);

      errMsg.Insert(0, '');
      errMsg.Insert(0, 'The following errors occured while importing the list of sales. ' +
        'The unprocessed sales have been saved into the following file:' + #13#10 + JsonFileName);
      TfrmMemoDialog.Memopopup(errMsg.Text,'Import Errors');
    end;

  finally
    list.Free;
    errList.Free;
    errMsg.Free;
    JSONDesrialiser.DatabaseConnection.Free;
    JSONDesrialiser.Free;
    prog.Free;
  end;
end;

Function TSalesPrnBaseGUI.PrintAsOnedcument(selclientID:Integer;DoPrint:boolean):Boolean;
begin
    ReportToPrint:='';
    fsReportName := continuousreportname;
    Try
      LoadTemplate(SelectedIDs('SaleID'),selclientID, DoPrint, false);
      REsult:= True;
      DocSalesPrinted(not(DoPrint));
    Except
      On e:Exception do REsult := False;
    End;
end;

procedure TSalesPrnBaseGUI.PrintExtraReports(Sender:TObject);
begin

end;

procedure TSalesPrnBaseGUI.PrintSelectedTrans(Sender: TObject; selclientID: Integer; IsFirst: boolean);
var
  i: integer;
  ctr,fCtr:Integer;
  FFlag :Boolean;
  FieldName: string;
  RecipientAddress: string;

  function StringtoDefaultcontactMethod(const Value:String):TDefaultcontactMethod;
  begin
    Result := dcmNone;
         if sameText(Value , 'Email') then result := dcmEmail
    else if sameText(Value , 'Fax') then Result := dcmFax
    else if sameText(Value , 'Print') then Result := dcmPrint
    else if sameText(Value , 'Phone') then Result := dcmPhone
    else if sameText(Value , 'Mobile') then Result := dcmMobile
    else if sameText(Value , 'Visit') then Result := dcmVisit;
  end;

  function DocumentOutputtype:TdocumentOutputtype;
  begin
    result := dotPreview;
  //       if Sender = btnSend    then result := dotEmail
    (*else if (Sender = cmdPrint ) and (chkPreview.checked)       then result := dotPreview *)
//    else if (Sender = cmdPrint ) and (chkEmail.checked)         then result := dotEmail
         if (Sender = cmdPrint ) and (chkEmail.checked)         then result := dotEmail
    else if (Sender = cmdPrint ) and (chkFax.checked)           then result := dotFax
    else if (Sender = cmdPrint ) and (not chkPreview.checked) then result := dotPrint
    else if (Sender = cmdPrint ) then result := dotPreview;
  end;
  function toBeEmaild:Boolean;
  begin
    result := False;
    (*
    if (Sender = btnSend) and ((ClientDefaultcontactMethod<=dcmEmail) or (ClientDefaultcontactMethod>=dcmPhone))  then
      REsult:= True
    else*) if (Sender = cmdPrint ) and (chkEmail.checked)  then
      result := True;
  end;

  function toBeFaxed:Boolean;
  begin
    result := False;
    (*
    if (Sender = btnSend) and ((ClientDefaultcontactMethod<=dcmFax) or (ClientDefaultcontactMethod>=dcmPhone))  then REsult:= True
    else *)if (Sender = cmdPrint ) and (chkFax.checked)  then result := True;
  end;
  (*function ToBePrinted:Boolean;
  begin
    result := False;
    if (Sender = btnSend) and (Appenv.Employee.ShowPreview=False) then REsult:= True
    else if (Sender = cmdPrint ) and (chkPreview.checked=False) then result := True;
  end;*)
begin
  fsReportName :='';
(*if (chkPrintAsOnedocument.checked) and (Sender = cmdPrint ) and (chkPreview.checked) then begin
        PrintOK := PrintAsOnedcument(selclientID,False);
      end else if (chkPrintAsOnedocument.checked) and (Sender = cmdPrint ) and (chkPreview.checked=False) then begin
        PrintOK := PrintAsOnedcument(selclientID , true);*)
      if (chkPrintAsOnedocument.checked) and (Sender = cmdPrint )  then begin
        PrintOK := PrintAsOnedcument(selclientID, not chkPreview.Checked);
      end else begin
          //PrintTemplate.UseEmployeeShowPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
          PrintTemplate.CancelPreviewAll:= False;
          //ShowProgressbar('Printing Invoices' , GrdMain.SelectedList.Count);
          //try
              for i := 0 to GrdMain.SelectedList.Count - 1 do begin
                StepProgressbar(inttostr(i+1) +' of ' +inttostr(GrdMain.SelectedList.Count));
                if not chkChooseRpt.Checked then  fsReportName :='';
                if not Qrymain.BookmarkValid(GrdMain.SelectedList.Items[i]) then Continue;
                Inc(PrintCount);
                {store the SaleIDs and client email addresses to send email the xml invoices }
                if (ReportType = 'Invoice') and (QrymainSendXMLInvoices.asBoolean) and
                   (QrymainEmailXML.asString <> '' ) then begin
                  fFlag := False;
                  fctr:=0;
                  for ctr := 0 to High(SaleIDs) do
                      if SaleIDs[ctr].customerId = QrymainClientID.asInteger then begin
                          fFlag := True;
                          fctr := ctr;
                      End;
                  if fFlag then begin
                      if SaleIDs[fctr].SaleIds <> '' then SaleIDs[fctr].SaleIds := SaleIDs[fctr].SaleIds + ',';
                      SaleIDs[fctr].SaleIds :=SaleIDs[fctr].SaleIds + QrymainSaleID.asString;
                  end else begin
                      Setlength(SaleIDs , High(SaleIDs)+2);
                      SaleIDs[High(SaleIDs)].SaleIds      := QrymainSaleID.asString;
                      SaleIDs[High(SaleIDs)].CustomerId   := QrymainClientID.asInteger;
                      SaleIDs[High(SaleIDs)].EmailAddress := QrymainEmailXML.asString;
                  end;
                end;

                Qrymain.GotoBookmark(GrdMain.SelectedList.Items[i]);
                fsFax := false;
                //ClientDefaultcontactMethod:= StringtoDefaultcontactMethod(tcdatautils.ClientdefaultContactMethod(Qrymain.FieldByName('ClientID').AsInteger));

                FieldName := '';
                RecipientAddress := '';
                case TSalesBase.GetSaleType(Qrymain.FieldByName('SaleID').AsInteger) of
                  TSaleType.stNone:;
                  TSaleType.stInvoice: FieldName := 'MainContactForInvoice';
                  TSaleType.stCashsale: FieldName := 'MainContactForCashSale';
                  TSaleType.stSalesOrder: FieldName := 'MainContactForSalesOrder';
                  TSaleType.stPOS: FieldName := 'MainContactForPOS';
                  TSaleType.stPOSLayby: FieldName := 'MainContactForPOS';
                  TSaleType.stPOSLaybyPayment: FieldName := 'MainContactForPOS';
                  TSaleType.stQuote: FieldName := 'MainContactForQuote';
                  TSaleType.stPOSCashSale: FieldName := 'MainContactForPOS';
                  TSaleType.stCustomerReturn: FieldName := 'MainContactForRefund';
                end;

                if FieldName <> '' then
                  RecipientAddress := GetContactEmails(Qrymain.FieldByName('ClientID').AsInteger, FieldName);
                StepProgressbar(inttostr(i+1) +' of ' +inttostr(GrdMain.SelectedList.Count)+' Printing');
                if (toBeEmaild) and (RecipientAddress <> '') then begin
                  ReportToPrint := '';
                  PrintOK := EmailSale(QrymainSaleID.asInteger, i = 0);
                end else if  (toBeFaxed) and (GetClientFaxNumber(QrymainClientID.asInteger)<>'') then begin
                  ReportToPrint := 'Fax';
                  PrintOK := Faxsale(QrymainSaleID.asInteger);
                (*end else if  tobePrinted  then begin
                  ReportToPrint := '';
                  LoadTemplate(IntToStr(QrymainSaleID.asInteger),QrymainClientID.asInteger, true, false);
                  PrintOK := True;*)
                end else begin
                  ReportToPrint := '';
                  LoadTemplate(IntToStr(QrymainSaleID.asInteger),QrymainClientID.asInteger,(not chkPreview.Checked), false);
                  PrintOK := True;
                end;
                //if devmode then MessageDlg(ReportToPrint, mtInformation, [mbOK], 0);
                If PrintOK then begin
                    fPrintDoc := TBusObjPrintDoc.Create(self);
                    Try
                      fPrintDoc.Printdoc(DocumentName,   QrymainSaleID.asInteger, dtMain, Self.Classname ,DocumentOutputtype , ReportToPrint);
                    finally
                      Freeandnil(fPrintDoc);
                    end;
                    PrintExtraReports(Sender);
                end;
                Qrymain.Next;
                //PrintTemplate.UseEmployeeShowPrintDialogPref :=False;
                if PrintTemplate.CancelPreviewAll then exit;
              end;
          //finally
          //  HideProgressbar;
          //end;
      end;
end;

end.


