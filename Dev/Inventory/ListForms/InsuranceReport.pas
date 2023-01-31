unit InsuranceReport;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess,
  ERPdbComponents, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox;
const
  HeaderFields :Array[1..41] of String = ('FirstName','MiddleName','LastName','Street','Street2','Suburb','State','Country',
        'Postcode','BillStreet','BillStreet2','BillSuburb','BillState','BillCountry','BillPostcode','POBox','POSuburb','POState',
        'POCountry','POPostcode','FaxNumber','Email','AltContact','SaleId','sSaleID',
        'InsuranceProductName','CustomerName', 'phonenumber', 'ShipStreet1',
        'ShipStreet2', 'ShipStreet3', 'ShipSuburb', 'Saledate', 'ShipCountry', 'ShipPostCode' , 'AgencyRef1' , 'AgencyRef2' ,'policyValue' , 'PolicyTerm' , 'Premiumcharged' ,  'Linecost');

  CommonFields :Array [1..2] of String = ('Machinetype' ,'TotalAvgcost');
type
  TInsuranceReportGUI = class(TBaseListingGUI)
    btnProductgroups: TDNMSpeedButton;
    qryMaindetails: TLargeintField;
    qryMaincAgencyRef1: TWideStringField;
    qryMaincAgencyRef2: TWideStringField;
    qryMainSSaleId: TWideStringField;
    qryMainsaleid: TIntegerField;
    qryMainInsuranceproductname: TWideStringField;
    qryMaincustomername: TWideStringField;
    qryMainproductname: TWideStringField;
    qryMainproduct_description: TWideStringField;
    qryMainlinecost: TFloatField;
    qryMainFirstcolumn: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainFirstName: TWideStringField;
    qryMainMiddleName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainBillStreet: TWideStringField;
    qryMainBillStreet2: TWideStringField;
    qryMainBillSuburb: TWideStringField;
    qryMainBillState: TWideStringField;
    qryMainBillCountry: TWideStringField;
    qryMainBillPostcode: TWideStringField;
    qryMainPOBox: TWideStringField;
    qryMainPOSuburb: TWideStringField;
    qryMainPOState: TWideStringField;
    qryMainPOCountry: TWideStringField;
    qryMainPOPostcode: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainAltContact: TWideStringField;
    qryMainphonenumber: TWideStringField;
    qryMainMachinetype: TWideStringField;

    qryMainShipStreet1: TWideStringField;
    qryMainShipStreet2: TWideStringField;
    qryMainShipStreet3: TWideStringField;
    qryMainShipSuburb: TWideStringField;
    qryMainShipState: TWideStringField;
    qryMainShipCountry: TWideStringField;
    qryMainShipPostcode: TWideStringField;

    qryMainTotalAvgcost: TFloatField;
    qryMainpolicyValue: TFloatField;
    qryMainPolicyTerm: TLargeintField;
    qryMainPremiumcharged: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure btnProductgroupsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    (* procedure cmdPrintClick(Sender: TObject); *)
    procedure cmdExportClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    Tablename: string;
    SelectingProductGroups: Boolean;
    GroupValues: TStringList;
    summarySQL:String;
    function isHEaderfield(Const FieldName:String):Boolean;
    procedure SetQrymainSQL;
    procedure GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
    procedure ProductGroupsSelected(Sender: TObject);
    procedure ReadGuipref;
    procedure WriteGuiPref;
    procedure BeforeShowProductGroupItems(Sender: TObject);
    Procedure MakeQry;
    (* function ReportSQL: String; *)
    function Iscommonfield(const FieldName: String): Boolean;
    procedure ExportDataset(Qry: TERPQuery);
  Protected
    procedure SetGridColumns; Override;

  public
    procedure RefreshQuery; override;
  end;

implementation

uses CommonDbLib, ProductQtyLib, CommonLib, CommonFormLib, ProductGroupItems, GlobalEventsObj, AppEnvironment, 
  DatasetExporter, MySQLConst, tcConst;

