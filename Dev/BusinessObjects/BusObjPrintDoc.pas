{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 28/11/05  1.00.00 BJ   Initial version.
                        This object is supposed to be outside the transaction,
                        If a connection within transaction is passed into it, it
                        will lock the printdoc Table
 15/08/2006 1.00.01 BJ  PrintDoc procedure locking the tbale using userlock object instead of 'Lock table'
                        the table shouldn;t be within transaction.
                        }
unit BusObjPrintDoc;

interface

uses BusobjBase, classes, XMLDoc, XMLIntf;

type

  TDocumentType = (dtMain, dtPickSlip, dtDelDock,dtStawySlip);
  TDocumentOutputType = (dotPrint, dotPreview , dotEmail, dotFax, dotEDI, dotPDF);

  TBusObjPrintDoc = class(TMSBusObj)
  private
    function getDocName: string;
    function getPrintedFrom: string;
    function getTemplateName: string;
    function getPrintcount: integer;
    function getDocId: integer;
    function getPrintDate: TDateTime;
    function getPrintedBy: integer;
    function GetDocType: TDocumentType;
    function GetDocOutputType: TDocumentOutputType;
    procedure SetPrintedBy(const Value: integer);
    procedure SetPrintDate(const Value: TDateTime);
    procedure SetDocId(const Value: integer);
    procedure SetPrintcount(const Value: integer);
    procedure SetDocName(const Value: string);
    procedure SetPrintedFrom(const Value: string);
    procedure SetTemplateName(const Value: string);
    procedure SetDocType(const Value: TDocumentType);
    procedure SetDocOutputType(const Value: TDocumentOutputType);
    procedure sendPrintinfoemail(const DocumentName: String;
      const DocumentId: integer; const DocumentType: TDocumentType);
    function GetPrintedByEmployeeName: string;
    procedure SetPrintedByEmployeeName(const Value: string);

  protected
    function GetSQL: string; override;
    function GetId: integer; override;
    function DoAfterInsert(Sender :TDatasetBusObj ): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner :TComponent); override;
    function DocPrintedBy(const DocumentName: string; const DocumentId: integer): string;
    function PrintDoc(const DocumentName: string; const DocumentId: integer; const DocumentType: TDocumentType ;PrintedFromName:String;DocumentOutputtype :TDocumentOutputtype;fTemplateName:String): integer;
    procedure SaveToXMLNode(const node: IXMLNode); Reintroduce;
    procedure LoadFromXMLNode(const node: IXMLNode); Reintroduce;
    Class Function XMLBranchName :String;override;
    function Save: boolean; override;
    function ValidateData: Boolean; override;
    class function _Schema: string; override;
  Published
    property DocName: string read getDocName write SetDocName;
    property PrintedFrom: string read getPrintedFrom write SetPrintedFrom;
    property TemplateName: string read getTemplateName write SetTemplateName;
    property Printcount: integer read getPrintcount write SetPrintcount;
    property DocId: integer read getDocId write SetDocId;
    property PrintDate: TDateTime read getPrintDate write SetPrintDate;
    property PrintedBy: integer read getPrintedBy write SetPrintedBy;
    property PrintedByEmployeeName: string read GetPrintedByEmployeeName write SetPrintedByEmployeeName;
    property DocType: TDocumentType read GetDocType write SetDocType;
    property DocOutputType: TDocumentOutputType read GetDocOutputType write SetDocOutputType;
  end;

  TInvoicePrintDoc = class(TBusObjPrintDoc)
  protected
    function DoAfterInsert(Sender :TDatasetBusObj ): Boolean; override;
  public
    constructor Create(AOwner :TComponent); override;
  end;

  Function DoctypetoString(const Value :TDocumenttype):String;
  Function StringToDoctype(Const Value:String):TDocumentType;
  Function DocOutputTypetoString(const Value :TDocumentOutputType):String;
  Function StringToDocOutputType(Const Value:String):TDocumentOutputType;
  function PreviewToDocumentOutputType(const Value:Boolean):TDocumentOutputType;

implementation

