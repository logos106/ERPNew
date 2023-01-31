unit TemplateReportSelectObj;

interface

uses
  classes, JsonObject;

type
  TUserConfirmFunc = function(aConfirmType: string; var Handled: boolean): boolean of object;
  TStepProgressFunc = procedure() of object;
  TShowProgressFunc = procedure(ProgressBarCaption: String; ProgressCount: Integer = 0) of object;
  THideProgressFunc = procedure() of object;


  TTemplateReportSelect = class(TObject)
  private
    fSQL: TStringList;
    fReportSQLSupplied: boolean;
    fReportToPrint: string;
    fID: integer;
    fOnStepProgress: TStepProgressFunc;
    fOnShowProgressBar: TShowProgressFunc;
    fOnHideProgressBar: THideProgressFunc;
    fGroupReportByClass: boolean;
    function GetReportTypeName: string ;
    procedure SetReportSQLSupplied(const Value: boolean);
  protected
    JsonCtr: integer;
    fDoUserConfirm: TUserConfirmFunc;
    procedure SetID(const Value: integer); virtual;
    procedure MakeSQL(SQL: TStringList); virtual;
    procedure TransSpecificSQL(SQL: TStringList); virtual;
    procedure AddMasterSourceDetails(MasterDs, DetailDs, MasterFields, DetailFields: string);
    procedure ShowProgressBar(ProgressBarCaption: String; ProgressCount: Integer = 0);
    procedure HideProgressBar;
    procedure StepProgressBar;
    procedure AddSQLPortion(x: Integer; aSQLPortion: String);
    property ReportTypeName: string read GetReportTypeName;
  public
    Json: TJsonObject;
    function SelectSQL: string;
    constructor Create; virtual;
    destructor Destroy; override;
    property SQLStringList: TStringList read fSQL;
    property ID: integer read fID write SetID;
    property ReportToPrint: string read fReportToPrint write fReportToPrint;
    property ReportSQLSupplied: boolean read fReportSQLSupplied write SetReportSQLSupplied;
    property GroupReportByClass: boolean read fGroupReportByClass write fGroupReportByClass;
    property OnUserConfirm: TUserConfirmFunc read fDoUserConfirm write fDoUserConfirm;
    property OnStepProgress: TStepProgressFunc read fOnStepProgress write fOnStepProgress;
    property OnShowProgressBar: TShowProgressFunc read fOnShowProgressBar write fOnShowProgressBar;
    property OnHideProgressBar: THideProgressFunc read fOnHideProgressBar write fOnHideProgressBar;
  end;

  TRTSelBaseTrans = class(TTemplateReportSelect)
  private
    fMatrixReportType: string;
    fClientID: integer;
    fTransType: string;
    function PrintMatrixSQL(ReportTemplName: string; TransType: String; ID: Integer): String;
    function GetClientID: integer;
  protected
    TempTableName: string;
    Tablename1, Tablename2: String;
    ExcludeBOSQL: string;
    Function PrintMatrixYSQL(const ID: Integer ; var ReportTablename: String;
      IsYMode: Boolean; IncludeBOM: Boolean; var Json: TJsonObject): String;
    procedure SetID(const Value: integer); override;
    procedure MakeSQL(SQL: TStringList); override;
    procedure TransSpecificSQL(SQL: TStringList); override;
    property MatrixReportType: string read fMatrixReportType write fMatrixReportType;
    function IDFieldName: string; virtual; abstract;
    function IstoExcludeBoFromPrint: boolean;
    Function SLPrefix: String;
    procedure MakeExcludeBOSQL;
    property ClientID: integer read GetClientID;
    procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
    function SalesOrderManufactureReportSQL(Includeallocation: Boolean = False): String;
    function RepairSalesSQL: String;
    function InvoiceGroupSQL: String;
//    function TransType: string;
  public
    constructor Create; override;
    destructor Destroy; override;
    property TransType: string read fTransType write fTransType;
  end;

  TRTSelSale = class(TRTSelBaseTrans)
  protected
    procedure MakeSQL(SQL: TStringList); override;
    function IDFieldName: string; override;
    procedure TransSpecificSQL(SQL: TStringList); override;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TRTSelOrder = class(TRTSelBaseTrans)
  protected
    function IDFieldName: string; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TRTSelInvoice = class(TRTSelSale)
  protected
    procedure MakeSQL(SQL: TStringList); override;
    procedure TransSpecificSQL(SQL: TStringList); override;
  end;

  TRTSelSalesOrder = class(TRTSelSale)
  end;

  TRTSelQuote = class(TRTSelSale)
  end;

  TRTSelCashBase = class(TRTSelBaseTrans)
  protected
    function IDFieldName: string; override;
  end;

  TRTSelRefundSale = class(TRTSelCashBase)
  end;

  TRTSelCustomerReturn = class(TRTSelRefundSale)
  end;

  TRTSelPOSCashSale = class(TRTSelCashBase)
  end;

  TRTSelVoucherCashSale = class(TRTSelPOSCashSale)
  end;

  TRTSelPurchaseOrder = class(TRTSelOrder)
  end;

  TRTSelCashSale = class(TRTSelCashBase)
  end;

  TRTSelRefund = class(TRTSelCashBase)
  end;

  TRTSelDeliveryDocket = class(TTemplateReportSelect)
  private
  protected
    procedure MakeSQL(SQL: TStringList); override;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;


implementation

uses
  CommonLib, CommonDbLib, SysUtils, ERPDbComponents, AppEnvironment, Variants,
  DB, MatrixObj, tcConst, PrintPickingSlipsLib, StrUtils, TemplateReportsLib,
  ManufactureLib, ProductQtyLib, RepairsLib, BusObjRepairs,
  PrintDeliveryDocketLib;


{ TTemplateReportSelect }

procedure TTemplateReportSelect.AddMasterSourceDetails(MasterDs, DetailDs,
  MasterFields, DetailFields: string);
begin
  if JsonCtr = 0 then Json := JO;
  JsonCtr := JsonCtr +1;
  Json.O[IntToStr(Jsonctr)].S['master']:= masterds;
  Json.O[IntToStr(Jsonctr)].S['detail']:= detailds;
  Json.O[IntToStr(Jsonctr)].S['masterfields']:=masterfields;
  Json.O[IntToStr(Jsonctr)].S['detailfields']:= detailfields;
end;

procedure TTemplateReportSelect.AddSQLPortion(x: Integer; aSQLPortion: String);
begin
  if x <= 1 then exit;
  While StringCount('~|||~', fSQL.Text) < x - 1 do fSQL.Add('~|||~');
  if aSQLPortion <> '' then fSQL.Add(aSQLPortion);
end;

constructor TTemplateReportSelect.Create;
begin
  fSQL := TStringList.Create;
  fGroupReportByClass := false;
end;

destructor TTemplateReportSelect.Destroy;
begin
  fSQL.Free;
  Json.Free;
  inherited;
end;

function TTemplateReportSelect.GetReportTypeName: string;
var
  qry: TERPQuery;
begin
  result := '';
  if ReportToPrint = '' then exit;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select tbltemplatetype.TypeName from tbltemplatetype');
    qry.SQL.Add('inner join tbltemplates on tbltemplates.TemplName = ' + QuotedStr(ReportToPrint));
    qry.SQL.Add('and tbltemplates.TypeID = tbltemplatetype.TypeID');
    qry.Open;
    result := qry.FieldByName('TypeName').AsString;
    if result = '' then begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select tbltemplatetype.TypeName from tbltemplatetype');
      qry.SQL.Add('inner join tbltemplates on tbltemplates.TemplateClass = ' + QuotedStr(ReportToPrint));
      qry.SQL.Add('and tbltemplates.TypeID = tbltemplatetype.TypeID');
      qry.Open;
      result := qry.FieldByName('TypeName').AsString;
    end;
  finally
    qry.Free;
  end;
end;

procedure TTemplateReportSelect.HideProgressBar;
begin
  if Assigned(fOnHideProgressBar) then
    fOnHideProgressBar;
end;

procedure TTemplateReportSelect.MakeSQL(SQL: TStringList);
begin
  { override in desendant classes }
end;

function TTemplateReportSelect.SelectSQL: string;
begin
  MakeSQL(fSQL);
  result := fSQL.Text;
end;



procedure TTemplateReportSelect.SetID(const Value: integer);
begin
  fID := Value;
end;

procedure TTemplateReportSelect.SetReportSQLSupplied(const Value: boolean);
begin
  fReportSQLSupplied := Value;
end;

procedure TTemplateReportSelect.ShowProgressBar(ProgressBarCaption: String;
  ProgressCount: Integer);
begin
  if Assigned(fOnShowProgressBar) then
    fOnShowProgressBar(ProgressBarCaption, ProgressCount);
end;

procedure TTemplateReportSelect.StepProgressBar;
begin
  if Assigned(fOnStepProgress) then
    fOnStepProgress;
end;

procedure TTemplateReportSelect.TransSpecificSQL(SQL: TStringList);
begin

end;

{ TRTSelBaseTrans }

constructor TRTSelBaseTrans.Create;
begin
  inherited;
  TempTableName := '';
  Tablename1 := '';
  Tablename2 := '';
end;

destructor TRTSelBaseTrans.Destroy;
begin
  DestroyUserTemporaryTable(TempTableName);
  DestroyUserTemporaryTable(Tablename1);
  DestroyUserTemporaryTable(Tablename2);
  inherited;
end;

function TRTSelBaseTrans.GetClientID: integer;
var
  qry: TERPQuery;
begin
  if (fClientID = 0) and (ID > 0) then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Add('Select ClientID');
      if self is TRTSelOrder then begin
        qry.SQL.Add('from tblpurchaseorders');
        qry.SQL.Add('where PurchaseOrderID = ' + IntToStr(ID));
      end
      else if self is TRTSelSale then begin
        qry.SQL.Add('from tblsales');
        qry.SQL.Add('where SaleID = ' + IntToStr(ID));
      end;
      qry.Open;
      fClientID := qry.FieldByName('ClientID').AsInteger;
    finally
      qry.Free;
    end;
  end;
  result := fClientID;
end;

function TRTSelBaseTrans.InvoiceGroupSQL: String;
begin
  result :=' AND d3.ProductName <>"Memo Only" ' +
    ' AND d2.SaleId = '+IntToStr(ID) +
    ' GROUP By d2.SaleID,ProductID,d3.LinePrice,d3.UnitofMeasureSaleLines'+
    ' Order by d3.Sortid '+
    ' ~|||~' +' and saleId = '+IntToStr(ID) ;
end;

function TRTSelBaseTrans.IstoExcludeBoFromPrint: boolean;
var
  qry: TERPQuery;
  Handled: boolean;
  Exclude: boolean;
begin
//  result := ((TransBase is TOrderBase) and (AppEnv.CompanyPrefs.ExcludeBOFromPrintinPO)    and (tblMaster.FieldByName('TotalAmountInc').AsFloat <> 0) )
//                    or
//           (((TransBase is Tsales)    and (AppEnv.CompanyPrefs.ExcludeBOFromPrintinSales) and (tblMaster.FieldByName('TotalAmountInc').AsFloat <> 0) and (not SameText(TransBase.TransName,'Quote')))  ) ;
//  if result then
//    result:= MessageDlgXP_Vista('Do You Wish to Exclude the Back Ordered Items From Print?' , mtConfirmation , [mbyes, mbno] , 0 ) = mryes;
  result := false;
  if (self is TRTSelOrder) then begin
    if AppEnv.CompanyPrefs.ExcludeBOFromPrintinPO then begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := CommonDbLib.GetSharedMyDacConnection;
        qry.SQL.Add('select TotalAmountInc from tblpurchaseorders');
        qry.SQL.Add('where PurchaseOrderId = ' + IntToStr(ID));
        qry.Open;
        if qry.FieldByName('TotalAmountInc').AsFloat <> 0 then
          result := true;
      finally
        qry.Free;
      end;
    end;
  end
  else if (self is TRTSelSale) and (not (self is TRTSelQuote)) then begin
    if AppEnv.CompanyPrefs.ExcludeBOFromPrintinSales then begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := CommonDbLib.GetSharedMyDacConnection;
        qry.SQL.Add('select TotalAmountInc from tblSales');
        qry.SQL.Add('where SaleID = ' + IntToStr(ID));
        qry.Open;
        if qry.FieldByName('TotalAmountInc').AsFloat <> 0 then
          result := true;
      finally
        qry.Free;
      end;
    end;
  end;
  if result then begin
    if Assigned(fDoUserConfirm) then begin
      Handled := false;
      Exclude := fDoUserConfirm('ExcludeBOFromPrint', Handled);
      if Handled then
        result := Exclude;
    end;
  end;
end;

procedure TRTSelBaseTrans.MakeExcludeBOSQL;
begin
  if ExcludeBOSQL = '' then begin
    ExcludeBOSQL:= '  ';
    if IsToExcludeBoFromPrint then ExcludeBOSQL := ' AND ifnull('+SLPrefix+'.shipped,0) <> 0 ';
    if (self is TRTSelSale) or (self is TRTSelCashBase) then
      if appenv.CompanyPrefs.RemoveHideOnPrintProductFromReports then
        ExcludeBOSQL := ExcludeBOSQL +
          ' AND (P.HideOnPrint = "F"  and ('+SLPrefix+'.IsRelatedProduct = "F" or ( '+SLPrefix+'.IsRelatedProduct = "T" and ifnull(d5.HideRelated,"F")  <> "T")))';
  end;