{$R *.dfm}

procedure TInsuranceReportGUI.BeforeShowProductGroupItems(Sender: TObject);
begin
  if not(Sender is TProductGroupItemsGUI) then exit;
  TProductGroupItemsGUI(Sender).FilterString := 'Groupname = ' + quotedstr(AppEnv.DefaultClass.FirstColumn);
  TProductGroupItemsGUI(Sender).SelectedGroups.Commatext :=GroupValues.Commatext
end;

procedure TInsuranceReportGUI.btnProductgroupsClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselect('TProductGroupItemsGUI', BeforeShowProductGroupItems);
  SelectingProductGroups := True;
end;


procedure TInsuranceReportGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;

end;

procedure TInsuranceReportGUI.FormCreate(Sender: TObject);
var
  s: string;
begin
  GroupValues := TStringList.create;
  SelectingProductGroups := False;
  summarySQL:= '';
  Tablename := GetUserTemporaryTableName('InsuranceReport');
  s := 'Drop table if exists ' + Tablename + ';' + 'Create table ' + Tablename +
    ' Select SL.SaleID , Min(SL.ProductName) as ProductName ' +
    ' from tblSales S  ' +
    ' INNER JOIN tblSalesLines SL on SL.SaleID = S.SaleID  ' + ' WHERE S.IsInvoice = "T" AND SL.ProductName like ' + quotedstr(AppEnv.CompanyPrefs.InsuranceProductNameStartsWith + '%') +
    ' group by SaleID ;' + ' ALTER TABLE ' + Tablename + '  ADD COLUMN `ID` INT(11) NOT NULL AUTO_INCREMENT ,  ADD PRIMARY KEY (`ID`);' + ' ALTER TABLE ' + Tablename +
    '    ADD INDEX `SaleID` (`SaleID`);';
  ExecuteSQL(s);
  SetQrymainSQL;
  inherited;
  GlobalEvents.RegisterNameHandler(Self, 'TProductGroupItemsGUI', '', GEVENT_ListClosed, GlobalEventHandler);
end;

procedure TInsuranceReportGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(GroupValues);
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TInsuranceReportGUI.FormShow(Sender: TObject);
begin
  ReadGuipref;
  inherited;

end;

procedure TInsuranceReportGUI.ProductGroupsSelected(Sender: TObject);
var
  form: TProductGroupItemsGUI;
  strGroupvalues: string;
begin
  form := nil;
  if ((Sender is TProductGroupItemsGUI)) then form := TProductGroupItemsGUI(Sender)
  else if ((Sender is TDNMSpeedButton) and (assigned(TDNMSpeedButton(Sender).owner)) and (TDNMSpeedButton(Sender).owner is TProductGroupItemsGUI)) then
      form := TProductGroupItemsGUI(TDNMSpeedButton(Sender).owner);
  if form = nil then exit;
  if form.grdMain.SelectedList.Count = 0 then exit;
  strGroupvalues := form.SelectedDatas('GroupValue');
  if GroupValues.commatext <> strGroupvalues then begin
    GroupValues.commatext := strGroupvalues;
    Qrymain.disablecontrols;
    try
      SetQrymainSQL;
      RefreshQuery;
    finally Qrymain.Enablecontrols;
    end;
  end;
end;

procedure TInsuranceReportGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if QrymainDetails.asInteger <> 1 then exit;
       if QrymainLinecost.asFloat <=1000 then QrymainpolicyValue.asFloat := 1000
  else if QrymainLinecost.asFloat <=1500 then QrymainpolicyValue.asFloat := 1500
  else if QrymainLinecost.asFloat <=2000 then QrymainpolicyValue.asFloat := 2000
  else if QrymainLinecost.asFloat <=3000 then QrymainpolicyValue.asFloat := 3000
  else if QrymainLinecost.asFloat <=4000 then QrymainpolicyValue.asFloat := 4000
  else QrymainpolicyValue.asFloat := QrymainLinecost.asFloat;
