unit frmImportoptionsFrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 28/07/05 1.00.01  DSP  Fixed problem with foreign price and extra buy price.
 04/08/05 1.00.02  DSP  Added ability to import 'Product Foreign Sell Prices'.
 14/09/06 1.00.03  IJB  Changed to use StringToFloat in place of StrToFloat to
                        allow conversion of empty strings.
 12/04/06 1.00.04  DSP  Removed AdvMatrix functionality.                       

}

interface

uses
  Windows, Forms, Dialogs, StdCtrls, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar, Controls, ExtCtrls,
  Classes, SysUtils, MyAccess,ERPdbComponents, MyClasses,  BaseInputForm, SelectionDialog,
  AppEvnts,  MyScript, kbmMemTable, DBAccess, DataState, Menus, AdvMenus,
  Graphics, Shader, DNMPanel, ImgList, MemDS, DB, ProgressDialog;

type
  TWhereTableName = (wttblcurrencyconversion, wttblcurrencyconversionhistory,
    wttblunitsofmeasure, wttblpublicholidays,
    wttbltrainerrates, wttblForeignPrice,
    wttblextrapricesell,
    wttblextraprice, wttblcompanyinformation, wttblsource,
    wttblcustomerlines, wttblclienttype, {wttblcontacts,}
    wttblemployeeformsaccess, wttblparts, wttblclients,
    wttblchartofaccounts, wttblclass, wttblterms,
    wttblemployees, wttblprodgroupdiscs,
    wttblsimpletypes, wttblmarketingcontacts,wttblfixedassets,wttblShippingAddress,
    wttblProductbin, wttblproductclasses, wttblProductRewardpoints,
    wttblProductCLIENTREWARDPOINTS , wttblequipment, wttblmanufacture , wttblrepairfaults);

  TWhereField = array[Low(TWhereTableName)..High(TWhereTableName)] of string;

const
  TableDesc: TWhereField = ('tblcurrencyconversion', 'tblcurrencyconversionhistory',
    'tblunitsofmeasure', 'tblpublicholidays', 'tbltrainerrates',
    'tblforeignprice', 'tblextrapricesell',
    'tblextraprice', 'tblcompanyinformation', 'tblsource', 'tblcustomerlines',
    'tblclienttype', {'tblcontacts',} 'tblemployeeformsaccess', 'tblparts',
    'tblclients', 'tblchartofaccounts', 'tblclass', 'tblterms',
    'tblemployees', 'tblprodgroupdiscs', 'tblsimpletypes',
    'tblmarketingcontacts','tblfixedassets','tblShippingAddress',
    'tblProductbin', 'tblproductclasses' , 'tblProductRewardpoints' ,
    'tblsaleslinespoints' , 'tblequipment' ,'tblmanufacture' , 'tblrepairfaults');

  WhereField: TWhereField = ('Code', 'Code^Date', 'UnitName^PartID', 'Day', 'EmployeeID^ServiceID',
    'PartsID^SupplierID', 'PartsID^ClientTypeID', 'PartsID^SupplierID', 'SetupID=1', 'MediaType',
    'CustomerId^ProductID', 'ClientTypeID', {'EmployeeID^SupID^CusID^ContactFirstName^ContactSurName',} 'EmployeeID^FormID',
    'PARTNAME', 'Company', 'AccountName', 'ClassName',
    'Terms', 'FirstName^LastName',
    'ClientID^Col1^Col2^Col3',
    'Name', 'Company','AssetID','CompanyName^Customer_ID','BinLocation^Binnumber^ClassId',
    'ClassId^ProductID' , 'Partname^UOM^DateFrom^DateTo' , 'clientID^IsOpeningBalance',
    'EquipmentName','Name' , 'Code^Category');

type
  TfrmImportoptions = class(TBaseInputGUI)
    OpenDialog1: TOpenDialog;
    SpeedButton1: TDNMSpeedButton;
    txtFilePath: TEdit;
    Letter_Label: TLabel;
    lblImporting: TLabel;
    ImportProgressBar: TProgressBar;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    memSqlStrings: TkbmMemTable;
    memSqlStringsID: TAutoIncField;
    memSqlStringsInsertSQL: TWideMemoField;
    memSqlStringsHeaderStrings: TWideMemoField;
    memSqlStringsTableString: TWideMemoField;
    memSqlStringsDataStrings: TWideMemoField;
    ImportProgressBar2: TProgressBar;
    lblImporting2: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    memSqlStringsSeqNo: TIntegerField;
    procedure btnCancelClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    UseForeignExchangeObj: boolean;
    EarlyClose: boolean;
    qryInsertRecord: TERPCommand;
    qryUpdateRecord: TERPCommand;
    qryTemp: TERPQuery;
    TextFileStrings: TStringList;
    UpdateStrings: TStringList;
    UpdateForeignExchangeStrings: TStringList;
    HeaderStrings: string;
    TableString: string;
    TableType: TWhereTableName;
    F: TextFile;
    ErrorLog: TextFile;
    LineNumber, FileLinesCount: integer;
    ErrorOccured: boolean;
    bEmpImported: boolean;
    bProductImported: boolean;
    bShippADDImported: boolean;
    MaxSeqNo:Integer;
//    Procedure updatecontacts;
    
    
    function LineCount(const FileName: string; var ExportHeading:String): integer;
    function GetLineOfString(const I, LinesCount: integer): string;
    procedure ProcessLineOfString(const LineStr: string; const LineNo: integer);
    function StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
    procedure InsertRecord(const HeaderStrings, TableString, DataStrings: string; SeqNo :Integer = 0); overload;
    procedure InsertRecord(const strSQL:String);overload;
    procedure CheckDataFields(const DataSet: TkbmMemTable);
    function UpdateRecord(const HeaderStrings, TableString, DataStrings, ForeignExchangeStrings: string): boolean;
    function CreateUpdateString(const HeaderStrings, DataStrings: string): string;
    function CreateWhereString(const HeaderStrings, TableString, DataStrings: string): string;
    (*function ModQtyDataStr(const LineStringTemp: string): string;*)
    function TypeToTableName(const TableName: TWhereTableName): string;
    function TypeToWhereField(const TableName: TWhereTableName): string;
    function FieldCounter(const TestString: string): integer;
    function GetColumnNo(const ColumnHeading, HeaderStrings: string): integer;
    function ReplaceColumnNo(const ColumnNo: integer; const ReplacmentStr, LineString: string; Const Delimter:String=#9): string;
    Function DeleteColumn(const ColumnHeading, HeaderStrings, LineString: string):String;
    function ValidRewardPoints(var LineString: string): boolean;
    function ValidCLIENTREWARDPOINTS(var LineString: string): boolean;
    Function ValidProductAccounts(const LineString: string): boolean;
    Function ValidEQUIPMENT(const LineString: string): boolean;
    Function ValidMANUFACTURE(const LineString: string): boolean;
    Function ValidRepairFaults(const LineString: string): boolean;

//    Function ValidateContact(Const LineString:String):Boolean;
    function ValidBin(var LineString: string): boolean;
    Function ValidProductclass(var LineString: string): boolean;


    procedure UpdateEmpName;
    procedure UpdateSNTracking;
    procedure UpdateRecords;
    procedure AfterUpdate(Firstfield:String);
    procedure ImportBudget(Const HeaderStrings, LineString: string);
    procedure CalcCostsPricesInc;
    procedure PopulateBarcodes;
    procedure ShippADDlink;

    //Get ID's
    function GetPartID(const PartName: string): integer;
    (*function GetClassID(const fsClassName: string): integer;*)
    function GetEmployeeID(const EmployeeName: string): integer;
    function GetClientTypeID(const TypeName: string): integer;
    function GetOtherContactClientTypeID(const TypeName: string): integer;
    function GetSourceID(const SourceName: string): integer;
    function GetTermsID(const TermsName: string): integer;
    function GetClientID(const ClientName: string): integer;
    function GetAccountID(const AccountName: string): integer;
    function GetShippingID(const ShippingMethod: string): integer;
    function GetCurrencyID(const CurrencyCode: string): integer;
    //Error Log
    procedure AddErrorLogMessage(const MessageText: string);
    procedure NewErrorLogFile;
    function GetClassNameofFile(Const FileName: string): string;
    function ObjectImporting(ExportHeading :String):Boolean;
  end;


implementation

uses
  DNMLib,systemlib, StrUtils, CommonDbLib, CommonLib,
  DNMExceptions, ForeignExchangeObj, BusObjImportExport, FastFuncs, tcTypes,
  AppEnvironment, BusObjClass, MySQLConst, tcDataUtils, CompanyPrefObj,
  DefaultClassObj, DataImport, SimpleEncrypt;

const
  ERRORLOG_FILE = 'ImportErrors.log';

  {$R *.DFM}

procedure TfrmImportoptions.btnCancelClick(Sender: TObject);
begin
  EarlyClose := true;
  Self.Close;
end;



function TfrmImportoptions.LineCount(const FileName: string; var ExportHeading:String): integer;
var
  Count: integer;
  F: TextFile;
begin
  Count := 0;
  if not FileExists(FileName) then begin
    Result := 0;
    Exit;
  end;
  AssignFile(F, FileName);
  try
    {$I-}
    Reset(F);
    {$I+}
    IOResult;
    Readln(F , ExportHeading); Inc(Count);
    while not Eof(F) do begin
      Readln(F);
      Inc(Count);
    end;
    CloseFile(F);
    Result := Count;
  except
    CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtWarning, [mbOK], 0);
    Result := 0;
  end;
end;


procedure TfrmImportoptions.SpeedButton1Click(Sender: TObject);
var
  slLines: TStringList;
begin
  if OpenDialog1.Execute then begin
    txtFilePath.Text := Opendialog1.FileName;
  end;

  if (Self.CallingClassName = 'TfrmMarketingContactDetailsListGUI') and
    (OpenDialog1.FileName <> '') then begin
    slLines := TStringList.Create;
    try
      slLines.Clear;
      slLines.LoadFromFile(Opendialog1.FileName);
      if not Assigned(StrPos(PChar(slLines.Strings[0]), PChar('$MARKETINGCONTACTS'))) then begin
        CommonLib.MessageDlgXP_Vista('This is NOT an ERP Marketing Contacts import file!', mtWarning, [mbOK], 0);
        txtFilePath.Text := '';
        OpenDialog1.FileName := '';
        Exit;
      end else begin
        btnOk.Enabled := true;
      end;
    finally
      // Release our used objects.
      if Assigned(slLines) then
        FreeandNil(slLines);
    end;
  end;
  Application.ProcessMessages;
  Self.Update;
end;

procedure TfrmImportoptions.btnOKClick(Sender: TObject);
var
  LINESTRING: string;
  I, Count: integer;
  Cls: TPersistentClass;
  fsClassName: string;
  strSql: string;
  ExportHeading:String;