end;

procedure TRTSelBaseTrans.MakeSQL(SQL: TStringList);
var
  x: integer;
begin
  inherited;
  if  StringContains(ReportToPrint,'(Matrix)') then begin
    SQL.Text := PrintMatrixSQL(ReportToPrint , MatrixReportType , ID);
    ReportSQLSupplied := true;
    TransSpecificSQL(SQL);
  end
  else if (StringContains(ReportToPrint,'(Matrix-X)')) or (Stringcontains(ReportToPrint,'(Matrix-Y)'))  then begin
    SQL.Add(PrintMatrixYSQL(ID, TableName1 , StringContains(ReportToPrint,'(Matrix-Y)'),
      Stringcontains(ReportToPrint,'(BOM)') , Json));
      TableName2 := TableName1+'BOM';
    ReportSQLSupplied := true;
  end
  else if (self is TRTSelInvoice) and SameText(ReportToPrint , 'Invoice with details') then begin
    SQL.Add( PrintPickingSlipsLib.SQL4PickingSlipreport(ReportToPrint,json , IntToStr(ID), 'TInvoiceLine'));
    ReportSQLSupplied := true;
    TransSpecificSQL(SQL);
  end
  else if (PosEx('with Customer Ref' , ReportToPrint)<>0) then begin
      AddMasterSourceDetails('Sales','SalesLines'       ,'SaleId'   ,'SaleID'     );
      AddMasterSourceDetails('Sales','CustomerReferals' ,'ClientID' ,'C.clientID' );
      AddMasterSourceDetails('Sales','ShippingDetails'  ,'SaleID'   ,'Sd.SalesID' );
      AddMasterSourceDetails('Sales','ProductDetails'   ,'SaleId'   ,'S.SaleId'   );
      {Sales}
      SQL.Add(' Where S.' + IDFieldName +' = '+ IntToStr(ID));

      {SalesLines}
      MakeExcludeBOSQL;
      SQL.Add(' ~|||~ Where '+SLPrefix+'.' + IDFieldName +' = '+ IntToStr(ID)+ ' and ifnull('+SLPrefix+'.BOMProductionLine, "F") ="F"  ' + ExcludeBOSQL)  ;
      if (self is TRTSelSale) and ( Appenv.companyprefs.SalesPrintOrderBy <> '' ) then
        SQL.Add(' order by '+SLPrefix+'.' +trim(Appenv.companyprefs.SalesPrintOrderBy )+','+SLPrefix+'.sortID')
      else  SQL.Add(' order by '+SLPrefix+'.sortID');

      {CustomerReferals}
      SQL.Add(' ~|||~ Where R.ClientID = ' +IntToStr(ClientID)) ;
      {ShippingDetails}
      SQL.Add(' ~|||~ Where SD.salesid = ' + IntToStr(ID)+ ' Group by SD.SalesID') ;

      {ProductDetails}
      SQL.Add(' ~|||~ Where '+SLPrefix+'.SaleID = ' + IntToStr(ID)+' group by P.CommodityCode , P.Description , P.ProductUOM , P.countryofOriginID ');
      {companyInfo}
      SQL.Add(' ~|||~ ');

      {TaxDetails}
      if (TemplateContainsSection('TaxDetails',ReportToPrint,x))  then
        SQL.Add('~|||~ where TTC.' +TRim(IDFieldname)+' = ' +inttostr(ID) +' group by TTCL.`SubTaxCode`');
      {ClientCustomFields}
      SQL.Add(' ~|||~ and Trans.' +TRim(IDFieldname)+' = ' +inttostr(ID));

      {ShippingAddress}
      SQL.Add(' ~|||~ Where S.saleId = '+ IntToStr(ID));

      {ShippingDetails}
      SQL.Add('  ~|||~ Where salesId = '+ IntToStr(ID));
  end
  else if Sametext(Reporttoprint, 'Sale Tree') or Sametext(Reporttoprint, 'Quote Tree') or Sametext(Reporttoprint, 'Invoice Tree')  then begin
    if tablename1 = '' then tablename1 := GetUserTemporaryTableName(StripQuotes(Reporttoprint)+'_PrintTreeSQL');
    SQL.Add('{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN ' +
          ' FROM tblCompanyInformation AS CO ' +
          ' ~|||~{Details}' + SalesPrintTreeSQLWithNodeSelected(Tablename1, SalesPrintTreeSQL(inttostr(ID) ))+
          '~|||~{Sales}Select S.* , C.Phone , C.FaxNumber , C.Mobile from tblSales S inner join tblclients C on C.clientId = S.clientId where S.SaleId =  ' +IntToStr(ID)+
          '~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,   Sum(TTCL.`TaxAmount`) TaxAmount from tblsalestaxcodelines TTCL  inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID  '+
                ' Where TTC.SaleId = ' + IntToStr(ID) +' group by TTCL.`SubTaxCode` '+
          '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value  '+
                ' from  tblsales Trans   '+
                ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID  '+
                ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId  '+
                ' where ifnull(CCV.Value,"")<>"" and CFL.ListType = "ltCustomer" And Trans.SaleId = ' + IntToStr(ID));
    ReportSQLSupplied := true;
    TransSpecificSQL(SQL);
  end
  else if (Sysutils.SameText(ReportToPrint , 'Sales Order With Options')) or (Sysutils.SameText(ReportToPrint , 'Sales Order Manufacture')) then begin
    ReportSQLSupplied := true;
    SQL.Text := SalesOrderManufactureReportSQL;
    TransSpecificSQL(SQL);
    SQL.Add('~|||~{CompanyInfo}'
           +' SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN '
           +' FROM tblCompanyInformation AS CO');
  end
  else if (PosEx('Customer Return' , ReportToPrint)= 1) then begin//end else if (Sysutils.SameText(ReportToPrint , 'Customer Return')) then begin
    ReportSQLSupplied := False;
    SQL.Add(' AND d2.saleId = ' + inttostr(ID) + '~|||~'+
              ' AND trans.saleId = ' + inttostr(ID)+'~|||~') ;
  end
//  else if (GetReportTypeID = 106) then begin {voucher}
  else if SameText(ReportTypeName, 'Voucher') then begin
    SQL.Add('~|||~ and d2.SaleID = ' + inttostr(ID) +
             '~|||~ where TTC.' +TRim(IDFieldname)+' = ' +inttostr(ID) +' group by TTCL.`SubTaxCode`'+
             '~|||~ and Trans.' +TRim(IDFieldname)+' = ' +inttostr(ID));
    TransSpecificSQL(SQL);
    ReportSQLSupplied := False;
  end
  else if ((self is TRTSelInvoice) or (self is TRTSelSalesOrder)) and (PosEx('(Repair Details)' , ReportToPrint) <> 0) then begin
    ReportSQLSupplied := true;
    SQL.Text := RepairSalesSQL;
  end
  else begin
    MakeExcludeBOSQL;