end;

procedure TInsuranceReportGUI.ReadGuipref;
var
  Value: string;
begin
  if GuiPrefs.Node.Exists('General') then begin
    Value := GuiPrefs.Node['General.GroupValues'].asString;
    if GroupValues.commatext <> Value then begin
      GroupValues.commatext := Value;
      SetQrymainSQL;
    end;
  end;
end;

procedure TInsuranceReportGUI.RefreshQuery;
begin
  Qrymain.Parambyname('DateFrom').AsDatetime := FilterdateFrom;
  Qrymain.Parambyname('DateTo').AsDatetime := FilterdateTo;
  inherited;
end;

procedure TInsuranceReportGUI.GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
begin
  if (sameText(Event, GEVENT_ListClosed)) and (Sender.Classnameis('TProductGroupItemsGUI')) and (SelectingProductGroups) then begin
    ProductGroupsSelected(Sender);
    SelectingProductGroups := False;
  end;
end;

procedure TInsuranceReportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qryMaindetails.asInteger = 1 then begin
    if isHEaderfield(Field.fieldname) or Iscommonfield(Field.fieldname) then  AFont.Style := AFont.Style + [fsBold]
    else AFont.color := ABrush.color;
  end else begin
    if isHEaderfield(Field.fieldname) and not(Iscommonfield(Field.fieldname)) then AFont.color := ABrush.color;
  end;
end;

function TInsuranceReportGUI.isHEaderfield(const FieldName: String): Boolean;
var
  ctr:Integer;
begin
  Result := false;
  For ctr := low(HeaderFields) to high(HeaderFields) do
    if Sametext(HeaderFields[ctr] , fieldname) then begin
      REsult := TRue;
      Exit;
    end;
end;
function TInsuranceReportGUI.Iscommonfield(const FieldName: String): Boolean;
var
  ctr:Integer;
begin
  Result := false;
  For ctr := low(CommonFields) to high(CommonFields) do
    if Sametext(CommonFields[ctr] , fieldname) then begin
      REsult := TRue;
      Exit;
    end;
end;

procedure TInsuranceReportGUI.cmdExportClick(Sender: TObject);
var
  SQLS:String;
  TablenameS :String;
  QryS :TERPQuery;
  fsfilter:String;
  bm:TBookmark;
  saleIdfilter:String;