begin
  DisableForm;
  try
    btnOK.Enabled := false;
    btnCancel.Enabled := false;
    cls := nil;
    try
      fsClassName := GetClassNameofFile(txtFilePath.Text);
      try
        If Not Empty(fsClassName) then
          cls := findClass(fsClassName);
      except
        fsClassName := '';
      end;
      if fsClassName <> '' then begin // valid class
        if cls <> nil then with TBusObjImportExport(cls.Create) do try
              FileName := txtFilePath.Text;
              Progressbar := ImportProgressBar;
              LabelMsg := lblImporting;
              ImportProgressBar2.Visible := false;
              ImportData;
              if LogExists then begin
                LogError;
                if CommonLib.MessageDlgXP_Vista('A log file is created - ' + ImportLog + Chr(13) +
                  'Do you wish to see the log file?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                  STRSQL := PrintError; // object creates the temp table for the log report and returns the table name
                if strSql <> '' then begin
                  with TERPQuery.Create(self) do try
                      Connection := GetSharedMyDacConnection;
                      sQL.add('Drop table ' + strSql);
                      strSql := 'Select * from ' + strSql;// + ' order by MsgDesc' ;
                      fbReportSQLSupplied := true;
                      PrintTemplateReport('Data Import Log', strSql, false, 1);
                      Execute;
                    finally
                      if Active then Close;
                      Free;
                    end;
                end;
              end;
            finally
              Free;
            end;
        Self.Close;
        Exit;
      end;


      bEmpImported  := false;
      HeaderStrings := '';

      if empty(txtFilePath.Text) then begin
        SpeedButton1Click(Sender);
      end;

      if IsDir(ExtractFileDir(txtFilePath.Text)) then begin
        if IsFile(txtFilePath.Text) then begin
          NewErrorLogFile;
          //Import Function
          lblImporting.Caption := 'Please Wait Loading Data ..... 0%';
          lblImporting.Visible := true;
          FileLinesCount := LineCount(txtFilePath.Text, ExportHeading);
         if (FileLinesCount = 0) then begin
            Self.Close;
            Exit;
          end;

          ImportProgressBar.Min := 0;
          ImportProgressBar.Max := FileLinesCount;
          ImportProgressBar.Position := ImportProgressBar.Min;
          try
            if ObjectImporting(ExportHeading) then begin
              With TDataImport.create(Self) do try
                ImportingFile := txtFilePath.Text;
                Importdata;
                if ImportErrors <> '' then begin
                  AddErrorLogMessage(ImportErrors);
                  ErrorOccured:= true;
                end;
              finally
                  Free;
              end;
            end else begin
            try
            AssignFile(F, txtFilePath.Text);
            try
              {$I-}
              Reset(F);
              {$I+}
              IOResult;
            except
              CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtWarning, [mbOK], 0);
            end;

            Count := FileLinesCount;
            TextFileStrings.Clear;
            for I := 1 to Count do begin
              //get next Line
              LineNumber := I;
              LINESTRING := GetLineOfString(I, FileLinesCount);
              LINESTRING := Trim(LINESTRING);
              if not empty(LINESTRING) then TextFileStrings.Add(LINESTRING);
            end;

            UpdateStrings.Clear;
            memSqlStrings.Open;
            MaxSeqNo := 0;

              for I := 0 to TextFileStrings.Count - 1 do begin
                LineNumber := I;
                if EarlyClose then Exit;
                ProcessLineOfString(TextFileStrings.Strings[I], I);
                ImportProgressBar.StepIt;
                lblImporting.Caption := 'Please Wait Loading Data ..... ' + FloatToStrF(((I / TextFileStrings.Count) * 100),
                  ffFixed, 18, 0) + '% Complete';
                Self.Update;
              end;

              if bProductImported then begin
                lblImporting.Caption := 'Verify Products .....  Please Wait ';
                Self.Update;
                CalcCostsPricesInc;
                PopulateBarcodes;
                Self.Update;
              end;

              if bShippADDImported then begin
                Self.Update;
                ShippADDlink;
                Self.Update;
              end;

              if bEmpImported then begin
                UpdateEmpName;
              end;

              UpdateSNTracking;
              SetAccountLevelField;
          finally
            try
              CloseFile(F);
            except
            end;  
          end;
          end;
          finally
            Try
              CloseFile(ErrorLog);
            except
            end;
            if ErrorOccured then begin
              CommonLib.MessageDlgXP_Vista('Imported Data Had Errors !' + #13 + #10 + '' + #13 + #10 + 'Check Error Log File (' +
                SystemLib.ExeDir + ERRORLOG_FILE + ') To See Rejected Lines.', mtWarning, [mbOK], 0);
            end;
          end;

          lblImporting.Visible := true;
          Self.Close;
        end else begin
          CommonLib.MessageDlgXP_Vista('File "' + txtFilePath.Text + '"' + #13 + 'Does Not Exist !', mtWarning, [mbOK], 0);
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFilePath.Text) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
      end;

    finally
      btnOK.Enabled     := true;
      btnCancel.Enabled := true;
    end;
  finally
    EnableForm;
  end;  
end;
procedure TfrmImportoptions.PopulateBarcodes;
var
  qry : TERPQuery;
begin
qry := TERPQuery.Create(Self);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;

  qry.Options.StrictUpdate := false;
  try
    with qry do begin
      SQL.Clear;
      SQL.add('insert ignore  into  tblpartbarcodes(PartsId , barCode, IsPrimarybarcode , active)');
      SQL.add('SELECT tblparts.PARTSID,tblparts.BARCODE , "T" , "T"');
      SQL.add(' FROM tblparts');
      SQL.add(' Left Join tblpartbarcodes ON ');
      SQL.add('tblparts.PARTSID = tblpartbarcodes.PartsID ');
      SQL.add('AND tblparts.barcode = tblpartbarcodes.BarCode');
      SQL.add('where ifnull(tblPartBarcodes.PartsId  , 0) = 0 ');
      SQL.add('AND ifnull(tblparts.BARCODE  , "") <> ""');
      Execute;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmImportoptions.CalcCostsPricesInc;
var
  TempEx, TempInc: double;
  qry : TERPQuery;
begin

  qry := TERPQuery.Create(Self);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;

  qry.Options.StrictUpdate := false;
  try
    with qry do begin
      {List of Parts}
      SQL.Clear;

      SQL.Add('SELECT PARTSID, COST1, COST2, COST3,COSTINC1,COSTINC2,COSTINC3, PRICE1, PRICE2, PRICE3,PRICEINC1,PRICEINC2,PRICEINC3, TaxCode ');
      SQL.Add('FROM tblparts Where not isNull(PARTSID)  ');
      Open;
    end;
    showProgressbar('Calculating Costs n Prices' , Qry.RecordCount , true);
    try
    with qry do begin
      First;
      while not Eof do begin
        //COSTINC1
        TempEx := FieldByName('COST1').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qry.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('COSTINC1').AsFloat := TempInc;
         //COSTINC2
        TempEx := FieldByName('COST2').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qry.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('COSTINC2').AsFloat := TempInc;
        //COSTINC3
        TempEx := FieldByName('COST3').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qry.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('COSTINC3').AsFloat := TempInc;
        //PRICEINC1
        TempEx := FieldByName('PRICE1').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qry.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('PRICEINC1').AsFloat := TempInc;
        //PRICEINC2
        TempEx := FieldByName('PRICE2').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qry.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('PRICEINC2').AsFloat := TempInc;
         //PRICEINC3
        TempEx := FieldByName('PRICE3').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qry.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('PRICEINC3').AsFloat := TempInc;

        Post;

        qry.Next;
        stepProgressbar;
      end;
    end;
    finally
        HideProgressbar;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

