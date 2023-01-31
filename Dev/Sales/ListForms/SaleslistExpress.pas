unit SaleslistExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseListExpress, DAScript,
  MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSaleslistExpressGUI = class(TBaseListExpressGUI)
    qryMainSaleId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainConverted: TWideStringField;
    qryMainfutureSo: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainDone: TWideStringField;
    qryMainType: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainShipDate: TDateField;
    qryMainHeld: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainTerms: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainComments: TWideMemoField;
    qryMainTotalAmount: TFloatField;
    qryMainSaleNo: TWideStringField;
    qryMainClientId: TIntegerField;
    qryMaindueDate: TDateField;
    qryMainemployeename: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainPrintName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); Override;
  private
    fiCustomerId: Integer;
    fExcludeDeleted: boolean;
    { Private declarations }
  Protected
    Function ListType:String;Virtual;abstract;
    procedure SetGridColumns; Override;
    procedure MakeQryMain; Virtual;
    property ExcludeDeleted: boolean read fExcludeDeleted write fExcludeDeleted;
    //function Extraconditions: String;Virtual;
    function ExtraFields: String;Virtual;
    function ExtraTables: String;Virtual;
  public
    Procedure RefreshQuery; Override;
    Property CustomerId:Integer read fiCustomerId write fiCustomerId;
  end;


implementation

uses CommonFormLib, dateutils, tcDataUtils, StrUtils, ProductQtyLib,
  InvoicelistExpress, AppEnvironment, SalesorderListExpress, QuoteListExpress,
  MySQLConst, InvoiceInternalOrderlistExress, AmazonSalesOrderExpress,
  ColesSaleslistExpress, ColesORDRSPExpressList, ColesDESADVExpressList, ColesInvoicelistExpress;

{$R *.dfm}

procedure TSaleslistExpressGUI.FormCreate(Sender: TObject);
begin
  Qrymain.Parambyname('Listtype').asString:= ListType;
  fiCustomerId :=0;
  fExcludeDeleted := true;
  MakeQryMain;
  inherited;
  KeyIdfieldname := 'SaleID';
end;

procedure TSaleslistExpressGUI.grdMainDblClick(Sender: TObject);
begin
//  if SameText(ActiveFieldname , Qrymaincustomername.fieldname) then
//    if Clienttype(QrymainClientID.asInteger)  = ttcustomer then
//      SubsequentID := '_Customer'
//    else
//      SubsequentID := '_Job';
  inherited;
  SubsequentID:= '';
end;