begin
Qrymain.Disablecontrols;
Try
  fsFilter := Qrymain.filter;
  bm:= Qrymain.getbookmark;
  try
    SQLS := SummarySQL +' Order by SaleDate, saleID,Details';



    SQLS:= replacestr(SQLS, ':dateFrom' , Quotedstr(formatDateTime(mySQLDateformat, filterDateFrom)));
    SQLS:= replacestr(SQLS, ':dateTo' , Quotedstr(formatDateTime(mySQLDateformat, filterDateTo)));

    TablenameS := CreateUserTemporaryTable('tmp_insurancereportExport');

    with TempMyScript do try
      SQL.add('Truncate ' + TablenameS +';');

      SQL.add('insert into  ' + TablenameS +' ( '+
        'details,Agencyref1,AgencyRef2,SSaleID,saleid,FirstName,MiddleName,LastName,Street,Street2,Suburb,State,Country,'+
        'Postcode,BillStreet,BillStreet2,BillSuburb,BillState,BillCountry,BillPostcode,POBox,POSuburb,'+
        'POState,POCountry,POPostcode,phonenumber,ShipStreet1,ShipStreet2,ShipStreet3,ShipSuburb,ShipState,ShipCountry,ShipPostCode,FaxNumber,Email,AltContact,insuranceProductname,PolicyTerm,Premiumcharged,'+
        'customername,productname,product_description,linecost,TotalAvgcost,Firstcolumn,SaleDate,productnamesort, Machinetype)' +
      SQLS +';');
      SQL.add('update ' + Tablenames +' set policyValue =  if(ifnull(linecost,0)<=1000 , 1000 ,'+
                                                          'if(ifnull(linecost,0)<=1500 , 1500 ,'+
                                                          'if(ifnull(linecost,0)<=2000 , 2000,'+
                                                          'if(ifnull(linecost,0)<=3000 , 3000 , '+
                                                          'if(ifnull(linecost,0)<=4000 , 4000 , ifnull(linecost,0)))) ) );');
      (* SQL.add('update ' + Tablenames +' set PolicyTerm = Convert(Substring(Insuranceproductname, length(Insuranceproductname),1) , Signed INTEGER);');
      SQL.add('update ' + Tablenames +' set Premiumcharged = ' +FloatTostr(Appenv.CompanyPrefs.InsurancePremiumcharged) +';');
      SQL.add('update ' + Tablenames +' set AgencyRef1 = ' + Quotedstr(Appenv.CompanyPrefs.InsuranceAgencyREf1) +';');
      SQL.add('update ' + Tablenames +' set AgencyRef2 = '+Quotedstr(Appenv.CompanyPrefs.InsuranceAgencyREf2) +';');*)
      (* SQL.add('update ' + Tablenames +' set Machinetype =' +  'if(productnamesort=1 ,'+Quotedstr(AppEnv.CompanyPrefs.InsurancereportOrderbyProductNameStartswith1) +', '+
        'if(productnamesort=2 ,'+Quotedstr(AppEnv.CompanyPrefs.InsurancereportOrderbyProductNameStartswith2) +',"" ) );'); *)
      Execute;
    finally
      Free;
    end;
    QryS:= TempMyQuery;
    try
      Qrys.SQL.add('Select ' +ArrayToString(HeaderFields)+' , ' + ArrayToString(CommonFields)+',product_description '+
        ' from ' + tablenames +' Order by SaleDate, saleID' );
      Qrys.open;
      Qrys.filter := Qrymain.Filter;
      Qrys.filtered := Qrys.filter <> '';
      if Qrys.recordcount =0 then exit;
      Qrys.first;
      if fsFilter <> '' then saleIdfilter := '(' + fsFilter +') and ' else saleIdfilter := '';
      showProgressbar(WAITMSG+' Searching for Product Names' ,Qrys.Recordcount);
      try
        While Qrys.Eof = False do begin
          Qrymain.Filtered:= False;
          Qrymain.Filter := saleIdfilter + ' SaleID = ' +inttostr(Qrys.FieldByname('saleId').asInteger)+' and Details <> 1';
          Qrymain.Filtered:= True;
          Qrys.Edit;
          Qrys.Fieldbyname('Machinetype').asString := Qrymain.FieldByname('Machinetype').asString;
          Qrys.Fieldbyname('Product_description').asString := Qrymain.Groupconcat('Product_description');
          Qrys.Post;
          Qrys.Next;
          stepProgressbar('SaleId #' +inttostr(Qrys.FieldByname('saleId').asInteger));
        end;
        Qrymain.filter := fsfilter;
      finally
        HideProgressbar;
      end;
      ExportDataset(Qrys);
    finally
      Qrys.closenFree;
    end;
  finally
    DestroyUserTemporaryTable(TablenameS);
    Qrymain.filter := fsfilter;
    Qrymain.gotobookmark(bm);
    Qrymain.FreeBookmark(bm);
  end;

Finally
  Qrymain.EnableControls;
End;
end;
procedure TInsuranceReportGUI.ExportDataset(Qry:TERPQuery);
var
  Filename:String;
  DE:TERPQueryExporter;
begin
//  inherited;
  dlgSave.Title := 'Export - ' + Caption;
  if dlgSave.Execute then begin
    Processingcursor(True);
    try
      Filename := dlgSave.FileName;
      DE:= TERPQueryExporter.create(Self);
          try
            DE.Query                  := Qry;
            DE.Grid                   := grdMain;
            DE.fileName               := FileName;
            DE.DefaultExtension       := 'txt';
            DE.RemoveNonPrintablechar := True;
            if DE.DoExport <> '' then
              MessageDlgXP_Vista('Insurance report is exported to  ' + chr(13) + Quotedstr(filename)+ '.', mtInformation, [mbOK], 0)
            else MessageDlgXP_Vista('Exporting Insurance Report Failed', mtWarning, [mbOK], 0);
      finally
        FreeandNil(DE);
      end;
    finally
      ProcessingCursor(False);
    end;
  end;
