unit PrintDeliveryDocketLib;

interface

uses
  classes;

type
  TDeliveryDocketReportSQL = class(TObject)
  private
    fExcludeBackorders: boolean;
    fSaleId: integer;
    fReportToPrint: string;
    fOnExcludeBackordersVerify: TNotifyEvent;
    fReportSQLSupplied: boolean;
    fTemplateName: string;
  public
    constructor Create;
    destructor Destroy; override;
    property OnExcludeBackordersVerify: TNotifyEvent read fOnExcludeBackordersVerify write fOnExcludeBackordersVerify;
    property ExcludeBackorders: boolean read fExcludeBackorders write fExcludeBackorders;
    property SaleId: integer read fSaleId write fSaleId;
    property ReportToPrint: string read fReportToPrint write fReportToPrint;
    property TemplateName: string read fTemplateName write fTemplateName;
    property ReportSQLSupplied: boolean read fReportSQLSupplied write fReportSQLSupplied;
    function GetReportSQL: string;
  end;


implementation

uses
  ERPDbComponents, JsonObject, CommonDbLib, tcDataUtils,
  TemplateReportsTypeLib, SysUtils, AppEnvironment, PrintPickingSlipsLib;

{ TDeliveryDocketReportSQL }

constructor TDeliveryDocketReportSQL.Create;
begin
  //fExcludeBackorders := true;
  fExcludeBackorders := false;
  fSaleId := 0;
  fReportToPrint := '';
  fTemplateName := '';
  fReportSQLSupplied := false;
end;

destructor TDeliveryDocketReportSQL.Destroy;
begin

  inherited;
end;

function TDeliveryDocketReportSQL.GetReportSQL: string;
var
  qry: TERPQuery;
  Json: TJsonObject;

  function Transtype:String;
  begin
    result :='';
    if qry.FieldByname('IsInvoice').asboolean then result := 'TInvoiceLine'
    else if qry.FieldByname('IsSalesOrder').asboolean then result := 'TSalesOrderLine'
    else if qry.FieldByname('IsQuote').asboolean then result := 'TQuoteLine';
  end;

begin
  result := '';
  Json := nil;
  TemplateName := ReportToPrint;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select IsSalesOrder, IsInvoice, IsQuote, ClientID, BOID');
    qry.SQL.Add('from tblsales where SaleID = ' + IntToStr(SaleID));
    qry.Open;
    if TemplateName = '' then TemplateName := DeliverydocketTemplateForSale( saleID);
    (*if TemplateName = '' then TemplateName :=
      tcDataUtils.GetTemplate(tcDataUtils.ClientDefaultDeliveryTemplateID(qry.FieldByName('ClientId').AsInteger));
    if TemplateName = '' then TemplateReportsTypeLib.GetDefaultReport('Delivery Docket');
    if TemplateName = '' then if IsSaleOnHold(SaleID) then
      TemplateName := 'Delivery Docket Held'
    else
      TemplateName := 'Delivery Docket';*)
    if SameText(Copy(TemplateName+ '              ' , 1, 14), 'Bill of Lading') then begin
      result :=  '~|||~where S.SAleId = ' +IntToStr(SaleID);
      if AppEnv.CompanyPrefs.RemoveHideOnPrintProductFromReports then
        result := result + ' AND (P.HideOnPrint = "F"  and (SL.IsRelatedProduct = "F" or ( SL.IsRelatedProduct = "T" and RP.HideRelated  = "F" and RP.ISContainer="F" and RP.IsPallet="F")))';
      result := result + 'order by   if(ifnull(P.PRODUCTAttrib1,0)>0 , if(ifnull( UOM.Weight,0)>= ifnull(P.PRODUCTAttrib1,0) , 1 , 2) , if(ifnull(P.generalnotes,"") <> "" , 3 , 4)) , P.PRODUCTAttrib1, RQ ';
      ReportSQLSupplied := False;
    end else if not(SameText(Trim(TemplateName) , 'Delivery Docket With Details')) then begin
      result :=  '~|||~~|||~AND d2.SaleID = ' +IntToStr(SaleID);
      if (AppEnv.CompanyPrefs.ExcludeBOFromPrintinSales) and (qry.FieldByName('BOID').AsString <> '')  then
        if Assigned(fOnExcludeBackordersVerify) then
          fOnExcludeBackordersVerify(self);

        if self.ExcludeBackorders then
          result := result + ' AND ifnull(d3.shipped,0) <> 0 ';
        ReportSQLSupplied:= False;
    end else begin
      ReportSQLSupplied:= True;
      result:= PrintPickingSlipsLib.SQL4PickingSlipreport(ReportToPrint,Json, IntToStr(SaleID), TransType);
    end;
  finally
    Json.Free;
    qry.Free;
  end;
end;



end.