//    if Sysutils.SameText(ReportToPrint , 'Purchase Order (Store Away)') or Sysutils.SameText(ReportToPrint ,  'Purchase Order(Alloc)') then begin
    if (Pos('purchase order', Lowercase(ReportToPrint)) > 0) and
      ((Pos('store away', Lowercase(ReportToPrint)) > 0) or (Pos('alloc', Lowercase(ReportToPrint)) > 0)) then begin
      SQL.Add(' ~|||~ WHERE PO.'+IDFieldName+ ' = '+IntToStr(ID)+ ExcludeBOSQL) ;
    end else if  Assigned(StrPos(PChar(ReportToPrint), PChar('Purchase Order ShipTo'))) then begin
      SQL.Add(' ~|||~ WHERE P.'+IDFieldName+ ' = '+IntToStr(ID)+ ExcludeBOSQL) ;
    end else begin
      SQL.Add(ExcludeBOSQL  + ' AND d2.' + IDFieldName +' = '+ IntToStr(ID));
      if self is TRTSelSalesOrder then
        SQL.Add(' and ifnull('+SLPrefix+'.BOMProductionLine, "F") ="F"');
    end;

    if self is TRTSelPurchaseOrder then begin
      {purchase order specific}
      if GroupReportByClass then begin
        ReportToPrint := 'Purchase Order(Produc group)';
      end;

      if Sysutils.SameText(ReportToPrint , 'Purchase Order (Store Away)') or Sysutils.SameText(ReportToPrint ,  'Purchase Order(Alloc)') then begin
        SQL.Add(' Group by  PurchaseLineId, '+
                        ' ifnull(PQABatch.Value,"") ,ifnull(PQABatch.TruckLoadNo,"") , ifnull(PQABatch.ExpiryDate,0),'+
                        ' ifnull(PBin.binnumber,""), ifnull(PBin.Binlocation,"") ');
        if Sysutils.SameText(ReportToPrint ,  'Purchase Order(Alloc)') then
          SQL.Add(',ifnull(PQASn.Value,"")');
        SQL.Add(' Order by PurchaseLineId, '+
                        ' ifnull(PQABatch.Value,"")  ,ifnull(PQABatch.TruckLoadNo,""), ifnull(PQABatch.ExpiryDate,0),'+
                        ' ifnull(PBin.binnumber,""), ifnull(PBin.Binlocation,"") ');
        if Sysutils.SameText(ReportToPrint ,  'Purchase Order(Alloc)') then
          SQL.Add(',ifnull(PQASn.Value,"")');
      end
      else begin
        if not Assigned(StrPos(PChar(ReportToPrint), PChar('Purchase Order ShipTo'))) then begin
          SQL.Add(' Group by PurchaseLineID ');
        end;
        if GroupReportByClass then begin
          SQL.Add(' order by class,classid,  productName, ProductId, sortID');
        end else begin
          SQL.Add(' order by SortID');
        end;
      end;
    end else if Self is TRTSelInvoice then begin
      {invoice}
      if Sametext(Trim(ReportToPrint) ,'Invoice Grouped') or (sametext(Trim(reporttoPrint) , 'InvoiceGroup')) then begin
        SQL.Add(ExcludeBOSQL + InvoiceGroupSQL);
      end else if (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg3')) or
          (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg3Det')) then begin
        SQL.Add(ExcludeBOSQL + ' AND d2.SaleId ='+ IntToStr(ID));
        SQL.Add(  //' Group by ' + ProductQtylib.Thirdcolumn(SLPrefix)+',' +ProductQtylib.SecondColumn(SLPrefix)+',' +ProductQtylib.Firstcolumn(SLPrefix)+
                      ' Order by Thirdcolumn,SecondColumn,Firstcolumn');
      end else if (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg2')) or
          (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg2Det')) then begin
        SQL.Add(ExcludeBOSQL + ' AND d2.SaleId ='+ IntToStr(ID));
        SQL.Add(  //' Group by ' + ProductQtylib.SecondColumn(SLPrefix)+',' +ProductQtylib.Firstcolumn(SLPrefix)+',' +ProductQtylib.Thirdcolumn(SLPrefix)+
                        ' Order by SecondColumn,Firstcolumn,Thirdcolumn');
      end else if (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg')) or
          (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatgDet')) then begin
        SQL.Add(ExcludeBOSQL + ' AND d2.SaleId ='+ IntToStr(ID));
        SQL.Add( //' Group by ' + ProductQtylib.Firstcolumn(SLPrefix)+',' +ProductQtylib.SecondColumn(SLPrefix)+',' +ProductQtylib.Thirdcolumn(SLPrefix)+
                       ' Order by Firstcolumn,SecondColumn,Thirdcolumn');
      end;
    end else if Self is TRTSelCashSale then begin
      {Cash Sale}
      if ReportToPrint = 'Cash Sale Grouped' then begin
        SQL.Add(' AND '+SLPrefix+'.ProductName <> "Memo Only"');
        SQL.Add(' GROUP By d2.SaleID,ProductID,'+SLPrefix+'.LinePrice,'+SLPrefix+'.UnitofMeasureSaleLines  order by '+SLPrefix+'.sortID');
      end;
    end else if Self is TRTSelQuote then begin
      if (Sysutils.SameText(ReportToPrint , 'Quote_GroupOnCatg2')) or
          (Sysutils.SameText(ReportToPrint , 'Quote_GroupOnCatg2Det')) then begin
        SQL.Add(ExcludeBOSQL + ' AND d2.SaleId ='+ IntToStr(ID));
        SQL.Add( ' Order by SecondColumn,Firstcolumn,Thirdcolumn');
      end;
    end;

    if pos(uppercase('Order by') , UpperCase(SQL.Text)) = 0 then begin
      if (Self is TRTSelSale) and ( Appenv.companyprefs.SalesPrintOrderBy <> '' ) then
        SQL.Add(' order by '+SLPrefix+'.' + trim(Appenv.companyprefs.SalesPrintOrderBy )+','+SLPrefix+'.sortID')
      else if SameText(ReportToPrint, 'Invoice Summary Grouped') then
        SQL.Add(' ORDER BY ProductGroup, ' + SLPrefix+'.sortID')
      else
        SQL.Add(' order by '+SLPrefix+'.sortID');
    end;

    SQL.Add('~|||~ where TTC.' +TRim(IDFieldname)+' = ' +inttostr(ID) +' group by TTCL.`SubTaxCode`');
    SQL.Add('~|||~ and Trans.' +TRim(IDFieldname)+' = ' +inttostr(ID)) ;
    TransSpecificSQL(SQL);


    {adding the repair details if its the (Repair) template for Sales Order or invoice}
  end;

  if Pos(uppercase('Purchase Order Est FX') , upperCase(reporttoprint))>0  then
    SQL.Add('~|||~');

  {TransComments}
  if (ReportSQLSupplied) then begin
    SQL.Add('~|||~{TransComments}SELECT C.Comments ' +
            ' FROM tblComments C ' +
            ' inner join tbltranscomments TC on C.CommentsID = TC.CommentID ' +
            ' where TC.Transtype = ' + quotedstr(TransType)+' and TC.TransId = ' + inttostr(ID) +
            ' ORDER BY seqno');
    if (((Self is TRTSelInvoice) and (Sysutils.SameText(ReportToPrint , 'Invoice with details'))) OR
       (Self is TRTSelSalesOrder)) then begin
          SQL.Add('~|||~{FormulaDetails}Select  SL.saleId, ifnull(fe.formulaId,0) formulaId, describeformula(fe.formula) dformula, fe.formula , fe.formulaname  '+
                         ' from tblsaleslines  SL  '+
                         ' Left join tblfeFormula fe  on SL.formulaid = fe.FormulaId '+
                         ' Where SL.SaleId = ' + inttostr(ID));
          SQL.Add('~|||~' + ColumnHeadingsSQL('columnHeadings' ));
    end;
    if (Self is TRTSelInvoice) and (Sysutils.SameText(ReportToPrint , 'Invoice with details')) then begin
          SQL.Add('~|||~{InvioceSalesOrder}Select SO.* from tblsales SO inner join tblSales Invoice on So.globalref = ifnull(Invoice.salesorderglobalref , "")  where invoice.saleId = ' + IntToStr(ID));
    end;
  end
  else begin
    if TemplateContainsSection('TransComments',self.ReportToPrint,x)  then
      SQL.Add('~|||~where TC.Transtype = ' + quotedstr(TransType)+' and TC.TransId = ' + inttostr(ID) +
                ' ORDER BY seqno');

    if SameText(ReportTypeName,'Cash Sale') and TemplateContainsSection('Payments',self.ReportToPrint,x) then begin
      AddSQLPortion(x , 'and SaleID = ' + IntToStr(ID) );
    end;

    if SameText(ReportToPrint, 'Invoice Summary Grouped') then begin
      SQL.Add('~|||~  AND d2.SaleId ='+ IntToStr(ID) + ' GROUP BY partsublevel2');
    end;

    if TemplateContainsSection('StockLevels',self.ReportToPrint,x) and (self is TRTSelSale)  then begin
      AddSQLPortion(x , ' and SL.SaleID = ' + IntToStr(ID) +
                        ' group by PC.ClassID, PC.ClassName , PC.ProductID ' +
                        ' Order by  ClassName , PartName');
      if TemplateContainsSection('SQL',self.ReportToPrint,x) then
        AddMasterSourceDetails('SQL','StockLevels','ProductId','PartsID');
    end;

    if TemplateContainsSection('ETADetails',self.ReportToPrint,x) and (self is TRTSelSale) then begin
      AddSQLPortion(x , ' and SL.SaleID = ' + IntToStr(ID) +
                        ' GROUP BY PL.PurchaseOrderID , PL.Class , PL.ProductID;');
      if TemplateContainsSection('SQL',self.ReportToPrint,x) then
        AddMasterSourceDetails('SQL','ETADetails','ProductId','PL.ProductID');
    end;
    if TemplateContainsSection('Packages',self.ReportToPrint,x) then begin
      AddSQLPortion(x , ' and SL.SaleID = ' + IntToStr(ID));
      if TemplateContainsSection('SQL',self.ReportToPrint,x) then
        AddMasterSourceDetails('SQL','Packages','saleLineId','pack.saleLineId')
    end;

    if TemplateContainsSection('FormulaDetails',self.ReportToPrint,x)  then begin
      AddSQLPortion(x , ' Where SL.SaleID = ' + IntToStr(ID) );
      if TemplateContainsSection('SQL',self.ReportToPrint,x) then
        AddMasterSourceDetails('SQL','FormulaDetails','SaleLineId','sl.saleLineId')
    end;
    if  SameText(ReportTypeName,'Invoice') and TemplateContainsSection('InvioceSalesOrder',self.ReportToPrint,x) then begin
      AddSQLPortion(x ,  ' where invoice.saleId = ' + IntToStr(ID) );
    end;
  end;

  if self is TRTSelSale then begin
    if TemplateContainsSection('DiscountTotals',self.ReportToPrint,x)  then begin
      if ReportSQLSupplied then begin
         SQL.Add('~|||~{DiscountTotals}Select MasterSale.saleId  , (select 0-S.TotalDiscount  '+
                    ' from tblsales S  '+
                    ' where saleid = MasterSale.SaleId ) as totalProductDiscount,  '+
           ' (select (Sum(ifnull(TotalLineamountinc,0))) '+
                    ' from tblsaleslines SL  '+
                    ' where saleid = MasterSale.SaleId  '+
                    ' and productname = ' + quotedstr(PAYMENT_DISCOUNT_PRODUCT) +') as PaymentDiscount,    '+
           ' (select (Sum(ifnull(TotalLineamountinc,0)))  '+
                    ' from tblsaleslines SL  '+
                    ' where saleid = MasterSale.SaleId  '+
                    ' and productname = ' + Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +' ) as Earlypaymentdiscount,   '+
           ' (select (Sum(ifnull(TotalLineamountinc,0)))  '+
                    ' from tblsaleslines SL  '+
                    ' where saleid = MasterSale.SaleId  '+
                    ' and productname = ' + Quotedstr(TOTALDISCOUNT_PRODUCT) +'  ) as TotalSaleDiscount,   '+
           ' (Select Totalamountinc - S.totalmarkup -(0- S.TotalDiscount + (select (Sum(ifnull(TotalLineamountinc,0)))   '+
                                                                                  ' from tblsaleslines SL  '+
                                                                                  ' where Sl.saleid = S.SaleID   '+
                                                                                  ' and (productname = ' + quotedstr(PAYMENT_DISCOUNT_PRODUCT) +
                                                                                  '  or productname = ' + Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +
                                                                                  ' or productname = ' + Quotedstr(TOTALDISCOUNT_PRODUCT) +'  )))  	  '+
                    ' from tblsales S   '+
                    ' where saleid = MasterSale.SaleId  ) as TotalSaleExdiscount,   '+
           ' (select S.totalmarkup  '+
                    ' from tblsales S  '+
                    ' where saleid = MasterSale.SaleId ) as TotalMarkup,    '+
           ' (Select 0- S.TotalDiscount + (select (Sum(ifnull(TotalLineamountinc,0)))   '+
                                                  ' from tblsaleslines SL  '+
                                                  ' where Sl.saleid = S.SaleID   '+
                                                  ' and (productname = ' + quotedstr(PAYMENT_DISCOUNT_PRODUCT) +
                                                  '  or productname = ' + Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +
                                                  ' or productname = ' + Quotedstr(TOTALDISCOUNT_PRODUCT) +'  ))   '+
                     ' from tblsales S  where saleid = MasterSale.SaleId ) as TotalDiscount,   '+
           ' (Select S.TotalAmountInc   '+
                     ' from tblsales S   '+
                     ' where saleid = MasterSale.SaleId ) as SalesTotalincdisc   '+
           ' from tblsales MasterSale     '+
                     ' Where MasterSale.saleId = ' + IntToStr(ID));
      end
      else begin
        AddSQLPortion(x ,  '  Where MasterSale.saleId = ' + IntToStr(ID) );
      end;
    end;
  end;
end;

procedure TRTSelBaseTrans.MyScriptBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  if Assigned(fOnStepProgress) then
    fOnStepProgress();
end;

function TRTSelBaseTrans.PrintMatrixSQL(ReportTemplName, TransType: String;
  ID: Integer): String;
var
  s:String;
  Qryx, Qryy :TERpQuery;
  QryTemp, QryTempCaptions,QryDetails :TERpQuery;
  colcount,ctr:Integer;
  //SaleLineId:Integer;
  //xValue,yvalue:String;
  //Sold,Shipped, BO:Double;
  //PAGID:Integer;
  //uom:String;

  function TransLineuom       :String; begin if SameText(Transtype , 'Sales') then result := 'UnitofMeasureSaleLines' else result := 'UnitofMeasurePOLines';end;
  function TransTable         :String; begin if SameText(Transtype , 'Sales') then result := 'tblsales'               else result := 'tblPurchaseOrders';   end;
  function TransLineTable     :String; begin if SameText(Transtype , 'Sales') then result := 'tblsaleslines'          else result := 'tblPurchaseLines';    end;
  function TransIDfield       :String; begin if SameText(Transtype , 'Sales') then result := 'saleId'                 else result := 'PurchaseOrderId';     end;
  function TransLineIDfield   :String; begin if SameText(Transtype , 'Sales') then result := 'SaleLineID'             else result := 'PurchaseLineID';      end;
  function YValueTocolcount(yValue:String;PagID:Integer):Integer;
  var
    i:Integer;
  begin
    result :=0;
    QryTempCaptions.Locate('Pag_ID' ,PagID, []);
    for i := 1 to colcount do begin
      if Sametext(QryTempCaptions.fieldByname('column'+inttostr(i)).asString , yValue) then begin
        result := i;
        break;
      end;
    end;
  end;
begin
  if ID=0 then exit;

{get Y attribute count}
  With TempMyQuery(CommonDbLib.GetSharedMyDacConnection) do Try
    SQL.add( 'Select distinct PAG.Name , count(PAV.value) ctr ' +
      ' from tblproductattributegroups PAG ' +
      ' inner join tblproductattributenames PAN on PAN.PAG_ID = PAG.PAG_ID and PAN.PAN_ID = PAG.yAxisAttribute ' +
      ' inner join tblproductattributevalues PAV on PAV.PAN_ID = PAN.PAN_ID '+
      ' Where PAG.PAG_ID in (Select PAP.PAG_ID ' +
      ' From tblproductattributeproducts PAP  ' +
      ' inner join '+TransLineTable+' SL on SL.ProductID = PAP.ProductID and SL.'+TransIDfield+' ='+inttostr(ID)+') ' +
      ' group by PAG.Name order by ctr desc');
    open;
    First;
    colcount:= FieldByname('ctr').asInteger;
  finally
    closenFree;
  end;
  if colcount =0 then colcount:= AppEnv.companyPrefs.MaxNoOfAttributes;

{Make Temporary table}
    TempTableName := GetUserTemporaryTableName(Self.Classname+'PrintMatrix');
    s:= 'Drop table if exists ' + TempTableName +';'+
        'CREATE TABLE ' + TempTableName + ' (  ID INT(10) NULL AUTO_INCREMENT,  ';
    s:= s +'Groupname varchar(255) DEFAULT "" ,';
    s:= s +'PAG_ID int(11) DEFAULT 0 ,';
    s:= s +'xName varchar(255) DEFAULT "" ,';
    s:= s +'xValue varchar(255) DEFAULT "" ,';
    s:= s +'yName varchar(255) DEFAULT "" ,';
    for ctr := 1 to colcount do begin
      s:= s +'Sold'   + inttostr(ctr)+' DOUBLE NULL DEFAULT 0 ,';
      s:= s +'Shipped'+ inttostr(ctr)+' DOUBLE NULL DEFAULT 0 ,';
      s:= s +'BO'     + inttostr(ctr)+' DOUBLE NULL DEFAULT 0 ,';
      s:= s +'UOM'    + inttostr(ctr)+' varchar(100) NULL DEFAULT "" ,';
    end;
    s:= s+' PRIMARY KEY (ID) ) ENGINE=MyISAM ;';

    s:= s+'Drop table if exists ' + TempTableName +'Captions;'+
        'CREATE TABLE '+TempTableName + 'Captions (  ID INT(10) NULL AUTO_INCREMENT,  ';
    s:= s +'Groupname varchar(255) DEFAULT "" ,';
    s:= s +'PAG_ID int(11) DEFAULT 0 ,';
    for ctr := 1 to colcount do s:= s +'Column'+inttostr(ctr)+' varchar(255) DEFAULT "" ,';
    s:= s+' PRIMARY KEY (ID) ) ENGINE=MyISAM ;';
    With TempMyScript do try
      SQL.add(s);
      execute;
    finally
      Free;
    end;

{xaxis attributes}
    s:= 'Select distinct PAG.PAG_ID,PAG.Name groupname, PAN.Name , PAV.Value ,' +
        ' (Select Pany.name  from tblproductattributenames PANy where  PANy.PAG_ID = PAG.PAG_ID and PANy.PAN_ID = PAG.yAxisAttribute ) as yname '+
        ' from tblproductattributegroups PAG ' +
        ' inner join tblproductattributenames PAN on PAN.PAG_ID = PAG.PAG_ID and PAN.PAN_ID = PAG.XAxisAttribute ' +
        ' inner join tblproductattributevalues PAV on PAV.PAN_ID = PAN.PAN_ID ' +
        ' Where PAG.PAG_ID in (Select PAP.PAG_ID ' +
        ' From tblproductattributeproducts PAP  ' +
        ' inner join '+TransLineTable+' SL on SL.ProductID = PAP.ProductID and SL.'+TransIDfield+' ='+inttostr(ID)+')'+
        ' order by groupname';
    Qryx:= TempMyQuery(CommonDbLib.GetSharedMyDacConnection);
    Qryx.SQL.add(s);
    Qryx.open;
{Yaxis attributes}
    s:= 'Select distinct PAG.PAG_ID, PAG.Name groupname, PAN.NAme, PAV.value ' +
        ' from tblproductattributegroups PAG ' +
        ' Left join tblproductattributenames PAN on PAN.PAG_ID = PAG.PAG_ID and PAN.PAN_ID = PAG.yAxisAttribute ' +
        ' Left join tblproductattributevalues PAV on PAV.PAN_ID = PAN.PAN_ID '+
        ' Where PAG.PAG_ID in (Select PAP.PAG_ID ' +
        ' From tblproductattributeproducts PAP  ' +
        ' inner join '+TransLineTable+' SL on SL.ProductID = PAP.ProductID and SL.'+TransIDfield+' ='+inttostr(ID)+')'+
        ' order by groupname';
    Qryy:= TempMyQuery(CommonDbLib.GetSharedMyDacConnection);
    Qryy.SQL.add(s);
    Qryy.open;
{Flat table with yaxis names as columns}
    QryTempCaptions:= TempMyQuery(CommonDbLib.GetSharedMyDacConnection);
    QryTempCaptions.SQL.add('Select * from ' +TempTableName+'captions');
    QryTempCaptions.open;
      Qryy.first;
      ctr:= 1;
      while Qryy.eof = False do begin
        if s<>Qryy.fieldByname('groupname').asString then begin
          if QryTempCaptions.State in [dsEdit,dsInsert] then QryTempCaptions.Post;
          QryTempCaptions.append;
          QryTempCaptions.Fieldbyname('groupname').asString :=  Qryy.fieldByname('groupname').asString;
          QryTempCaptions.Fieldbyname('PAG_ID').asInteger   :=  Qryy.fieldByname('PAG_ID').asInteger;
          s:= Qryy.fieldByname('groupname').asString;
          ctr:= 1;
        end;
        QryTempCaptions.fieldbyname('column' +inttostr(ctr)).AsString :=Qryy.fieldbyname('Value').asString;
        ctr:= ctr+1;
        Qryy.next;
      end;
    if QryTempCaptions.State in [dsEdit,dsInsert] then QryTempCaptions.Post;

{Flat table with xaxis names as Rows}
    QryTemp:= TempMyQuery(CommonDbLib.GetSharedMyDacConnection);
    QryTemp.SQL.add('Select * from ' +TempTableName);
    QryTemp.open;
    Qryx.First;
    While Qryx.eof = False do begin
      QryTemp.Append;
      QryTemp.fieldbyname('Groupname').asString :=Qryx.fieldbyname('Groupname').asString;
      QryTemp.fieldbyname('PAG_ID').asInteger :=Qryx.fieldbyname('PAG_ID').asInteger;
      QryTemp.fieldbyname('xName').asString :=Qryx.fieldbyname('Name').asString;
      QryTemp.fieldbyname('xValue').asString :=Qryx.fieldbyname('Value').asString;
      QryTemp.fieldbyname('yname').asString :=Qryx.fieldbyname('yname').asString;
      QryTemp.Post;
      Qryx.Next;
    End;

    s:= 'Select distinct TL.'+TransLineIDfield+', TL.ProductID, TL.ProductName ,  '+
        ' TL.Shipped , TL.QtySold , TL.BackOrder , TL.UnitofMeasureQtySold , TL.UnitofMeasureShipped ,  '+
        ' TL.UnitofMeasureBackorder , concat(TL.' +TransLineuom+'  , "(" , TL.UnitofMeasureMultiplier , ")") as uom , '+
        '(Select min(PAG.PAG_ID) from tblproductattributegroups PAG ' +
            ' inner join tblproductattributeproducts PAP on PAG.PAG_ID = PAP.PAG_ID ' +
            ' where pap.productId = TL.ProductID) as PAG_ID,'+
        '(Select PAP.attribValue from  tblproductattributegroups PAG   '+
            ' inner join tblproductattributenames PAN on PAN.PAG_ID = PAG.PAG_ID and PAN.PAN_ID = PAG.XAxisAttribute '+
            ' inner join tblproductattributeproducts PAP on PAN.PAG_ID = PAP.PAG_ID and PAP.AttribName = PAN.Name '+
            ' where pap.productId = TL.ProductID) as xValue, '+
        '(Select PAP.attribValue  from tblproductattributegroups PAG '+
            ' inner join tblproductattributenames PAN on PAN.PAG_ID = PAG.PAG_ID and PAN.PAN_ID = PAG.yAxisAttribute '+
            ' inner join tblproductattributeproducts PAP on PAN.PAG_ID = PAP.PAG_ID and PAP.AttribName = PAN.Name '+
            ' where pap.productId = TL.ProductID) as yValue '+
        ' from '+TransLineTable+' TL '+
        ' where TL.' +TransIDfield+' = '+inttostr(ID);
    if sametext(Transtype , 'Sales') then
      s:= s + ' and ifnull(TL.BOMProductionLine, "F") ="F"';

    QryDetails:=TempMyQuery(CommonDbLib.GetSharedMyDacConnection);
    QryDetails.sQL.add(s);
    QryDetails.open;
    QryDetails.First;
    While QryDetails.Eof = False do begin
      ctr:= YValueTocolcount(QryDetails.fieldbyname('yValue').asString, QryDetails.fieldbyname('PAG_ID').asInteger);
      if ctr>0 then begin
          if QryTemp.Locate('PAG_ID;xValue' ,VarArrayof([QryDetails.fieldbyname('PAG_ID').asInteger,QryDetails.fieldbyname('xValue').asString]) , []) then begin
            editDB(QryTemp);
            QryTemp.fieldbyname('sold'+inttostr(ctr)).AsFloat :=  QryDetails.fieldbyname('UnitofMeasureQtySold').asFloat;
            QryTemp.fieldbyname('shipped'+inttostr(ctr)).AsFloat :=  QryDetails.fieldbyname('UnitofMeasureShipped').asFloat;
            QryTemp.fieldbyname('BO'+inttostr(ctr)).AsFloat :=  QryDetails.fieldbyname('UnitofMeasureBackorder').asFloat;
            QryTemp.fieldbyname('uom'+inttostr(ctr)).asString :=  QryDetails.fieldbyname('uom').asString;
            PostDB(QryTemp);
          end;
      end;
      QryDetails.Next;
    end;
  s:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO'+
      '~|||~{Header}Select T.*  , ' +
            'C.Phone , C.FaxNumber , C.AltPhone , C.Mobile, C.email, C.Street , C.Street2 , C.Suburb , C.State , C.Postcode ,  ' +
            'IFNULL(CC.ContactPH,C.Phone)       AS ContactPH    ,' +
            'IFNULL(`ContactAltPH`,C.AltPhone)  AS ContactAltPH ,' +
            'IFNULL(`ContactMOB`,C.Mobile)      AS ContactMOB   ,' +
            'IFNULL(`ContactFax`,C.FaxNumber)   AS ContactFax   ,' +
            'IFNULL(`ContactEmail`,C.email)     AS ContactEmail  ' ;
  if self is TRTSelInvoice then
    s:= s+ ', (Select Sum(PP.Balance) TotalBalance ' +
                  ' from tblSalesPrepayments  SP  '+
                  ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                  ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref or SP.SalesRef = T.salesorderglobalref) as Prepayments,   '+
                ' (Select Sum(PP.Balance) TotalBalance  '+
                  ' from tblSalesPrepayments  SP  '+
                  ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                  ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref or SP.SalesRef = T.salesorderglobalref) +T.payment as Totalpayment,  '+
                ' T.totalamountinc - (Select Sum(PP.Balance) TotalBalance  '+
                  ' from tblSalesPrepayments  SP  '+
                  ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                  ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref or SP.SalesRef = T.salesorderglobalref) -payment as Invoicebalance';
  if self is TRTSelSalesOrder then
    s:= s+ ',(Select Sum(PP.Balance) TotalBalance  '+
                    ' from tblSalesPrepayments  SP  '+
                    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                    ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref ) as Prepayments,   '+
                  ' (Select Sum(PP.Balance) TotalBalance  '+
                    ' from tblSalesPrepayments  SP  '+
                    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                  ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref ) +T.payment as Totalpayment,'+
                  ' T.totalamountinc - (Select Sum(PP.Balance) TotalBalance  '+
                    ' from tblSalesPrepayments  SP  '+
                    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                    ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref ) -payment as SalesOrderbalance';
  if self is TRTSelSale then s:= s+    ', C.Manufacture , C.JobRegistration , C.Colour , C.BodyType , C.SerialNumber , '+
                        ' C.InsuranceCompanyName , C.JobNumber , C.ExcessAmount, C.CustomerJobNumber ' ;
  s:= s+    ' from '+TransTable+' T   ' +
            'inner join tblClients C on T.ClientID = C.ClientID  ' +
            'Left join tblcontacts CC on CC.ContactID = T.contactID where '+TransIDfield+' = '+inttostr(ID) +
    '~|||~{Details}Select Captions.* , Data.* from '+TempTableName +' Data ' +
    'inner join '+TempTableName +'captions Captions on Data.PAG_ID =Captions.pag_id ' +
    '~|||~{NonAttribProducts}Select * from ' +TransLineTable+' where '+TransIDfield+' = '+inttostr(ID) +
      ' and productId not in (Select ProductId from tblproductattributeproducts) ';
    if self is TRTSelSale then
      s:= s+'~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,    '+
              ' Sum(TTCL.`TaxAmount`) TaxAmount   '+
              ' from tblsalestaxcodelines TTCL   '+
              ' inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID '+
              ' Where TTC.SaleId = ' + inttostr(ID) +' group by TTCL.`SubTaxCode` '+
          '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value  '+
              ' from  tblsales Trans   '+
              ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID  '+
              ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId  '+
              ' where ifnull(CCV.Value,"")<>"" and CFL.ListType = "ltCustomer" And Trans.SaleId = ' + inttostr(ID)

    else
      s:= s+'~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,    '+
              ' Sum(TTCL.`TaxAmount`) TaxAmount   '+
              ' from tblpurchasetaxcodelines TTCL   '+
              ' inner join tblpurchasetaxcodes TTC on TTCL.PurchaseTaxCodeID = TTC.ID  '+
              ' Where TTC.PurchaseOrderID = ' + inttostr(ID) +' group by TTCL.`SubTaxCode` '+
          '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value  '+
              ' from  tblpurchaseorders Trans   '+
              ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID  '+
              ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId  '+
              ' where ifnull(CCV.Value,"")<>"" and CFL.ListType = "ltSupplier"  And Trans.PurchaseOrderID = ' + inttostr(ID);
    Result := s;
