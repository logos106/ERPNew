unit frmExportoptionsFrm;

{

 Date     Version  Who What
 -------- -------- --- ------------------------------------------------------
 26/07/05  1.00.01 IJB Added exception handling around output file creation.
 28/07/05  1.00.02 DSP Fixed problem with extra buy price.
 04/08/05  1.00.03 DSP Added ability to export 'Product Foreign Sell Prices'.
 11/10/05  1.00.04 BJ  Added ability to export 'Budgets'.
 26/04/04  1.00.05 BJ  Default UOM fieds are removed from the Parts table and so removed from the
                        ProdctList export query.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DNMSpeedButton, DB, MyAccess,ERPdbComponents, ComCtrls,AdvOfficeStatusBar, ExtCtrls,
  BaseInputForm, DNMPanel,
  SelectionDialog, AppEvnts,  DBAccess, DataState, Menus, AdvMenus, Shader,
  ImgList, CheckLst, MemDS;

type
  TfrmExportoptions = class(TBaseInputGUI)
    Label14: TLabel;
    lblImporting: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    ExportProgressBar: TProgressBar;
    SpeedButton1: TDNMSpeedButton;
    txtFileName: TEdit;
    Letter_Label: TLabel;
    SaveDialog1: TSaveDialog;
    Bevel2: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    dsfds: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label19: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    ChkAccounts: TCheckBox;
    ChkClients: TCheckBox;
    ChkProducts: TCheckBox;
    ChkClass: TCheckBox;
    ChkEmployee: TCheckBox;
    ChkTerms: TCheckBox;
    ChkAccessLevels: TCheckBox;
    ChkClientsContacts: TCheckBox;
    ChkClientsTypes: TCheckBox;
    ChkExtraBuy: TCheckBox;
    ChkExtraSell: TCheckBox;
    ChkSource: TCheckBox;
    ChkClientsSpecialPrice: TCheckBox;
    ChkCompanyInfo: TCheckBox;
    ChkClientsGroupDiscounts: TCheckBox;
    ChkForeignBuy: TCheckBox;
    ChkRepRates: TCheckBox;
    ChkPubHolidays: TCheckBox;
    ChkForExHist: TCheckBox;
    ChkForExRates: TCheckBox;
    ChkUnitOfMeasure: TCheckBox;
    chkMarketingContacts: TCheckBox;
    chkForeignSell: TCheckBox;
    chkBudgets: TCheckBox;
    chkFixedAssets: TCheckBox;
    chkMarketingContactsDetails: TCheckBox;
    ChkClientsShipAddress: TCheckBox;
    chkProductbin: TCheckBox;
    Label3: TLabel;
    chkProductClass: TCheckBox;
    Label17: TLabel;
    chkRewardPoints: TCheckBox;
    Label30: TLabel;
    chkClientrewardPoints: TCheckBox;
    Label31: TLabel;
    chkProductCommission: TCheckBox;
    Label32: TLabel;
    chkEquipment: TCheckBox;
    Label33: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    chkManufacture: TCheckBox;
    Label34: TLabel;
    Label35: TLabel;
    chkRepairFaults: TCheckBox;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ChkAccessLevelsClick(Sender: TObject);
    procedure ChkAccountsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkMarketingContactsClick(Sender: TObject);
    procedure chkMarketingContactsDetailsClick(Sender: TObject);
    procedure TitleLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    RunOnceFlag: boolean;
    qryExport: TERPQuery;
    F: TextFile;
    function IsDir(const DirPath: string): boolean;
    function MakeDataLine(const TypeStr: string): string;
    function MakeHeaderLine(const TypeStr, TypeStr2, TypeStr3: string): string;
    function MakeExportFile(const FileName: string): boolean;
    procedure CloseExportFile;
    procedure AddLinetoFile(const StrData: string);
    procedure ExportAccessLevelsChangeGUI(const Enabled: boolean);
    //A better file reset procedure.... probably best to put into an I/O pas
    procedure ABetterRewrite(var fd: text);
    Procedure ExportSelected(const CreatedQryStr, Header1, Header2, Header3 , EXPORTTYPE, Caption:String );

  public
    { Public declarations }
    OldFilter : string;
  end;


implementation

uses FastFuncs,DNMLib, CommonDbLib, DNMExceptions, BusObjImportExport, CommonLib,
  MySQLConst, AppEnvironment, tcConst;

{$R *.DFM}

resourcestring
  // Headers Strings
  HBUDGETINFO = '$BUDGETINFO, BudgetID, Name,Description, Amount1Label, Amount2Label,ShowAmount1, ShowAmount2, BudgetStartDate,' +
    'BudgetEndDate, IntervalPeriod, IntervalDuration,tblbudgetsActive, BudgetPeriodID,BudgetDate,' +
    'BudgetNo, StartDate,EndDate,  tblbudgetperiodsActive,BudgetPeriodLinesID, ClassID,' +
    'AccountID, JobID, BudgetDate,ForDate, Amount1, Amount2, tblbudgetperiodlinesActive,' +
    'BudgetLineID, Date, Conservative,Aggressive, tblbudgetlinesActive';

  HCOMPANYINFO   =
    '$COMPANYINFO,CompanyName,Address,Address2,City,State,Postcode,Country,PhoneNumber,FaxNumber,ABN,POBox,POBox2,POCity,POState,POPostcode,POCountry';
  HSOURCE        = '$SOURCE,MediaType,Cost,AccountName,Active';
  HCONTACT       = '$CONTACT,CustomerName,SupplierName,Company,ContactTitle,ContactFirstName,ContactSurName,ContactAddress,';
  HCONTACT1      =
    'ContactCity,ContactState,ContactPcode,ContactPH,ContactAltPH,ContactMOB,ContactFax,ContactEmail,Notes,ContactAddress2,JobTitle,AccountNo,CardNumber,Active';
  HCLIENTTYPE    = '$CLIENTTYPE,ClientTypeID,TypeName,TypeDescription,Terms,CreditLimit,GracePeriod';
  HCLIENTREWARDPOINTS = '$CLIENTREWARDPOINTS,Company,RewardPoints,PointExpiresOn,ValueforRewardPoint,OpeningBalanceAsOn';
  HSPECIALPRICE  = '$SPECIALPRICE,Company,Name,Description,OrigPrice,LinePrice';
  HEXTRABUYPRICE =
    '$EXTRABUYPRICE,PartName,Company,Buy1,' +
    (*'Buy2,Buy3,' +*)
    'Price,UOM,UOMMultiplier,' +
    (*'Price2,Price3,' +*)
    'PrintedValue1,' +
    (*'PrintedValue2,PrintedValue3,' +*)
    'SupplierProductCode,SupplierProductName,UsePrice,UOMID';
  HEXTRASELLPRICE =
    '$EXTRASELLPRICE,PartName,QtyPercent1,Price1,UOM,UOMMultiplier,' +
    (*'QtyPercent2,Price2,QtyPercent3,Price3,' +*)
    'DateTo,DateFrom,ExtraSellDesc,TypeName,AllClients,UOMID';
  HACCESS        = '$ACCESS,EmployeeName,FormID,Access';
  HPART          =
    '$PART,PARTTYPE,PRODUCTGROUP,PARTNAME,PARTSDESCRIPTION,PURCHASEDESC,INCOMEACCNT,ASSETACCNT,COGSACCNT,BARCODE,PRODUCTCODE,' +
    'NormalDeliveryTime, ';
  HPART2         =
    'TAXCODE,PURCHTAXCODE,PREFEREDSUPP,SpecialDiscount,SNTracking,MultipleBins,BuyQTY1,BuyQTY2,BuyQTY3,COST1,COST2,COST3,SellQTY1,SellQTY2,SellQTY3,PRICE1,PRICE2,PRICE3,WHOLESALEPRICE,SupplierProductCode,';
  HPART3         = 'Attrib1Sale,Attrib2Sale,Attrib1Purchase,Attrib2Purchase,Active';
  HPARTBIN       = '$PARTBIN,CLASSID,BINLOCATION,BINNUMBER,VOLUME,VOLUME_USED,ACTIVE';
  HPARTCLASS     = '$PARTCLASS,ProductName,ClassName,ReOrderPoint,PreferredLevel,ReOrderAmount,' +
    'LastAdj,LastAdjAccount,ClassPriceVariance,VariantPrice,NextStocktakeDate,Active,BinLocation,BinNumber,DefaultBinId,ClassId,ProductID';
  HCLIENT        =
    '$CLIENT,Company,JobName,ABN,Title,FirstName,LastName,Street,Street2,Suburb,State,Postcode,BillStreet,BillStreet2,BillSuburb,BillState,BillPostcode,POBox,';
  HCLIENT2       =
    'POSuburb,POState,POPostcode,Phone,FaxNumber,Mobile,Email,AltContact,AltPhone,Contact1,Contact1Phone,Contact2Phone,Notes,ClientNo,TypeName,TermsName,';
  HCLIENT3       =
    'ShippingMethod,SourceName,Customer,Supplier,OtherContact,IsJob,CreditLimit,GracePeriod,Discount,SpecialDiscount,RepName,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,CUSTFLD7,CUSTFLD8,';
  HCLIENT4       = 'CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,JobTitle,CardNumber,Global,Active';
  HACCOUNT       = '$ACCOUNT,AccountName,AccountGroup,AccountType,Description,AccountNumber,Taxcode,BankNumber,Extra,Class,Active';
  (*HQTY           = '$QTY,ProductName,ProductGroup,ClassName,InStockQty,ReOrderPoint,PreferredLevel,ReOrderAmount,ClassPriceVariance';*)
  HCLASS         = '$CLASS,ClassName,Description,Active';
  HTERMS         = '$TERMS,Terms,Description,TermsAmount,EOM,EOMPlus,Active';
  HEMPLOYEE      = '$EMPLOYEE,Title,FirstName,MiddleName,LastName,Initials,EmployeeNo,Street,Street2,Suburb,Postcode,State,Phone,AltPhone,FaxNumber,';
  HEMPLOYEE2     = 'Mobile,Email,AltContact,Position,ABN,TFN,DOB,Sex,Notes,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,CUSTFLD7,CUSTFLD8,';
  HEMPLOYEE3     = 'CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,DateStarted,DateFinished,Canvasser,Rep,Active';
  HCLIENTGROUPDISCOUNTS = '$CLIENTGROUPDISCOUNTS,Company,Col1,Col2,Col3,Discount';
  HFOREIGNBUYPRICE =  '$FOREIGNBUYPRICE,PartName,Company,Currency,Buy1,Price1, UOM,UOMMultiplier,UOMID'(* + ',Buy2,Price2,Buy3,Price3'*);
  HFOREIGNSELLPRICE = '$FOREIGNSELLPRICE,PartName,Currency,Buy1,Price1,UOM,UOMMultiplier,UOMID' (*+',Buy2,Price2,Buy3,Price3'*);
  HREPRATES      = '$REPRATES,EmployeeName,ServiceDesc,AbilityDesc,Company,Rate,PayRate';
  HRWARDPOINTS   = '$REWARDPOINTS,UseUOM,UOM,UOMMultiplier,Partname,Points,Value,UseDate,DateFrom,DateTo,UseExpiryDate,RewardPointExpiresOn,ExpiresOnNoOfMonthsAfterPurchase,Active,DateCreated,PartsId,UOMID';
  HPRODUCTCOMMISSION='$PRODUCTCOMMISSION,Partname,CommissionRate,IsPercentage,ForAllEmployees,EmployeeName,Active';
  HPUBHOL        = '$PUBHOL,Day,Description';
  HFORIEGNEXCHANGERATES = '$FORIEGNEXCHANGERATES,Code,Country,Currency,BuyRate,SellRate,FixedRate,UpperVariation,LowerVariation,Active';
  HFORIEGNEXCHANGEHISTORY = '$FORIEGNEXCHANGEHISTORY,Code,Date,BuyRate,SellRate,Active';
  HUNITOFMEASURE = '$UNITOFMEASURE,UnitName,UnitDescription,Multiplier,BaseUnitName,Product,SalesDefault,PurchasesDefault,Active';
  HMARKETINGCONTACTS = '$MARKETINGCONTACTS,CompanyTypeName,Company,JobTitle,Title,Firstname,Middlename,LastName,Street,Street2,Suburb,State,Postcode,Country,Email,Phone,Mobile,FaxNumber,AltPhone,EmployeeSize,Notes,Source,Active';
  HFIXEDASSETS  = '$FIXEDASSETS,AssetCode,AssetName,PurchDate,PurchCost,AssetType,ClassID,LocationDescription,BrandName,Manufacture,Model,Serial,Notes,Qty,AssetCondition,Colour,Size,Shape,Status,EstimatedValue,'+
                   'ReplacementCost,WarrantyType,WarrantyExpiresDate,InsuredBy,InsurancePolicy,InsuredUntil,BusinessUsePercent,'+
                   'CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,'+
                   'SupplierName,BarCode,CUSTDATE1,CUSTDATE2,CUSTDATE3,Active';
  HManufacture = '$MANUFACTURE,Name,Active,CreatedOn';
  HRepairFaults = '$REPAIRFAULTS,code,Category,Description,Active,Manufacture';

  HSHIPPINGADDRESS = '$SHIPPINGADDRESS,CompanyName, ShipAddress, ShipAddress1,ShipCity,ShipPostCode,ShipState,ShipCountry,CustomerCompany';
  HEQUIPMENT='$EQUIPMENT,EquipmentName,EquipmentDescription,PARTNAME,Manufacture,Model,Active';

procedure TfrmExportoptions.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

function TfrmExportoptions.IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;

procedure TfrmExportoptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TfrmExportoptions.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  //SaveDialog1.InitialDir := SystemLib.ExeDir;
  if SaveDialog1.Execute then begin
    txtFileName.Text := SaveDialog1.FileName;
  end;
end;

procedure tfrmExportoptions.ABetterRewrite(var fd: text);
const
 TimeOutValue = 100; // msecs

var
  TickCount: DWORD;
  IOR: integer;
begin
  TickCount := GetTickCount;
  while abs(TickCount-GetTIckCount) < TimeOutValue do begin
{$I-} Rewrite(fd); {$I+}
      IOR := IOResult;
      if IOR = 0 then Exit; // success
      if IOR <> 5 then raise Exception.Create('I/O error'); // 5 = access denied -> retry

  end;
end;


procedure TfrmExportoptions.AddLinetoFile(const StrData: string);
var
  sData: string;
begin
  sData := StringReplace(StrData, #13#10, '\n\r', [rfReplaceAll,rfIgnoreCase]);
  sData := StringReplace(sData, #44, '', [rfReplaceAll,rfIgnoreCase]);
  Writeln(F, sData);
end;

function TfrmExportoptions.MakeExportFile(const FileName: string): boolean;
begin
  Result := true;
  try
    AssignFile(F, FileName);
  //  Rewrite(F);
    ABetterRewrite(F);

  except
    Result := false;
    CommonLib.MessageDlgXP_Vista('Unable to create file: ' + FileName, mtWarning, [mbOK], 0);
    try
      CloseFile(F);
    except
    end;
  end;
end;

procedure TfrmExportoptions.CloseExportFile;
begin
  try
    Flush(F);
    CloseFile(F);
  except
  end;
end;

procedure TfrmExportoptions.btnOKClick(Sender: TObject);
var
  CreatedQryStr: string;
  P,I, LinesCount: integer;
  EnCryptedLine: string;
  Cls: TPersistentClass;
  ClassName: string;
  qryMaster, qryDetail : TERPQuery;
  SL : TStringList;
begin
  DisableForm;
  try
    P := 0;
    inherited;
    btnOK.Enabled := false;
    try
      if chkMarketingContactsDetails.Checked then begin

        If SaveDialog1.FileName = ''  then Begin
          CommonLib.MessageDlgXP_Vista('No file nominated.', mtWarning, [mbOK], 0);
          btnOK.Enabled := True;
          Exit;
        end;

        qryMaster := TERPQuery.Create(nil);
        qryDetail := TERPQuery.Create(nil);
        SL := TStringList.Create;
        try
          qryMaster.Connection := GetSharedMyDacConnection;
          qryMaster.SQL.Text :=
          'SELECT' +
          ' ID, Title, FirstName, LastName, Street, Postcode, Suburb, State, Country,'+
          ' Phone, Mobile, AltPhone, Email, FaxNumber,'+
          ' Company, JobTitle, Notes, CompanyTypeName, Source'+
          ' FROM tblmarketingcontacts';
          qryMaster.Open;

          If qryMaster.RecordCount=0 then Begin
            Self.Close;
            Exit;
          end;

          qryDetail.Connection := qryMaster.Connection;
          qryDetail.SQL.Text :=
          'SELECT tblmarketingleadlines.*, tblmarketingleads.ISLead as marketingLead '+
              ' FROM tblmarketingleadlines inner join  tblmarketingleads on tblmarketingleadlines.LeadId =tblmarketingleads.LeadID' +
              ' WHERE tblmarketingleads.MarketingContactID = :ClientID';

          ExportProgressBar.Min := 1;
          ExportProgressBar.Max := qryMaster.RecordCount;

          for i := 1 to qryMaster.RecordCount do begin
            P:= i;
            SL.Add('~~Record No. ' + IntToStr(i));
            SL.Add('Title, FirstName, LastName, Street, Postcode, Suburb, State, Country,'+
             ' Phone, Mobile, AltPhone, Email, FaxNumber,'+
             ' Company, JobTitle, Notes, CompanyTypeName, Source');
            SL.Add(
             QuotedStr(qryMaster.FieldByName('Title').AsString)                + ',' +
             QuotedStr(qryMaster.FieldByName('FirstName').AsString)            + ',' +
             QuotedStr(qryMaster.FieldByName('LastName').AsString)             + ',' +
             QuotedStr(qryMaster.FieldByName('Street').AsString)               + ',' +
             QuotedStr(qryMaster.FieldByName('Postcode').AsString)             + ',' +
             QuotedStr(qryMaster.FieldByName('Suburb').AsString)               + ',' +
             QuotedStr(qryMaster.FieldByName('State').AsString)                + ',' +
             QuotedStr(qryMaster.FieldByName('Country').AsString)              + ',' +
             QuotedStr(qryMaster.FieldByName('Phone').AsString)                + ',' +
             QuotedStr(qryMaster.FieldByName('Mobile').AsString)               + ',' +
             QuotedStr(qryMaster.FieldByName('AltPhone').AsString)             + ',' +
             QuotedStr(qryMaster.FieldByName('Email').AsString)                + ',' +
             QuotedStr(qryMaster.FieldByName('FaxNumber').AsString)            + ',' +
             QuotedStr(qryMaster.FieldByName('Company').AsString)              + ',' +
             QuotedStr(qryMaster.FieldByName('JobTitle').AsString)             + ',' +
             '"' + qryMaster.FieldByName('Notes').AsString + '"'                + ',' +
             QuotedStr(qryMaster.FieldByName('CompanyTypeName').AsString)      + ',' +
             QuotedStr(qryMaster.FieldByName('Source').AsString)
             );
            SL.Add('~~Detail No. ' + IntToStr(i));
            qryDetail.ParamByName('ClientID').AsInteger := qryMaster.FieldByName('ID').AsInteger;
            qryDetail.Open;
            while not qryDetail.Eof do begin
              SL.Add('ResultType,FollowUp/ActionDate,Employee,Done,LastUpdated,Notes,ISLead,MarketingLead');
              SL.Add(
                QuotedStr(qryDetail.FieldByName('ResultTypeName').AsString)      + ',' +
                QuotedStr(qryDetail.FieldByName('FollowUpDate').AsString)        + ',' +
                QuotedStr(qryDetail.FieldByName('EmployeeName').AsString)        + ',' +
                QuotedStr(qryDetail.FieldByName('Done').AsString)                + ',' +
                QuotedStr(qryDetail.FieldByName('UpdateDate').AsString)          + ',' +
                QuotedStr(qryDetail.FieldByName('Notes').AsString )               + ',' +
                QuotedStr(qryDetail.FieldByName('ISLead').AsString )               + ',' +
                QuotedStr(qryDetail.FieldByName('MarketingLead').AsString ) );
              qryDetail.Next;
            end;
            qryDetail.Close;
            SL.Add('~~End of Record No. ' + IntToStr(i));
            qryMaster.Next;
            ExportProgressBar.StepIt;
          end;

          SL.SaveToFile(SaveDialog1.FileName);

        finally
          FreeandNil(SL);
          FreeandNil(qryMaster);
          FreeandNil(qryDetail);
        end;

        CommonLib.MessageDlgXP_Vista(IntToStr(P) + ' record(s) exported successfully!', mtInformation, [mbOK], 0);
        ExportProgressBar.Position := 0;
        btnOK.Enabled := True;
        Exit;

      end;

      ClassName := '';

      if empty(txtFileName.Text) then SpeedButton1Click(Sender);

      if not IsDir(ExtractFileDir(txtFileName.Text)) then begin
        CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFileName.Text) +
          '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
        btnOK.Enabled := true;
        SetControlFocus(txtFileName);
        Exit;
      end;

      btnCancel.Enabled := false;
      qryExport         := TERPQuery.Create(nil);
      try
        qryExport.Connection := CommonDbLib.GetSharedMyDacConnection;
        qryExport.ParamCheck := false;

        //Start File
        if not MakeExportFile(txtFileName.Text) then begin
          btnOK.Enabled := true;
          Exit;
        end;

        //What to Export ??

        {Export Access Levels }
        if ChkAccessLevels.Checked then begin
          //if ChkAccessLevels.Checked then begin
            CreatedQryStr :=
              'SELECT Concat(FirstName," ",LastName) AS "EmployeeName", FormID, Access FROM tblemployeeformsaccess ' +
              'INNER JOIN tblemployees Using(EmployeeID);';
            qryExport.SQL.Clear;
            qryExport.SQL.Add(CreatedQryStr);
            lblImporting.Caption := 'Please Wait Preparing Access Levels ..... 0%';
            lblImporting.Visible := true;
            ExportProgressBar.Min := 0;
            Application.ProcessMessages;
            qryExport.Active := true;
            EnCryptedLine := EnCrypt(MakeHeaderLine(HACCESS, '', ''), '^');
            AddLinetoFile(EnCryptedLine);
            EnCryptedLine := '';
            with qryExport do begin
              First;
              LinesCount := qryExport.RecordCount + 1;
              ExportProgressBar.Max := LinesCount;
              ExportProgressBar.Position := ExportProgressBar.Min;
              for I := 0 to qryExport.RecordCount - 1 do begin
                ExportProgressBar.StepIt;
                lblImporting.Caption :=
                  'Please Wait Exporting Access Levels ..... ' + FloatToStrF(((I / LinesCount) * 100),
                  ffFixed, 7, 0) + '% Complete';
                EnCryptedLine := EnCrypt(MakeDataLine('ACCESS'), '^' + IntToStr(I));
                AddLinetoFile(EnCryptedLine);
                EnCryptedLine := '';
                Next;
                Application.ProcessMessages;
              end;
            end;
            AddLinetoFile(EnCrypt('FINALACCESS', '^'));
          //end;
        end else begin
          if ChkCompanyInfo.Checked then begin
            CreatedQryStr := 'Select ' + ReplaceStr(HCOMPANYINFO, '$COMPANYINFO,', '') + ' FROM tblcompanyinformation;';
            ExportSelected(CreatedQryStr , HCOMPANYINFO, '', '', 'COMPANYINFO', 'Company Information');
          end;

          {Export Class}
          if ChkClass.Checked then begin
            CreatedQryStr := 'Select ' + ReplaceStr(HCLASS, '$CLASS,', '') + ' FROM tblclass Where ClassName is not null;';
            ExportSelected(CreatedQryStr , HCLASS, '', '', 'CLASS', appenv.DefaultClass.ClassHeading);
          end;

          {Export Public Holidays}
          if ChkPubHolidays.Checked then begin
            CreatedQryStr := 'Select ' + ReplaceStr(HPUBHOL, '$PUBHOL,', '') + ' From tblpublicholidays;';
            ExportSelected(CreatedQryStr , HPUBHOL, '', '', 'PUBHOL','Public Holidays');
          end;

          {Export Terms}
          if ChkTerms.Checked then begin
            CreatedQryStr := 'Select ' + ReplaceStr(HTERMS, '$TERMS,', '') + ' From tblterms Where Terms is not null;';
            ExportSelected(CreatedQryStr , HTERMS, '', '', 'TERMS','Terms');
          end;

          {Export Accounts}
          if ChkAccounts.Checked then begin
            CreatedQryStr := 'Select ' + ReplaceStr(HACCOUNT, '$ACCOUNT,',
              '') + ' From tblchartofaccounts Where AccountName is not null;';
            ExportSelected(CreatedQryStr , HACCOUNT, '', '', 'ACCOUNT','Accounts');
          end;

          {Equipment}
          if chkEquipment.checked then begin
              CreatedQryStr := 'SELECT E.EquipmentName,E.EquipmentDescription,P.PARTNAME,' +
                        ' E.Manufacture,E.Model,E.Active' +
                        ' FROM tblequipment AS E Left Join tblparts AS P ON E.ProductId = P.PARTSID';
              ExportSelected(CreatedQryStr , HEQUIPMENT , '','', 'EQUIPMENT', 'Equipment');
          end;
          {Export Employess}
          if ChkEmployee.Checked then begin
            CreatedQryStr := 'Select ' + ReplaceStr(HEMPLOYEE, '$EMPLOYEE,', '') + HEMPLOYEE2 +
              HEMPLOYEE3 + ' FROM tblemployees Where FirstName <> "";';
            ExportSelected(CreatedQryStr , HEMPLOYEE, HEMPLOYEE2, HEMPLOYEE3, 'EMPLOYEE', 'Employee');
          end;

          {Export Product Commission}
          if chkProductCommission.Checked then begin
            CreatedQryStr := 'SELECT PC.Partname, PC.CommissionRate, PC.IsPercentage,' +
                            ' PC.ForAllEmployees,E.EmployeeName,PC.Active' +
                            ' FROM tblproductcommission AS PC' +
                            ' Left Join tblemployees AS E ON PC.EmployeeId = E.EmployeeID';
            ExportSelected(CreatedQryStr , HPRODUCTCOMMISSION, '', '', 'PRODUCTCOMMISSION', 'Product Commission');
          end;

          {reward points}
          if chkRewardPoints.checked then begin
            CreatedQryStr :=
              'SELECT UseUOM,UOM,UOMMultiplier,Partname,Points,Value,' +
                    ' UseDate,DateFrom,DateTo,UseExpiryDate,RewardPointExpiresOn,' +
                    ' ExpiresOnNoOfMonthsAfterPurchase,Active,DateCreated ' +
                    ' from tblProductRewardpoints ' +
                    ' Order by Partname , UOM';
            ExportSelected(CreatedQryStr , HRWARDPOINTS, '', '', 'REWARDPOINTS', 'Reward Points');

          end;
          {Export Rep Rates}
          if ChkRepRates.Checked then begin
            CreatedQryStr :=
              'SELECT EmployeeName, ServiceDesc,AbilityDesc, C.Company, Rate, PayRate ' +
              'FROM tbltrainerrates TR  ' + 'Left Join tblemployees E Using(EmployeeID) ' +
              'Left Join tblservices S on S.ServiceID=TR.ServiceID ' + 'Left Join tblability A on A.AbilityID=TR.AbilityID  ' +
              'Left Join tblClients C on C.ClientID=TR.ClientID  ' + 'Order By EmployeeName;';
           ExportSelected(CreatedQryStr , HREPRATES, '', '', 'REPRATES','Rep Rates');
          end;

          {Export Source}
          if ChkSource.Checked then begin
            CreatedQryStr :=
              'SELECT MediaType,Cost, AccountName,tblsource.Active  FROM tblsource LEFT JOIN tblchartofaccounts on Account=AccountID;';
            ExportSelected(CreatedQryStr , HSOURCE, '', '', 'SOURCE','Source');
          end;
          if chkClientrewardPoints.checked then begin
            CreatedQryStr :=
              'SELECT C.Company, S.LinePoints as RewardPoints, S.PointExpiresOn, S.ValueforRewardPoint,  ' +
                    'S.OpeningBalanceAsOn  ' +
                    'FROM tblclients AS C  ' +
                    'Left Join tblsaleslinespoints AS S ON C.ClientID = S.clientID and S.IsOpeningBalance =  "T"   ' +
                    'where company <> '+ QuotedStr(CLIENT_CASH) +
                    ' Order by C.company';
           ExportSelected(CreatedQryStr , HCLIENTREWARDPOINTS, '', '', 'CLIENTREWARDPOINTS','Reward Points');
          end;
          {Export Client Types}
          if ChkClientsTypes.Checked then begin
            CreatedQryStr :=
              'SELECT ClientTypeID, TypeName, TypeDescription, Terms, CreditLimit, GracePeriod FROM tblclienttype Left Join tblterms Using(TermsID);';
            ExportSelected(CreatedQryStr , HCLIENTTYPE, '', '', 'CLIENTTYPE','Client Types');

          end;

          {Export Clients}
          if ChkClients.Checked then begin
            CreatedQryStr :=
              'Select tblclients.Company,JobName,tblclients.ABN,tblclients.Title,tblclients.FirstName,tblclients.LastName,' +
              'tblclients.Street,tblclients.Street2,tblclients.Suburb,tblclients.State,tblclients.Postcode,' +
              'BillStreet,BillStreet2,BillSuburb,BillState,BillPostcode,POBox,POSuburb,POState,POPostcode,' +
              'tblclients.Phone,tblclients.FaxNumber,tblclients.Mobile,tblclients.Email,tblclients.AltContact,' +
              'tblclients.AltPhone,Contact1,Contact1Phone,Contact2Phone,' +
              'SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(tblclients.Notes,0x22,0x27),0xD," "),0xA," "),0x9," "),1,char_length(REPLACE(REPLACE(REPLACE(REPLACE(tblclients.Notes,0x22,0x27),0xD," "),0xA," "),0x9," ")))as Notes,'
              + 'ClientNo,TypeName,tblterms.Terms as TermsName,tblshippingmethods.ShippingMethod,MediaType as SourceName,' +
              'Customer,Supplier,OtherContact,IsJob,tblclients.CreditLimit,tblclients.GracePeriod,tblclients.Discount,tblclients.SpecialDiscount,' +
              'Concat(E.FirstName," ",E.LastName) AS RepName,tblclients.CUSTFLD1,tblclients.CUSTFLD2,tblclients.CUSTFLD3,tblclients.CUSTFLD4,tblclients.CUSTFLD5,tblclients.CUSTFLD6,tblclients.CUSTFLD7,tblclients.CUSTFLD8,'
              +
              'tblclients.CUSTFLD9,tblclients.CUSTFLD10,tblclients.CUSTFLD11,tblclients.CUSTFLD12,tblclients.CUSTFLD13,tblclients.CUSTFLD14,tblclients.CUSTFLD15,tblclients.JobTitle,tblclients.CardNumber,tblclients.Global,tblclients.Active '
              + 'FROM tblclients ' + 'LEFT JOIN tblterms on tblterms.TermsID=tblclients.TermsID ' +
              'LEFT JOIN tblemployees as E on E.EmployeeID=tblclients.RepID ' +
              'LEFT JOIN tblclienttype on tblclienttype.ClientTypeID = tblclients.ClientTypeID ' +
              'LEFT JOIN tblshippingmethods on tblshippingmethods.ShippingMethodID = tblclients.ShippingID ' +
              'LEFT JOIN tblsource on tblsource.MedTypeID = tblclients.MedTypeID ' + 'Where tblclients.Company is not null;';
          ExportSelected(CreatedQryStr , HCLIENT, HCLIENT2, HCLIENT3 + HCLIENT4, 'CLIENT','Clients');

          end;

          {Export CONTACT}
          if ChkClientsContacts.Checked then begin
            CreatedQryStr :=
              'SELECT If(CusID>0,CL1.Company,"") as CustomerName,If(SupID>0,CL2.Company,"") as SupplierName, ' +
              'tblcontacts.Company,ContactTitle,ContactFirstName,ContactSurName, ' +
              'ContactAddress,ContactCity,ContactState,ContactPcode,ContactPH,ContactAltPH,ContactMOB, ' +
              'ContactFax,ContactEmail,tblcontacts.Notes,ContactAddress2,tblcontacts.JobTitle,tblcontacts.AccountNo,tblcontacts.CardNumber,tblcontacts.Active ' +
              'FROM tblcontacts ' + 'Left JOIN tblclients as CL1 on tblcontacts.ClientID = CL1.ClientID ' +
//              'Left JOIN tblclients as CL2 on SupID = CL2.ClientID ' +
              'Where tblcontacts.Active = "T";';
          ExportSelected(CreatedQryStr , HCONTACT, HCONTACT1, '', 'CONTACT','Contacts');
          end;
          {product class n default bin }
          if chkProductClass.checked then begin
              CreatedQryStr :=  ' SELECT PC.ProductName, PC.ClassName, PC.ReOrderPoint, ' +
                  'PC.PreferredLevel, PC.ReOrderAmount, PC.LastAdj, PC.LastAdjAccount,  ' +
                  'PC.ClassPriceVariance, PC.VariantPrice, PC.NextStocktakeDate,  ' +
                  'PC.Active, PB.BinLocation, PB.BinNumber  ' +
                  ' FROM tblproductclasses AS PC  ' +
                  ' Left Join tblproductbin AS PB ON PC.DefaultbinId = PB.BinID  ' +
                  ' Order by ProductName, Classname, binLocation,binnumber';
            ExportSelected(CreatedQryStr , HPARTCLASS, '', '', 'PARTCLASS','Product Classes');
          end;
          {export productBin }
          if chkProductbin.checked then begin
              CreatedQryStr :=  ' SELECT  tblclass.ClassName, tblproductbin.BinLocation, tblproductbin.BinNumber, ' +
                                ' tblproductbin.volume, tblproductbin.Volume_Used, tblproductbin.Active' +
                                ' FROM tblproductbin Inner Join tblclass ON tblproductbin.ClassId = tblclass.ClassID'+
                                ' Order by Classname, BinLocation,binnumber';
              ExportSelected(CreatedQryStr , HPARTBIN, '', '', 'PARTBIN','Product Bins');

          end;
          {Export Products}
          {binny : UOM fields are removed from the parts table, so removed from the export query}
          if ChkProducts.Checked then begin
            CreatedQryStr :=
              'Select PARTTYPE,PRODUCTGROUP,PARTNAME,'+
              'REPLACE(REPLACE(REPLACE(REPLACE(PARTSDESCRIPTION,0x22,0x27),0xD," "),0xA," "),0x9," "),' +
              'REPLACE(REPLACE(REPLACE(REPLACE(PURCHASEDESC,0x22,0x27),0xD," "),0xA," "),0x9," "),' +
              'INCOMEACCNT,ASSETACCNT,COGSACCNT,BARCODE,PRODUCTCODE,'+
              //'UnitofMeasure,UnitofMeasureSales,'+
              'NormalDeliveryTime,'
              + HPART2 + HPART3 + ' From tblparts Where PARTNAME is not null;';
            ExportSelected(CreatedQryStr , HPART, HPART2, HPART3, 'PART','Products');
          end;

          {Export EXTRA SELL PRICE}
          if ChkExtraSell.Checked then begin
            CreatedQryStr :=
              'SELECT PartName,QtyPercent1,tblextrapricesell.Price1, UOM,UOMMultiplier, ' +
              (* 'QtyPercent2,tblextrapricesell.Price2,QtyPercent3,tblextrapricesell.Price3, ' +*)
               'DateTo,DateFrom,ExtraSellDesc,TypeName,AllClients '+
               'FROM tblextrapricesell  '+
               'INNER JOIN tblparts Using (PartsID)  '+
               'LEFT JOIN tblclienttype on tblclienttype.ClientTypeID=tblextrapricesell.ClientTypeID;';
            ExportSelected(CreatedQryStr , HEXTRASELLPRICE, '', '', 'EXTRASELLPRICE','Extra Sell Price');
          end;

          {Export EXTRA BUY PRICE}
          if ChkExtraBuy.Checked then begin
            CreatedQryStr :=
              'SELECT tblparts.PartName, Company, Buy1, ' +
              (*'Buy2, Buy3, ' +*)
              'Price, UOM,UOMMultiplier,  ' +
              (*'tblextraprice.Price2, tblextraprice.Price3, ' +*)
              'PrintedValue1, ' +
              (*'PrintedValue2, PrintedValue3, ' +*)
              'tblextraprice.SupplierProductCode, SupplierProductName, UsePrice ' +
              'FROM tblextraprice INNER JOIN tblparts Using (PartsID) INNER JOIN tblclients on SupplierID=ClientID;';
            ExportSelected(CreatedQryStr , HEXTRABUYPRICE, '', '', 'EXTRABUYPRICE','Extra Buy Prices');
          end;

          {Export SPECIAL PRICE}
          if ChkClientsSpecialPrice.Checked then begin
            CreatedQryStr :=
              'SELECT Company, Name, Description, OrigPrice, LinePrice FROM tblcustomerlines INNER JOIN tblClients on CustomerId=ClientID;';
            ExportSelected(CreatedQryStr , HSPECIALPRICE, '', '', 'SPECIALPRICE','Special Prices');
          end;

          {Export FOREIGN BUY PRICE}
          if ChkForeignBuy.Checked then begin
            CreatedQryStr :=
              'SELECT p.PartName,cl.Company,cc.Code,fp.Buy1,fp.Price1, fp.UOM, fp.UOMMultiplier ' +
              (*',fp.Buy2,fp.Price2, fp.Buy3, fp.Price3 ' +*)
              ' FROM tblforeignprice fp Inner Join tblParts p Using(PartsID) '+
              ' Inner Join tblclients cl on cl.ClientID=fp.ClientID ' +
              ' Inner Join tblCurrencyConversion cc on fp.CurrencyId = cc.CurrencyId';
            ExportSelected(CreatedQryStr , HFOREIGNBUYPRICE, '', '', 'FOREIGNBUYPRICE','Foreign Buy Prices');
          end;

          {Export FOREIGN SELL PRICE}
          if ChkForeignSell.Checked then begin
            CreatedQryStr :=
              'SELECT p.PartName, cc.Code, fp.Buy1, fp.Price1, fp.UOM, fp.UOMMultiplier ' +
              (*', fp.Buy2, fp.Price2, fp.Buy3, fp.Price3 ' +*)
              ' FROM tblforeignprice fp INNER JOIN tblParts p USING(PartsID) ' +
              ' INNER JOIN tblcurrencyconversion cc ON fp.CurrencyID=cc.CurrencyID WHERE fp.IsSellPrice="T"';
            ExportSelected(CreatedQryStr , HFOREIGNSELLPRICE, '', '', 'FOREIGNSELLPRICE','Foreign Sell Prices');
          end;


          {Export Clients Group Discounts}
          if ChkClientsGroupDiscounts.Checked then begin
            CreatedQryStr := 'Select ' + ReplaceStr('Company, Col1, Col2, Col3,tblprodgroupdiscs.Discount',
              '$CLIENTGROUPDISCOUNTS,', '') + ' FROM tblprodgroupdiscs LEFT JOIN tblclients Using(ClientID) Where Company is not null;';
            ExportSelected(CreatedQryStr , HCLIENTGROUPDISCOUNTS, '', '', 'CLIENTGROUPDISCOUNTS','Clients Group Discounts');
          end;


          {Export Foreign Exchange Rates}
          if ChkForExRates.Checked then begin
            CreatedQryStr :=
              'SELECT Code,Country,Currency,BuyRate,SellRate,FixedRate,UpperVariation,LowerVariation,Active FROM tblcurrencyconversion;';
            ExportSelected(CreatedQryStr , HFORIEGNEXCHANGERATES, '', '', 'FORIEGNEXCHANGERATES','Foreign Exchange Rates');
          end;

          {Export Foreign Exchange History}
          if ChkForExHist.Checked then begin
            CreatedQryStr :=
              'SELECT Code,Date,BuyRate,SellRate,Active  FROM tblcurrencyconversionhistory;';
            ExportSelected(CreatedQryStr , HFORIEGNEXCHANGEHISTORY, '', '', 'FORIEGNEXCHANGEHISTORY','Foreign Exchange History');
          end;

          {Export Units Of Measure}
          if ChkUnitOfMeasure.Checked then begin
            CreatedQryStr :=
              'SELECT  UOM.UnitName,  UOM.UnitDescription, UOM.Multiplier, UOM.BaseUnitName,PARTNAME as Product, UOM.SalesDefault, UOM.PurchasesDefault, UOM.Active '+
              'FROM tblunitsofmeasure UOM LEFT JOIN tblParts P ON PARTSID=PartID;';
            ExportSelected(CreatedQryStr , HUNITOFMEASURE, '', '', 'UNITOFMEASURE','Unit Of Measure');
          end;

          {Export Shipping Address}
          if ChkClientsShipAddress.Checked then begin
            CreatedQryStr :=
              'SELECT  CompanyName, ShipAddress, ShipAddress1,ShipCity,ShipPostCode,ShipState,ShipCountry,Company as CustomerCompany,SHPA.Active '+
              'FROM tblShippingAddress SHPA '+
              'INNER JOIN tblclients C ON Customer_ID=ClientID;';
            ExportSelected(CreatedQryStr , HSHIPPINGADDRESS, '', '', 'SHIPPINGADDRESS','Shipping Addresses');
          end;

          {Export Fixed Assets }
          if ChkFixedAssets.Checked then begin
            CreatedQryStr := 'Select ' + ReplaceStr(HFIXEDASSETS, '$FIXEDASSETS,', '') + ' From tblFixedAssets ;';
            ExportSelected(CreatedQryStr , HFIXEDASSETS, '', '', 'FIXEDASSETS','Fixed Assets');
          end;
          if chkManufacture.checked then begin
            CreatedQryStr := 'Select ' + ReplaceStr(HManufacture, '$MANUFACTURE,', '') + ' From tblmanufacture;';
            ExportSelected(CreatedQryStr , HManufacture, '', '', 'MANUFACTURE','Manufacture');
          end;
          if chkRepairFaults.checked then begin
            CreatedQryStr := 'Select ' + ReplaceStr(HRepairFaults, '$REPAIRFAULTS,', '') + ' From tblrepairfaults;';
            ExportSelected(CreatedQryStr , HRepairFaults, '', '', 'REPAIRFAULTS','Repair Faults');
          end;

          {Export Marketing Contacts}
          if chkMarketingContacts.Checked then begin
            CreatedQryStr :=
              'SELECT CompanyTypeName,Company,JobTitle,Title,Firstname,Middlename,LastName,' +
              'Street,Street2,Suburb,State,Postcode,Country,Email,Phone,Mobile,FaxNumber,AltPhone,' +
              'EmployeeSize,Notes,Source,Active FROM tblmarketingcontacts';
            ExportSelected(CreatedQryStr , HMARKETINGCONTACTS, '', '', 'MARKETINGCONTACTS','Marketing Contacts');
          end;
          if chkBudgets.Checked then begin
              ClassName := 'TBusObjBudgetImportExport';
              try
                  Cls := FindClass(ClassName);
              except
                  cls := nil;
                  CommonLib.MessageDlgXP_Vista('Budget Class not found, the package may not be implemented', mtWarning, [mbOK], 0);
              end;
              if cls <> nil then with TBusObjImportExport(cls.Create) do try
                      FileName := txtFileName.Text;
                      ModuleName := 'Budget';
                      ProgressBar := ExportProgressBar;
                      LabelMsg := lblImporting;
                      lblImporting.Caption :='Please Wait Preparing Budget Records ';
                      lblImporting.Visible := true;
                      ExportProgressBar.Min := 0;
                      Application.ProcessMessages;
                      ExportData;
                      if IOQry.Recordcount > 0 then begin
                          if qryExport.Active then qryExport.Close;
                          qryExport.SQL.Clear;
                          qryExport.SQL :=IOQry.SQL;
                          qryExport.Open;
                          if Specialnote <> '' then AddLinetoFile(Specialnote);
                          AddLinetoFile(MakeHeaderLine(HeaderLine, '', ''));
                          qryExport.first;
                          LinesCount := qryExport.RecordCount + 1;
                          ExportProgressBar.Max := LinesCount;
                          ExportProgressBar.Position := ExportProgressBar.Min;
                          I:= 1;
                          while qryExport.eof = False do begin
                              ExportProgressBar.StepIt;
                              lblImporting.Caption :=
                                      'Please Wait Exporting Budget ..... ' + FloatToStrF(((I / LinesCount) * 100),
                                      ffFixed, 7, 0) + '% Complete';
                              AddLinetoFile(MakeDataLine('BUDGETINFO'));
                              qryExport.Next;
                              Application.ProcessMessages;
                              I:= I+1;
                          end;
                          AddLinetoFile(FooterLine);
                      End;
              finally
                      Free;
              end;
          end;

        end;
      finally
        // Release our used objects.
        if Assigned(qryExport) then
          FreeandNil(qryExport);
      end;
      //Save And Close File
    except
      raise;
      CloseExportFile;
      btnCancel.Enabled := true;
      btnOK.Enabled     := true;
      Self.Close;
    end;

    CloseExportFile;

    {exporting using the busiess object should be added at the end
    Business object opening the output file in append mode, above code creates a new file.}
    btnCancel.Enabled := true;
    btnOK.Enabled := true;
    Self.Close;
  finally
    EnableForm;
  end;  
end;

function TfrmExportoptions.MakeHeaderLine(const TypeStr, TypeStr2, TypeStr3: string): string;
begin
  if not Empty(TypeStr) and not Empty(TypeStr2) and not Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9) + ReplaceStr(TypeStr2, ',', #9) + ReplaceStr(TypeStr3, ',', #9);
  end else if not Empty(TypeStr) and not Empty(TypeStr2) and Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9) + ReplaceStr(TypeStr2, ',', #9);
  end else if not Empty(TypeStr) and Empty(TypeStr2) and Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9);
  end;
end;

function TfrmExportoptions.MakeDataLine(const TypeStr: string): string;
var
  TempStr: string;
  I: integer;
begin 
  TempStr := '';
  with qryExport do begin
    TempStr := TypeStr + #9;
    TempStr := StringReplace(TempStr, #44, '', [rfReplaceAll,rfIgnoreCase]);
    for I := 0 to qryExport.FieldCount - 1 do begin
      if (Fields[I].DataType = ftDate) or (Fields[I].DataType = ftDateTime) then begin
        if Fields[I].AsDateTime <> 0 then begin
          TempStr := TempStr + FormatDateTime(MysqlDateFormat, Fields[I].AsDateTime) + #9;
        end else begin
          TempStr := TempStr + #9;
        end;
      end else begin
        TempStr := TempStr + Fields[I].AsString + #9;
      end;
    end;
  end;

  Result := Copy(TempStr, 0, char_length(TempStr) - 1);
end;

procedure TfrmExportoptions.ExportAccessLevelsChangeGUI(const Enabled: boolean);
var
  iIndex: integer;

  function AnyChecked: boolean;
  var
    iIndex2: integer;
  begin 
    for iIndex2 := 0 to ComponentCount - 1 do begin 
      if Components[iIndex2] is TCheckBox then begin
        if TCheckBox(Components[iIndex2]).Checked then begin
          if not (TCheckBox(Components[iIndex2]).Name = 'ChkAccessLevels') then begin 
            Result := true;
            Exit;
          end;
        end;
      end;
    end;
    Result := false;
  end;
begin { ====> }
  if Enabled then begin
    for iIndex := 0 to ComponentCount - 1 do begin
      if Components[iIndex] is TCheckBox then begin
        TCheckBox(Components[iIndex]).Enabled := false;
      end;
    end;
  end else begin
    for iIndex := 0 to ComponentCount - 1 do begin
      if Components[iIndex] is TCheckBox then begin
        TCheckBox(Components[iIndex]).Enabled := true;
      end;
    end;
  end;

  if AnyChecked then begin
    ChkAccessLevels.Enabled := false;
  end else begin
    ChkAccessLevels.Enabled := true;
  end;
end;

procedure TfrmExportoptions.ChkAccessLevelsClick(Sender: TObject);
begin 
  inherited;
  if not RunOnceFlag then begin
    RunOnceFlag := true;
    ExportAccessLevelsChangeGUI(ChkAccessLevels.Checked);
    RunOnceFlag := false;
  end;
end;

procedure TfrmExportoptions.ChkAccountsClick(Sender: TObject);
begin 
  inherited;
  if not RunOnceFlag then begin
    RunOnceFlag := true;
    ExportAccessLevelsChangeGUI(false);
    RunOnceFlag := false;
  end;
end;

procedure TfrmExportoptions.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      on e: Exception do else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmExportoptions.chkMarketingContactsClick(Sender: TObject);
var
  iX: integer;
begin 
  inherited;
  if chkMarketingContacts.Checked then begin
    // We need to Disable all TCheckbox controls.
    for iX := 0 to Self.ComponentCount - 1 do begin
      if Self.Components[iX].ClassName = 'TCheckBox' then begin
        if not (TCheckBox(Self.Components[iX]).Name = 'chkMarketingContacts') then begin
          TCheckBox(Self.Components[iX]).Enabled := false;
        end;
      end;
    end;
  end else begin
    // We need to Enable all TCheckbox controls.
    for iX := 0 to Self.ComponentCount - 1 do begin
      if Self.Components[iX].ClassName = 'TCheckBox' then begin
        if not (TCheckBox(Self.Components[iX]).Name = 'chkMarketingContacts') then begin
          TCheckBox(Self.Components[iX]).Enabled := true;
        end;
      end;
    end;
  end;
end;

procedure TfrmExportoptions.chkMarketingContactsDetailsClick(
  Sender: TObject);
Var iX : integer;  
begin
  inherited;
  if chkMarketingContactsDetails.Checked then begin
    // We need to Disable all TCheckbox controls.
    OldFilter := SaveDialog1.Filter;
    SaveDialog1.Filter := 'CSV file (*.csv)|*.csv';
    for iX := 0 to Self.ComponentCount - 1 do begin
      if Self.Components[iX].ClassName = 'TCheckBox' then begin
        if not (TCheckBox(Self.Components[iX]).Name = 'chkMarketingContactsDetails') then begin
          TCheckBox(Self.Components[iX]).Enabled := false;
        end;
      end;
    end;
  end else begin
     SaveDialog1.Filter := OldFilter;
    // We need to Enable all TCheckbox controls.
    for iX := 0 to Self.ComponentCount - 1 do begin
      if Self.Components[iX].ClassName = 'TCheckBox' then begin
        if not (TCheckBox(Self.Components[iX]).Name = 'chkMarketingContactsDetails') then begin
          TCheckBox(Self.Components[iX]).Enabled := true;
        end;
      end;
    end;
  end;
end;

procedure TfrmExportoptions.ExportSelected(const CreatedQryStr, Header1, Header2, Header3 , EXPORTTYPE, Caption:String );
var
  LinesCount:Integer;
  I:Integer;
begin
    if qryExport.active then qryExport.close;
    qryExport.SQL.Clear;
    qryExport.SQL.Add(CreatedQryStr);
    lblImporting.Caption := 'Please Wait Preparing ' + Caption+' ..... 0%';
    lblImporting.Visible := true;
    ExportProgressBar.Min := 0;
    Application.ProcessMessages;
    qryExport.Active := true;
    AddLinetoFile(MakeHeaderLine(HEader1 ,Header2, Header3 ));
    with qryExport do begin
      First;
      LinesCount := qryExport.RecordCount + 1;
      ExportProgressBar.Max := LinesCount;
      ExportProgressBar.Position := ExportProgressBar.Min;
      for I := 0 to qryExport.RecordCount - 1 do begin
        ExportProgressBar.StepIt;
        lblImporting.Caption :=
          'Please Wait Exporting ' + Caption+' ..... ' + FloatToStrF(((I / LinesCount) * 100),
          ffFixed, 7, 0) + '% Complete';
        AddLinetoFile(MakeDataLine(EXPORTTYPE));
        Next;
        Application.ProcessMessages;
      end;
    end;
    AddLinetoFile('FINAL'+EXPORTTYPE);
end;

procedure TfrmExportoptions.TitleLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  form: TBaseInputGUI;
begin
  inherited;
  if (ssCtrl in Shift) and (ssAlt in Shift) then begin
    form:= TBaseInputGUI(GetComponentByClassName('TfmExportImportData'));
    if Assigned(form) then begin
      form.FormStyle := fsMDIChild;
      form.BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfrmExportoptions);
end.