end;

(* procedure TInsuranceReportGUI.cmdPrintClick(Sender: TObject);
begin
  ReportSQLSupplied := True;
  try
    PrintTemplateReport('Insurance Product', ReportSQL, False, 1);
  finally
    ReportSQLSupplied := False;
  end;
  // inherited;
end;
function TInsuranceReportGUI.ReportSQL:String;
var
  s: string;
  ctr:Integer;
begin
  s := '';
  if GroupValues.Count <> 0 then
    for ctr := 0 to GroupValues.Count - 1 do begin
      if s <> '' then s := s + ' or ';
      s := s + ' SL.productgroup like ' + quotedstr(GroupValues[ctr] + '%');
    end;
  Result := '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, ' +
         ' CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' +
         ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN ' +
         ' FROM tblCompanyInformation AS CO' +
         ' ~|||~{Details}'+
         ' SELECT' +
         ' 2 as details,' +
         ' concat("Invoice No :" , S.sAleID)  SSaleID,' +
         ' S.saleid,' +
         ' Insurance.productname insuranceProductname,' +
         'Convert(Substring(Insurance.productname, length(Insurance.productname),1) , Signed INTEGER) PolicyTerm,' +
         ' S.customername,' +
         ' SL.productname,' +
         ' SL.product_description,' +
         ' SL.linecost,' +
         FirstColumn('SL') + ' as Firstcolumn,' +
         ' S.SaleDate,' +
         quotedstr(AppEnv.DefaultClass.FirstColumn) + ' as FirstcolumnCaption,' +
         quotedstr(AppEnv.DefaultClass.SecondColumn) + ' as SecondcolumnCaption,' +
         quotedstr(AppEnv.DefaultClass.ThirdColumn) + ' as ThirdcolumnCaption' +
         ' FROM  tblSales   S' +
         ' INNER JOIN tblSalesLines SL  on S.SaleID = SL.SaleID' +
         ' INNER JOIN ' + Tablename + '  AS Insurance on S.saleid = Insurance.saleid' +
         ' Where S.IsInvoice = "T"' +
         ' and SL.linecost  > ' + FloattoStr(AppEnv.CompanyPrefs.InsuranceProductListMinCost) +
         ' and S.SaleDate between '+ Quotedstr(FormatDateTime('yyyy-mm-dd' , filterDatefrom)) +' and ' + Quotedstr(formatdateTime('yyyy-mm-dd' , filterdateTo)) ;
  if s <> '' then  Result := Result + '  AND (' + s + ')' ;
  Result := Result + ' Order by SaleDate, saleID,Details, productnamesort';
end; *)

Procedure TInsuranceReportGUI.MakeQry;
var
  s: string;
  ctr:Integer;