end;

function TRTSelBaseTrans.PrintMatrixYSQL(const ID: Integer;
  var ReportTablename: String; IsYMode, IncludeBOM: Boolean;
  var Json: TJsonObject): String;
begin
  with TMatrixsale.Create(nil) do try
    YMode := ISYMode;
    DeleteMatrixTableOnDestroy:= False;
    SaleID := ID;
    MakeMatrixTable(IsYMode);
    ReportTablename := Matrixtablename;
    result := SalesMatrixReportSQL(self is TRTSelInvoice, IncludeBOM);
    Json:= SaleaMtrixMasterDetailLink(Stringcontains(ReportToPrint,'(BOM)'));
  finally
    free;
  end;
end;

function TRTSelBaseTrans.RepairSalesSQL: String;
var
  sl: TStringList;
  qry: TERPQuery;
  RepairGlobalRef: string;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select RepairGlobalRef from tblsales');
    qry.SQL.Add('where SaleID = ' + IntToStr(ID));
    qry.Open;
    RepairGlobalRef := qry.FieldByName('RepairGlobalRef').AsString;
  finally
    qry.Free;
  end;

  sl := TStringList.Create;
  try
    TransSpecificSQL(sl);
    result :=
          '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO'+
          '~|||~{Details} SELECT    '+
          ' e.WorkPhone,CONCAT_WS(" ", c.Title, c.FirstName,c.LastName) as CompanyContact, '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.UnitofMeasureSaleLines)                     as UnitofMeasure,  '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.UnitofMeasureShipped)                       as UnitofMeasureShipped,      '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.UnitofMeasureBackorder)                     as UnitofMeasureBackorder,      '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.TotalLineAmount/SL.UnitofMeasureShipped)    as UnitofMeasureLinePrice,          '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.TotalLineAmountInc/SL.UnitofMeasureShipped) as UnitofMeasureLinePriceInc,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), "*" , SL.ProductName)                                as ProductName,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.Shipped)                                    as Shipped,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.BackOrder)                                  as BackOrder,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.Product_Description)                        as Product_Description,          '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.LinePrice)                                  as LinePrice,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.LineTax)                                    as LineTax,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.TotalLineAmountInc)                         as TotalLineAmountInc,             '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.Shipped)                                    as QtySold, '+
          ' (Price1+(Price1*LineTaxRate))     as OrgLinePriceInc, '+
          ' (100-DisCountPercent)             as RebatePercent ,       '+
          Firstcolumn('P')  + '               AS PartHeader,          '+
          Secondcolumn('P') + '               AS PartSubLevel1,            '+
          Thirdcolumn('P')  + '               AS PartSubLevel2,   '+
          ' if(S.Paid="T","YES","NO")         as Paid2,              '+
          ' SUBSTRING_INDEX( c.Company,"^",1) as Company_NoJobName,       '+
          ' P.Price1                          as "ListPrice(Ex)",              '+
          ' P.PRODUCTCODE,'+
          ' P.ProductComment,'+
          ' P.SupplierProductCode as SuppProdCode,'+
          ' pp.partpic, '+
          ClientnameandAddress('C') + '  AS "No Company Name", '+
          ' c.Company               as Company, '+
          ' c.ABN                   as ABN, '+
          ' c.Title                 as Title, '+
          ' c.FirstName             as FirstName,      '+
          ' c.MiddleName            as MiddleName, '+
          ' c.LastName              as LastName, '+
          ' c.Position              as Position,      '+
          ' c.Street                as CustStreet,  '+
          ' c.Street2               as CustStreet2,  '+
          ' c.Street3               as CustStreet3,      '+
          ' c.Suburb                as CustSuburb,  '+
          ' c.State                 as CustState,  '+
          ' c.Country               as CustCountry,      '+
          ' c.Postcode              as CustPostcode,  '+
          ' c.BillStreet            as BillStreet, '+
          ' c.BillStreet2           as BillStreet2,      '+
          ' c.BillSuburb            as BillSuburb, '+
          ' c.BillState             as BillState, '+
          ' c.BillCountry           as BillCountry,        '+
          ' c.BillPostcode          as BillPostcode,  '+
          ' c.POBox                 as POBox,  '+
          ' c.POSuburb              as POSuburb,  '+
          ' c.POState               as POState,      '+
          ' c.POCountry             as POCountry, '+
          ' c.POPostcode            as POPostcode, '+
          ' c.Phone                 as Phone,        '+
          ' c.FaxNumber             as FaxNumber, '+
          ' c.Mobile                as Mobile,  '+
          ' c.Email                 as Email, '+
          ' c.AltContact            as AltContact,      '+
          ' c.AltPhone              as AltPhone,  '+
          ' c.PhoneSupportTill      as PhoneSupportTill, '+
          ' c.Contact1              as Contact1,      '+
          ' c.Contact2              as Contact2, '+
          ' c.Contact1Phone         as Contact1Phone, '+
          ' c.Contact2Phone         as Contact2Phone,      '+
          ' c.CreationDate          as CreationDate,  '+
          ' c.UpdateDate            as UpdateDate, '+
          ' c.DateInactive          as DateInactive,      '+
          ' c.Notes                 as Notes, '+
          ' c.ClientNo              as ClientNo,  '+
          ' c.JobName               as JobName,  '+
          ' c.CUSTFLD1              as CustomerCustfld1, '+
          ' c.CUSTFLD2              as CustomerCustfld2, '+
          ' c.CUSTFLD3              as CustomerCustfld3, '+
          ' c.CUSTFLD4              as CustomerCustfld4, '+
          ' c.CUSTFLD5              as CustomerCustfld5, '+
          ' c.CUSTFLD6              as CustomerCustfld6, '+
          ' c.CUSTFLD7              as CustomerCustfld7, '+
          ' c.CUSTFLD8              as CustomerCustfld8, '+
          ' c.CUSTFLD9              as CustomerCustfld9, '+
          ' c.CUSTFLD10             as CustomerCustfld10,'+
          ' c.CUSTFLD11             as CustomerCustfld11,'+
          ' c.CUSTFLD12             as CustomerCustfld12,'+
          ' c.CUSTFLD13             as CustomerCustfld13,'+
          ' c.CUSTFLD14             as CustomerCustfld14,'+
          ' c.CUSTFLD15             as CustomerCustfld15,'+
          ' C.CUSTDATE1             as CustomerCUSTDATE1,'+
          ' C.CUSTDATE2             as CustomerCUSTDATE2,'+
          ' C.CUSTDATE3             as CustomerCUSTDATE3,'+
          ' c.DeliveryNotes         as DeliveryNotes,  '+
          ' C.Manufacture ,'+
          ' C.JobRegistration , '+
          ' C.Colour , '+
          ' C.BodyType , '+
          ' C.SerialNumber , '+
          ' C.InsuranceCompanyName , '+
          ' C.JobNumber , '+
          ' C.ExcessAmount, '+
          ' C.CustomerJobNumber , '+
          ' C.Jobname , C.ModelNumber,'+
          ' IF(c.IsJob = "T",IF(C2.StopCredit="T","Yes","No"),IF(c.StopCredit="T","Yes","No"))  AS StopCredit ,'+
          ' S.* ,   '+
          ' SL.*,'+
          ' (Select Sum(PP.Balance) TotalBalance '+
                ' from tblSalesPrepayments  SP '+
                ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  '+
                ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) as Prepayments,  '+
          ' (Select Sum(PP.Balance) TotalBalance '+
                ' from tblSalesPrepayments  SP '+
                ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  '+
                ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) +S.payment as Totalpayment, '+
          ' S.totalamountinc - (Select Sum(PP.Balance) TotalBalance '+
                ' from tblSalesPrepayments  SP '+
                ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  '+
                ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) -payment as Invoicebalance, '+
          ' SL.orglineprice+ SL.orglineprice* SL.linetaxrate as  orglinepriceinc ,'+
          ' SL.OrgLinePrice*SL.Shipped TotalOrgLinePrice , '+
          ' (SL.OrgLinePrice*SL.Shipped) + (SL.OrgLinePrice*SL.Shipped * SL.LineTaxRate) TotalOrgLinePriceINC  , '+
          ' SL.QtySold* SL.ForeignCurrencyLinePrice as EstForeingPrice, '+
          ' SL.ForeignExchangeSellRate * SL.LineCost as FXCost  , '+
          ' SL.OrgLinePrice * SL.Shipped TotalOrglinePrice,'+
          ' SL.OrgLinePrice * SL.Shipped+ SL.OrgLinePrice * SL.Shipped * SL.LineTaxRate as TotalOrglinePriceInc,'+
          ' SL.OrgLinePrice * SL.QtySold as TotalOrgEstlinePrice,'+
          ' SL.OrgLinePrice * SL.QtySold+ SL.OrgLinePrice * SL.QtySold * SL.LineTaxRate as TotalOrgEstlinePriceInc  , '+
          ' (SL.shipped*SL.ForeignCurrencyLinePrice) as TotalForeignCurrencyLinePrice, '+
          ' (Totaltax-TotalWETTax ) as TotalTaxExWET        ,'+
          ' FESL.Field1 as FormulaValue1, '+
          ' FESL.Field2 as FormulaValue2, '+
          ' FESL.Field3 as FormulaValue3, '+
          ' FESL.Field4 as FormulaValue4, '+
          ' FESL.Field5 as FormulaValue5,'+
          ' (Select FormulaEntryName from tblfenames where FormulaEntryId = 1) Formulaname1,'+
          ' (Select FormulaEntryName from tblfenames where FormulaEntryId = 2) Formulaname2,'+
          ' (Select FormulaEntryName from tblfenames where FormulaEntryId = 3) Formulaname3,'+
          ' (Select FormulaEntryName from tblfenames where FormulaEntryId = 4) Formulaname4,'+
          ' (Select FormulaEntryName from tblfenames where FormulaEntryId = 5) Formulaname5 ,'+
          ' SL.backorder*SL.LinePrice Bakorderamount,   '+
          ' (SL.TotalLineAmountInc*1.50) as LineCalc,'+
          ' (SL.TotalLineAmountInc*0.50) as TotalSavings,'+
          ' ct.contactemail     as ContEmail, '+
          ' ct.contacttitle     as ContTitle, '+
          ' ct.contactfirstname as ContFirstName, '+
          ' ct.contactsurname   as ContSurname,'+
          ' ct.contactaddress   as ContAddress, '+
          ' ct.contactaddress2  as ContAddress2, '+
          ' ct.contactaddress3  as ContAddress3, '+
          ' ct.contactcity      as ContCity,'+
          ' ct.contactstate     as ContState, '+
          ' ct.contactpcode     as ContPostcode, '+
          ' ct.contactcountry   as ContCountry, '+
          ' ct.contactph        as ContPh, '+
          ' ct.contactaltph     as ContAltPh,'+
          ' ct.contactmob       as ContMob, '+
          ' ct.contactfax       as ContactFax   '+
          ' FROM '+
          ' tblSales S'+
          ' INNER JOIN tblSalesLines SL Using(SaleID)'+
          ' Left join (tblfesaleslines FESL inner join tblfesaleslinesrelatedprs  FESLR on FESLR.FESalesLineID = FESL.FESalesLineID) on FESL.SaleLineID = SL.SaleLineID and FESLR.ProductID = SL.productId'+
          ' INNER JOIN tblparts P on SL.ProductID=P.PartsID'+
          ' INNER JOIN tblclients c on S.ClientID = c.ClientID'+
          ' LEFT JOIN tblClients as C2 on c.ParentClientID = C2.ClientID'+
          ' Left join tblpartspics pp on ifnull(pp.Isdefault, "") = "T" and pp.partID = SL.ProductID'+
          ' LEFT JOIN tblrelatedparts AS RP on (SL.ProductID=RP.ProductID AND SL.RelatedParentProductID=RP.ParentID)'+
          ' LEFT JOIN tblcontacts AS ct on (S.ContactID=ct.ContactID)'+
          ' Left join tblemployees e on e.EmployeeID = S.EmployeeID'+
          ' WHERE S.SaleID = SL.SaleID'+
          ' AND (P.HideOnPrint = "F"  and   (SL.IsRelatedProduct = "F" or ( SL.IsRelatedProduct = "T" and RP.HideRelated  = "F"))) AND S.SaleID = ' + inttostr(ID) +' order by SL.sortID' +
          '~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,  Sum(TTCL.`TaxAmount`) TaxAmount '+
          'from tblsalestaxcodelines TTCL '+
          'inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID'+
          ' where TTC.SaleID =  ' + inttostr(ID) +' group by TTCL.`SubTaxCode`'+
          '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value '+
          'from  tblsales Trans  '+
          'inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID '+
          'inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId '+
          ' where ifnull(CCV.Value,"")<>""  and CFL.ListType = "ltCustomer"'+
          ' and Trans.SaleID =  ' + inttostr(ID) +' '+
          sl.Text +
          '~|||~{InvoiceFooter} Select Invoice_Footer from vinvoicefooterpref '+
          '~|||~'+RepairsReportSQL(TRepairs.IDGlobalRefToggle(RepairGlobalRef) , 0 , False);
  finally
    sl.Free;
  end;