function TfrmImportoptions.StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := HSrc + Delim;
  S := 1;
  for L9 := 1 to Count - 1 do begin
    S := FastFuncs.PosEx(Delim, Src);
    if S > 0 then Delete(Src, S, char_length(Delim))
    else Break;
  end;

  Result := '';
  if S > 0 then begin
    E      := FastFuncs.PosEx(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;

function TfrmImportoptions.GetLineOfString(const I, LinesCount: integer): string;
begin
  try
    Readln(F, Result);
  except
    on EInOutError do Result := '';
  end;
end;

//Procedure TfrmImportoptions.updatecontacts;
//var
//    strSQL:String;
//    qryExec : TERPCommand;
//begin
//    strSQL := 'update tblcontacts Set ContactIsCustomer ="T" where ifnull(CusID , 0) <> 0;';
//    strSQL := strSQL +'update tblcontacts Set ContactIsSupplier ="T" where ifnull(SupID , 0) <> 0;';
//    strSQL := strSQL +'update tblcontacts inner join tblclients on tblclients.ClientId = tblcontacts.CusID Set tblcontacts.ContactIsOtherContact ="T" where ifnull(tblclients.OtherContact,"") = "T";';
//    strSQL := strSQL +'update tblcontacts inner join tblclients on tblclients.ClientId = tblcontacts.CusID Set tblcontacts.ContactIsJob ="T" where INSTR(tblclients.Company, "^") <> 0;';
//  qryExec := TERPCommand.Create(Self);
//  try
//    qryExec.Connection          := CommonDbLib.GetSharedMyDacConnection;
//    qryExec.SQL.add(strSQL);
//    qryExec.Execute;
//  finally
//    FreeandNil(qryExec);
//  end;
//end;

procedure TfrmImportoptions.ProcessLineOfString(const LineStr: string; const LineNo: integer);
var
  FieldValueStrEmployee, FieldValueStrID, StrEmployeeID, TempStr, LineString, LineString1, FirstField,
  FirstField1, TypeImport, TypeImport1: string;
  TempFloat1, TempFloat2, TempFloat3: double;
  TempPartID: integer;
  UOMMultiplier:double;
  UOM:String;
  ClientTypeID:Integer;
  clientType:String;
  UOMID:Integer;
  xDateFrom,xDateTo:String;
  strSqL:String;
  ForeignExchangeObj: TForeignExchangeObj;
  qry: TERPQuery;
  IsJob:Boolean;
  function DateFrom:String;
  begin
      if Empty(xDateFrom) then result := quotedStr(formatDatetime(MysqlDateFormat , 0)) else
        result := quotedStr(xDatefrom);
  end;
  function Dateto:String;
  begin
      if Empty(xdateTo) then result := quotedStr(formatDatetime(MysqlDateFormat , 0)) else
        result := quotedStr(xDateTo);
  end;
begin
  UseForeignExchangeObj := false;
  FirstField := '';
  LineString := LineStr;
  LineString := StripQuotes(LineString);
  if (Empty(HeaderStrings) or (LineNo = TextFileStrings.Count - 1)) then begin
    LineString1 := DeCrypt(LineString, '^');
  end else begin
    LineString1 := DeCrypt(LineString, '^' + IntToStr(LineNo - 1));
  end;

  FirstField1 := StrExtStr(LineString1, #9, 1);
  TypeImport1 := Commonlib.ReplaceStr(FirstField1, '$', '');
  TypeImport1 := Commonlib.ReplaceStr(TypeImport1, 'FINAL', '');

  FirstField := StrExtStr(LineString, #9, 1);
  TypeImport := Commonlib.ReplaceStr(FirstField, '$', '');
  TypeImport := Commonlib.ReplaceStr(TypeImport, 'FINAL', '');

  if TypeImport1 = 'ACCESS' then begin
    if FirstField1 = '$ACCESS' then begin
      LineString1 := Commonlib.ReplaceStr(LineString1, '$ACCESS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString1, #9, #44);
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'EmployeeName', 'EmployeeID');
      TableType := wttblemployeeformsaccess;
      TableString := TypeToTableName(TableType);
    end else if FirstField1 = 'ACCESS' then begin
      LineString1 := Commonlib.ReplaceStr(LineString1, 'ACCESS' + #9, '');
      FieldValueStrEmployee := StrExtStr(LineString1, #9, 1);
      FieldValueStrID := StrExtStr(LineString1, #9, 2);
      StrEmployeeID := IntToStr(GetEmployeeID(FieldValueStrEmployee));
      LineString1 := Commonlib.ReplaceStr(LineString1, FieldValueStrEmployee + #9 + FieldValueStrID + #9,
        StrEmployeeID + #9 + FieldValueStrID + #9);
      LineString1 := Commonlib.ReplaceStr(LineString1, #9, #39 + #44 + #39);
      LineString1 := #39 + LineString1 + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString1) then begin
        InsertRecord(HeaderStrings, TableString, LineString1);
      end;
    end else if FirstField1 = 'FINALACCESS' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'BUDGETINFO' then begin
    if FirstField = '$BUDGETINFO' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$BUDGETINFO' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
                {TableType       := wttblcurrencyconversion;
                TableString     := TypeToTableName(TableType);}
    end else if FirstField = 'BUDGETINFO' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'BUDGETINFO' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(LineString) then begin
        ImportBudget(HeaderStrings, LineString);
      end;
    end;
  end else if TypeImport = 'FORIEGNEXCHANGERATES' then begin
    if FirstField = '$FORIEGNEXCHANGERATES' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$FORIEGNEXCHANGERATES' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblcurrencyconversion;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'FORIEGNEXCHANGERATES' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'FORIEGNEXCHANGERATES' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALFORIEGNEXCHANGERATES' then begin
      HeaderStrings := '';
      UseForeignExchangeObj := true;
      UpdateRecords;AfterUpdate(FirstField);
      UseForeignExchangeObj := false;
    end;
  end else if TypeImport = 'FORIEGNEXCHANGEHISTORY' then begin
    if FirstField = '$FORIEGNEXCHANGEHISTORY' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$FORIEGNEXCHANGEHISTORY' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      HeaderStrings := HeaderStrings + ',CurrencyID';
      TableType := wttblcurrencyconversionhistory;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'FORIEGNEXCHANGEHISTORY' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'FORIEGNEXCHANGEHISTORY' + #9, '');
      //Add CurrencyID
      ForeignExchangeObj := TForeignExchangeObj.Create;
      try
        TempStr := StrExtStr(LineString, #9, GetColumnNo('Code', HeaderStrings));
        LineString := LineString + #9 + IntToStr(ForeignExchangeObj.GetCurrencyID(TempStr));
      finally
        FreeandNil(ForeignExchangeObj);
      end;
      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALFORIEGNEXCHANGEHISTORY' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'UNITOFMEASURE' then begin
    if FirstField = '$UNITOFMEASURE' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$UNITOFMEASURE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      //Change Names For ID's
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Product', 'PartID');
      TableType := wttblunitsofmeasure;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'UNITOFMEASURE' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'UNITOFMEASURE' + #9, '');
      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('PartID', HeaderStrings));
      TempPartID := GetPartID(TempStr);
      LineString := ReplaceColumnNo(GetColumnNo('PartID', HeaderStrings), IntToStr(TempPartID), LineString);
      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALUNITOFMEASURE' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'EXTRASELLPRICE' then begin
    if FirstField = '$EXTRASELLPRICE' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$EXTRASELLPRICE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      //Change Names For ID's
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'PartName', 'PartsID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'TypeName', 'ClientTypeID');
      TableType := wttblextrapricesell;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'EXTRASELLPRICE' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'EXTRASELLPRICE' + #9, '');
      //Change Names For ID's
      clientType := StrExtStr(LineString, #9, GetColumnNo('ClientTypeID', HeaderStrings));
      ClientTypeID :=GetClientTypeID(clientType);
      LineString := ReplaceColumnNo(GetColumnNo('ClientTypeID', HeaderStrings),
        IntToStr(ClientTypeID), LineString);

      TempStr := StrExtStr(LineString, #9, GetColumnNo('PartsID', HeaderStrings));
      TempPartID := GetPartID(TempStr);
      LineString := ReplaceColumnNo(GetColumnNo('PartsID', HeaderStrings), IntToStr(TempPartID), LineString);

      UOM:= StrExtStr(LineString, #9, GetColumnNo('UOM', HeaderStrings)) ;
      UOMMultiplier:= strTofloat(StrExtStr(LineString, #9, GetColumnNo('UOMMultiplier', HeaderStrings)));
      UOMID:=tcDatautils.GetUnitOfMeasureID(TempPartID , UOM, UOMMultiplier);
      LineString := ReplaceColumnNo(GetColumnNo('UOMID', HeaderStrings), IntToStr(UOMID), LineString);
      //Price to Percent

      {Price1}
      if not Empty(StrExtStr(LineString, #9, GetColumnNo('Price1', HeaderStrings))) then begin
        TempFloat1 := StringToFloat(StrExtStr(LineString, #9, GetColumnNo('Price1', HeaderStrings)));
        TempFloat2 := GetPartPrice1(TempPartID);
        TempFloat3 := (DivZer(TempFloat1, TempFloat2) - 1) * -100;
        LineString := ReplaceColumnNo(GetColumnNo('QtyPercent1', HeaderStrings), FloatToStr(TempFloat3), LineString);
      end else begin
        TempFloat3 := StringToFloat(StrExtStr(LineString, #9, GetColumnNo('QtyPercent1', HeaderStrings)));
        TempFloat2 := GetPartPrice1(TempPartID);
        TempFloat1 := (1 - DivZer(TempFloat3, 100)) * TempFloat2;
        LineString := ReplaceColumnNo(GetColumnNo('Price1', HeaderStrings), FloatToStr(TempFloat1), LineString);
      end;
      //Empty Date To Null
      {DateTo}
      xDAteTo:= StrExtStr(LineString, #9, GetColumnNo('DateTo', HeaderStrings));
      if Empty(xDAteTo) then begin
        LineString := ReplaceColumnNo(GetColumnNo('DateTo', HeaderStrings), 'Null', LineString);
      end;

      {DateFrom}
      xDateFrom:= StrExtStr(LineString, #9, GetColumnNo('DateFrom', HeaderStrings));
      if Empty(xDateFrom) then begin
        LineString := ReplaceColumnNo(GetColumnNo('DateFrom', HeaderStrings), 'Null', LineString);
      end;

      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      LineString := Commonlib.ReplaceStr(LineString, #39 + 'Null' + #39, 'Null');


      strSQL:='Select PriceID from tblExtraPriceSell ' +
          ' where   ((ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + DateFrom +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + DateFrom +' ) '+
          ' Or ( ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + DAteTo +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + DAteTo +'  )'+
          ' Or ( ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') >=' + DateFrom +'  and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')<=' + DAteTo +'  ))'+
          ' and ifnull(UOMID,0)= '+IntToStr(UOMID) +
          ' and ifnull(ClienttypeID,0)='+IntToStr(ClientTypeID) +
          ' and ifnull(PartsID,0)='+IntToStr(TempPartID) ;

      With CommonDbLib.TempMyQuery do try
        SQL.add(strSQL);
        open;
        if recordcount > 0 then begin
          Self.InsertRecord('Replace tblExtraPriceSell Set QtyPercent1 = ' +FloattoStr(TempFloat3) +', '+
                        ' Price1 = ' + FloatToStr(TempFloat1)+
                        ' where PriceId = '+ IntToStr(Fieldbyname('PriceID').asInteger )+ ';' );
        end else begin
          if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
            Self.InsertRecord(HeaderStrings, TableString, LineString);
          end;
        end;
      finally
        if active then close;
        free;
      end;

    end else if FirstField = 'FINALEXTRASELLPRICE' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'EXTRABUYPRICE' then begin
    if FirstField = '$EXTRABUYPRICE' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$EXTRABUYPRICE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      //Change Names For ID's
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'PartName', 'PartsID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Company', 'SupplierID');
      (*HeaderStrings := HeaderStrings + ',UOMID';*)
      TableType := wttblextraprice;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'EXTRABUYPRICE' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'EXTRABUYPRICE' + #9, '');
      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('SupplierID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('SupplierID', HeaderStrings), IntToStr(GetClientID(TempStr)), LineString);

      TempStr := StrExtStr(LineString, #9, GetColumnNo('PartsID', HeaderStrings));
      TempPartID := GetPartID(TempStr);
      LineString := ReplaceColumnNo(GetColumnNo('PartsID', HeaderStrings), IntToStr(TempPartID), LineString);

      UOM:= StrExtStr(LineString, #9, GetColumnNo('UOM', HeaderStrings)) ;
      UOMMultiplier:= strTofloat(StrExtStr(LineString, #9, GetColumnNo('UOMMultiplier', HeaderStrings)));
      (*LineString := LineString + '#9' +Quotedstr(IntToStr(tcDatautils.GetUnitOfMeasureID(TempPartID , UOM, UOMMultiplier)));*)
      LineString := ReplaceColumnNo(GetColumnNo('UOMID', HeaderStrings), IntToStr(tcDatautils.GetUnitOfMeasureID(TempPartID , UOM, UOMMultiplier)), LineString);
      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);

      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALEXTRABUYPRICE' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if (TypeImport = 'FOREIGNPRICE') or (TypeImport = 'FOREIGNBUYPRICE') then begin
    if (FirstField = '$FOREIGNPRICE') or (FirstField = '$FOREIGNBUYPRICE') then begin
      LineString := Commonlib.ReplaceStr(LineString, '$FOREIGNPRICE' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, '$FOREIGNBUYPRICE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);

      //Change Names For ID's
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'PartName', 'PartsID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Company', 'ClientID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Currency', 'CurrencyID');
      (*HeaderStrings := HeaderStrings + ',UOMID';*)
      TableType := wttblForeignPrice;
      TableString := TypeToTableName(TableType);
    end else if (FirstField = 'FOREIGNPRICE') or (FirstField = 'FOREIGNBUYPRICE') then begin
      LineString := Commonlib.ReplaceStr(LineString, 'FOREIGNPRICE' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, 'FOREIGNBUYPRICE' + #9, '');
      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('ClientID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('ClientID', HeaderStrings), IntToStr(GetClientID(TempStr)), LineString);

      TempStr := StrExtStr(LineString, #9, GetColumnNo('PartsID', HeaderStrings));
      TempPartID := GetPartID(TempStr);
      LineString := ReplaceColumnNo(GetColumnNo('PartsID', HeaderStrings), IntToStr(TempPartID), LineString);

      TempStr := StrExtStr(LineString, #9, GetColumnNo('CurrencyID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('CurrencyID', HeaderStrings), IntToStr(GetCurrencyID(TempStr)), LineString);

      UOM:= StrExtStr(LineString, #9, GetColumnNo('UOM', HeaderStrings)) ;
      UOMMultiplier:= strtofloat(StrExtStr(LineString, #9, GetColumnNo('UOMMultiplier', HeaderStrings)));
      (*LineString := LineString + '#9' +Quotedstr(IntToStr(tcDatautils.GetUnitOfMeasureID(TempPartID , UOM, UOMMultiplier)));*)
      LineString := ReplaceColumnNo(GetColumnNo('UOMID', HeaderStrings), IntToStr(tcDatautils.GetUnitOfMeasureID(TempPartID , UOM, UOMMultiplier)), LineString);
      
      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);

      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if (FirstField = 'FINALFOREIGNPRICE') or (FirstField = 'FINALFOREIGNBUYPRICE') then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'FOREIGNSELLPRICE' then begin
    if FirstField = '$FOREIGNSELLPRICE' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$FOREIGNSELLPRICE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      HeaderStrings := HeaderStrings + ',IsSellPrice';

      //Change Names For ID's
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'PartName', 'PartsID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Currency', 'CurrencyID');
      TableType := wttblForeignPrice;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'FOREIGNSELLPRICE' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'FOREIGNSELLPRICE' + #9, '');

      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('CurrencyID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('CurrencyID', HeaderStrings), IntToStr(GetCurrencyID(TempStr)), LineString);
      TempStr := StrExtStr(LineString, #9, GetColumnNo('PartsID', HeaderStrings));
      TempPartID := GetPartID(TempStr);
      LineString := ReplaceColumnNo(GetColumnNo('PartsID', HeaderStrings), IntToStr(TempPartID), LineString);

      UOM:= StrExtStr(LineString, #9, GetColumnNo('UOM', HeaderStrings)) ;
      UOMMultiplier:= strtofloat(StrExtStr(LineString, #9, GetColumnNo('UOMMultiplier', HeaderStrings)));
      LineString := ReplaceColumnNo(GetColumnNo('UOMID', HeaderStrings), IntToStr(tcDatautils.GetUnitOfMeasureID(TempPartID , UOM, UOMMultiplier)), LineString);
      LineString := LineString + 'T';
      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;

      if not Empty(HeaderStrings) and not Empty(TableString) and (not Empty(LineString)) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALFOREIGNSELLPRICE' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'CLIENTREWARDPOINTS' then begin
    if FirstField = '$CLIENTREWARDPOINTS' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$CLIENTREWARDPOINTS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Company', 'ClientId');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'RewardPoints', 'LinePoints');
      HeaderStrings := HeaderStrings + ',DeptID,DeptName,IsOpeningBalance,Active';
      TableType := wttblProductCLIENTREWARDPOINTS;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'CLIENTREWARDPOINTS' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'CLIENTREWARDPOINTS' + #9, '');

      if ValidCLIENTREWARDPOINTS(LineString) then begin
        LineString := Commonlib.ReplaceStr(LineString, #39, '');
        LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
        LineString := #39 + LineString + #39;
        if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
          InsertRecord(HeaderStrings, TableString, LineString);
        end;
      end;
    end else if FirstField = 'FINALCLIENTREWARDPOINTS' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;

  end else if TypeImport = 'REWARDPOINTS' then begin
    if FirstField = '$REWARDPOINTS' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$REWARDPOINTS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblProductRewardpoints;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'REWARDPOINTS' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'REWARDPOINTS' + #9, '');

      if ValidRewardPoints(LineString) then begin
        LineString := Commonlib.ReplaceStr(LineString, #39, '');
        LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
        LineString := #39 + LineString + #39;
        if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
          InsertRecord(HeaderStrings, TableString, LineString);
        end;
      end;
    end else if FirstField = 'FINALREWARDPOINTS' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;

  end else if TypeImport = 'REPRATES' then begin
    if FirstField = '$REPRATES' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$REPRATES' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      //Change Names For ID's
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'EmployeeName', 'EmployeeID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'ServiceDesc', 'ServiceID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'AbilityDesc', 'AbilityID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Company', 'ClientID');

      TableType := wttbltrainerrates;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'REPRATES' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'REPRATES' + #9, '');

      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('EmployeeID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('EmployeeID', HeaderStrings), IntToStr(GetEmployeeID(TempStr)), LineString);
      TempStr := StrExtStr(LineString, #9, GetColumnNo('ServiceID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('ServiceID', HeaderStrings), IntToStr(GetServiceID(TempStr)), LineString);
      TempStr := StrExtStr(LineString, #9, GetColumnNo('AbilityID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('AbilityID', HeaderStrings), IntToStr(GetAbilityID(TempStr)), LineString);
      TempStr := StrExtStr(LineString, #9, GetColumnNo('ClientID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('ClientID', HeaderStrings), IntToStr(GetClientID(TempStr)), LineString);
      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);

      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALREPRATES' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'COMPANYINFO' then begin
    if FirstField = '$COMPANYINFO' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$COMPANYINFO' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblcompanyinformation;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'COMPANYINFO' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'COMPANYINFO' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        UpdateRecord(HeaderStrings, TableString, LineString, '');
      end;
    end else if FirstField = 'FINALCOMPANYINFO' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'PUBHOL' then begin
    if FirstField = '$PUBHOL' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$PUBHOL' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblpublicholidays;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'PUBHOL' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'PUBHOL' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALPUBHOL' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'SOURCE' then begin
    if FirstField = '$SOURCE' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$SOURCE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      //Change Names For ID's
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'AccountName', 'Account');
      TableType := wttblsource;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'SOURCE' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'SOURCE' + #9, '');
      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('Account', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('Account', HeaderStrings), IntToStr(GetAccountID(TempStr)), LineString);

      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALSOURCE' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'SPECIALPRICE' then begin
    if FirstField = '$SPECIALPRICE' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$SPECIALPRICE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      //Change Names For ID's
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Company', 'CustomerId');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Name', 'ProductID');
      HeaderStrings := HeaderStrings + ',Name';
      TableType := wttblcustomerlines;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'SPECIALPRICE' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'SPECIALPRICE' + #9, '');
      LineString := LineString + #9 + QuotedStr('');
      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('CustomerId', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('CustomerId', HeaderStrings), IntToStr(GetClientID(TempStr)), LineString);

      TempStr := StrExtStr(LineString, #9, GetColumnNo('ProductID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('Name', HeaderStrings), TempStr, LineString);
      LineString := ReplaceColumnNo(GetColumnNo('ProductID', HeaderStrings), IntToStr(GetPartID(TempStr)), LineString);

      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALSPECIALPRICE' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'CLIENTTYPE' then begin
    if FirstField = '$CLIENTTYPE' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$CLIENTTYPE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      //Change Names For ID's
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Terms', 'TermsID');
      TableType := wttblclienttype;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'CLIENTTYPE' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'CLIENTTYPE' + #9, '');
      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('TermsID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('TermsID', HeaderStrings), IntToStr(GetTermsID(TempStr)), LineString);

      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39#44#39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALCLIENTTYPE' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;

    // This is for other contacts and there company types.
  end else if TypeImport = 'OTHERCONTACTCLIENTTYPE' then begin
    if FirstField = '$OTHERCONTACTCLIENTTYPE' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$OTHERCONTACTCLIENTTYPE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblsimpletypes;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'OTHERCONTACTCLIENTTYPE' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'OTHERCONTACTCLIENTTYPE' + #9, '');

      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #9, #39#44#39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALOTHERCONTACTCLIENTTYPE' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'PART' then begin
    if FirstField = '$PART' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$PART' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblparts;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'PART' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'PART' + #9, '');

      if ValidProductAccounts(LineString) then begin
        LineString := Commonlib.ReplaceStr(LineString, #39, '');
        LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
        LineString := #39 + LineString + #39;
        TempStr := StrExtStr(LineString, ',', GetColumnNo('NormalDeliveryTime', HeaderStrings));
        if (Tempstr='') or (TempStr='''''') then  // empty string or just quotes
          LineString := ReplaceColumnNo(GetColumnNo('NormalDeliveryTime', HeaderStrings), '0', LineString, ',');

        if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
          InsertRecord(HeaderStrings, TableString, LineString);
        end;
      end;

    end else if FirstField = 'FINALPART' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
      bProductImported := True;
    end;
  end else if TypeImport = 'EQUIPMENT' then begin
    if FirstField = '$EQUIPMENT' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$EQUIPMENT' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'PartName', 'ProductID');
      TableType := wttblequipment;
      TableString := TypeToTableName(TableType);

    end else if FirstField = 'EQUIPMENT' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'EQUIPMENT' + #9, '');

      if ValidEQUIPMENT(LineString) then begin
        TempStr := StrExtStr(LineString, #9, GetColumnNo('ProductID', HeaderStrings));
        TempPartID := GetPartID(TempStr);
        LineString := ReplaceColumnNo(GetColumnNo('ProductID', HeaderStrings), IntToStr(TempPartID), LineString);
        LineString := Commonlib.ReplaceStr(LineString, #39, '');
        LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
        LineString := #39 + LineString + #39;
        if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
          InsertRecord(HeaderStrings, TableString, LineString);
        end;
      end;
    end;
  end else if TypeImport = 'REPAIRFAULTS' then begin
    if FirstField = '$REPAIRFAULTS' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$REPAIRFAULTS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblrepairfaults;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'REPAIRFAULTS' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'REPAIRFAULTS' + #9, '');
      if ValidRepairFaults(LineString) then begin
        TempStr := StrExtStr(LineString, #9, GetColumnNo('Manufacture', HeaderStrings));
        LineString := Commonlib.ReplaceStr(LineString, #39, '');
        LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
        LineString := #39 + LineString + #39;
        if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
          InsertRecord(HeaderStrings, TableString, LineString);
        end;
      end;
    end else if FirstField = 'FINALREPAIRFAULTS' then begin
      HeaderStrings := '';
      InsertRecord('Insert ignore into tblManufacture (Name)  ' +
              'Select Manufacture  from tblrepairfaults  ' +
              'where ifnull(Manufacture,"") <> "" and ifnull(ManufactureID,0) = 0;');
      InsertRecord('update tblrepairfaults E Set ManufactureID =  ' +
              'ifnull((Select ifnull(ID,0) from tblManufacture M where M.Name = E.Manufacture),0)   ' +
              'where  ifnull(E.Manufacture,"") <> "" and ifnull(E.ManufactureID,0) = 0;');
      UpdateRecords;AfterUpdate(FirstField);
      (*bProductImported := True;*)
    end;

  end else if TypeImport = 'MANUFACTURE' then begin
    if FirstField = '$MANUFACTURE' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$MANUFACTURE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblmanufacture;
      TableString := TypeToTableName(TableType);

    end else if FirstField = 'MANUFACTURE' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'MANUFACTURE' + #9, '');

      if ValidMANUFACTURE(LineString) then begin
        LineString := Commonlib.ReplaceStr(LineString, #39, '');
        LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
        LineString := #39 + LineString + #39;
        if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
          InsertRecord(HeaderStrings, TableString, LineString);
        end;
      end;

    end else if FirstField = 'FINALMANUFACTURE' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
      bProductImported := True;
    end;


  end else if TypeImport = 'PARTBIN' then begin
    if FirstField = '$PARTBIN' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$PARTBIN' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblProductbin;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'PARTBIN' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'PARTBIN' + #9, '');

      if ValidBin(LineString) then begin
        LineString := Commonlib.ReplaceStr(LineString, #39, '');
        LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
        LineString := #39 + LineString + #39;
        if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
          InsertRecord(HeaderStrings, TableString, LineString);
        end;
      end;
    end else if FirstField = 'FINALPARTBIN' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
      (*bProductImported := True;*)
    end;
  end else if TypeImport = 'PARTCLASS' then begin
    if FirstField = '$PARTCLASS' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$PARTCLASS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblproductclasses;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'PARTCLASS' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'PARTCLASS' + #9, '');

      if ValidProductclass(LineString) then begin
        LineString := Commonlib.ReplaceStr(LineString, #39, '');
        LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
        LineString := #39 + LineString + #39;
        if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
          InsertRecord(Commonlib.replaceStr(HeaderStrings, ',BinLocation,BinNumber' , '')(*+ ',ClassId,ProductID'*), TableString, LineString);
        end;
      end;
    end else if FirstField = 'FINALPARTCLASS' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
      bProductImported := True;
    end;
  end else if TypeImport = 'MARKETINGCONTACTS' then begin
    if FirstField = '$MARKETINGCONTACTS' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$MARKETINGCONTACTS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblmarketingcontacts;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'MARKETINGCONTACTS' then begin
      TempStr := StrExtStr(LineString, #9, GetColumnNo('CompanyTypeName', HeaderStrings) + 1);
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := CommonDbLib.GetSharedMyDacConnection;
        if TempStr <> '' then begin
          qry.SQL.Clear;
          qry.SQL.Add('INSERT INTO tblsimpletypes');
          qry.SQL.Add('(TypeCode, Name, Description, IsDefault, Active) VALUES (');
          qry.SQL.Add(QuotedStr('CompanyType') + ', ' + QuotedStr(TempStr) + ', ');
          qry.SQL.Add(QuotedStr(TempStr) + ', "F", "T")');
          try
            qry.Execute;
          except 
          end;
        end;

        TempStr := StrExtStr(LineString, #9, GetColumnNo('Source', HeaderStrings) + 1);
        if TempStr <> '' then begin
          qry.SQL.Clear;
          qry.SQL.Add('INSERT INTO tblsource');
          qry.SQL.Add('(MediaType, Active) VALUES (');
          qry.SQL.Add(QuotedStr(TempStr) + ', "T")');
          try
            qry.Execute;
          except 
          end;
        end;

      finally
        if Assigned(qry) then FreeAndNil(qry);
      end;

      LineString := Commonlib.ReplaceStr(LineString, 'MARKETINGCONTACTS' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, '\n\r', #13#10);
      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALMARKETINGCONTACTS' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
//  end else if TypeImport = 'CONTACT' then begin
//    if FirstField = '$CONTACT' then begin
//      LineString := Commonlib.ReplaceStr(LineString, '$CONTACT' + #9, '');
//      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
//      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'CustomerName', 'CusID');
//      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'SupplierName', 'SupID');
//      TableType := wttblcontacts;
//      TableString := TypeToTableName(TableType);
//    end else if FirstField = 'CONTACT' then begin
//      LineString := Commonlib.ReplaceStr(LineString, 'CONTACT' + #9, '');
//      //Change Names For ID's
//      if ValidateContact(LineString) then begin
//        TempStr := StrExtStr(LineString, #9, GetColumnNo('CusID', HeaderStrings));
//        LineString := ReplaceColumnNo(GetColumnNo('CusID', HeaderStrings), IntToStr(GetClientID(TempStr)), LineString);
//
//        TempStr := StrExtStr(LineString, #9, GetColumnNo('SupID', HeaderStrings));
//        LineString := ReplaceColumnNo(GetColumnNo('SupID', HeaderStrings), IntToStr(GetClientID(TempStr)), LineString);
//
//        LineString := Commonlib.ReplaceStr(LineString, #39, '');
//        LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
//        LineString := #39 + LineString + #39;
//        if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
//          InsertRecord(HeaderStrings, TableString, LineString);
//        end;
//      end;
//    end else if FirstField = 'FINALCONTACT' then begin
//      HeaderStrings := '';
//      UpdateRecords;AfterUpdate(FirstField);
//    end;
  end else if TypeImport = 'CLIENT' then begin
    if FirstField = '$CLIENT' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$CLIENT' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      //Change Names For ID's
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'RepName', 'RepID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'CompanyTypeName', 'CompanyTypeID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'TypeName', 'ClientTypeID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'TermsName', 'TermsID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'SourceName', 'MedTypeID');
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'ShippingMethod', 'ShippingID');

      TableType := wttblclients;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'CLIENT' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'CLIENT' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, '\n\r', #13#10);
      isjob :=(Trim(StrExtStr(LineString, #9, GetColumnNo('IsJob', HeaderStrings))) = 'T');
      if isjob then begin
        if not AnsiContainsText(HeaderStrings, ',IsJob,ParentClientID,') then begin
          HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, ',IsJob,', ',IsJob,ParentClientID,');
        end;

        LineString := ReplaceColumnNo(GetColumnNo('IsJob', HeaderStrings), 'T' + #9, LineString);

        TempStr := StrExtStr(LineString, #9, GetColumnNo('Company', HeaderStrings));
        TempStr := StrExtStr(TempStr, '^', 1);
        if GetClientID(TempStr) = 0 then begin
          exit; // job record - parent client doesn't exists - should not be imported
        end;
        LineString := ReplaceColumnNo(GetColumnNo('ParentClientID', HeaderStrings),
          IntToStr(GetClientID(TempStr)), LineString);
      end else begin
        HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, ',IsJob,ParentClientID,', ',IsJob,'); //If Job is before a CLient
      end;

      // Discount & special discount
      TempStr := StrExtStr(LineString, #9, GetColumnNo('Discount', HeaderStrings));
      if Tempstr='' then
        LineString := ReplaceColumnNo(GetColumnNo('Discount', HeaderStrings), '0', LineString);
      TempStr := StrExtStr(LineString, #9, GetColumnNo('SpecialDiscount', HeaderStrings));
      if Tempstr='' then
        LineString := ReplaceColumnNo(GetColumnNo('SpecialDiscount', HeaderStrings), '0', LineString);
      //Suburbs {Upper & Trim}
      TempStr := StrExtStr(LineString, #9, GetColumnNo('Suburb', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('Suburb', HeaderStrings), uppercase(Trim(TempStr)), LineString);

      TempStr := StrExtStr(LineString, #9, GetColumnNo('BillSuburb', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('BillSuburb', HeaderStrings), uppercase(Trim(TempStr)), LineString);

      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('ShippingID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('ShippingID', HeaderStrings), IntToStr(GetShippingID(TempStr)), LineString);

      // Is this record to be a Other Contact Record?
      if (Trim(StrExtStr(LineString, #9, GetColumnNo('OtherContact', HeaderStrings))) = 'T') then begin
        // Yes, get company type ID from tblsimpletypes
        TempStr := StrExtStr(LineString, #9, GetColumnNo('CompanyTypeID', HeaderStrings));
        LineString := ReplaceColumnNo(GetColumnNo('CompanyTypeID', HeaderStrings),
          IntToStr(GetOtherContactClientTypeID(TempStr)), LineString);
      end;
        // Otherwise, get company type ID from tblclienttypes
        TempStr := StrExtStr(LineString, #9, GetColumnNo('ClientTypeID', HeaderStrings));
        LineString := ReplaceColumnNo(GetColumnNo('ClientTypeID', HeaderStrings),
          IntToStr(GetClientTypeID(TempStr)), LineString);
      (*end;*)

      TempStr := StrExtStr(LineString, #9, GetColumnNo('TermsID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('TermsID', HeaderStrings), IntToStr(GetTermsID(TempStr)), LineString);

      TempStr := StrExtStr(LineString, #9, GetColumnNo('MedTypeID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('MedTypeID', HeaderStrings), IntToStr(GetSourceID(TempStr)), LineString);

      TempStr := StrExtStr(LineString, #9, GetColumnNo('RepID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('RepID', HeaderStrings), IntToStr(GetEmployeeID(TempStr)), LineString);

      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        if isjob then InsertRecord(HeaderStrings, TableString, LineString,1)
        else InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALCLIENT' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'ACCOUNT' then begin
    if FirstField = '$ACCOUNT' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$ACCOUNT' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblchartofaccounts;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'ACCOUNT' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'ACCOUNT' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALACCOUNT' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'CLASS' then begin
    if FirstField = '$CLASS' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$CLASS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblclass;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'CLASS' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'CLASS' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALCLASS' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'TERMS' then begin
    if FirstField = '$TERMS' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$TERMS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblterms;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'TERMS' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'TERMS' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALTERMS' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'EMPLOYEE' then begin
    bEmpImported := true;
    if FirstField = '$EMPLOYEE' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$EMPLOYEE' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblemployees;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'EMPLOYEE' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'EMPLOYEE' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALEMPLOYEE' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'FIXEDASSETS' then begin
    if FirstField = '$FIXEDASSETS' then begin
      LineString := Commonlib.ReplaceStr(LineString, '$FIXEDASSETS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(LineString, #9, #44);
      TableType := wttblfixedassets;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'FIXEDASSETS' then begin
      LineString := Commonlib.ReplaceStr(LineString, 'FIXEDASSETS' + #9, '');
      LineString := Commonlib.ReplaceStr(LineString, '\n\r', #13#10);
      LineString := Commonlib.ReplaceStr(LineString, #39, '');
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALFIXEDASSETS' then begin
      HeaderStrings := '';
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'SHIPPINGADDRESS' then begin
    if FirstField = '$SHIPPINGADDRESS' then begin
      LineString := Commonlib.ReplaceStr(Trim(LineString), '$SHIPPINGADDRESS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(Trim(LineString), #9, #44);
      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'CustomerCompany', 'Customer_ID');
      TableType := wttblShippingAddress;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'SHIPPINGADDRESS' then begin
      LineString := Commonlib.ReplaceStr(Trim(LineString), 'SHIPPINGADDRESS' + #9, '');
      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('Customer_ID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('Customer_ID', HeaderStrings), IntToStr(GetClientID(TempStr)), LineString);
      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;

      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALSHIPPINGADDRESS' then begin
      HeaderStrings := '';
      lblImporting.Caption := 'Preparing Shipping Addresses .....  Please Wait ';
      Self.Update;
      bShippADDImported := true;
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end else if TypeImport = 'CLIENTGROUPDISCOUNTS' then begin
    if FirstField = '$CLIENTGROUPDISCOUNTS' then begin
      LineString := Commonlib.ReplaceStr(Trim(LineString), '$CLIENTGROUPDISCOUNTS' + #9, '');
      HeaderStrings := Commonlib.ReplaceStr(Trim(LineString), #9, #44);

      HeaderStrings := Commonlib.ReplaceStr(HeaderStrings, 'Company', 'ClientID');
      TableType := wttblprodgroupdiscs;
      TableString := TypeToTableName(TableType);
    end else if FirstField = 'CLIENTGROUPDISCOUNTS' then begin
      LineString := Commonlib.ReplaceStr(Trim(LineString), 'CLIENTGROUPDISCOUNTS' + #9, '');
      //Change Names For ID's
      TempStr := StrExtStr(LineString, #9, GetColumnNo('ClientID', HeaderStrings));
      LineString := ReplaceColumnNo(GetColumnNo('ClientID', HeaderStrings), IntToStr(GetClientID(TempStr)), LineString);
      LineString := Commonlib.ReplaceStr(LineString, #39, ''); 
      LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
      LineString := #39 + LineString + #39;

      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        InsertRecord(HeaderStrings, TableString, LineString);
      end;
    end else if FirstField = 'FINALCLIENTGROUPDISCOUNTS' then begin
      HeaderStrings := '';
      lblImporting.Caption := 'Preparing Clients Group Discounts .....  Please Wait ';
      Self.Update;
      UpdateRecords;AfterUpdate(FirstField);
    end;
  end;
end;

procedure TfrmImportoptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;
procedure TfrmImportoptions.InsertRecord(const strSQL:String);
begin
  memSqlStrings.Insert;
  memSqlStringsSeqNo.asInteger := 0;
  memSqlStringsHeaderStrings.AsString := '';
  memSqlStringsTableString.AsString := '';
  memSqlStringsDataStrings.AsString := '';
  memSqlStringsInsertSQL.AsString := strSQL;
  memSqlStrings.Post;
end;
procedure TfrmImportoptions.InsertRecord(const HeaderStrings, TableString, DataStrings: string; SeqNo :Integer = 0);
var
  SQLString: string;
begin
  if MaxSeqNo < SeqNo then MaxSeqNo := SeqNo;
  memSqlStrings.Insert;
  memSqlStringsSeqNo.asInteger := SeqNo;
  memSqlStringsHeaderStrings.AsString := HeaderStrings;
  memSqlStringsTableString.AsString := TableString;
  memSqlStringsDataStrings.AsString := DataStrings;
  CheckDataFields(memSqlStrings);
  SQLString := 'INSERT INTO ' + TableString + '(' + HeaderStrings + ') VALUES (' + memSqlStringsDataStrings.AsString + ');';
  memSqlStringsInsertSQL.AsString := SQLString;
  memSqlStrings.Post;

end;

procedure TfrmImportoptions.CheckDataFields(const DataSet: TkbmMemTable);
var
  TempData,CreatingString: string;
  FieldCount, I: integer;
  tmpFieldTypeInfo:  TFieldTypeInfo;
  qry : TERPQuery;
  tmpTableName:String;
  dt:TDatetime;

  Function GetFieldInfo(const qry : TERPQuery; const TableName,FieldName:String; Const SameTable: Boolean):TFieldTypeInfo;
  begin
    Result.FieldName := '';
    if not SameTable then Begin
      qry.Close;
      qry.SQL.Text := 'DESCRIBE `'+TableName+'`;';
      qry.Open;
    end;
    qry.First;
    If (qry.RecordCount <> 0) then Begin
      While Not qry.Eof do begin
        If Sysutils.SameText(qry.Fields[0].AsString,FieldName) then Begin
          Result.FieldName := FieldName;
          Result.TableName := TableName;
          Result.DataType := qry.Fields[1].AsString;
          Result.AllowNull := qry.Fields[2].asBoolean;
          Result.Default := qry.Fields[3].AsString;
          Break;
        end;
      qry.Next;
      end;
    end;
  end;


begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.Options.FlatBuffers := True;
    If DataSet.FieldByName('HeaderStrings').AsString='' then Exit;
    FieldCount := FieldCounter(DataSet.FieldByName('HeaderStrings').AsString);
    if FieldCount = 0 then begin
      FieldCount := 1;
    end;

    CreatingString := DataSet.FieldByName('DataStrings').AsString;
    for I := 1 to FieldCount do begin
      TempData := StrExtStr(CreatingString, #44, I);
      (*If (TempData = #39#39) then Begin*)
        tmpFieldTypeInfo := GetFieldInfo(qry,DataSet.FieldByName('TableString').AsString,
                             StrExtStr(DataSet.FieldByName('HeaderStrings').AsString, #44, I),
                            (tmpTableName = DataSet.FieldByName('TableString').AsString));
        tmpTableName := DataSet.FieldByName('TableString').AsString;
        If tmpFieldTypeInfo.FieldName = '' then Exit;

       If (TempData = #39#39) then Begin
        if (FastFuncs.PosExIgnoreCase('date',tmpFieldTypeInfo.DataType)> 0) then begin
          If tmpFieldTypeInfo.Default <> '' then begin
            TempData :=  #39+tmpFieldTypeInfo.Default+#39
          end else If tmpFieldTypeInfo.AllowNull then begin
             TempData :=  'Null'
          end else
            TempData :=  #39+'0'+#39;
          CreatingString := ReplaceColumnNo(I, TempData, CreatingString,#44);
        end else if (FastFuncs.PosExIgnoreCase('enum(',tmpFieldTypeInfo.DataType)> 0) then begin
          If tmpFieldTypeInfo.Default <> '' then begin
            TempData :=  #39+tmpFieldTypeInfo.Default+#39
          end else If tmpFieldTypeInfo.AllowNull then begin
             TempData :=  'Null'
          end;
          CreatingString := ReplaceColumnNo(I, TempData, CreatingString,#44);
        end else if (FastFuncs.PosExIgnoreCase('int(',tmpFieldTypeInfo.DataType)> 0) then begin
          If tmpFieldTypeInfo.Default <> '' then begin
            TempData :=  #39+tmpFieldTypeInfo.Default+#39
          end else If tmpFieldTypeInfo.AllowNull then begin
             TempData :=  'Null'
          end else
            TempData :=  #39+'0'+#39;
          CreatingString := ReplaceColumnNo(I, TempData, CreatingString,#44);
        end;
        DataSet.FieldByName('DataStrings').AsString := CreatingString;
      end else if (FastFuncs.PosExIgnoreCase('date',tmpFieldTypeInfo.DataType)> 0) then begin
        if IsDate(UnQuoteStr(Tempdata) , dt) then
          Tempdata := QuotedStr(FormatDateTime(MysqlDateFormat, dt));
        CreatingString := ReplaceColumnNo(I, TempData, CreatingString,#44);
        DataSet.FieldByName('DataStrings').AsString := CreatingString;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;



function TfrmImportoptions.UpdateRecord(const HeaderStrings, TableString, DataStrings,
  ForeignExchangeStrings: string): boolean;
var
  UpdateString, WhereString, SQLString: string;
begin
  //Convert Insert SQL String To Update SQL
  UpdateString := CreateUpdateString(HeaderStrings, DataStrings);
  //Create Update SQL Where Clause
  WhereString := CreateWhereString(HeaderStrings, TableString, DataStrings);

  if (GetColumnNo('CompanyName', HeaderStrings) = 1) and (GetColumnNo('Address', HeaderStrings) = 2) then begin
    WhereString := FastFuncs.LeftStr(WhereString, (char_length(WhereString) - 1));
  end;

  SQLString := 'UPDATE ' + TableString + ' SET ' + UpdateString + WhereString + ';';
  UpdateStrings.Add(SQLString);
  UpdateForeignExchangeStrings.Add(ForeignExchangeStrings);
  Result := true;
end;

(*function TfrmImportoptions.GetClassID(const fsClassName: string): integer;
begin
  If Empty(fsClassName) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT ClassID FROM tblclass WHERE ClassName = ' + QuotedStr(fsClassName) + ';');
  qryTemp.Active := true;
  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('ClassID').AsInteger;
  end else begin
    Result := 0;
  end;
end;*)

function TfrmImportoptions.GetPartID(const PartName: string): integer;
begin
(*  If Empty(PartName) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT PARTSID FROM tblparts WHERE PARTNAME = ' + QuotedStr(PartName) + ';');
  qryTemp.Active := true;
  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('PARTSID').AsInteger;
  end else begin
    Result := 0;
  end;*)
  result := getProduct(Partname);
end;

(*function TfrmImportoptions.ModQtyDataStr(const LineStringTemp: string): string;
var
  StringTemp: string;
  FieldValueStrPart: string;
  FieldValueStrClass: string;
  StrPartID: string;
  StrClassID: string;
begin
  StringTemp := Commonlib.ReplaceStr(LineStringTemp, #9, #44);
  FieldValueStrPart := StrExtStr(StringTemp, #44, 1);
  StrPartID := IntToStr(GetPartID(FieldValueStrPart));
  StringTemp := Commonlib.ReplaceStr(StringTemp, FieldValueStrPart + #44, FieldValueStrPart + #44 + StrPartID + #44);
  FieldValueStrClass := StrExtStr(StringTemp, #44, 4);
  StrClassID := IntToStr(GetClassID(FieldValueStrClass));
  StringTemp := Commonlib.ReplaceStr(StringTemp, FieldValueStrClass + #44, FieldValueStrClass + #44 + StrClassID + #44);
  StringTemp := Commonlib.ReplaceStr(StringTemp, #44, #39 + #44 + #39);
  StringTemp := #39 + StringTemp + #39;

  if (GetPartID(FieldValueStrPart) = 0) or (GetClassID(FieldValueStrClass) = 0) {OR QtyExists(StrPartID,StrClassID)} then
  begin
    Result := '';
  end else begin
    Result := StringTemp;
  end;
end;*)

function TfrmImportoptions.TypeToTableName(const TableName: TWhereTableName): string;
begin
  Result := TableDesc[TableName];
end;

function TfrmImportoptions.TypeToWhereField(const TableName: TWhereTableName): string;
begin
  Result := WhereField[TableName];
end;

function TfrmImportoptions.FieldCounter(const TestString: string): integer;
var
  TempStr: string;
  S, Count, I: integer;
begin
  TempStr := TestString;
  Count := 1;

  for I := 1 to 200 do begin
    S := FastFuncs.PosEx(#44, TempStr);
    if S > 0 then begin
      Delete(TempStr, S, char_length(#44));
      Count := Count + 1;
    end else begin
      Break;
    end;
  end;
  Result := Count
end;

function TfrmImportoptions.CreateUpdateString(const HeaderStrings, DataStrings: string): string;
var
  TempString, CreatingString: string;
  FieldCount, I: integer;
begin
  TempString := '';
  CreatingString := '';
  FieldCount := FieldCounter(HeaderStrings);

  if FieldCount = 0 then begin
    FieldCount := 1;
  end;

  for I := 1 to FieldCount do begin
    TempString     := '';
    TempString     := TempString + StrExtStr(HeaderStrings, #44, I) + '=';
    TempString     := TempString + StrExtStr(DataStrings, #44, I) + ',';
    CreatingString := CreatingString + TempString
  end;
  CreatingString := Copy(CreatingString, 0, char_length(CreatingString) - 1);
  Result := CreatingString
end;

function TfrmImportoptions.CreateWhereString(const HeaderStrings, TableString, DataStrings: string): string;
var
  TempWhereField1, TempWhereField2, TempWhereField3, TempWhereField4, TempWhereField5, TempWhereField6,
  TempWhereField7, TempWhereField8, TempWhereField9: string;
  TempStr, CreatingString: string;
  FieldCount, I: integer;
begin
  TempStr := '';
  TempWhereField1 := '';
  TempWhereField2 := '';
  TempWhereField3 := '';
  TempWhereField4 := '';
  TempWhereField5 := '';
  TempWhereField6 := '';
  TempWhereField7 := '';
  TempWhereField8 := '';
  TempWhereField9 := '';

  case TableType of
    wttblemployees, wttblemployeeformsaccess, wttblcustomerlines,
    wttblextraprice, wttblextrapricesell, wttblprodgroupdiscs, wttblForeignPrice, wttbltrainerrates,
    wttblcurrencyconversionhistory,wttblunitsofmeasure,wttblShippingAddress,{wttblcontacts,}wttblproductclasses,wttblrepairfaults:

      begin
        TempStr := TypeToWhereField(TableType);
        TempWhereField1 := StrExtStr(TempStr, '^', 1);
        TempWhereField2 := StrExtStr(TempStr, '^', 2);
        TempWhereField3 := StrExtStr(TempStr, '^', 3);
        TempWhereField4 := StrExtStr(TempStr, '^', 4);
        TempWhereField5 := StrExtStr(TempStr, '^', 5);
        TempWhereField6 := StrExtStr(TempStr, '^', 6);
        TempWhereField7 := StrExtStr(TempStr, '^', 7);
        TempWhereField8 := StrExtStr(TempStr, '^', 8);
        TempWhereField9 := StrExtStr(TempStr, '^', 9);

        CreatingString := ' WHERE ' + TempWhereField1 + '=';
        FieldCount := FieldCounter(HeaderStrings);

        if FieldCount = 0 then begin
          FieldCount := 1;
        end;
        TempStr := '';
        for I := 1 to FieldCount do begin
          if SameText(StrExtStr(HeaderStrings, #44, I) , TempWhereField1) then begin
            TempStr := StrExtStr(DataStrings, #44, I);
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
            Break;
          end;
        end;
        if Empty(TempStr) then begin
          if Empty(TempStr) then TempStr := '""';
          CreatingString := CreatingString + TempStr;
        end;
        //2
        if not Empty(TempWhereField2) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField2 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField2 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///3
        if not Empty(TempWhereField3) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField3 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField3 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///4
        if not Empty(TempWhereField4) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField4 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField4 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///5
        if not Empty(TempWhereField5) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField5 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField5 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///6
        if not Empty(TempWhereField6) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField6 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField6 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///7
        if not Empty(TempWhereField7) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField7 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField7 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///8
        if not Empty(TempWhereField8) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField8 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField8 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///9
        if not Empty(TempWhereField9) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField9 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField9 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
      end;

    else begin
        CreatingString := ' WHERE ' + TypeToWhereField(TableType) + '=';
        FieldCount := FieldCounter(HeaderStrings);

        if FieldCount = 0 then begin
          FieldCount := 1;
        end;


        for I := 1 to FieldCount do begin
          if StrExtStr(HeaderStrings, #44, I) = TypeToWhereField(TableType) then begin
            TempStr := StrExtStr(DataStrings, #44, I);
            CreatingString := CreatingString + TempStr;
            Break;
          end;
        end;
        if Empty(TempStr) then begin
          CreatingString := CreatingString + TempStr;
        end;
      end;
  end;
  Result := CreatingString;
end;

function TfrmImportoptions.GetEmployeeID(const EmployeeName: string): integer;
begin
  If Empty(EmployeeName) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT EmployeeID FROM tblemployees WHERE Concat(FirstName," ",LastName) = ' +
    QuotedStr(EmployeeName) + ';');
  qryTemp.Active := true;
  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('EmployeeID').AsInteger;
  end else begin
    Result := 0;
  end;
end;

function TfrmImportoptions.GetClientTypeID(const TypeName: string): integer;
begin
  If Empty(TypeName) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT ClientTypeID FROM tblclienttype ');
  qryTemp.Sql.Add('WHERE Active= "T" AND TypeName=' + QuotedStr(TypeName) + ';');
  qryTemp.Active := true;
  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('ClientTypeID').AsInteger;
  end else begin
    Result := 0;
  end;
end;

function TfrmImportoptions.GetOtherContactClientTypeID(const TypeName: string): integer;
begin
  If Empty(TypeName) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT ID FROM tblsimpletypes WHERE Name =' + QuotedStr(TypeName) + ';');
  qryTemp.Active := true;
  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('ID').AsInteger;
  end else begin
    Result := 0;
  end;
end;

function TfrmImportoptions.GetSourceID(const SourceName: string): integer;
begin
  If Empty(SourceName) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT MedTypeID FROM tblsource WHERE MediaType =' + QuotedStr(SourceName) + ';');
  qryTemp.Active := true;
  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('MedTypeID').AsInteger;
  end else begin
    Result := 0;
  end;
end;

function TfrmImportoptions.GetTermsID(const TermsName: string): integer;
begin
  If Empty(TermsName) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT TermsID FROM tblterms WHERE Terms =' + QuotedStr(TermsName) + ';');
  qryTemp.Active := true;
  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('TermsID').AsInteger;
  end else begin
    Result := 0;
  end;
end;

function TfrmImportoptions.GetColumnNo(const ColumnHeading, HeaderStrings: string): integer;
var
  SL:TStringList;
  ctr:Integer;
begin
  result:= -1;
  SL:=TStringList.create;
  try
    Split(HeaderStrings, ',' , SL);
    for ctr := 0 to SL.count-1 do
      if sameText(sl[ctr] , ColumnHeading) then begin
          Result := ctr+1;
          Exit;
      end;
  finally
      FreeandNil(SL);
  end;
(*var
  TotalStrLength, CurrentStrLength, Count, I: integer;
  TempStrValue: string;
begin
  Count := 0;
  CurrentStrLength := 0;
  TotalStrLength := char_length(HeaderStrings);

  for I := 1 to TotalStrLength do begin
    Count        := I;
    TempStrValue := StrExtStr(HeaderStrings, #44, I);

    if (uppercase(TempStrValue) = uppercase(ColumnHeading)) then begin
      Break;
    end;

    CurrentStrLength := CurrentStrLength + char_length(TempStrValue);

    if (CurrentStrLength = TotalStrLength) then begin
      Count := 0;
      Break;
    end;
  end;

  Result := Count;*)
end;
Function TfrmImportoptions.DeleteColumn(const ColumnHeading, HeaderStrings, LineString: string):String;
var
  i:Integer;
  SL:TStringList;
begin

  SL:= TStringList.create;
  //SL.DelimitedText := #9;
  //SL.commatext :=  LineString;
  SL.Delimiter := #9;
  Split(LineString , #9 , SL);
  i:= GetColumnNo(ColumnHeading ,HeaderStrings);
  try
    SL.Delete(i-1);
  Except
      //kill the exception if the column is empty
  end;
  result := SL.DelimitedText;
end;
function TfrmImportoptions.ReplaceColumnNo(const ColumnNo: integer; const ReplacmentStr, LineString: string; Const Delimter:String=#9): string;
var
  TotalField, TotalStrLength, CurrentStrLength, Count, I: integer;
  CreationStr, TempStrValue: string;
begin
  CurrentStrLength := 0;
  TotalStrLength := char_length(LineString);
  TotalField := FieldCounter(HeaderStrings);
  for I := 1 to TotalField do begin
    Count := I;
    TempStrValue := Trim(StrExtStr(LineString, Delimter, I));

    if not (ColumnNo = Count) then begin
      CreationStr := CreationStr + Delimter + TempStrValue;
      CurrentStrLength := CurrentStrLength + char_length(Delimter + TempStrValue);
    end else begin
      TotalStrLength := TotalStrLength - (char_length(TempStrValue) - char_length(ReplacmentStr));
      CreationStr := CreationStr + Delimter + ReplacmentStr;
      CurrentStrLength := CurrentStrLength + char_length(ReplacmentStr);
    end;

    if CurrentStrLength = TotalStrLength then begin
      Break;
    end;
  end;
  CreationStr := FastFuncs.RightStr(CreationStr, (char_length(CreationStr) - 1));
  Result := CreationStr;
end;


function TfrmImportoptions.GetClientID(const ClientName: string): integer;
begin
  If Empty(ClientName) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT ClientID FROM tblclients WHERE Company =' + QuotedStr(ClientName) + ';');
  qryTemp.Active := true;
  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('ClientID').AsInteger;
  end else begin
    Result := 0;
  end;
end;

function TfrmImportoptions.GetAccountID(const AccountName: string): integer;
begin
  If Empty(AccountName) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT AccountID FROM tblchartofaccounts WHERE AccountName =' + QuotedStr(AccountName) + ';');
  qryTemp.Active := true;
  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('AccountID').AsInteger;
  end else begin
    Result := 0;
  end;
end;

procedure TfrmImportoptions.FormCreate(Sender: TObject);
begin
  inherited;
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  qryUpdateRecord := TERPCommand.Create(nil);
  qryUpdateRecord.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryInsertRecord := TERPCommand.Create(nil);
  qryInsertRecord.Connection := CommonDbLib.GetSharedMyDacConnection;
  TextFileStrings := TStringList.Create;
  UpdateStrings := TStringList.Create;
  UpdateForeignExchangeStrings := TStringList.Create;
  memSqlStrings.Close;
  memSqlStrings.EmptyTable;
  memSqlStrings.Standalone := true;
  memSqlStrings.Performance := mtpfFast;
  memSqlStrings.EnableIndexes := false;
  ErrorOccured := false;
  bEmpImported:= false;
  bProductImported:= false;
  bShippADDImported:= false;
end;

procedure TfrmImportoptions.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryTemp);
  FreeandNil(qryUpdateRecord);
  FreeandNil(qryInsertRecord);
  FreeandNil(TextFileStrings);
  FreeandNil(UpdateStrings);
  FreeandNil(UpdateForeignExchangeStrings);
  inherited;
end;
function TfrmImportoptions.ValidProductclass(var LineString: string): boolean;
var
  BinLocation,Binnumber, strClass:String;
  classid,binId, ProductID :Integer;
begin
  REsult := True;
  binlocation :=Trim(StrExtStr(LineString, #9, GetColumnNo('BINLOCATION', HeaderStrings)));
  binNumber :=Trim(StrExtStr(LineString, #9, GetColumnNo('BINNUMBER', HeaderStrings)));
  ProductID := tcDatautils.GetProduct(Trim(StrExtStr(LineString, #9, GetColumnNo('ProductName', HeaderStrings))));
  if ProductID =0 then begin
      AddErrorLogMessage('Error: '+Trim(StrExtStr(LineString, #9, GetColumnNo('ProductName', HeaderStrings))) + ' is invalid Product -' + IntToStr(LineNumber));
      Result := false;
      Exit;
  end;

  strClass:=Trim(StrExtStr(LineString, #9, GetColumnNo('CLASSName', HeaderStrings)));
  if strclass= '' then begin
    AddErrorLogMessage('Error: Class name is blank on Line - ' + IntToStr(LineNumber));
    Result := false;
    Exit;
  end;
  classId := tcDataUtils.GetDeptID(strClass);
  if classId =0 then begin
      AddErrorLogMessage('Error: '+strClass + ' is invalid class -' + IntToStr(LineNumber));
      Result := false;
      Exit;
  end;
  BinId := tcdatautils.GetBinID(BinLocation,Binnumber, classid);
  if (binId =0) and (BinLocation <>'') then begin
      AddErrorLogMessage('Error: '+binlocation +'-' +binnumber + ' is invalid bin -' + IntToStr(LineNumber));
      Result := false;
      Exit;
  end;
  LineString := DeleteColumn('binNumber' , HeaderStrings ,LineString);
  LineString := DeleteColumn('binLocation' , HeaderStrings ,LineString);
  //LineString := ReplaceColumnNo(GetColumnNo('binNumber', HeaderStrings),IntToStr(binID), LineString);
  //LineString := ReplaceColumnNo(GetColumnNo('ProductID', HeaderStrings),IntToStr(ProductID), LineString);
  LineString := LineString+#9 + IntToStr(binID);
  LineString := LineString+#9 + IntToStr(ClassId);
  LineString := LineString+#9 + IntToStr(ProductID);
end;
function TfrmImportoptions.ValidBin(var LineString: string): boolean;
var
  binlocation, binNumber, strclass, strSQL:String;
  BinVolume :double;
  VOLUME_USED :String;
begin
  REsult := True;
  binlocation :=Trim(StrExtStr(LineString, #9, GetColumnNo('BINLOCATION', HeaderStrings)));
  binNumber :=Trim(StrExtStr(LineString, #9, GetColumnNo('BINNUMBER', HeaderStrings)));
  strClass:=Trim(StrExtStr(LineString, #9, GetColumnNo('CLASSID', HeaderStrings)));
  VOLUME_USED:=Trim(StrExtStr(LineString, #9, GetColumnNo('VOLUME_USED', HeaderStrings)));
  if IsNumeric( Trim(StrExtStr(LineString, #9, GetColumnNo('VOLUME', HeaderStrings)))) then
    BinVolume:=  strToFloat(Trim(StrExtStr(LineString, #9, GetColumnNo('VOLUME', HeaderStrings)))) else BinVolume:=  0;

  if binlocation='' then begin
     AddErrorLogMessage('Error: BinLocation is blank on Line - ' + IntToStr(LineNumber));
    Result := false;

  end;
  if strClass='' then begin
     AddErrorLogMessage('Error: Class name is blank on Line - ' + IntToStr(LineNumber));
    Result := false;

  end;
  if Appenv.CompanyPrefs.EnforceBinVolume then
    if BinVolume=0 then begin
       AddErrorLogMessage('Error: BIN VOLUME is either blank or invalid on Line - ' + IntToStr(LineNumber));
      Result := false;
    end;
  strSQL:=' select classid from tblclass where classname = ' +QuotedStr(strClass);
  with CommonDbLib.TempMyQuery do try
    SQL.add(strSQL);
    open;
    if recordcount = 0 then begin
      AddErrorLogMessage('Error: classname ' +strClass+' doesn''t exists on Line - ' + IntToStr(LineNumber));
      Result := false;
    (*end else begin
        strSQL:= 'SELECT BinID ' +
                  ' from tblProductbin  ' +
                  ' where binlocation = ' +QuotedStr(BinLocation) +
                  ' and binnumber = '+QuotedStr(Binnumber)+
                  ' and classid = ' +IntToStr(Fieldbyname('ClassId').asInteger);
        if Active then close;
        SQL.clear;
        SQL.add(strSQL);
        open;
        if recordcount > 0 then begin
          AddErrorLogMessage('Error: Bin record already exists.(BinLocation :-' +binlocation +',BinNumber:-' +binNumber +', ClassName ' + strclass +') on Line - ' + IntToStr(LineNumber));
          Result := false;
        end;*)
    end;
  finally
      if active then Close;
      free;
  end;
  if not result then exit;
  LineString := ReplaceColumnNo(GetColumnNo('CLASSID', HeaderStrings),IntToStr(BusobjClass.TDeptClass.IDToggle(strClass)), LineString);
  if VOLUME_USED = '' then
    LineString := ReplaceColumnNo(GetColumnNo('VOLUME_USED', HeaderStrings),'0', LineString);
  if BinVolume = 0 then
    LineString := ReplaceColumnNo(GetColumnNo('VOLUME', HeaderStrings),'0', LineString);

end;
function TfrmImportoptions.ValidCLIENTREWARDPOINTS(var LineString: string): boolean;
var
  clientID :Integer;
  company:String;
  ValueforRewardPoint :string;
  dValueforRewardPoint:Double;
  OpeningBalanceAsOn:String;
  dOpeningBalanceAsOn:TDateTime;
begin
  result := true;
  Company :=Trim(StrExtStr(LineString, #9, GetColumnNo('clientId', HeaderStrings)));
  clientID := tcdatautils.getclientID(company);
  if clientId = 0 then begin
    AddErrorLogMessage('Error: Unable to Find Company [' + company + '] on Line - ' + IntToStr(LineNumber));
    Result := false;
  end;

  dValueforRewardPoint :=0;
  ValueforRewardPoint :=Trim(StrExtStr(LineString, #9, GetColumnNo('ValueforRewardPoint', HeaderStrings)));
  if IsNumeric(ValueforRewardPoint) then dValueforRewardPoint := strTofloat(ValueforRewardPoint);
  if dValueforRewardPoint =0 then
    dValueforRewardPoint := Appenv.CompanyPrefs.ValueforRewardPoints;


  OpeningBalanceAsOn:=Trim(StrExtStr(LineString, #9, GetColumnNo('OpeningBalanceAsOn', HeaderStrings)));
  if OpeningBalanceAsOn = '' then begin
    AddErrorLogMessage('"Opening balance reward points as on" is blank on Line - ' + IntToStr(LineNumber));
    Result := false;
  end;

  if not IsDate(OpeningBalanceAsOn , dOpeningBalanceAsOn) then begin
    AddErrorLogMessage('"Opening balance reward points as on" [' + OpeningBalanceAsOn +'] is invalid on Line - ' + IntToStr(LineNumber));
    Result := false;
  end;

  if result then begin
      with CommonDbLib.TempMyQuery do try
        SQL.add('SELECT ' +
                '`tblsalesredeempoints`.`SaleslinesRedeemPointID` ' +
                'FROM tblsaleslinespoints ' +
                'inner join tblsalesredeempoints on  tblsalesredeempoints.SalesLinesPointsId   = tblsaleslinespoints.SalesLinesPointsId ' +
                'where clientId = ' + IntToStr(ClientID)+ ' and deptId = ' + IntToStr(appenv.DefaultClass.ClassID)+ ' and IsOpeningBalance ="T" ' );
        open;
        if recordcount > 0 then begin
          AddErrorLogMessage('Error: Opening balance reward point for ' + company +' already exists and redeemed on Line - ' + IntToStr(LineNumber));
          Result := false;
        end;
      finally
        if active then close;
        Free;
      end;
  end;

  if result then begin

    LineString := ReplaceColumnNo(GetColumnNo('ClientID', HeaderStrings), IntToStr(ClientID), LineString);
    LineString := ReplaceColumnNo(GetColumnNo('ValueforRewardPoint', HeaderStrings), FloattoStr(dValueforRewardPoint), LineString);
    LineString := LineString+#9 + IntToStr(Appenv.DefaultClass.ClassID);
    LineString := LineString+#9 + Appenv.DefaultClass.DefaultClassName;
    LineString := LineString+#9 + QuotedStr('T');
    LineString := LineString+#9 + QuotedStr('T');
  end;


end;

Function TfrmImportoptions.ValidRewardPoints(var LineString: string): boolean;
var
  PartName, UOM, sUOMMult:String;
  UOMMult:Double;
  PartsId, UOMID:Integer;
begin
    result   := true;
    PartName :=Trim(StrExtStr(LineString, #9, GetColumnNo('PARTNAME', HeaderStrings)));
    PartsId  :=tcDatautils.GetProduct(PartName);
    UOM      := Trim(StrExtStr(LineString, #9, GetColumnNo('UOM', HeaderStrings)));

    sUOMMult := Trim(StrExtStr(LineString, #9, GetColumnNo('UOMMultiplier', HeaderStrings)));
    if sUOMMult = '' then UOMMult := 0 else UOMMult := StrToFloat(sUOMMult);


    if PartsId = 0 then begin
      AddErrorLogMessage('Error: Unable to Find Product on Line - ' + IntToStr(LineNumber));
      Result := false;
    end;
    UOMID   := tcDataUtils.GetUnitOfMeasureID(PartsId, UOM, UOMMult);
    if UOMID = 0 then begin
      AddErrorLogMessage('Error: Unable to Find UOM on Line - ' + IntToStr(LineNumber));
      Result := false;
    end;
  if result then begin
     LineString := LineString+#9 + IntToStr(PartsId);
     LineString := LineString+#9 + IntToStr(UOMID);
  end;
end;
function TfrmImportoptions.ValidProductAccounts(const LineString: string): boolean;
begin
  Result := true;
  if (GetAccountID(Trim(StrExtStr(LineString, #9, GetColumnNo('INCOMEACCNT', HeaderStrings)))) = 0) then begin
    AddErrorLogMessage('Error: Unable to Find Income Account :' + StrExtStr(LineString, #9, GetColumnNo('INCOMEACCNT', HeaderStrings)) +' on Line - ' + IntToStr(LineNumber));
    Result := false;
  end;

  if (GetAccountID(Trim(StrExtStr(LineString, #9, GetColumnNo('ASSETACCNT', HeaderStrings)))) = 0) then begin
    AddErrorLogMessage('Error: Unable to Find Asset Account :'+StrExtStr(LineString, #9, GetColumnNo('ASSETACCNT', HeaderStrings))+' on Line - ' + IntToStr(LineNumber));
    Result := false;
  end;

  if (GetAccountID(Trim(StrExtStr(LineString, #9, GetColumnNo('COGSACCNT', HeaderStrings)))) = 0) then begin
    AddErrorLogMessage('Error: Unable to Find Cost Of Goods Sold Account :'+StrExtStr(LineString, #9, GetColumnNo('ASSETACCNT', HeaderStrings))+' on Line - ' + IntToStr(LineNumber));
    Result := false;
  end;
end;


procedure TfrmImportoptions.AddErrorLogMessage(const MessageText: string);
begin
  ErrorOccured := true;
  Writeln(ErrorLog, MessageText);
  Flush(ErrorLog);
end;

procedure TfrmImportoptions.NewErrorLogFile;
var
  sFile: string;
begin
  sFile := SystemLib.ExeDir + ERRORLOG_FILE;
  AssignFile(ErrorLog, sFile);
  try
    {$I-}
    Rewrite(ErrorLog);
    {$I+}
    IOResult;
  except
    on EInOutError do;
  end;
end;

procedure TfrmImportoptions.UpdateEmpName;
begin
  qryUpdateRecord.SQL.Clear;
  qryUpdateRecord.SQL.Add('UPDATE tblEmployees SET EmployeeName = CONCAT_WS(" ", FirstName, LastName);');
  qryUpdateRecord.Execute;
end;

function TfrmImportoptions.GetShippingID(const ShippingMethod: string): integer;
begin
  If Empty(ShippingMethod) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT ShippingMethodID FROM tblshippingmethods WHERE ShippingMethod =' + QuotedStr(ShippingMethod) + ';');
  qryTemp.Active := true;
  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('ShippingMethodID').AsInteger;
  end else begin
    Result := 0;
  end;
end;

procedure TfrmImportoptions.FormShow(Sender: TObject);
begin
  try
    inherited;
    if Self.CallingClassName = 'TfrmMarketingContactDetailsListGUI' then begin
      Letter_Label.Caption := 'Please select Marketing Contacts Import File';
      btnOk.Enabled := false;
    end;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TfrmImportoptions.UpdateRecords;
var
  qryExec: TERPCommand;
  I, C: integer;
  ForeignExchangeObj: TForeignExchangeObj;
  Code: string;
  BuyRate: double;
  SellRate: double;
  SeqNo:Integer;
begin
  UpdateStrings.Clear;
  UpdateForeignExchangeStrings.Clear;
  memSqlStrings.EnableIndexes := true;
  memSqlStrings.UpdateIndexes;
  qryExec := TERPCommand.Create(Self);
  try
    qryExec.Connection          := CommonDbLib.GetSharedMyDacConnection;
    ImportProgressBar2.Visible  := true;
    ImportProgressBar2.Min      := 0;
    ImportProgressBar2.Max      := memSqlStrings.RecordCount + 2;
    ImportProgressBar2.Position := ImportProgressBar2.Min;
    lblImporting2.Caption       := 'Please Wait Importing ..... 0%';
    lblImporting2.Visible       := true;
    ImportProgressBar2.Visible  := true;
    Self.Update;
    if Self.CallingClassName = 'TfrmMarketingContactDetailsListGUI' then begin
      btnOk.Enabled := false;
    end;

    C := 0;
    for SeqNo := 0 to MaxSeqNo do begin
      memSqlStrings.First;
      while not memSqlStrings.Eof do begin
        if memSqlStringsSeqNo.asInteger = Seqno then begin
          Code := '';
          BuyRate := 0.00;
          SellRate := 0.00;
          C := C + 1;
          qryExec.SQL.Clear;
          qryExec.SQL.Text := memSqlStringsInsertSQL.AsString;
          Self.Update;
          try
            if UseForeignExchangeObj then begin
              Code := StrExtStr(memSqlStringsDataStrings.AsString, #44, GetColumnNo('Code', memSqlStringsHeaderStrings.AsString));
              Code := Commonlib.ReplaceStr(Code, #39, '');
              BuyRate := StrValue(StrExtStr(memSqlStringsDataStrings.AsString, #44,
                GetColumnNo('BuyRate', memSqlStringsHeaderStrings.AsString)));
              SellRate := StrValue(StrExtStr(memSqlStringsDataStrings.AsString, #44,
                GetColumnNo('SellRate', memSqlStringsHeaderStrings.AsString)));
            end;
            qryExec.Execute;
            if UseForeignExchangeObj then begin
              ForeignExchangeObj := TForeignExchangeObj.Create;
              try
                ForeignExchangeObj.AddForeignExchangeRateHistory(ForeignExchangeObj.GetCurrencyID(Code), BuyRate, SellRate, Now());
              finally
                if Assigned(ForeignExchangeObj) then
                  FreeandNil(ForeignExchangeObj);
              end;
            end;
          except
            on E: EMyError do begin
              if Pos('Duplicate entry', E.message)> 0 then begin
                UpdateRecord(memSqlStringsHeaderStrings.AsString, memSqlStringsTableString.AsString,
                  memSqlStringsDataStrings.AsString, Code + ',' + FloatToStr(BuyRate) + ',' + FloatToStr(SellRate));
              end;
            end;
            on E:Exception do begin
            end;
          end;
        end;
        memSqlStrings.Next;
        ImportProgressBar2.StepIt;
        lblImporting2.Caption := 'Please Wait Importing ..... ' + FloatToStrF(((C / (memSqlStrings.RecordCount + 1)) * 100),
          ffFixed, 18, 0) + '% Complete';
        Self.Update;
      end;
    end;
    memSqlStrings.Close;
    memSqlStrings.EmptyTable;
    memSqlStrings.Open;
    //###########
    ImportProgressBar2.Min      := 0;
    ImportProgressBar2.Max      := UpdateStrings.Count + 2;
    ImportProgressBar2.Position := ImportProgressBar2.Min;
    lblImporting2.Caption       := 'Please Wait Updating ..... 0%';
    lblImporting2.Visible       := true;
    Self.Update;
    
    for I := 0 to UpdateStrings.Count - 1 do begin
      qryExec.SQL.Clear;
      qryExec.SQL.Text := UpdateStrings.Strings[I];
      Self.Update;
      try
        qryExec.Execute;
        if UseForeignExchangeObj then begin
          ForeignExchangeObj := TForeignExchangeObj.Create;
          try
            Code := StrExtStr(UpdateForeignExchangeStrings.Strings[I], #44, 1);
            BuyRate := StrValue(StrExtStr(UpdateForeignExchangeStrings.Strings[I], #44, 2));
            SellRate := StrValue(StrExtStr(UpdateForeignExchangeStrings.Strings[I], #44, 3));
            ForeignExchangeObj.AddForeignExchangeRateHistory(ForeignExchangeObj.GetCurrencyID(Code), BuyRate, SellRate, Now());
          finally
            FreeandNil(ForeignExchangeObj);
          end;
        end;
      except
        on E:Exception do ;
        on E:EMyError  do ;
      end;
      ImportProgressBar2.StepIt;
      lblImporting2.Caption := 'Please Wait Updating ..... ' + FloatToStrF(((I / (UpdateStrings.Count + 1)) * 100),
        ffFixed, 18, 0) + '% Complete';
      Self.Update;
    end;
  finally
    FreeandNil(qryExec);
  end;
  ImportProgressBar2.Position := ImportProgressBar2.Min;
  lblImporting2.Visible := false;
  UpdateStrings.Clear;
  UpdateForeignExchangeStrings.Clear;
end;

function TfrmImportoptions.GetCurrencyID(const CurrencyCode: string): integer;
begin
  If Empty(CurrencyCode) then Begin
    Result := 0;
    Exit;
  end;
  qryTemp.Sql.Clear;
  qryTemp.Sql.Add('SELECT CurrencyID FROM tblcurrencyconversion WHERE Code=' + QuotedStr(CurrencyCode) + ';');
  qryTemp.Active := true;

  if not qryTemp.IsEmpty then begin
    Result := qryTemp.FieldByName('CurrencyID').AsInteger;
  end else begin
    Result := 0;
  end;
end;

procedure TfrmImportoptions.ImportBudget(Const HeaderStrings, LineString: string);
begin
  CommonLib.MessageDlgXP_Vista(HeaderStrings, mtInformation , [mbOK], 0);
  CommonLib.MessageDlgXP_Vista(LineString, mtInformation , [mbOK], 0);
end;

function TfrmImportOptions.GetClassNameofFile(Const FileName: string): string;
var
  fl: TextFile;
  LineString: string;
begin
  Result := '';
  AssignFile(fl, FileName);
  FileMode:=0;        {set file to read only access}
  try
    {$I-}
    Reset(fl);
    {$I+}
    IOResult;
    {$I-} if Eof(fl) then exit; {$I+}
      Readln(fl, LineString);//special note
      Readln(fl, LineString);//heading
      LineString := StrExtStr(LineString, #9, 1);
      LineString := Commonlib.ReplaceStr(LineString, '$', '');
      CloseFile(fl);
      Result := LineString;
  except
    CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmImportoptions.UpdateSNTracking;
begin
  qryUpdateRecord.SQL.Clear;
  qryUpdateRecord.SQL.Add('UPDATE tblparts SET SNTracking= "F" WHERE `SNTracking` = "";');
  Try
    qryUpdateRecord.Execute;
  except
  end;
end;

procedure TfrmImportoptions.ShippADDlink;
var
  qry : TERPCommand;
begin

  qry := TERPCommand.Create(Self);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'INSERT IGNORE INTO tblclienttoshipaddresslink (ClientID,ShipAddressID) '+
                    'SELECT Customer_ID,ShipAddressID FROM `tblshippingaddress`;';
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;







//function TfrmImportoptions.ValidateContact(  const LineString: String): Boolean;
//var
//  customername:String;
//  Suppliername:String;
//begin
//  Result := true;
//
//  customername :=Trim(StrExtStr(LineString, #9, GetColumnNo('CusID', HeaderStrings)));
//  supplierName :=Trim(StrExtStr(LineString, #9, GetColumnNo('SupID', HeaderStrings)));
//  if (customername = '') and (SupplierName = '') then begin
//    AddErrorLogMessage('Error: both customername and suppliername are blank - ' + IntToStr(LineNumber));
//    Result := false;
//  end else if (customername <> '') and (GetClientID(customername) = 0) then begin
//    AddErrorLogMessage('Error: Unable to Find Customer(' +CustomerName +') - ' + IntToStr(LineNumber));
//    Result := false;
//  end else if (Suppliername<>'') and (GetClientID(supplierName) = 0) then begin
//    AddErrorLogMessage('Error: Unable to Find Supplier(' +Suppliername +') - ' + IntToStr(LineNumber));
//    Result := false;
//  end;
//end;





function TfrmImportoptions.ObjectImporting(ExportHeading :String): Boolean;
var
  FirstField:String;
begin
  FirstField := StrExtStr(StripQuotes(ExportHeading), #9, 1);
  result := (Sysutils.SameText(FirstField , '$PRODUCTCOMMISSION')) OR
            (Sysutils.SameText(FirstField , '$EXPORTTITLE'));
end;

function TfrmImportoptions.ValidEQUIPMENT(const LineString: string): boolean;
var
  PartName:String;
  ProductID:Integer;
begin
  Result := true;
  PartName:= StrExtStr(LineString, #9, GetColumnNo('ProductID', HeaderStrings));
  if PartName = '' then exit;
  ProductID:= GetProduct(PartName);
  if ProductID = 0 then begin
    AddErrorLogMessage('Error: Unable to Find Product' + PartName + ' on Line - ' + IntToStr(LineNumber));
    Result := false;
  end ;
end;

procedure TfrmImportoptions.AfterUpdate(Firstfield: String);
var
  strSQL:string;
  qryExec : TERPCommand;
begin
  strSQL := '';
  if Sysutils.SameText(Firstfield, 'FINALEXTRASELLPRICE') then begin
    {if the prices are imported - overright it}
      strSQL := 'update  `tblparts` Inner Join `tblextrapricesell` ON `tblparts`.`PARTSID` = `tblextrapricesell`.`PartsID`  Set  `tblextrapricesell`.`Price1` = `tblparts`.`PRICE1` - (`tblparts`.`PRICE1` *`tblextrapricesell`.`QtyPercent1`/100);'
  end;

  if strSQL <> '' then begin
    qryExec := TERPCommand.Create(Self);
    try
      qryExec.Connection          := CommonDbLib.GetSharedMyDacConnection;
      qryExec.SQL.add(strSQL);
      qryExec.Execute;
    finally
      FreeandNil(qryExec);
    end;
  end;
end;

function TfrmImportoptions.ValidMANUFACTURE(const LineString: string): boolean;
var
  Name:String;
begin
  Result := true;
  Name:= StrExtStr(LineString, #9, GetColumnNo('Name', HeaderStrings));
  if Name = '' then  begin
    AddErrorLogMessage('Manufacture Name is blank on Line - ' + IntToStr(LineNumber));
    Result := false;
  end ;
end;

function TfrmImportoptions.ValidRepairFaults(const LineString: string): boolean;
var
  Code:String;
begin
  Result := true;
  Code:= StrExtStr(LineString, #9, GetColumnNo('Code', HeaderStrings));
  if code = '' then begin
    AddErrorLogMessage('Error: Code is blank on Line - ' + IntToStr(LineNumber));
    Result := false;
  end;
  Code:= StrExtStr(LineString, #9, GetColumnNo('Category', HeaderStrings));
  if code = '' then begin
    AddErrorLogMessage('Error: Category is blank on Line - ' + IntToStr(LineNumber));
    Result := false;
  end;
end;

initialization
  RegisterClassOnce(TfrmImportOptions);
end.