begin
  s := '';
  if GroupValues.Count <> 0 then
    for ctr := 0 to GroupValues.Count - 1 do begin
      if s <> '' then s := s + ' or ';
      s := s + ' SL.productgroup like ' + quotedstr(GroupValues[ctr] + '%');
    end;

  Qrymain.SQL.add(' SELECT  ' );
  Qrymain.SQL.add(' 1 as details,' );
  Qrymain.SQL.add(' ' +Quotedstr(Appenv.CompanyPrefs.InsuranceAgencyREf1) +'  as AgencyRef1,');
  Qrymain.SQL.add(' ' +Quotedstr(Appenv.CompanyPrefs.InsuranceAgencyREf2) +'  as AgencyRef2,');
  Qrymain.SQL.add(' concat("Invoice No :" , S.sAleID)  SSaleID,' );
  Qrymain.SQL.add(' S.saleid,' );
  Qrymain.SQL.add(' C.FirstName   ,' );
  Qrymain.SQL.add(' C.MiddleName    ,' );
  Qrymain.SQL.add(' C.LastName    ,' );
  Qrymain.SQL.add(' C.Street,' );
  Qrymain.SQL.add(' C.Street2,' );
  Qrymain.SQL.add(' C.Suburb,' );
  Qrymain.SQL.add(' C.State,' );
  Qrymain.SQL.add(' C.Country,' );
  Qrymain.SQL.add(' C.Postcode,' );
  Qrymain.SQL.add(' C.BillStreet,' );
  Qrymain.SQL.add(' C.BillStreet2,' );
  Qrymain.SQL.add(' C.BillSuburb,' );
  Qrymain.SQL.add(' C.BillState,' );
  Qrymain.SQL.add(' C.BillCountry,' );
  Qrymain.SQL.add(' C.BillPostcode,' );
  Qrymain.SQL.add(' C.POBox,' );
  Qrymain.SQL.add(' C.POSuburb,' );
  Qrymain.SQL.add(' C.POState, ' );
  Qrymain.SQL.add(' C.POCountry,' );
  Qrymain.SQL.add(' C.POPostcode,' );
  Qrymain.SQL.add('if(ifnull(C.Mobile,"")<> "" , C.Mobile , if(ifnull(C.Phone,"") <> "" , C.Phone , C.AltPhone)) phonenumber,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipAddress , C.Street  ) as ShipStreet1,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipAddress1, C.Street2 ) as ShipStreet2,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipAddress2, c.Street3 ) as ShipStreet3,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipCity    , c.Suburb  ) as shipSuburb,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipState   , C.State   ) as ShipState,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipCountry , C.country ) as ShipCountry,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipPostCode, C.PostCode) as ShipPostCode,');
  Qrymain.SQL.add(' C.FaxNumber,' );
  Qrymain.SQL.add(' C.Email,' );
  Qrymain.SQL.add(' C.AltContact,' );
  Qrymain.SQL.add(' Insurance.productname insuranceProductname,' );
  Qrymain.SQL.add(' Convert(Substring(Insurance.productname, length(Insurance.productname),1) , Signed INTEGER) PolicyTerm,');
  Qrymain.SQL.add(' ' +FloatToStrF(Appenv.CompanyPrefs.InsurancePremiumcharged, ffnumber, 15, 2) +'  as Premiumcharged,');
  Qrymain.SQL.add(' S.customername,' );
  Qrymain.SQL.add(' ""  productname ,' );
  Qrymain.SQL.add(' "" product_description,' );
  //Qrymain.SQL.add(' Sum(SL.linecost) Linecost,' );
  Qrymain.SQL.add(' Sum(if(ifnull(SL.linecost,0)> ' + FloattoStr(AppEnv.CompanyPrefs.InsuranceProductListMinCost)+' , Sl.LineCost , 0) ) Linecost,' );
  Qrymain.SQL.add(' sum(Sl.shipped*P.AvgCost) as TotalAvgcost,');
  Qrymain.SQL.add(' "" as Firstcolumn,' );
  Qrymain.SQL.add(' S.SaleDate,' );
  Qrymain.SQL.add('0 productnamesort ,');
  Qrymain.SQL.add('" " as Machinetype');
  Qrymain.SQL.add(' FROM  tblSales   S' );
  Qrymain.SQL.add(' INNER JOIN tblSalesLines SL  on S.SaleID = SL.SaleID' );
  Qrymain.SQL.add(' INNER JOIN tblParts P on P.PartsId = SL.ProductID' );
  Qrymain.SQL.add(' INNER JOIN tblClients C on C.ClientID = S.ClientID' );
  Qrymain.SQL.add(' INNER JOIN ' + Tablename + '  AS Insurance on S.saleid = Insurance.saleid' );
  Qrymain.SQL.add(' LEFT JOIN tblshippingaddress AS ShipAddress on ShipAddress.ShipAddressID = S.ShipToID' );
  Qrymain.SQL.add(' Where S.IsInvoice = "T"' );
  Qrymain.SQL.add(' and SL.linecost  > ' + FloattoStr(AppEnv.CompanyPrefs.InsuranceProductListMinCost) );
  Qrymain.SQL.add(' and S.SaleDate between :DateFrom and :Dateto' );
  if s <> '' then Qrymain.SQL.add('  AND (' + s + ')' );
  Qrymain.SQL.add(' Group by S.SaleID' );
  SummarySQL:= Qrymain.SQl.text;
  Qrymain.SQL.add(' Union all ' );
  Qrymain.SQL.add(' SELECT' );
  Qrymain.SQL.add(' 2 as details,' );
  Qrymain.SQL.add(' ' +Quotedstr(Appenv.CompanyPrefs.InsuranceAgencyREf1) +'  as AgencyRef1,');
  Qrymain.SQL.add(' ' +Quotedstr(Appenv.CompanyPrefs.InsuranceAgencyREf2) +'  as AgencyRef2,');
  Qrymain.SQL.add(' concat("Invoice No :" , S.sAleID)  SSaleID,' );
  Qrymain.SQL.add(' S.saleid,' );
  Qrymain.SQL.add(' C.FirstName,' );
  Qrymain.SQL.add(' C.MiddleName,' );
  Qrymain.SQL.add(' C.LastName,' );
  Qrymain.SQL.add(' C.Street,' );
  Qrymain.SQL.add(' C.Street2,' );
  Qrymain.SQL.add(' C.Suburb,' );
  Qrymain.SQL.add(' C.State,' );
  Qrymain.SQL.add(' C.Country,' );
  Qrymain.SQL.add(' C.Postcode,' );
  Qrymain.SQL.add(' C.BillStreet,' );
  Qrymain.SQL.add(' C.BillStreet2,' );
  Qrymain.SQL.add(' C.BillSuburb,' );
  Qrymain.SQL.add(' C.BillState,' );
  Qrymain.SQL.add(' C.BillCountry,' );
  Qrymain.SQL.add(' C.BillPostcode,' );
  Qrymain.SQL.add(' C.POBox,' );
  Qrymain.SQL.add(' C.POSuburb,' );
  Qrymain.SQL.add(' C.POState,' );
  Qrymain.SQL.add(' C.POCountry,' );
  Qrymain.SQL.add(' C.POPostcode,' );
  Qrymain.SQL.add('if(ifnull(C.Mobile,"")<> "" , C.Mobile , if(ifnull(C.Phone,"") <> "" , C.Phone , C.AltPhone) ) phonenumber,');