end;

function TRTSelBaseTrans.SalesOrderManufactureReportSQL(
  Includeallocation: Boolean): String;
var
  s:String;
  filename:String;
  st:TStringList;
  i:Integer;

  function SalesfieldList:String;
  begin
      result := 'State,Postcode,PhoneNumber,FaxNumber,ABN,CompanyName,Address,Address2,City,SaleID,SalesGlobalRef,InvoiceDocNumber,'+
                  'OriginalNo,BaseNo,Account,AccountID,BOID,CustomerName,ClientID,InvoiceTo,ShipTo,PickupFrom,SaleDate,TotalTax,'+
                  'TotalWETTax,TotalWEGTax,TotalAmount,TotalAmountInc,TotalMarkup,TotalDiscount,EmployeeName,EmployeeID,ClassID,'+
                  'Class,OrderNumber,PONumber,ChequeNo,SaleShipDate,FutureSO,DueDate,ConNote,Memo,Comments,InvoicePrintDesc,PickMemo,'+
                  'PrintHold,Shipping,Terms,PayMethod,PayDueDate,Paid,Balance,SOBalance,Payment,ApplyFlag,AmountDue,TimeOfSale,IsPOS,'+
                  'POS,IsRefund,IsCashSale,IsInvoice,IsQuote,IsSalesOrder,IsVoucher,IsLayby,IsLaybyTOS,IsLaybyPayment,TotalQuoteAmount,'+
                  'Deposited,TillID,HoldSale,FreezeQuoteAmount,Converted,EnteredBy,EnteredAt,CommissionPaid,IsManifest,'+
                  'UsedOnManifest,AddToManifest,SalesOrderGlobalRef,QuoteGlobalRef,RepairGlobalRef,IsBarcodePicking,BarcodePickingDone,'+
                  'ARNotes,OriginalCreationDate,QuoteStatus,DespatchID,RunID,RunName,Reference,POCreated,ForeignExchangeCode,'+
                  'ForeignExchangeRate,ForeignTotalAmount,ForeignPaidAmount,ForeignBalanceAmount,IsGeneratedFromHire,BlindBalancePeriodID,'+
                  'SaleDateTime,AutoSmartOrderRef,IsInternalOrder,ShippingCost,contactID,ContactName,POSPostCode,RepairID,MedtypeID,'+
                  'Medtype,NoOfBoxes,SaleLineID,ProductID,PARTTYPE,INCOMEACCNT,ASSETACCNT,COGSACCNT,ProductGroup,ProductName,'+
                  'Product_Description,Product_Description_Memo,OrgLinePrice,LinePrice,LinePriceInc,LineWholesalePrice,LineTaxRate,'+
                  'LineCost,LineCostInc,LineTaxCode,LineTax,QtySold,UnitofMeasureQtySold,Shipped,UnitofMeasureShipped,'+
                  'UnitofMeasureLinePrice,UnitofMeasureLinePriceInc,BackOrder,UnitofMeasureBackorder,UnitofMeasure,UnitOfMeasureID,'+
                  'UnitofMeasureMultiplier,Invoiced,Discounts,Markup,Margin,MarkupPercent,MarginPercent,DiscountPercent,Timecostused,TotalLineAmount,'+
                  'TotalLineAmountInc,RefundQty,SoldSerials,Attrib1Sale,Attrib2Sale,Attrib1SaleRate,LastLineID,DescAttrib3,'+
                  'DescAttrib1,DescAttrib2,Supplier,SupplierContact,DescAttrib4,DescAttrib5,ForeignExchangeSellRate,ForeignExchangeSellCode,'+
                  'ForeignCurrencyLinePrice,ForeignTotalLineAmount,Area,SearchFilter,SearchFilterCopy,IsRelatedProduct,RelatedParentProductID,'+
                  'CostCentreId,ClonedFromId,DocketNumber,UseHedging,PartSpecID,SpecDescription,SpecValue,CreationDate,WarrantyPeriod,'+
                  'WarrantyEndsOn,SalesLinesCustField1,SalesLinesCustField2,SalesLinesCustField3,SalesLinesCustField4,SalesLinesCustField5,'+
                  'SalesLinesCustField6,SalesLinesCustField7,SalesLinesCustField8,SalesLinesCustField9,SalesLinesCustField10,LineNotes,'+
                  'CustomData,INCOMEACCNTID,ASSETACCNTID,COGSACCNTID,SortId,MemoLine,SeqNo,RelatedParentLineRef,RelatedProductQty,'+
                  'IsFormulaRElatedProduct,FormulaID,AutoSmartOrder,SmartOrderCreated,LineShipDate,BaseLineno,PartBarcode,'+
                  'TotalOrglinePrice , TotalOrglinePriceInc, TotalOrgEstlinePrice,TotalOrgEstlinePriceInc,  CompanyContact,'+
                  'TotalForeignCurrencyLinePrice,CustJobName,CustABN,CustTitle,CustFirstName,CustMiddleName,CustLastName,CustStreet,'+
                  'CustStreet2,CustSuburb,CustState,CustCountry,CustPostcode,CustBillStreet,CustBillStreet2,CustBillSuburb,CustBillState,'+
                  'CustBillCountry,CustBillPostcode,CustPOBox,CustPOSuburb,CustPOState,CustPOCountry,CustPOPostcode,CustPhone,CustFaxNumber,'+
                  'CustMobile,CustEmail,CustAltContact,CustAltPhone,ClientNo,DeliveryNotes,SuppProdCode,ProductHideOnPrint,Prepayments,Totalpayment,SalesOrderBalance,'+
                  'Manufacture,JobRegistration,Colour,BodyType,SerialNumber,InsuranceCompanyName,JobNumber,ExcessAmount,CustomerJobNumber ';
  end;

  function SalesSQL:String;
  begin
        REsult := '  SELECT'+
                ' d1.State, d1.Postcode, d1.PhoneNumber AS PhoneNumber, '+
                ' d1.FaxNumber AS FaxNumber, d1.ABN,   CompanyName, Address, '+
                ' Address2, City,'+
                'S.SaleID	as 	SaleID	,'+
                'S.GlobalRef	as 	SalesGlobalRef	,'+
                'S.InvoiceDocNumber	as 	InvoiceDocNumber	,'+
                'S.OriginalNo	as 	OriginalNo	,'+
                'S.BaseNo	as 	BaseNo	,'+
                'S.Account	as 	Account	,'+
                'S.AccountID	as 	AccountID	,'+
                'S.BOID	as 	BOID	,'+
                'S.CustomerName	as 	CustomerName	,'+
                'S.ClientID	as 	ClientID	,'+
                'S.InvoiceTo	as 	InvoiceTo	,'+
                'S.ShipTo	as 	ShipTo	,'+
                'S.PickupFrom	as 	PickupFrom	,'+
                'S.SaleDate	as 	SaleDate	,'+
                'S.TotalTax	as 	TotalTax	,'+
                'S.TotalWETTax	as 	TotalWETTax	,'+
                'S.TotalWEGTax	as 	TotalWEGTax	,'+
                'S.TotalAmount	as 	TotalAmount	,'+
                'S.TotalAmountInc	as 	TotalAmountInc	,'+
                'S.TotalMarkup	as 	TotalMarkup	,'+
                'S.TotalDiscount	as 	TotalDiscount	,'+
                'S.EmployeeName	as 	EmployeeName	,'+
                'S.EmployeeID	as 	EmployeeID	,'+
                'S.ClassID	as 	ClassID	,'+
                'S.Class	as 	Class	,'+
                'S.OrderNumber	as 	OrderNumber	,'+
                'S.PONumber	as 	PONumber	,'+
                'S.ChequeNo	as 	ChequeNo	,'+
                'S.ShipDate	as 	SaleShipDate	,'+
                'S.FutureSO	as 	FutureSO	,'+
                'S.DueDate	as 	DueDate	,'+
                'S.ConNote	as 	ConNote	,     '+
                'S.Memo	as 	Memo	,'+
                'S.Comments	as 	Comments	,'+
                'S.InvoicePrintDesc	as 	InvoicePrintDesc	,'+
                'S.PickMemo	as 	PickMemo	,'+
                'S.PrintHold	as 	PrintHold	,'+
                'S.Shipping	as 	Shipping	,'+
                'S.Terms	as 	Terms	,'+
                'S.PayMethod	as 	PayMethod	,'+
                'S.PayDueDate	as 	PayDueDate	,'+
                'S.Paid	as 	Paid	,'+
                'S.Balance	as 	Balance	,'+
                'S.SOBalance	as 	SOBalance	,'+
                'S.Payment	as 	Payment	,'+
                'S.ApplyFlag	as 	ApplyFlag	,'+
                'S.AmountDue	as 	AmountDue	,'+
                'S.TimeOfSale	as 	TimeOfSale	,'+
                'S.IsPOS	as 	IsPOS	,'+
                'S.POS	as 	POS	,'+
                'S.IsRefund	as 	IsRefund	,'+
                'S.IsCashSale	as 	IsCashSale	,'+
                'S.IsInvoice	as 	IsInvoice	,'+
                'S.IsQuote	as 	IsQuote	,'+
                'S.IsSalesOrder	as 	IsSalesOrder	,'+
                'S.IsVoucher	as 	IsVoucher	,'+
                'S.IsLayby	as 	IsLayby	,'+
                'S.IsLaybyTOS	as 	IsLaybyTOS	,'+
                'S.IsLaybyPayment	as 	IsLaybyPayment	,'+
                'S.TotalQuoteAmount	as 	TotalQuoteAmount	,'+
                'S.Deposited	as 	Deposited	,'+
                'S.TillID	as 	TillID	,'+
                'S.HoldSale	as 	HoldSale	,'+
                'S.FreezeQuoteAmount	as 	FreezeQuoteAmount	,'+
                'S.Converted	as 	Converted	,'+
                'S.EnteredBy	as 	EnteredBy	,'+
                'S.EnteredAt	as 	EnteredAt	,'+
                'S.CommissionPaid	as 	CommissionPaid	,'+
                'S.IsManifest	as 	IsManifest	,'+
                'S.UsedOnManifest	as 	UsedOnManifest	,'+
                'S.AddToManifest	as 	AddToManifest	,'+
                'S.SalesOrderGlobalRef	as 	SalesOrderGlobalRef	,'+
                'S.QuoteGlobalRef	as 	QuoteGlobalRef	,'+
                'S.RepairGlobalRef	as 	RepairGlobalRef	,'+
                'S.IsBarcodePicking	as 	IsBarcodePicking	,'+
                'S.BarcodePickingDone	as 	BarcodePickingDone	,'+
                'S.ARNotes	as 	ARNotes	,'+
                'S.OriginalCreationDate	as 	OriginalCreationDate	,'+
                'S.QuoteStatus	as 	QuoteStatus	,'+
                'S.DespatchID	as 	DespatchID	,'+
                'S.RunID	as 	RunID	,'+
                'S.RunName	as 	RunName	,'+
                'S.Reference	as 	Reference	,'+
                'S.POCreated	as 	POCreated	,'+
                'S.ForeignExchangeCode	as 	ForeignExchangeCode	,'+
                'S.ForeignExchangeRate	as 	ForeignExchangeRate	,'+
                'S.ForeignTotalAmount	as 	ForeignTotalAmount	,'+
                'S.ForeignPaidAmount	as 	ForeignPaidAmount	,'+
                'S.ForeignBalanceAmount	as 	ForeignBalanceAmount	,'+
                'S.IsGeneratedFromHire	as 	IsGeneratedFromHire	,'+
                'S.BlindBalancePeriodID	as 	BlindBalancePeriodID	,'+
                'S.SaleDateTime	as 	SaleDateTime	,'+
                'S.AutoSmartOrderRef	as 	AutoSmartOrderRef	,'+
                'S.IsInternalOrder	as 	IsInternalOrder	,'+
                'S.ShippingCost	as 	ShippingCost	,'+
                'S.contactID	as 	contactID	,'+
                'S.ContactName	as 	ContactName	,'+
                'S.POSPostCode	as 	POSPostCode	,'+
                'S.RepairID	as 	RepairID	,'+
                'S.MedtypeID	as 	MedtypeID	,'+
                'S.Medtype	as 	Medtype	,'+
                'S.NoOfBoxes	as 	NoOfBoxes	,'+
                'SL.SaleLineID	as	SaleLineID	,'+
                'SL.ProductID	as	ProductID	,'+
                'SL.PARTTYPE	as	PARTTYPE	,'+
                'SL.INCOMEACCNT	as	INCOMEACCNT	,'+
                'SL.ASSETACCNT	as	ASSETACCNT	,'+
                'SL.COGSACCNT	as	COGSACCNT	,'+
                'SL.ProductGroup	as	ProductGroup	,'+
                'SL.ProductName	as	ProductName	,'+
                'SL.Product_Description	as	Product_Description	,'+
                'SL.Product_Description_Memo	as	Product_Description_Memo	,'+
                'SL.OrgLinePrice	as	OrgLinePrice	,'+
                'SL.LinePrice	as	LinePrice	,'+
                'SL.LinePriceInc	as	LinePriceInc	,'+
                'SL.LineWholesalePrice	as	LineWholesalePrice	,'+
                'SL.LineTaxRate	as	LineTaxRate	,'+
                'SL.LineCost	as	LineCost	,'+
                'SL.LineCostInc	as	LineCostInc	,'+
                'SL.LineTaxCode	as	LineTaxCode	,'+
                'SL.LineTax	as	LineTax	,'+
                'SL.QtySold	as	QtySold	,'+
                'SL.UnitofMeasureQtySold	as	UnitofMeasureQtySold	,'+
                'SL.Shipped	as	Shipped	,'+
                'SL.UnitofMeasureShipped	as	UnitofMeasureShipped	,'+
                'SL.TotalLineAmount/SL.UnitofMeasureShipped as UnitofMeasureLinePrice,'+
                'SL.TotalLineAmountInc/SL.UnitofMeasureShipped as UnitofMeasureLinePriceInc,'+
                'SL.BackOrder	as	BackOrder	,'+
                'SL.UnitofMeasureBackorder	as	UnitofMeasureBackorder,'+
                'SL.UnitofMeasureSaleLines	as	UnitofMeasure	,'+
                'SL.UnitOfMeasureID	as	UnitOfMeasureID	,'+
                'SL.UnitofMeasureMultiplier	as	UnitofMeasureMultiplier	,'+
                'SL.Invoiced	as	Invoiced	,'+
                'SL.Discounts	as	Discounts	,'+
                'SL.Markup	as	Markup	,'+
                'SL.MarkupPercent	as	MarkupPercent	,'+
                'SL.Margin	as	Margin	,'+
                'SL.MarginPercent	as	MarginPercent	,'+
                'SL.DiscountPercent	as	DiscountPercent	,'+
                'SL.Timecostused	as	Timecostused	,'+
                'SL.TotalLineAmount	as	TotalLineAmount	,'+
                'SL.TotalLineAmountInc	as	TotalLineAmountInc	,'+
                'SL.RefundQty	as	RefundQty	,'+
                'SL.SoldSerials	as	SoldSerials	,'+
                'SL.Attrib1Sale	as	Attrib1Sale	,'+
                'SL.Attrib2Sale	as	Attrib2Sale	,'+
                'SL.Attrib1SaleRate	as	Attrib1SaleRate	,'+
                'SL.LastLineID	as	LastLineID	,'+
                'SL.DescAttrib3	as	DescAttrib3	,'+
                'SL.DescAttrib1	as	DescAttrib1	,'+
                'SL.DescAttrib2	as	DescAttrib2	,'+
                'SL.Supplier	as	Supplier	,'+
                'SL.SupplierContact	as	SupplierContact	,'+
                'SL.DescAttrib4	as	DescAttrib4	,'+
                'SL.DescAttrib5	as	DescAttrib5	,'+
                'SL.ForeignExchangeSellRate	as	ForeignExchangeSellRate	,'+
                'SL.ForeignExchangeSellCode	as	ForeignExchangeSellCode	,'+
                'SL.ForeignCurrencyLinePrice	as	ForeignCurrencyLinePrice	,'+
                'SL.ForeignTotalLineAmount	as	ForeignTotalLineAmount	,'+
                'SL.Area	as	Area	,'+
                'SL.SearchFilter	as	SearchFilter	,'+
                'SL.SearchFilterCopy	as	SearchFilterCopy	,'+
                'SL.IsRelatedProduct	as	IsRelatedProduct	,'+
                'SL.RelatedParentProductID	as	RelatedParentProductID	,'+
                'SL.CostCentreId	as	CostCentreId	,'+
                'SL.ClonedFromId	as	ClonedFromId	,'+
                'SL.DocketNumber	as	DocketNumber	,'+
                'SL.UseHedging	as	UseHedging	,'+
                'SL.PartSpecID	as	PartSpecID	,'+
                'SL.SpecDescription	as	SpecDescription	,'+
                'SL.SpecValue	as	SpecValue	,'+
                'SL.CreationDate	as	CreationDate	,'+
                'SL.WarrantyPeriod	as	WarrantyPeriod	,'+
                'SL.WarrantyEndsOn	as	WarrantyEndsOn	,'+
                'SL.SalesLinesCustField1	as	SalesLinesCustField1	,'+
                'SL.SalesLinesCustField2	as	SalesLinesCustField2	,'+
                'SL.SalesLinesCustField3	as	SalesLinesCustField3	,'+
                'SL.SalesLinesCustField4	as	SalesLinesCustField4	,'+
                'SL.SalesLinesCustField5	as	SalesLinesCustField5	,'+
                'SL.SalesLinesCustField6	as	SalesLinesCustField6	,'+
                'SL.SalesLinesCustField7	as	SalesLinesCustField7	,'+
                'SL.SalesLinesCustField8	as	SalesLinesCustField8	,'+
                'SL.SalesLinesCustField9	as	SalesLinesCustField9	,'+
                'SL.SalesLinesCustField10	as	SalesLinesCustField10	,'+
                'SL.LineNotes	as	LineNotes	,'+
                'SL.CustomData	as	CustomData	,'+
                'SL.INCOMEACCNTID	as	INCOMEACCNTID	,'+
                'SL.ASSETACCNTID	as	ASSETACCNTID	,'+
                'SL.COGSACCNTID	as	COGSACCNTID	,'+
                'SL.SortId	as	SortId	,'+
                'SL.MemoLine	as	MemoLine	,'+
                'SL.SeqNo	as	SeqNo	,'+
                'SL.RelatedParentLineRef	as	RelatedParentLineRef	,'+
                'SL.RelatedProductQty	as	RelatedProductQty	,'+
                'SL.IsFormulaRElatedProduct	as	IsFormulaRElatedProduct	,'+
                'SL.FormulaID	as	FormulaID	,'+
                'SL.AutoSmartOrder	as	AutoSmartOrder	,'+
                'SL.SmartOrderCreated	as	SmartOrderCreated	,'+
                'SL.ShipDate	as	LineShipDate	,'+
                'SL.BaseLineno	as	BaseLineno	,'+
                'SL.PartBarcode	as	PartBarcode	,'+
                'SL.OrgLinePrice * SL.Shipped TotalOrglinePrice,'+
                'SL.OrgLinePrice * SL.Shipped+ SL.OrgLinePrice * SL.Shipped * SL.LineTaxRate TotalOrglinePriceInc,'+
                'SL.OrgLinePrice * SL.QtySold TotalOrgEstlinePrice,'+
                'SL.OrgLinePrice * SL.QtySold+ SL.OrgLinePrice * SL.QtySold * SL.LineTaxRate TotalOrgEstlinePriceInc,'+
                '  CONCAT_WS(" ", C.Title, C.FirstName, C.LastName) as CompanyContact,'+
                '  (SL.shipped*SL.ForeignCurrencyLinePrice) as TotalForeignCurrencyLinePrice,'+
                '  C.JobName as CustJobName,    C.ABN as CustABN,  C.Title as CustTitle,'+
                      'C.FirstName as CustFirstName,    C.MiddleName as CustMiddleName, '+
                      'C.LastName as CustLastName,      C.Street as CustStreet, C.Street2 as CustStreet2, '+
                      'C.Suburb as CustSuburb, C.State as CustState, C.Country as CustCountry,   '+
                      'C.Postcode as CustPostcode,  C.BillStreet as CustBillStreet, '+
                      'C.BillStreet2 as CustBillStreet2,  C.BillSuburb as CustBillSuburb,      '+
                      'C.BillState as CustBillState,    C.BillCountry as CustBillCountry,  '+
                      'C.BillPostcode as CustBillPostcode,        C.POBox as CustPOBox,    '+
                      'C.POSuburb as CustPOSuburb,  C.POState as CustPOState,    '+
                      'C.POCountry as CustPOCountry,      C.POPostcode as CustPOPostcode,  '+
                      'C.Phone as CustPhone,      C.FaxNumber as CustFaxNumber,      '+
                      'C.Mobile as CustMobile,  C.Email as CustEmail,    C.AltContact as CustAltContact,    '+
                      'C.AltPhone as CustAltPhone,   C.ClientNo,      C.DeliveryNotes,'+
                '  P.supplierproductcode as SuppProdCode ,'+
                '  P.HideOnPrint ProductHideOnPrint,'+
                ' (Select Sum(PP.Balance) TotalBalance '+
                '     from tblSalesPrepayments  SP '+
                '     inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  '+
                '     Where PP.Deleted = "F" and SP.SalesRef = S.Globalref ) as Prepayments,  '+
                '  (Select Sum(PP.Balance) TotalBalance '+
                '     from tblSalesPrepayments  SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  '+
                '     Where PP.Deleted = "F" and SP.SalesRef = S.Globalref ) +S.payment as Totalpayment,'+
                ' S.totalamountinc - (Select Sum(PP.Balance) TotalBalance  '+
                  ' from tblSalesPrepayments  SP  '+
                  ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                  ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref ) -payment as SalesOrderbalance , '+
                  'C.Manufacture , C.JobRegistration , C.Colour , C.BodyType , C.SerialNumber , C.InsuranceCompanyName , C.JobNumber , C.ExcessAmount, C.CustomerJobNumber ' +
                '  FROM tblCompanyInformation d1,'+
                '  tblSales S'+
                '  INNER JOIN tblSalesLines SL on S.SaleId = Sl.saleID and ifnull(SL.BOMProductionLine, "F") ="F" '+
                '  INNER JOIN tblparts P on SL.ProductID=PartsID'+
                '  INNER JOIN tblClients C ON S.ClientID = C.ClientID'+
                '  WHERE IsSalesOrder = "T"  and S.SaleId = ' +  IntToStr(ID);
          end;