uses Sysutils, db, DateUtils,  MyAccess,ERPdbComponents, tcDataUtils,
  AppEnvironment{, SoundObj}, EmailUtils, BusObjSales, CommonLib,
  BusObjSchemaLib, BusObjEmployee, tcConst, SMSUtils, CommonDbLib,
  CorrespondenceObj;

function TBusObjPrintDoc.PrintDoc(const DocumentName: string; const DocumentId: integer; const DocumentType: TDocumentType;PrintedFromName:String;DocumentOutputtype:TDocumentOutputtype;fTemplateName:String): integer;
begin
    Load(0);
    New;
    DocName       := DocumentName;
    DocType       := DocumentType;
    DocOutputType := DocumentOutputType;
    DocId         := DocumentId;
    PrintedFrom   := PrintedFromName;
    Printcount := Printcount + 1;
    PrintedBy := AppEnv.Employee.EmployeeID;
    Printdate := Now;
    TemplateName := fTemplateName;
    PostDB;
    Save;
    Result := Printcount;
    sendPrintinfoemail(DocumentName,DocumentId,DocumentType);
end;

procedure TBusObjPrintDoc.sendPrintinfoemail(const DocumentName:String; const DocumentId: integer;const DocumentType: TDocumentType);
var
  email: String;
  mobile: string;

  procedure SalesclientContacts;
  begin
    With GetNewdataset('select c.Email, c.Mobile from tblsales s inner join tblclients c on c.clientId = s.clientId where s.SaleID = ' +inttostr(DocumentId) , true) do try
         email:= Fieldbyname('Email').asString;
         mobile:= Fieldbyname('Mobile').asString;
    finally
      if active then close;
      free;
    end;
  end;

  function ReplaceTransInfo(Const Value:String):String;
  var
    s:string;
  begin
    s:='Select s.SAleId ,  ' +
        ' C.FirstName, ' +
        ' S.ShipTo, ' +
        ' concat(SL.Productname ,"     : " ,  SL.UnitofMeasureShipped , "  of  " ,   concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , ")" )) details ' +
        ' from tblsales s ' +
        ' inner join tblsaleslines SL on S.SAleId = SL.SaleId   ' +
        ' inner join tblclients c on c.clientId = s.clientID' +
        ' where ifnull(SL.UnitofMeasureShipped,0)<> 0 and  S.SaleID = ' + inttostr(DocumentId);
    With TERPQuery(GetNewDataset (s, true)) do try
      result:= Value;
      Result:= replaceStr(result , '#SaleID#'           ,  inttostr(DocumentId));
      Result:= replaceStr(result , '#ShippingAddress#'  ,  Fieldbyname('ShipTo').asString);
      Result:= replaceStr(result , '#Products#'         ,  Groupconcat('Details' , '' , False, #13 +#10 ));
      Result:= replaceStr(result , '#FirstName#'        , Fieldbyname('FirstName').asString);
    finally
      closenFree;
    end;
  end;

begin
  if sametext(DocumentName , TInvoice.classname) then begin
    //email:= SalesclientEmail;
    SalesclientContacts;
    if email <> '' then begin
      if Appenv.CompanyPrefs.EnableInvoiceMail  and ( DocumentType = dtMain) then begin
// Now handeled by new printing options
//          TEmailSender.SendEmail(email, ReplaceTransInfo(Appenv.CompanyPrefs.InvoiceMailSubject) ,ReplaceTransInfo(Appenv.CompanyPrefs.InvoiceMailText) , '');
      end
      else  if Appenv.CompanyPrefs.EnableInvoicePickMail  and ( DocumentType = dtPickSlip) then begin
//        TEmailSender.SendEmail(email, ReplaceTransInfo(Appenv.CompanyPrefs.InvoicePickMailSubject) ,ReplaceTransInfo(Appenv.CompanyPrefs.InvoicePickMailText) , '');
        TCorrespondenceGui.EmailCustomer(email,
          ReplaceTransInfo(Appenv.CompanyPrefs.InvoicePickMailSubject),
          ReplaceTransInfo(Appenv.CompanyPrefs.InvoicePickMailText),
          TInvoice.SaleClientId(DocumentId),
          true);
      end
      else  if Appenv.CompanyPrefs.EnableInvoiceDelMail  and ( DocumentType = dtDelDock) then begin
//        TEmailSender.SendEmail(email, ReplaceTransInfo(Appenv.CompanyPrefs.InvoiceDelMailSubject) ,ReplaceTransInfo(Appenv.CompanyPrefs.InvoiceDelMailText) , '');
        TCorrespondenceGui.EmailCustomer(email,
          ReplaceTransInfo(Appenv.CompanyPrefs.InvoiceDelMailSubject),
          ReplaceTransInfo(Appenv.CompanyPrefs.InvoiceDelMailText),
          TInvoice.SaleClientId(DocumentId),
          true);
      end;
    end;
    if Appenv.CompanyPrefs.SMSEnabled and (mobile <> '') then begin
      if Appenv.CompanyPrefs.EnableInvoicePrintSMS and (DocumentType = dtMain) then begin
// Now handled by new printing options
//        SMSUtils.SendSMS(mobile, ReplaceTransInfo(Appenv.CompanyPrefs.InvoicePrintSMSText), CommonDbLib.GetSharedMydacConnection);
//        AppEnv.UtilsClient.TriggerSMSSend;
      end
      else  if Appenv.CompanyPrefs.EnableInvoicePickSMS and (DocumentType = dtPickSlip) then begin
//        SMSUtils.SendSMS(mobile, ReplaceTransInfo(Appenv.CompanyPrefs.InvoicePickSMSText), CommonDbLib.GetSharedMydacConnection);
//        AppEnv.UtilsClient.TriggerSMSSend;
        TCorrespondenceGui.SMSCustomer(email,
          ReplaceTransInfo(Appenv.CompanyPrefs.InvoicePickSMSText),
          TInvoice.SaleClientId(DocumentId),
          true);
      end
      else  if Appenv.CompanyPrefs.EnableInvoiceDelSMS and (DocumentType = dtDelDock) then begin
//        SMSUtils.SendSMS(mobile, ReplaceTransInfo(Appenv.CompanyPrefs.InvoiceDelSMSText), CommonDbLib.GetSharedMydacConnection);
//        AppEnv.UtilsClient.TriggerSMSSend;
        TCorrespondenceGui.SMSCustomer(email,
          ReplaceTransInfo(Appenv.CompanyPrefs.InvoiceDelSMSText),
          TInvoice.SaleClientId(DocumentId),
          true);
      end;
    end;
  end;
end;

function TBusObjPrintDoc.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  PrintedBy := AppEnv.Employee.EmployeeID;
  Printdate := Now;
  DocType := dtMain;
end;

function TBusObjPrintDoc.DocPrintedBy(const DocumentName: string; const DocumentId: integer): string;
begin
  Result := '';
  LoadSelect('DocName = ' + QuotedStr(DocumentName) + ' and docId = ' + IntToStr(DocumentId));
  if Dataset.RecordCount > 0 then Result := getUserName(PrintedBy);
end;

constructor TBusObjPrintdoc.Create(AOwner :TComponent );
begin
    inherited create(AOwner);
    IgnoreAccesslevel := True; {Can Always Print even if readonly}
    fSQL := 'SELECT * FROM tblPrintDocs ';
    LogChangesOnSave := false ;
    self.ExportExcludeList.Add('printedby');
end;
function TBusObjPrintDoc.GetSQL: string;
begin
    result := inherited GetSQL;
end;

function TBusObjPrintDoc.GetId: integer;
begin
  Result := GetIntegerField('PrintdocId');
end;
class Function TBusObjPrintDoc.GetIDField :String ;
begin
    Result :='PrintdocId';
end;

class function TBusObjPrintDoc.GetBusObjectTablename: string;
begin
  Result := 'tblPrintDocs';
end;

function TBusObjPrintDoc.getDocName: string;
begin
  Result := getStringField('DocName');
end;
function TBusObjPrintDoc.getPrintedFrom: string;
begin
  Result := getStringField('PrintedFrom');
end;
function TBusObjPrintDoc.getTemplateName: string;
begin
  Result := getStringField('TemplateName');
end;

function TBusObjPrintDoc.getPrintcount: integer;
begin
  Result := Getintegerfield('Printcount');
end;

function TBusObjPrintDoc.getDocId: integer;
begin
  Result := getIntegerField('DocId');
end;

function TBusObjPrintDoc.getPrintDate: TDateTime;
begin
  Result := getDateTimefield('PrintDate');
end;

function TBusObjPrintDoc.getPrintedBy: integer;
begin
  Result := getIntegerField('PrintedBy');
end;

function TBusObjPrintDoc.GetPrintedByEmployeeName: string;
begin
  if PrintedBy > 0 then
    result := TEmployee.IDToggle(self.PrintedBy, Connection.Connection)
  else
    result := '';
end;

procedure TBusObjPrintDoc.SetPrintedBy(const Value: integer);
begin
  SetIntegerfield('Printedby', Value);
end;

procedure TBusObjPrintDoc.SetPrintedByEmployeeName(const Value: string);
begin
  if Value <> '' then
    self.PrintedBy := TEmployee.IDToggle(Value, Connection.Connection)
  else
    self.PrintedBy := 0;
end;

procedure TBusObjPrintDoc.SetPrintDate(const Value: TDateTime);
begin
  SetDateTimefield('PrintDate', Value);
end;

procedure TBusObjPrintDoc.SetDocId(const Value: integer);
begin
  SetIntegerField('DocId', Value);
end;

procedure TBusObjPrintDoc.SetPrintcount(const Value: integer);
begin
  SetIntegerField('Printcount', Value);
end;

procedure TBusObjPrintDoc.SetDocName(const Value: string);
begin
  SetStringField('docName', Value);
end;
procedure TBusObjPrintDoc.SetPrintedFrom(const Value: string);
begin
  SetStringField('PrintedFrom', Value);
end;
procedure TBusObjPrintDoc.SetTemplateName(const Value: string);
var
  Templname:String;
  Procedure ValidateTemplateName;
  begin
    if Templname =  '' then Exit;
    with getNewDataset('Select TemplName from tbltemplates where TemplName   = ' + quotedstr(Templname) , True) do try
      if recordcount > 0 then exit;
    finally
      if active then close;
      Free;
    end;
    with getNewDataset('Select TemplName   from tbltemplates where TemplateClass   = ' + quotedstr(Templname) , True) do try
      if recordcount > 0 then  Templname:= fieldByname('TemplName').asString;
    finally
      if active then close;
      Free;
    end;
  end;
begin
  Templname:= Value;
  ValidateTemplateName;
  SetStringField('TemplateName', Templname);
end;

function TBusObjPrintDoc.ValidateData: Boolean;
begin
  result := false;
  if self.DocName = '' then begin
    AddResult(false,rssWarning,0,'Doc Name is blank');
    exit;
  end;
  if self.DocId < 1 then begin
    AddResult(false,rssWarning,0,'Doc ID is blank');
    exit;
  end;
  if self.PrintedBy < 1 then begin
    AddResult(false,rssWarning,0,'Printed By is blank');
    exit;
  end;
  if self.PrintedFrom = '' then begin
    AddResult(false,rssWarning,0,'Printed From is blank');
    exit;
  end;
  result := true;
end;

{docname an docid is not writen into XML as its the owner class properties.
At the moment, the importing should ignore any instance of this class from the owner class
becuase the printing should be done from the application, should not be imported from any
external file. }
procedure TBusObjPrintDoc.SaveToXMLNode(const node: IXMLNode);
begin
    AddXMLNode(node,'DocName',DocName);
    AddXMLNode(node,'PrintedFrom',PrintedFrom);
    AddXMLNode(node,'TemplateName',TemplateName);
    AddXMLNode(node,'Doctype',Doctype);
    AddXMLNode(node,'DocOutputType',DocOutputType);
    AddXMLNode(node,'DocId',DocId);
    AddXMLNode(node,'PrintDate',PrintDate);
    AddXMLNode(node,'PrintedBy',PrintedBy);
    AddXMLNode(node,'Printcount',Printcount);
end;

procedure TBusObjPrintDoc.LoadFromXMLNode(const node: IXMLNode);
begin
    SetPropertyFromNode(Node, 'DocName');
    SetPropertyFromNode(Node, 'PrintedFrom');
    SetPropertyFromNode(Node, 'TemplateName');
    SetPropertyFromNode(Node, 'Doctype');
    SetPropertyFromNode(Node, 'DocOutputType');
    SetPropertyFromNode(Node, 'DocID');
    SetDateTimePropertyFromNode(Node, 'Printdate');
    SetPropertyFromNode(Node, 'PrintedBy');
    SetPropertyFromNode(Node, 'Printcount');
end;

Class Function TBusObjPrintDoc.XMLBranchName :String;
begin
    REsult := 'Print';
end;

class function TBusObjPrintDoc._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TEmployee','EmpObj','PrintedBy','ID');
end;

function TBusObjPrintDoc.GetDocType: TDocumentType;
begin
  result := stringtoDocType(GetStringfield('doctype'));
end;

procedure TBusObjPrintDoc.SetDocType(const Value: TDocumentType);
begin
  SetStringField('docType' , DoctypetoString(Value));
end;

function TBusObjPrintDoc.GetDocOutputType: TDocumentOutputType;
begin
  result := stringtoDocOutputType(GetStringfield('DocOutputType'));
end;

procedure TBusObjPrintDoc.SetDocOutputType(const Value: TDocumentOutputType);
begin
  SetStringField('DocOutputType' , DocOutputTypetoString(Value));
end;

function TBusObjPrintDoc.Save: boolean;
begin
  {as printing is doens outside Save, this flag shoudl be turned on for logging purcpose}
  postdb;
  self.ResultStatus.Clear;
  result := self.ValidateData;
  if result then
    if accessmanager.accesslevel <= 3 then result := inherited Save;
end;

function StringToDoctype(const Value: String): TDocumentType;
begin
    result := dtMain;
    if Value = 'dtMain' then result := dtMain
    else if Value = 'dtPickSlip' then result := dtPickSlip
    else if Value =  'dtDelDock' then result := dtDelDock
    else if Value = 'dtStawySlip' then result := dtStawySlip;
end;

function DoctypetoString(const Value: TDocumenttype): String;
begin
    Result := '';
    if Value = dtMain then result := 'dtMain'
    else if Value = dtPickSlip then result := 'dtPickSlip'
    else if Value = dtStawySlip then result := 'dtStawySlip'
    else if Value = dtDelDock then result := 'dtDelDock';
end;

function StringToDocOutputType(const Value: String): TDocumentOutputType;
begin
    Result := dotPrint;
         if Value = 'dotPrint'    then result :=dotPrint
    else if Value = 'dotPreview'  then result :=dotPreview
    else if Value = 'dotEmail'    then result :=dotEmail
    else if Value = 'dotFax'      then result :=dotFax
    else if Value = 'dotEDI'      then result := dotEDI
    else if Value = 'dotPDF'      then result := dotPDF;

end;

function DocOutputTypetoString(const Value: TDocumentOutputType): String;
begin
    Result := '';
         if Value = dotPrint    then result :='dotPrint'
    else if Value = dotPreview  then result :='dotPreview'
    else if Value = dotEmail    then result :='dotEmail'
    else if Value = dotFax      then result :='dotFax'
    else if Value = dotEDI      then result := 'dotEDI'
    else if Value = dotPDF      then result := 'dotPDF';

end;

function PreviewToDocumentOutputType(const Value:Boolean):TDocumentOutputType;
begin
  if Value then result := dotPreview
  else Result := dotPrint;
end;

{ TInvoicePrintDoc }

constructor TInvoicePrintDoc.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblPrintDocs where DocName = "TInvoice"';
end;

function TInvoicePrintDoc.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  DocName := 'TInvoice';
end;

initialization
  RegisterClass(TBusObjPrintDoc);
  RegisterClass(TInvoicePrintDoc);

end.