(*   Qrymain.SQL.add('ifnull(ShipAddress.ShipAddress,S.ShipTo) ShipStreet1,');
  Qrymain.SQL.add('ShipAddress.ShipAddress1 as ShipStreet2,');
  Qrymain.SQL.add('ShipAddress.ShipAddress2 as ShipStreet3,');
  Qrymain.SQL.add('ShipAddress.ShipCity as shipSuburb,');
  Qrymain.SQL.add('ShipAddress.ShipState ShipState,');
  Qrymain.SQL.add('ShipAddress.ShipCountry as ShipCountry,');
  Qrymain.SQL.add('ShipAddress.ShipPostCode as ShipPostCode,'); *)
  Qrymain.SQL.add('ifnull(ShipAddress.ShipAddress , C.Street  ) as ShipStreet1,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipAddress1, C.Street2 ) as ShipStreet2,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipAddress2, c.Street3 ) as ShipStreet3,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipCity    , c.Suburb  ) as shipSuburb,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipState   , C.State   ) as ShipState,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipCountry , C.country ) as ShipCountry,');
  Qrymain.SQL.add('ifnull(ShipAddress.ShipPostCode, C.PostCode) as ShipPostCode,');
  Qrymain.SQL.add(' C.FaxNumber,' );
  Qrymain.SQL.add(' C.Email,' );
  Qrymain.SQL.add(' C.AltContact,' );
  Qrymain.SQL.add(' Insurance.productname insuranceProductname,' );
  Qrymain.SQL.add(' Convert(Substring(Insurance.productname, length(Insurance.productname),1) , Signed INTEGER) PolicyTerm,');
  Qrymain.SQL.add(' ' +FloatToStrF(Appenv.CompanyPrefs.InsurancePremiumcharged, ffnumber, 15, 2) +'  as Premiumcharged,');
  Qrymain.SQL.add(' S.customername,' );
  Qrymain.SQL.add(' SL.productname,' );
  Qrymain.SQL.add(' SL.product_description,' );
  Qrymain.SQL.add(' SL.linecost,' );
  Qrymain.SQL.add(' Sl.shipped*P.AvgCost as TotalAvgcost,');
  Qrymain.SQL.add(FirstColumn('SL') + ' as Firstcolumn,' );
  Qrymain.SQL.add(' S.SaleDate,' );
  Qrymain.SQL.add('if(SL.product_description like '+Quotedstr(AppEnv.CompanyPrefs.InsurancereportOrderbyProductNameStartswith1+'%')+' , 1, '+
                  'if(SL.product_description like '+Quotedstr(AppEnv.CompanyPrefs.InsurancereportOrderbyProductNameStartswith2+'%')+', 2 , 3)) productnamesort ,');
  Qrymain.SQL.add('if(SL.product_description like '+Quotedstr(AppEnv.CompanyPrefs.InsurancereportOrderbyProductNameStartswith1+'%')+' , ' + Firstcolumn('P')+',"Auxilliary" ) as Machinetype');

  Qrymain.SQL.add(' FROM  tblSales   S' );
  Qrymain.SQL.add(' INNER JOIN tblSalesLines SL  on S.SaleID = SL.SaleID' );
  Qrymain.SQL.add(' INNER JOIN tblParts P on P.PartsID = SL.ProductID' );
  Qrymain.SQL.add(' INNER JOIN tblClients C on C.ClientID = S.ClientID' );
  Qrymain.SQL.add(' INNER JOIN ' + Tablename + '  AS Insurance on S.saleid = Insurance.saleid' );
  Qrymain.SQL.add(' LEFT JOIN tblshippingaddress AS ShipAddress on ShipAddress.ShipAddressID = S.ShipToID' );
  Qrymain.SQL.add(' Where S.IsInvoice = "T"' );
  Qrymain.SQL.add(' and SL.linecost  > ' + FloattoStr(AppEnv.CompanyPrefs.InsuranceProductListMinCost) );
  Qrymain.SQL.add(' and S.SaleDate between :DateFrom and :Dateto' );
  if s <> '' then Qrymain.SQL.add('  AND (' + s + ')' );
  Qrymain.SQL.add(' Order by SaleDate, saleID,Details , productnamesort');
end;

procedure TInsuranceReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Details');
  RemoveFieldfromGrid('ID');
end;

procedure TInsuranceReportGUI.SetQrymainSQL;
var
  ctr: Integer;
begin

  CloseDB(Qrymain);
  Qrymain.Sql.clear;
  MakeQry;
  RefreshOrignalSQL;
  if GroupValues.Count = 0 then btnProductgroups.hint := 'No Product Group Selected. List is populated for all Product groups'
  else begin
    btnProductgroups.hint := 'Selected Product Groups are ';
    for ctr := 0 to GroupValues.Count - 1 do btnProductgroups.hint := btnProductgroups.hint + chr(13) + '    ' + GroupValues[ctr];
  end;
end;

procedure TInsuranceReportGUI.WriteGuiPref;
begin
  GuiPrefs.Node['General.GroupValues'].asString := GroupValues.commatext;
end;

initialization

  RegisterClassOnce(TInsuranceReportGUI);

end.