begin
  st:=TStringList.create;
  try
    Tablename1 := '';
    Tablename2 := '';
    With CommonDbLib.TempMyScript do try
      BeforeExecute := MyScriptBeforeExecute;
      try
        SQL.add(CreateTemporaryTableusingfile('tmp_salesordermanufacturereport1' , SalesSQL , Salesfieldlist , Tablename1 , filename , '' , 'MyISAM'));
          st.add(fileName);
          s:= Tablename1 +'_1';
          SQL.add('DROP TABLE IF EXISTS ' + s +' ;');
          SQL.add('CREATE TABLE  ' + s +' (' +
                          'AutoId int(11) NOT NULL auto_increment,' +
                          'HideRelated enum("T","F") NOT NULL default "F",' +
                          'ProductID int(11) default 0,' +
                          'ParentID int(11) default 0,' +
                          'PRIMARY KEY  (AutoId)' +
                        ') ENGINE=myIsam;' );


        SQL.add(CreateTemporaryTableusingfile(s , 'Select RP.HideRelated , RP.ProductID , RP.ParentID ' +
                          ' from ' +Tablename1 +' T  ' +
                          ' inner join tblrelatedparts AS RP on ' +
                          ' (T.ProductID=RP.ProductID AND T.RelatedParentProductID=RP.ParentID)' ,'HideRelated , ProductID, ParentID' ,
                          s, filename));
          st.add(fileName);

          SQL.add('  update '+Tablename1+' T inner join '+
                      s+ ' AS RP on (T.ProductID=RP.ProductID AND T.RelatedParentProductID=RP.ParentID)'+
                      '  Set UnitofMeasure        ="" ,'+
                      '  UnitofMeasureShipped     =NULL,'+
                      '  UnitofMeasureBackorder   =NULL,'+
                      '  UnitofMeasureLinePrice   =NULL,'+
                      '  UnitofMeasureLinePriceInc=NULL,'+
                      '  ProductName              ="*",'+
                      '  Shipped                  =null,'+
                      '  BackOrder                =null,'+
                      '  Product_Description      =NULL,'+
                      '  LinePrice                =null,'+
                      '  LineTax                  =null,'+
                      '  ProductHideOnPrint       ="T",'+
                      '  TotalLineAmountInc       =null'+
                      '  Where (T.IsRelatedProduct ="T" and RP.HideRelated ="T") ;');
          SQL.add('  update '+Tablename1+' T'+
                      '  Set UnitofMeasure        = "" ,'+
                      '  UnitofMeasureShipped     = NULL,'+
                      '  UnitofMeasureBackorder   = NULL,'+
                      '  UnitofMeasureLinePrice   = NULL,'+
                      '  UnitofMeasureLinePriceInc= NULL,'+
                      '  ProductName              ="*",'+
                      '  Shipped                  = null,'+
                      '  BackOrder                =null,'+
                      '  Product_Description      =NULL,'+
                      '  LinePrice                =null,'+
                      '  LineTax                  =null,'+
                      '  TotalLineAmountInc       = null'+
                      '  Where  (T.ProductHideOnPrint ="T");');

          {remioving the product picture for the time being }
          //St.Add('  update '+Tablename1+'  T inner join tblpartspics pp on pp.partID = T.ProductID   Set T.PartPic  = pp.PartPic;');
          s:=  Tablename1 + '_2';
          SQL.add('DROP TABLE IF EXISTS ' + s +' ;');
          SQL.add('CREATE TABLE ' + s+ ' ('+
                    ' autoID int(11) NOT NULL auto_increment,'+
                    ' ContactID int(11) NOT NULL default "0",'+
                    ' contactemail varchar(255) default NULL,'+
                    ' contacttitle varchar(32) default NULL,'+
                    ' contactfirstname varchar(30) default NULL,'+
                    ' contactsurname varchar(30) default NULL,'+
                    ' contactaddress varchar(255) default NULL,'+
                    ' contactaddress2 varchar(255) default NULL,'+
                    ' contactaddress3 varchar(255) default NULL,'+
                    ' contactcity varchar(255) default NULL,'+
                    ' contactstate varchar(255) default NULL,'+
                    ' contactpcode varchar(255) default NULL,'+
                    ' contactcountry varchar(255) default NULL,'+
                    ' contactph varchar(255) default NULL,'+
                    ' contactaltph varchar(255) default NULL,'+
                    ' contactmob varchar(255) default NULL,'+
                    ' contactfax varchar(255) default NULL,'+
                    ' PRIMARY KEY  (autoID),'+
                    ' KEY ContactId (ContactID)'+
                    ' ) ENGINE=myisam;');

        SQL.add(CreateTemporaryTableusingfile(s ,'Select ct.ContactID,ct.contactemail,ct.contacttitle ,ct.contactfirstname ,'+
                  ' ct.contactsurname ,ct.contactaddress ,ct.contactaddress2 ,ct.contactaddress3 ,'+
                  ' ct.contactcity ,ct.contactstate ,ct.contactpcode ,ct.contactcountry ,'+
                  ' ct.contactph ,ct.contactaltph ,ct.contactmob ,ct.contactfax'+
                  ' from '+Tablename1+' T'+
                  ' inner JOIN tblcontacts AS ct on ifnull(T.ContactID,0)=ct.ContactID'+
                  ' where ifnull(T.ContactID,0)<> 0' ,
                  'ContactID,contactemail,contacttitle,contactfirstname,contactsurname, '+
                    ' contactaddress,contactaddress2,contactaddress3,contactcity,contactstate, '+
                    ' contactpcode,contactcountry,contactph,contactaltph,contactmob,contactfax' ,
                  s,filename));
          st.add(fileName);

          SQL.add('  update '+Tablename1+' T'+
          '  inner JOIN  ' + s +'  AS ct on ifnull(T.ContactID,0)=ct.ContactID'+
          '  Set T.ContEmail=ct.contactemail,'+
          '  T.ContTitle = ct.contacttitle ,'+
          '  T.ContFirstName = ct.contactfirstname ,'+
          '  T.ContSurname = ct.contactsurname ,'+
          '  T.ContAddress = ct.contactaddress ,'+
          '  T.ContAddress2 = ct.contactaddress2 ,'+
          '  T.ContAddress3 = ct.contactaddress3 ,'+
          '  T.ContCity = ct.contactcity ,'+
          '  T.ContState = ct.contactstate ,'+
          '  T.ContPostcode = ct.contactpcode ,'+
          '  T.ContCountry = ct.contactcountry ,'+
          '  T.ContPh = ct.contactph ,'+
          '  T.ContAltPh = ct.contactaltph ,'+
          '  T.ContMob = ct.contactmob ,'+
          '  T.ContactFax    = ct.contactfax'+
          '  where ifnull(T.ContactID,0)<> 0;');


        SQL.add(CreateTemporaryTableusingfile('tmp_salesordermanufacturereport2' ,
              ' Select  T.SaleLineId , pt.ProcTreeId , Caption as "OptionName",'+
              ' PT.Description, Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)) treeItem ,'+
              ' Quantity as OptionQty, TotalQty as OptionTotalQty , pt.info, PT.parentID ,'+
              ' Pt.Selected, PT.inputtype, PT.info, tblPartsPics.PartPic as OptionProductPicture, tblprocessstep.ExtraInfo as OptionProcessDetail'+
              ' from tblProcTree pt'+
              ' inner join '+Tablename1+' T on  pt.MasterId = T.SaleLineId and pt.MasterType <> "mtProduct" ' +
              ' left join tblPartsPics on tblPartsPics.PartId = pt.PartsID' +
              ' left join tblprocesspart on tblprocesspart.ProcTreeID = pt.ProcTreeId '+
              ' left join tblprocessstep on tblprocessstep.Id = tblprocesspart.ProcessStepID ',  // /* and pt.parentId <> 0 and pt.InputType = "itOption"  */

              ' SaleLineId , ProcTreeId , OptionName ,' +
              ' Description , TreeItem ,' +
              ' OptionQty , OptionTotalQty, OptionInfo,parentID,' +
              ' selected, inputtype ,info, OptionProductPicture, OptionProcessDetail' ,
              tablename2 ,filename,'' , 'MYISAM'));
          st.add(fileName);
          SQL.add('alter Table ' + tablename2 +' Add column nodeselected Enum ("T","F") default "F";');

          s:=  Tablename1 + '_3';
          SQL.add('DROP TABLE IF EXISTS ' + s+' ;');
          SQL.add('CREATE TABLE  ' + s+' ('+
                    ' AutoID int(11) NOT NULL auto_increment,'+
                    '  ParentId int(11) default NULL,'+
                    '  Selected enum("T","F") NOT NULL default "F",'+
                    ' Caption varchar(255) default NULL,'+
                    '  PRIMARY KEY  (AutoID)'+
                    ') ENGINE=myisam ;');


        SQL.add(CreateTemporaryTableusingfile(s ,
              'Select pt.ParentId , pt.Selected , pt.Caption'+
              ' from '+tablename2+' T inner join  tblProcTree pt on pt.ParentId = T.ProcTreeId and pt.Selected = "T"' ,
              ' ParentId ,Selected , Caption' , s , filename));


          SQL.Add('  update '+Tablename2+' T '+
                  ' inner join '+s + ' pt on pt.ParentId = T.ProcTreeId and pt.Selected = "T"     '+
                  ' Set T.OptionItem = pt.Caption;');

          ShowProgressBar('Please Wait' , 30);
          try
            execute;
          finally
              HideProgressbar;
          end;
        finally
            Free;
        end;
        DestroyUserTemporaryTable(Tablename1+'_1');
        DestroyUserTemporaryTable(Tablename1+'_2');
        DestroyUserTemporaryTable(Tablename1+'_3');
      finally
      end;
    finally
      for i := 0 to st.count-1 do AppEnv.UtilsClient.DeleteServerFiles(replaceStr(st[i], '.tmp' , '*.tmp'));
      Freeandnil(st);
    end;

    ChecknUpdateInTreeNodesSelected(tablename2  , 'nodeselected');

    if appenv.CompanyPrefs.HideSelectedSubnodesinReport then begin
      ExecuteSQL('delete from ' + Tablename2 +' where Selected ="T" and NodeSelected ="T";');
      With TERPQuery(TempMyquery) do try
        SQL.Add('Select Distinct ProctreeId from ' + Tablename2 + ' where ifnull(ParentID,0) <> 0 and ifnull(ParentID,0) not in (Select ProctreeId from ' + Tablename2  +')');
        open;
        s:= GroupConcat('ProctreeId');
        while s<> '' do begin
          ExecuteSQL('delete from ' + Tablename2 +' where proctreeId in (' + s +');');
          close;
          open;
          s:= GroupConcat('ProctreeId');
        end;
      finally
        ClosenFree;
      end;
    end;
    if Includeallocation then
      result := 'Select T1.* , T2.* , PBin.Binlocation,  PBin.binnumber,PQABatch.Value as batchno, PQABatch.TruckLoadNo , PQABatch.ExpiryDate, PQASN.Value as SoldSerials,  '+
                ' C.Manufacture , C.JobRegistration , C.Colour , C.BodyType , C.SerialNumber , C.InsuranceCompanyName , C.JobNumber , C.ExcessAmount, C.CustomerJobNumber , C.Jobname , C.ModelNumber  , '+
                ' salesProduct.ProductionNotes as ProductionNotes,' +
                '  Left(SUBSTRING_INDEX(salesProduct.Productgroup,"^",1),255) as firstcolumn,'+
                '  Left(substring(substring_index(salesProduct.Productgroup,"^",2),char_length(substring_index(salesProduct.Productgroup,"^",1))+1),255) as SecondColumn,'+
                '  Left(substring(substring_index(salesProduct.Productgroup,"^",2),char_length(substring_index(salesProduct.Productgroup,"^",1))+2),255) as thirdcolumn '+
                ' from  '+Tablename1+' T1 '+
                ' inner join tblparts salesProduct on salesProduct.PARTSID = T1.productID '+
                ' Left join '+Tablename2+' T2 on T1.saleLineID = T2.saleLineID  and T2.NodeSelected ="T"  and T2.parentId <> 0 '+
                ' left join tblClients C on C.clientId = T1.ClientId '+
                ' left join (tblproctreePart PTP inner join tblparts P on P.partsId = PTP.productID '+
                ' inner join tblpqa pqa on pqa.translineId = ptp.proctreepartId and pqa.transtype in ("TProctreePart")   and ((P.multiplebins = "F" and P.Batch="F" and P.SNTracking = "F")   OR (PQA.PQAID in (Select PQAID from `tblPQADetails`))) '+
                ' left join `tblPqaDetails` PQABatch  on PQABatch.PQAId  = PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T" '+
                ' left join `tblPqaDetails` PQABins   on PQABins.PQAId  = PQA.PQAID   and PQABins.PQAType = "Bin" and PQABins.Active = "T"  '+
                ' and    ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T"   and P.multiplebins = "T") or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T")) '+
                ' Left join `tblProductBin` PBin      on PBin.binId  = PQABins.BinID '+
                ' left join `tblPqaDetails` PQASN     on (PQASN.PQAId  = PQA.PQAID and PQASN.PQAType = "SN"    '+
                ' and PQASN.Active = "T"  and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T")   '+
                ' or (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") and P.Multiplebins = "T" and P.SNTracking = "T") or  (ifnull(PQASN.Parentref ,"") = "") and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T" ))        ) on PTP.proctreeId = T2.proctreeId '
    else
      result := 'Select T1.* , T2.*   , '+
                ' C.Manufacture , C.JobRegistration , C.Colour , C.BodyType , C.SerialNumber , C.InsuranceCompanyName , C.JobNumber , C.ExcessAmount, C.CustomerJobNumber , C.Jobname , C.ModelNumber  , '+
                ' salesProduct.ProductionNotes as ProductionNotes,' +
                '  Left(SUBSTRING_INDEX(salesProduct.Productgroup,"^",1),255) as firstcolumn,'+
                '  Left(substring(substring_index(salesProduct.Productgroup,"^",2),char_length(substring_index(salesProduct.Productgroup,"^",1))+1),255) as SecondColumn,'+
                '  Left(substring(substring_index(salesProduct.Productgroup,"^",2),char_length(substring_index(salesProduct.Productgroup,"^",1))+2),255) as thirdcolumn '+
                ' from  '+Tablename1+' T1 '+
                ' inner join tblparts salesProduct on salesProduct.PARTSID = T1.productID '+
                ' Left join '+Tablename2+' T2 on T1.saleLineID = T2.saleLineID  and T2.NodeSelected ="T"  and T2.parentId <> 0 '+
                ' left join tblClients C on C.clientId = T1.ClientId ';

    if appenv.CompanyPrefs.RemoveHideOnPrintProductFromReports then result := result + ' where T1.ProductHideOnPrint <>"T"';


    if ( Appenv.companyprefs.SalesPrintOrderBy <> '' ) then
      result := result + ' order by ' + trim(Appenv.companyprefs.SalesPrintOrderBy )+',sortID'
    else  result := result + ' Order by SortID';

    result:= result+'~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,  '+
                ' Sum(TTCL.`TaxAmount`) TaxAmount from tblsalestaxcodelines TTCL  '+
                ' inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID  '+
                ' Where TTC.SaleId = ' + inttostr(ID) +' group by TTCL.`SubTaxCode` '+
                '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value  '+
                    ' from  tblsales Trans   '+
                    ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID  '+
                    ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId  '+
                    ' where ifnull(CCV.Value,"")<>"" and CFL.ListType = "ltCustomer" And Trans.SaleId = ' + inttostr(ID);