procedure TSaleslistExpressGUI.MakeQryMain;
begin
    Qrymain.Sql.clear;
    Qrymain.Sql.Add('Select Distinct ');
    Qrymain.Sql.Add('S.clientId           AS ClientId, ');
    Qrymain.Sql.Add('S.InvoiceDocNumber   AS Saleno, ');
    Qrymain.Sql.Add('S.SaleId             AS SaleId, ');
    Qrymain.Sql.Add('S.BOID               AS BORef, ');
    Qrymain.Sql.Add('S.Customername       AS CustomerName, ');
    Qrymain.Sql.Add('S.ClientPrintName    AS PrintName, ');
    Qrymain.Sql.Add('S.totalAmountinc     AS TotalAmountinc, ');
    Qrymain.Sql.Add('S.TotalTax     AS TotalTax, ');
    Qrymain.Sql.Add('S.totalAmount        AS TotalAmount, ');
    Qrymain.Sql.Add('S.Payment            AS Payment, ');
    Qrymain.Sql.Add('S.balance            AS Balance, ');
    Qrymain.Sql.Add('S.SaleDate           AS SaleDate, ');
    Qrymain.Sql.Add('Date(S.SaleDateTime) AS TransDate, ');
    Qrymain.Sql.Add('Time(S.SaleDateTime) AS TransTime, ');
    Qrymain.Sql.Add('S.Converted          AS Converted, ');
    Qrymain.Sql.Add('S.futureSo           AS futureSo, ');
    Qrymain.Sql.Add('if(S.Deleted="T" or S.ISDone="T", "T", "F")            AS Done, ');
    Qrymain.Sql.Add(SaleType('S')+ '      AS Type, ');
    Qrymain.Sql.Add('S.QuoteStatus        AS Status, ');
    Qrymain.Sql.Add('S.ShipDate           AS shipdate, ');
    Qrymain.Sql.Add('S.HoldSale           AS held, ');
    Qrymain.Sql.Add('S.PONumber           AS PONumber, ');
    Qrymain.Sql.Add('S.terms              AS terms, ');
    Qrymain.Sql.Add('S.Comments           AS Comments, ');
    Qrymain.Sql.Add('S.Class              AS ClassName, ');
    Qrymain.Sql.Add('S.dueDate            AS dueDate, ');
    Qrymain.Sql.Add('S.employeename       AS employeename, ');
    Qrymain.Sql.Add('ReplaceNewLine(S.ShipTo,"") as ShipTo , ');
    Qrymain.Sql.Add(ExtraFields);
    Qrymain.Sql.Add('If(IsNull(S.ClientSignature),"F","T") AS HasSignature ');
    if (self is TColesSaleslistExpressGUI) or (self is TColesInvoicelistExpressGUI) then
    begin
      Qrymain.Sql.Add(',ref.SynchState ');
      Qrymain.Sql.Add(',ref.ID as refid ');
    end;
    Qrymain.Sql.Add('From tblSales S ');

    if self is TColesInvoicelistExpressGUI then
      Qrymain.Sql.Add('inner join tblexternalxref as ref on ERPID = s.saleid and ExternalType = "Coles" and ObjectType = "INVOIC"')
    else if self is TColesORDRSPExpressListGUI then
      Qrymain.Sql.Add('inner join tblexternalxref as ref on ERPID = s.saleid and ExternalType = "Coles" and ObjectType = "ORDRSP"')
    else if self is TColesDESADVExpressListGUI then
      Qrymain.Sql.Add('inner join tblexternalxref as ref on ERPID = s.saleid and ExternalType = "Coles" and ObjectType = "DESADV"')
    else if self is TColesSaleslistExpressGUI then
      Qrymain.Sql.Add('inner join tblexternalxref as ref on ERPID = s.saleid and ExternalType = "Coles" and ObjectType = "ORDERS"');

    Qrymain.Sql.Add('inner join tblsaleslines SL on S.saleID = SL.SaleId  ');

    if not(self is TAmazonSalesOrderExpressGUI) then Qrymain.Sql.Add(' AND  SL.Invoiced = "T"');
         if Self is TInvoiceInternalOrderlistExressGUI  then Qrymain.Sql.Add('  AND S.ISInternalOrder ="T" AND ( (S.IsPOS = "T" or S.IsRefund = "T" or S.IsCashSale = "T" or S.IsInvoice = "T") and S.islayby ="F")  ')
    else if Self is TInvoicelistExpressGUI              then Qrymain.Sql.Add('  AND S.ISInternalOrder ="F" AND ( (S.IsPOS = "T" or S.IsRefund = "T" or S.IsCashSale = "T" or S.IsInvoice = "T") and S.islayby ="F")  ')
    else if Self is TSalesorderListExpressGUI           then Qrymain.Sql.Add('  AND S.IsSalesOrder = "T" AND (S.IsCashSale="F" OR S.IsLayByTOS= "T") ')
    else if self is TAmazonSalesOrderExpressGUI         then Qrymain.Sql.Add('  AND S.IsSalesOrder = "T" AND (S.IsCashSale="F" OR S.IsLayByTOS= "T") ')
    else if self is TQuoteListExpressGUI                then Qrymain.Sql.Add('  AND S.IsQuote="T" ');

    Qrymain.Sql.Add(ExtraTables);

    if ExcludeDeleted then
      Qrymain.Sql.Add('Where s.deleted ="F" ')
    else
      Qrymain.Sql.Add('Where (s.deleted ="F" or s.deleted ="T")');

    Qrymain.Sql.Add('and S.SaleDate between :DateFrom and  :dateTo ');
    Qrymain.Sql.Add('and (:CustomerId =0 or S.clientID = :CustomerId) ');
    Qrymain.Sql.Add('AND (:SalesClassId =0 or S.ClassID = :SalesClassId) ');

    //Qrymain.Sql.Add(Extraconditions);
    Qrymain.Sql.Add('Order by S.SaleID Desc');
    RefreshOrignalSQL(true);
end;
Function TSaleslistExpressGUI.ExtraFields:String; begin end;
Function TSaleslistExpressGUI.ExtraTables:String; begin end;
(*Function TSaleslistExpressGUI.Extraconditions:String; begin end;*)

procedure TSaleslistExpressGUI.RefreshQuery;
begin
  //MakeQryMain;
  //qryMain.Params.ParamByName('DateFrom').AsDateTime := FilterDateFrom;
  //qryMain.Params.ParamByName('Dateto').AsDateTime   := FilterDateTo;
  InitDateFromnDateto;
  qryMain.Params.ParamByName('CustomerId').asInteger:= fiCustomerID;
  qryMain.Params.ParamByName('SalesClassId').asInteger:= 0;
  if Self is TInvoicelistExpressGUI then
      if not(AppEnv.CompanyPrefs.InvoiceClassDefaultAll and AllClasses) then
          if AppEnv.CompanyPrefs.InvoiceClassDefaultAll   then
            qryMain.Params.ParamByName('SalesClassId').asInteger:= SelectedClassID
          else qryMain.Params.ParamByName('SalesClassId').asInteger:= appenv.Employee.DefaultClassID;

  inherited;
end;

procedure TSaleslistExpressGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainClientId.Fieldname);
end;
end.