end;

procedure TRTSelBaseTrans.SetID(const Value: integer);
begin
  inherited;
  fClientID := 0;
end;

function TRTSelBaseTrans.SLPrefix: String;
begin
  if (PosEx('with Customer Ref' , ReportToPrint) <> 0) then
    result := 'SL'
  else result := 'd3';
end;

procedure TRTSelBaseTrans.TransSpecificSQL(SQL: TStringList);
begin
  inherited;
//  if ReportSQLSupplied then begin
//    SQL.Add('~|||~{ShippingAddress}select SA.* from tblsales S inner join tblshippingaddress SA on S.ShipToID = SA.ShipAddressID Where S.SaleId =  '+inttostr(ID));
//  end else begin
//    SQL.Add('~|||~ Where S.SaleId =  '+inttostr(ID));
//  end;
////  if not( Classnameis('TRTSelQuote')) then begin
//  if not (self is TRTSelQuote) then begin
//    if ReportSQLSupplied then begin
//      SQL.Add('~|||~{ShippingDetails}Select * from  tblsalesshippingdetails where salesid =   '+inttostr(ID));
//    end
//    else begin
//      SQL.Add('~|||~ where salesid =   '+inttostr(ID));
//    end;
//  end;
//  if SameText(ReportToPrint, 'Quote With Pictures') then
//      SQL.Add('~|||~ where sl.SaleId =   '+inttostr(ID));
end;

//function TRTSelBaseTrans.TransType: string;
//begin
//  result := Copy(Classname,Length('TRTSel')+1,255);
//end;

{ TRTSelSale }

constructor TRTSelSale.Create;
begin
  inherited;
  fMatrixReportType := 'Sales';
end;

destructor TRTSelSale.Destroy;
begin

  inherited;
end;

function TRTSelSale.IDFieldName: string;
begin
  result := 'SaleID';
end;

procedure TRTSelSale.MakeSQL(SQL: TStringList);
begin
  inherited;
end;


procedure TRTSelSale.TransSpecificSQL(SQL: TStringList);
begin
  inherited;
  if ReportSQLSupplied then begin
    SQL.Add('~|||~{ShippingAddress}select SA.* from tblsales S inner join tblshippingaddress SA on S.ShipToID = SA.ShipAddressID Where S.SaleId =  '+inttostr(ID));
  end else begin
    SQL.Add('~|||~ Where S.SaleId =  '+inttostr(ID));
  end;
  if not(self is TRTSelQuote) or (SameText(ReportToPrint, 'Quote_GroupOnCatg2') ) then
    if ReportSQLSupplied then begin
      SQL.Add('~|||~{ShippingDetails}Select * from  tblsalesshippingdetails where salesid =   '+inttostr(ID));
    end else begin
      SQL.Add('~|||~ where salesid =   '+inttostr(ID));
    end;
  if SameText(ReportToPrint, 'Quote With Pictures') then
    SQL.Add('~|||~ where sl.SaleId =   '+inttostr(ID));
end;

{ TRTSelOrder }

constructor TRTSelOrder.Create;
begin
  inherited;
  fMatrixReportType := 'PO';
end;

destructor TRTSelOrder.Destroy;
begin

  inherited;
end;

function TRTSelOrder.IDFieldName: string;
begin
  result := 'PurchaseOrderID';
end;

{ TRTSelInvoice }

procedure TRTSelInvoice.MakeSQL(SQL: TStringList);
begin
  inherited;
//  if SameText(ReportToPrint , 'Invoice with details') then begin
//    SQL.Add( PrintPickingSlipsLib.SQL4PickingSlipreport(ReportToPrint,json , IntToStr(ID), 'TInvoiceLine'));
//    ReportSQLSupplied := true;
//    TransSpecificSQL(SQL);
//  end
end;

procedure TRTSelInvoice.TransSpecificSQL(SQL: TStringList);
begin
  if ReportSQLSupplied then begin
     SQL.Add('~|||~{EarlyPayment} Select S.SAleID  , '+
                ' abs(totallineamountinc) EarlyPaymentDiscountAmount , '+
                ' if(ifnull(SL.SaleLineId,0)=0 , if(ifnull(T.EarlyPaymentDiscount ,0)=0 , 0 , S.totalamountinc*T.EarlyPaymentDiscount/100) , 0)    '+
                        ' from tblSales S   Left join tblsaleslines SL on  Sl.ProductName = '+Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +'    '+
                        ' and SL.sAleId = s.SAleID    '+
                ' Left join tblterms T on S.Terms = T.Terms  '+
                ' Where S.SaleId = ' + inttostr(ID));
  end else begin
    SQL.Add('~|||~ Where S.SaleId = ' + inttostr(ID));
  end;
  inherited;
end;

{ TRTSelCashBase }

function TRTSelCashBase.IDFieldName: string;
begin
  result := 'SaleID';
end;

{ TRTSelDeliveryDocket }

constructor TRTSelDeliveryDocket.Create;
begin
  inherited;

end;

destructor TRTSelDeliveryDocket.Destroy;
begin

  inherited;
end;

procedure TRTSelDeliveryDocket.MakeSQL(SQL: TStringList);
var
  dd: TDeliveryDocketReportSQL;
begin
  inherited;
  dd := TDeliveryDocketReportSQL.Create;
  try
    dd.SaleId := ID;
    dd.ReportToPrint := self.ReportToPrint;
    dd.ReportSQLSupplied := self.ReportSQLSupplied;
    sql.Text := dd.GetReportSQL;
    self.ReportSQLSupplied := dd.ReportSQLSupplied;
  finally
    dd.Free;
  end;
end;

end.
