unit SubtaxSummaryreport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,   Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MyAccess,ERPdbComponents, DBAccess, MemDS,
  wwdbdatetimepicker, DnmLib, wwdblook, wwcheckbox,
  ProgressDialog,  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup;

const
  SX_DatechangeMsg = WM_USER + 116;

type
  TSubtaxSummaryreportGUI = class(TBaseListingGUI)
    btnRefresh: TDNMSpeedButton;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    cboClassQry: TERPQuery;
    chkShowNT: TCheckBox;
    grpSumOption: TRadioGroup;
    qryMainDetails: TIntegerField;
    qryMaintype: TWideStringField;
    qryMainTransID: TIntegerField;
    qryMainTaxcode: TWideStringField;
    qryMainsubTaxCode: TWideStringField;
    qryMainINPUT_AmountEx: TFloatField;
    qryMainINPUT_AmountInc: TFloatField;
    qryMainOUTPUT_AmountEx: TFloatField;
    qryMainOUTPUT_AmountInc: TFloatField;
    qryMaintotalNet: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainPercentage: TFloatField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPostCode: TWideStringField;
    btnSalesTaxRpt: TDNMSpeedButton;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpSumOptionClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure btnSalesTaxRptClick(Sender: TObject);

  private
    procedure beforeshowTransAccountDetailsGUI(Sender: TObject);
    procedure beforeshowSalesTaxrpt(Sender: TObject);

  protected
    Tablename :String;
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    function GetReportTypeID: integer; override;
    procedure SetGridColumns; override;
    procedure CalcFooter;override;
    procedure CopyfilterParams(sender: TObject);override;
    function CreateTaxSummaryTempTable(Const DateFrom, DateTo: TDateTime):Boolean;virtual;
    function tablenamePrefix:String;virtual;abstract;
    procedure MakeQrymain;virtual;
  public

    { Public declarations }
  end;


implementation

uses
  CommonDbLib, CommonLib,  TransAccountDetailsForm,
  AppEnvironment, FastFuncs, MySQLConst, CommonFormLib,  tcConst;

{$R *.dfm}

procedure TSubtaxSummaryreportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMaindetails.fieldname);
end;

Function TSubtaxSummaryreportGUI.CreateTaxSummaryTempTable(Const DateFrom, DateTo: TDateTime):Boolean;
var
  tmpClassID:Integer;
begin
  tmpClassID := cboClassQry.FieldByName('ClassID').AsInteger;
  With ScriptMain do begin
    SQL.Clear;
    SQL.Add('DROP TABLE if exists ' + TableName + ';');
    SQL.Add('CREATE TABLE ' + TableName + ' ( ');
    SQL.Add('`ID` int(11) NOT NULL auto_increment,  ');
    SQL.Add('`TaxCode` varchar(50) NOT NULL ,');
    SQL.Add('`TaxRate` double NOT NULL default 0, ');
    SQL.Add('saleId int(11), ');
    SQL.Add('salelineId int(11), ');
    SQL.Add('purchaseOrderId int(11), ');
    SQL.Add('purchaselineId int(11), ');
    SQL.Add('`INPUT_AmountEx` double NOT NULL default 0, ');
    SQL.Add('`INPUT_AmountInc` double NOT NULL default 0, ');
    SQL.Add('`OUTPUT_AmountEx` double NOT NULL default 0, ');
    SQL.Add('`OUTPUT_AmountInc` double NOT NULL default 0, ');
    SQL.Add('`TotalNet` double NOT NULL default 0, ');
    SQL.Add('`TotalTax` double NOT NULL default 0,  ');
    SQL.Add('PRIMARY KEY  (`ID`)) ENGINE=MyISAM; ');
    SQL.Add('ALTER TABLE '+ tablename + '	ADD INDEX `KeyFieldsIdx` (`TaxCode`, `saleId`, `salelineId`, `purchaseOrderId`, `purchaselineId`);');
    SQL.Add('ALTER TABLE '+ tablename + '	ADD INDEX `saleId_salelineId` (`saleId`, `salelineId`),	ADD INDEX `purchaseOrderId_purchaselineId` (`purchaseOrderId`, `purchaselineId`);');



    SQL.Add('insert into ' +tablename +' (TaxCode,SAleID,SaleLineID,purchaseOrderId,purchaseLineID, TaxRate, OUTPUT_AmountEx,OUTPUT_AmountInc,INPUT_AmountEx,INPUT_AmountInc , TotalNet,TotalTax)');
    SQL.Add('Select TaxCode,SaleId,saleLineId,PurchaseorderId,purchaselineID ,TaxRate,');
    SQL.Add('Sum(if(TaxType="OUTPUT" , AmountEx , 0)) as OUTPUT_AmountEx,');
    SQL.Add('Sum(if(TaxType="OUTPUT" , AmountInc , 0)) as OUTPUT_AmountInc,');
    SQL.Add('Sum(if(TaxType<>"OUTPUT" , AmountEx , 0)) as INPUT_AmountEx,');
    SQL.Add('Sum(if(TaxType<>"OUTPUT" , AmountInc , 0)) as INPUT_AmountInc,');
    SQL.Add('/*Sum(if(TaxType<>"OUTPUT" , AmountEx , 0) - if(TaxType="OUTPUT" , AmountEx , 0)) as TotalEx,*/');
    SQL.Add('Sum(if(TaxType<>"OUTPUT" , AmountInc , 0) - if(TaxType="OUTPUT" , AmountInc , 0)) as TotalInc  ,');
    SQL.Add('Sum((if(TaxType<>"OUTPUT" , AmountEx , 0) - if(TaxType="OUTPUT" , AmountEx , 0))*TaxRate) as TotalTax');
    SQL.Add('from (');
    SQL.Add('     SELECT SaleId, saleLineId, purchaseOrderId, purchaselineId,  "OUTPUT" as TaxType,TaxCode,If(TaxCode="WET",0,TaxRate) as TaxRate, ');
    SQL.Add('     Round(Sum(CreditsEx- DebitsEx ),' + intTostr(CommonLib.CurrencyRoundPlaces)+') as AmountEx, ');
    SQL.Add('     Round(Sum(CreditsInc-DebitsInc),' + intTostr(CommonLib.CurrencyRoundPlaces)+') as AmountInc ');
    SQL.Add('     FROM tbltransactions ');
    SQL.Add('     LEFT JOIN tblgeneraljournal ON (SaleID=GJID AND Type = "Journal Entry" ) ');
    SQL.Add('     WHERE (TaxCode<>"" And Not IsNull(TaxCode)) ');
    SQL.Add('     AND (AccountName<>"Tax Paid" AND AccountName<>"Tax Collected") ');
    SQL.Add('     AND (Type = "Invoice" OR Type = "Refund" OR Type = "Cash Sale" OR Type = "Journal Entry") ');
    SQL.Add('     AND (tblgeneraljournal.TaxSelect<>"INPUT" OR IsNull(tblgeneraljournal.TaxSelect)) ');
    if not chkAllClass.Checked then  SQL.Add('AND ClassID = ' + IntToStr(tmpClassID) + ' ');
    SQL.Add('     AND Date Between "' + FormatDateTime(MysqlDateFormat, DateFrom) + '"  AND "' + FormatDateTime(MysqlDateFormat, DateTo) + '" ');
    SQL.Add('     Group by TaxCode , SaleId, saleLineId, purchaseOrderId, purchaselineId ');
    SQL.Add('     UNION ALL ');
    SQL.Add('     SELECT SaleId, saleLineId, purchaseOrderId, purchaselineId, "INPUT" as TaxType,TaxCode,If(TaxCode="WET",0,TaxRate), ');
    SQL.Add('     Round(Sum(DebitsEx-CreditsEx),' + intTostr(CommonLib.CurrencyRoundPlaces)+') as AmountEx, ');
    SQL.Add('     Round(Sum(DebitsInc-CreditsInc),' + intTostr(CommonLib.CurrencyRoundPlaces)+') as AmountInc ');
    SQL.Add('     FROM tbltransactions ');
    SQL.Add('     LEFT JOIN tblgeneraljournal ON (SaleID=GJID AND Type = "Journal Entry" ) ');
    SQL.Add('     WHERE (char_length(Taxcode)>0)  ');
    if not chkAllClass.Checked then  SQL.Add('AND ClassID = ' + IntToStr(tmpClassID) + ' ');
    SQL.Add('     AND (AccountName<>"Tax Paid" AND AccountName<>"Tax Collected") ');
    SQL.Add('     AND (Type = "PO" OR Type = "Bill" OR Type = "Credit" OR Type = "Cheque" OR Type = "Journal Entry") ');
    SQL.Add('     AND (tblgeneraljournal.TaxSelect<>"OUTPUT" OR IsNull(tblgeneraljournal.TaxSelect)) ');
    SQL.Add('     AND Date Between "' + FormatDateTime(MysqlDateFormat, DateFrom) + '"  AND "' + FormatDateTime(MysqlDateFormat, DateTo) + '" ');
    SQL.Add('     Group by TaxCode , SaleId, saleLineId, purchaseOrderId, purchaselineId');
    SQL.Add('     Order by TaxCode ');
    SQL.Add('          ) as Details');
    if (chkShowNT.Checked=False)  then SQL.Add('Where TaxCode<>"NT"');
    SQL.Add('group by TaxCode,SaleId,saleLineId,PurchaseorderId,purchaselineID ;');
    DoShowProgressbar(10,WAITMSG);
    SQL.text := ChangeQuery(SQL.text );
    try
      Execute;
      Result := True;
    finally
      DoHideProgressbar;
    end;
  end;


(*var
  qryTemp: TERPQuery;
  qryAddToTemp: TERPQuery;
  tmpClassID: integer;
begin

  Processingcursor(True);
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.Options.FlatBuffers := True;
  qryAddToTemp := TERPQuery.Create(nil);
  qryAddToTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryAddToTemp.Options.FlatBuffers := True;
  qryAddToTemp.Options.StrictUpdate := false;
  try
    cboClassQry.Locate('ClassName', cboClass.Text, [loCaseInsensitive]);
    tmpClassID := cboClassQry.FieldByName('ClassID').AsInteger;
    commondblib.DestroyUserTemporaryTable(Tablename);
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('CREATE TABLE ' + TableName + ' ( ');
    qryTemp.Sql.Add('`ID` int(11) NOT NULL auto_increment,  ');
    qryTemp.Sql.Add('`TaxCode` varchar(50) NOT NULL ,');
    qryTemp.Sql.Add('`TaxRate` double NOT NULL default 0, ');
    qryTemp.Sql.Add('saleId int(11), ');
    qryTemp.Sql.Add('salelineId int(11), ');
    qryTemp.Sql.Add('purchaseOrderId int(11), ');
    qryTemp.Sql.Add('purchaselineId int(11), ');
    qryTemp.Sql.Add('`INPUT_AmountEx` double NOT NULL default 0, ');
    qryTemp.Sql.Add('`INPUT_AmountInc` double NOT NULL default 0, ');
    qryTemp.Sql.Add('`OUTPUT_AmountEx` double NOT NULL default 0, ');
    qryTemp.Sql.Add('`OUTPUT_AmountInc` double NOT NULL default 0, ');
    qryTemp.Sql.Add('`TotalNet` double NOT NULL default 0, ');
    qryTemp.Sql.Add('`TotalTax` double NOT NULL default 0,  ');
    qryTemp.Sql.Add('PRIMARY KEY  (`ID`)) ENGINE=MyISAM; ');
    qryTemp.Sql.Add('ALTER TABLE '+ tablename +
              '	ADD INDEX `KeyFieldsIdx` (`TaxCode`, `saleId`, `salelineId`, `purchaseOrderId`, `purchaselineId`);');
    qryTemp.Execute;
    qryTemp.Sql.Clear;


    qryTemp.Sql.Add('SELECT SaleId, saleLineId, purchaseOrderId, purchaselineId,  "OUTPUT" as TaxType,TaxCode,If(TaxCode="WET",0,TaxRate) as TaxRate, ');
    qryTemp.Sql.Add('Round(Sum(CreditsEx- DebitsEx ),' + intTostr(CommonLib.CurrencyRoundPlaces)+') as AmountEx, ');
    qryTemp.Sql.Add('Round(Sum(CreditsInc-DebitsInc),' + intTostr(CommonLib.CurrencyRoundPlaces)+') as AmountInc ');
    qryTemp.Sql.Add('FROM tbltransactions ');
    qryTemp.Sql.Add('LEFT JOIN tblgeneraljournal ON (SaleID=GJID AND Type = "Journal Entry" ) ');
    qryTemp.Sql.Add('WHERE (TaxCode<>"" And Not IsNull(TaxCode)) ');
    qryTemp.Sql.Add('AND (AccountName<>"Tax Paid" AND AccountName<>"Tax Collected") ');
    qryTemp.Sql.Add('AND (Type = "Invoice" OR Type = "Refund" OR Type = "Cash Sale" OR Type = "Journal Entry") ');
    qryTemp.Sql.Add('AND (tblgeneraljournal.TaxSelect<>"INPUT" OR IsNull(tblgeneraljournal.TaxSelect)) ');
    if not chkAllClass.Checked then begin
      qryTemp.Sql.Add('AND ClassID = ' + IntToStr(tmpClassID) + ' ');
    end;
    qryTemp.Sql.Add('AND Date Between "' + FormatDateTime(MysqlDateFormat,
      DateFrom) + '"  AND "' + FormatDateTime(MysqlDateFormat, DateTo) + '" ');
    qryTemp.Sql.Add('Group by TaxCode , SaleId, saleLineId, purchaseOrderId, purchaselineId ');
    qryTemp.Sql.Add('UNION ALL ');
    qryTemp.Sql.Add('SELECT SaleId, saleLineId, purchaseOrderId, purchaselineId, "INPUT" as TaxType,TaxCode,If(TaxCode="WET",0,TaxRate), ');
    qryTemp.Sql.Add('Round(Sum(DebitsEx-CreditsEx),' + intTostr(CommonLib.CurrencyRoundPlaces)+') as AmountEx, ');
    qryTemp.Sql.Add('Round(Sum(DebitsInc-CreditsInc),' + intTostr(CommonLib.CurrencyRoundPlaces)+') as AmountInc ');
    qryTemp.Sql.Add('FROM tbltransactions ');
    qryTemp.Sql.Add('LEFT JOIN tblgeneraljournal ON (SaleID=GJID AND Type = "Journal Entry" ) ');
    qryTemp.Sql.Add('WHERE (char_length(Taxcode)>0)  ');
    if not chkAllClass.Checked then begin
      qryTemp.Sql.Add('AND ClassID = ' + IntToStr(tmpClassID) + ' ');
    end;
    qryTemp.Sql.Add('AND (AccountName<>"Tax Paid" AND AccountName<>"Tax Collected") ');
    qryTemp.Sql.Add('AND (Type = "PO" OR Type = "Bill" OR Type = "Credit" OR Type = "Cheque" OR Type = "Journal Entry") ');
    qryTemp.Sql.Add('AND (tblgeneraljournal.TaxSelect<>"OUTPUT" OR IsNull(tblgeneraljournal.TaxSelect)) ');
    qryTemp.Sql.Add('AND Date Between "' + FormatDateTime(MysqlDateFormat,
      DateFrom) + '"  AND "' + FormatDateTime(MysqlDateFormat, DateTo) + '" ');
    qryTemp.Sql.Add('Group by TaxCode , SaleId, saleLineId, purchaseOrderId, purchaselineId');
    qryTemp.Sql.Add('Order by TaxCode; ');


    qryTemp.SQL.text := ChangeQuery(qryTemp.SQL.text );

    qryTemp.Open;
    qryAddToTemp.Sql.Clear;
    qryAddToTemp.Sql.Add('SELECT ID, SaleId, saleLineId, purchaseOrderId, purchaselineId,  TaxCode,TaxRate, INPUT_AmountEx, INPUT_AmountInc, OUTPUT_AmountEx, OUTPUT_AmountInc, TotalNet, TotalTax  FROM  ' + TableName + ';');
    qryAddToTemp.Open;
    qryTemp.First;
    DoShowProgressbar(qryTemp.REcordcount ,WAITMSG);
    try
      while not qryTemp.Eof do begin
         if (chkShowNT.Checked)   or (not Sysutils.SameText(qryTemp.FieldByName('TaxCode').AsString, 'NT')) then begin
           if not(qryAddToTemp.Locate('TaxCode;SaleId;saleLineId;PurchaseorderId;purchaselineID',
                  vararrayof([qryTemp.FieldByName('TaxCode').AsString,
                              qryTemp.FieldByName('SaleId').asInteger,
                              qryTemp.FieldByName('SaleLineId').asInteger,
                              qryTemp.FieldByName('purchaseOrderId').asInteger,
                              qryTemp.FieldByName('PurchaseLineID').asInteger]) ,  [loCaseInsensitive])) then begin
              qryAddToTemp.Append;
              qryAddToTemp.FieldByName('TaxCode').AsString          := qryTemp.FieldByName('TaxCode').AsString;
              qryAddToTemp.FieldByName('SaleID').asInteger          := qryTemp.FieldByName('saleId').asInteger;
              qryAddToTemp.FieldByName('saleLineId').asInteger      := qryTemp.FieldByName('saleLineId').asInteger;
              qryAddToTemp.FieldByName('PurchaseorderId').asInteger := qryTemp.FieldByName('PurchaseorderId').asInteger;
              qryAddToTemp.FieldByName('PurchaselineID').asInteger  := qryTemp.FieldByName('PurchaselineID').asInteger;
              qryAddToTemp.FieldByName('TaxRate').AsString          := qryTemp.FieldByName('TaxRate').AsString;
              qryAddToTemp.FieldByName('OUTPUT_AmountEx').AsFloat := 0;
              qryAddToTemp.FieldByName('OUTPUT_AmountInc').AsFloat := 0;
              qryAddToTemp.Post;
            end;
            qryAddToTemp.Edit;
            if (qryTemp.FieldByName('TaxType').AsString = 'OUTPUT') then begin
              qryAddToTemp.FieldByName('OUTPUT_AmountEx').AsFloat   := qryAddToTemp.FieldByName('OUTPUT_AmountEx').AsFloat + qryTemp.FieldByName('AmountEx').AsFloat;
              qryAddToTemp.FieldByName('OUTPUT_AmountInc').AsFloat  := qryAddToTemp.FieldByName('OUTPUT_AmountInc').AsFloat + qryTemp.FieldByName('AmountInc').AsFloat;
            end else if (qryTemp.FieldByName('TaxType').AsString = 'INPUT') then begin
              qryAddToTemp.FieldByName('INPUT_AmountEx').AsFloat    := qryAddToTemp.FieldByName('INPUT_AmountEx').AsFloat + qryTemp.FieldByName('AmountEx').AsFloat;
              qryAddToTemp.FieldByName('INPUT_AmountInc').AsFloat   := qryAddToTemp.FieldByName('INPUT_AmountInc').AsFloat + qryTemp.FieldByName('AmountInc').AsFloat;
            end;
            qryAddToTemp.Post;
         end;
        qryTemp.Next;
        doStepProgressbar;
      end;
    finally
      doHideProgressbar;
    end;

    DoShowProgressbar(qryAddToTemp.REcordcount ,WAITMSG);
    try
      qryAddToTemp.First;
      while not qryAddToTemp.Eof do begin
        qryAddToTemp.Edit;
        qryAddToTemp.FieldByName('TotalNet').AsFloat :=
          qryAddToTemp.FieldByName('INPUT_AmountInc').AsFloat - qryAddToTemp.FieldByName('OUTPUT_AmountInc').AsFloat;
        qryAddToTemp.FieldByName('TotalTax').AsFloat :=
          (qryAddToTemp.FieldByName('INPUT_AmountEx').AsFloat - qryAddToTemp.FieldByName('OUTPUT_AmountEx').AsFloat) * qryAddToTemp.FieldByName('TaxRate').AsFloat;
        qryAddToTemp.Post;
        qryAddToTemp.Next;
        doStepProgressbar;
      end;
    finally
      doHideProgressbar;
    end;

    Result := True;
  finally
    FreeAndNil(qryTemp);
    FreeandNil(qryAddToTemp);
    Processingcursor(False);
  end;*)
end;

procedure TSubtaxSummaryreportGUI.RefreshQuery;
var
  dateFrom, dateTo: TDateTime;
begin
  ProcessingCursor(True);
  try
    if chkIgnoreDates.Checked then begin
      dateFrom := 0;
      dateTo := SysUtils.MaxDateTime;
    end
    else begin
      dateFrom := dtfrom.DateTime;
      dateTo := dtto.DateTime;
    end;
    If not CreateTaxSummaryTempTable(dateFrom, dateTo) then Begin
(*      Close;
      Exit;*)
    end;
    inherited;
    grdMain.columnbyName('INPUT_AmountEx').DisplayLabel   := 'INPUTS Ex (Purchases)';
    grdMain.columnbyName('INPUT_AmountInc').DisplayLabel  := 'INPUTS Inc (Purchases)';
    grdMain.columnbyName('OUTPUT_AmountEx').DisplayLabel  := 'OUTPUTS Ex  (Sales)';
    grdMain.columnbyName('OUTPUT_AmountInc').DisplayLabel := 'OUTPUTS Inc (Sales)';
    grdMain.columnbyName('TotalNet').DisplayLabel         := 'Total Net';
    grdMain.columnbyName('TotalTax').DisplayLabel         := 'Total Tax';
    RefreshTotals;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TSubtaxSummaryreportGUI.RefreshTotals;
begin
  CalcnShowFooter;
end;

procedure TSubtaxSummaryreportGUI.cmdPrintClick(Sender: TObject);
begin
  ReportSQLSupplied := true;
  TemplateSQL := 'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State,' +
                 ' CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN , ' +
                 Quotedstr(FormatDateTime('dd/mm/yyyy', dtfrom.DateTime)) + ' as DateFrom,"' + FormatDateTime('dd/mm/yyyy', dtto.DateTime) + '" as DateTo , ' +
                 'ID, TaxCode,subtaxcode, TaxRate,INPUT_AmountEx,INPUT_AmountInc,' + 'OUTPUT_AmountEx, OUTPUT_AmountInc,TotalNet,TotalTax ' +
                 ' FROM tblCompanyInformation AS CO, ' + TableName + ';';
  inherited;
  ReportSQLSupplied := false;
  TemplateSQL := '';
end;

function TSubtaxSummaryreportGUI.GetReportTypeID: integer;
begin
  Result := 42;
end;
procedure TSubtaxSummaryreportGUI.CalcFooter;
begin
  if QrymainDetails.asInteger <> 1 then exit;
  inherited;
end;

(*procedure TSubtaxSummaryreportGUI.MakeQrymain;
begin
    Tablename := GetUserTemporaryTableName('TaxSummaryReportdetails');
    Qrymain.SQL.clear;
    Qrymain.SQL.add('select ' );
    Qrymain.SQL.add('1                      as details,  ' );
    Qrymain.SQL.add('NULL                   as type,  ' );
    Qrymain.SQL.add('NULL                   as TransID,  ' );
    Qrymain.SQL.add('Taxcode                as TAxcode,  ' );
    Qrymain.SQL.add('null                   as subtaxcode, ' );
    Qrymain.SQL.add('sum(INPUT_AmountEx)    as INPUT_AmountEx, ' );
    Qrymain.SQL.add('sum(INPUT_AmountInc)   as INPUT_AmountInc, ' );
    Qrymain.SQL.add('sum(OUTPUT_AmountEx)   as OUTPUT_AmountEx, ' );
    Qrymain.SQL.add('sum(OUTPUT_AmountInc)  as OUTPUT_AmountInc, ' );
    Qrymain.SQL.add('sum(TotalNet)          as TotalNet, ' );
    Qrymain.SQL.add('sum(TotalTax)          as TotalTax, ' );
    Qrymain.SQL.add('T.taxrate*100          as Percentage' );
    Qrymain.SQL.add('from ' + tablename +'  T ' );
    Qrymain.SQL.add('group by  taxcode  ' );
    Qrymain.SQL.add('union all ' );
    Qrymain.SQL.add('select ' );
    Qrymain.SQL.add('2                      as Details, ' );
    Qrymain.SQL.add('"Sales"                as type,  ' );
    Qrymain.SQL.add('T.SaleId               as TransID,  ' );
    Qrymain.SQL.add('t.Taxcode              as Taxcode, ' );
    Qrymain.SQL.add('STL.SubTaxCode         as subTaxCode , ' );
    Qrymain.SQL.add('NULL                   as INPUT_AmountEx, ' );
    Qrymain.SQL.add('NULL                   as INPUT_AmountInc, ' );
    Qrymain.SQL.add('NULL                   as OUTPUT_AmountEx, ' );
    Qrymain.SQL.add('NULL                   as OUTPUT_AmountInc, ' );
    Qrymain.SQL.add('sum(0- STL.TaxAmount)  as totalNet , ' );
    Qrymain.SQL.add('sum(0- STL.TaxAmount)  as TotalTax , ' );
    Qrymain.SQL.add('STL.Percentage         as Percentage ' );
    Qrymain.SQL.add('from ' + tablename +'  T ' );
    Qrymain.SQL.add('inner join  tblsaleslines SL on T.SaleId = Sl.saleId and T.salelineId = sl.salelineId ' );
    Qrymain.SQL.add('inner join tblsalestaxcodes ST on SL.SaleLineID = ST.SaleLineId ' );
    Qrymain.SQL.add('inner join tblsalestaxcodelines STL on ST.ID = STL.SalesTaxCodeID ' );
    Qrymain.SQL.add('group by T.saleID, T.Taxcode, STL.SubTaxCode ' );
    Qrymain.SQL.add('union all ' );
    Qrymain.SQL.add('select ' );
    Qrymain.SQL.add('3                      as Details,' );
    Qrymain.SQL.add('"PO"                   as type,  ' );
    Qrymain.SQL.add('T.purchaseOrderID      as TransID,  ' );
    Qrymain.SQL.add('T.Taxcode              as Taxcode, ' );
    Qrymain.SQL.add('PTL.SubTaxCode         as subTaxCode , ' );
    Qrymain.SQL.add('NULL                   as INPUT_AmountEx, ' );
    Qrymain.SQL.add('NULL                   as INPUT_AmountInc, ' );
    Qrymain.SQL.add('NULL                   as OUTPUT_AmountEx, ' );
    Qrymain.SQL.add('NULL                   as OUTPUT_AmountInc, ' );
    Qrymain.SQL.add('Sum(PTL.TaxAmount)     as totalNet ,  ' );
    Qrymain.SQL.add('Sum(PTL.TaxAmount)     as TotalTax, ' );
    Qrymain.SQL.add('PTL.Percentage         as Percentage ' );
    Qrymain.SQL.add('from ' + tablename +'  T ' );
    Qrymain.SQL.add('inner join  tblpurchaselines PL on pl.purchaseorderId = t.purchaseorderId and Pl.purchaselineId = t.purchaselineId ' );
    Qrymain.SQL.add('inner  join tblpurchasetaxcodes PT on PL.PurchaseLineID= PT.PurchaseLineId ' );
    Qrymain.SQL.add('inner  join tblpurchasetaxcodelines PTL on PT.ID = PTL.PurchaseTaxCodeID ' );
    Qrymain.SQL.add('group by T.purchaseORderId, T.Taxcode, PTL.SubTaxCode' );
    Qrymain.SQL.add('order by type, TransID, Taxcode, details, subtaxcode');
end;*)
procedure TSubtaxSummaryreportGUI.FormCreate(Sender: TObject);
begin
  Tablename := GetUserTemporaryTableName('TaxSummaryReportdetails')+tablenamePrefix;;
  makeQrymain;
  inherited;
  //Addcalccolumn(qryMainTotalNet.FieldName, true);
  Addcalccolumn(qryMainTotalTax.FieldName, true);
  ShowChartViewOnPopup := True;
end;

procedure TSubtaxSummaryreportGUI.FormDestroy(Sender: TObject);
begin
  commondblib.DestroyUserTemporaryTable(Tablename);
  commondblib.DestroyUserTemporaryTable(Tablename+'1');
  inherited;
end;

procedure TSubtaxSummaryreportGUI.DateChange(var Message: TMessage);
begin
  if not (dtTo.DroppedDown or dtFrom.DroppedDown) then begin
    RefreshQuery;
  end;
end;

procedure TSubtaxSummaryreportGUI.btnSalesTaxRptClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSalesTaxReportGUI', beforeshowSalesTaxrpt)
end;
procedure TSubtaxSummaryreportGUI.beforeshowSalesTaxrpt(Sender: TObject);
begin
  copyParamsto(Sender);
end;

procedure TSubtaxSummaryreportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
    if (QrymainDetails.AsInteger = 1) and (grpfilters.itemindex<>0) then begin
      Afont.Style := Afont.Style  + [fsbold];
    end else begin
      Afont.Style := Afont.Style  - [fsbold];
    end;

end;

procedure TSubtaxSummaryreportGUI.grdMainDblClick(Sender: TObject);
begin
  if grpSumOption.itemindex = 1 then
    MessageDlg('Details can be viewed only for the main taxcode amount', mtInformation, [mbOK], 0)
  else if (grpFilters.itemindex <> 0) and (Qrymaindetails.asInteger <> 1) then
    MessageDlg('Details can be viewed only for the main taxcode amount', mtInformation, [mbOK], 0)
  else
    OpenERPListForm('TTransAccountDetailsGUI' ,beforeshowTransAccountDetailsGUI );
end;

procedure TSubtaxSummaryreportGUI.grpFiltersClick(Sender: TObject);
begin
  case grpFilters.ItemIndex of
    0:  GroupFilterString :=  'Details =1 ';
    1:  GroupFilterString :=  'Details =1  or Details = 2 ';
    2:  GroupFilterString :=  'Details =1  or Details = 3';
  end;
  inherited;

end;

procedure TSubtaxSummaryreportGUI.grpSumOptionClick(Sender: TObject);
begin
  inherited;
  if grpSumOption.ItemIndex = 0 then begin
    OpenERPListForm('TSubtaxSummaryreport_MainTaxCodeGUI' , CopyfilterParams)
  end else begin
    OpenERPListForm('TSubtaxSummaryreport_SubTaxCodeGUI' , CopyfilterParams)
  end;
  Self.Close;
end;
procedure TSubtaxSummaryreportGUI.MakeQrymain;
begin
    Qrymain.SQL.clear;
    Qrymain.SQL.add('select ' );
    Qrymain.SQL.add('Details          as Details, ' );
    Qrymain.SQL.add('type             as type,  ' );
    Qrymain.SQL.add('TransId        as TransID,  ' );
    Qrymain.SQL.add('Taxcode          as Taxcode, ' );
    Qrymain.SQL.add('subTaxCode     as subTaxCode , ' );
    Qrymain.SQL.add('sum(INPUT_AmountEx)   as INPUT_AmountEx, ' );
    Qrymain.SQL.add('sum(INPUT_AmountInc)  as INPUT_AmountInc, ' );
    Qrymain.SQL.add('sum(OUTPUT_AmountEx)  as OUTPUT_AmountEx, ' );
    Qrymain.SQL.add('sum(OUTPUT_AmountInc) as OUTPUT_AmountInc, ' );
    Qrymain.SQL.add('sum(totalNet)    as totalNet , ' );
    Qrymain.SQL.add('sum(TotalTax)    as TotalTax , ' );
    Qrymain.SQL.add('Percentage       as Percentage, ' );
    Qrymain.SQL.add('"" as Street,');
    Qrymain.SQL.add('"" as Street2,');
    Qrymain.SQL.add('"" as Suburb,');
    Qrymain.SQL.add('"" as State,');
    Qrymain.SQL.add('"" as Country,');
    Qrymain.SQL.add('"" as PostCode');
    Qrymain.SQL.add('from ' + tablename +'1  T Where details =1 ' );
    Qrymain.SQL.add('group by Taxcode ,subTaxCode ' );

    Qrymain.SQL.add('union all ' );
    Qrymain.SQL.add('select ' );
    Qrymain.SQL.add('Details          as Details, ' );
    Qrymain.SQL.add('type             as type,  ' );
    Qrymain.SQL.add('TransId        as TransID,  ' );
    Qrymain.SQL.add('Taxcode          as Taxcode, ' );
    Qrymain.SQL.add('subTaxCode     as subTaxCode , ' );
    Qrymain.SQL.add('sum(INPUT_AmountEx)   as INPUT_AmountEx, ' );
    Qrymain.SQL.add('sum(INPUT_AmountInc)  as INPUT_AmountInc, ' );
    Qrymain.SQL.add('sum(OUTPUT_AmountEx)  as OUTPUT_AmountEx, ' );
    Qrymain.SQL.add('sum(OUTPUT_AmountInc) as OUTPUT_AmountInc, ' );
    Qrymain.SQL.add('sum(totalNet)    as totalNet , ' );
    Qrymain.SQL.add('sum(TotalTax)    as TotalTax , ' );
    Qrymain.SQL.add('Percentage       as Percentage, ' );
    Qrymain.SQL.add('"" as Street,');
    Qrymain.SQL.add('"" as Street2,');
    Qrymain.SQL.add('"" as Suburb,');
    Qrymain.SQL.add('"" as State,');
    Qrymain.SQL.add('"" as Country,');
    Qrymain.SQL.add('"" as PostCode');
    Qrymain.SQL.add('from ' + tablename +'1  T Where details =2 ' );
    Qrymain.SQL.add('group by Taxcode ,subTaxCode' );

    Qrymain.SQL.add('union all ' );
    Qrymain.SQL.add('select ' );
    Qrymain.SQL.add('T.Details          as Details, ' );
    Qrymain.SQL.add('T.type             as type,  ' );
    Qrymain.SQL.add('TransId        as TransID,  ' );
    Qrymain.SQL.add('T.Taxcode          as Taxcode, ' );
    Qrymain.SQL.add('T.subTaxCode     as subTaxCode , ' );
    Qrymain.SQL.add('sum(T.INPUT_AmountEx)   as INPUT_AmountEx, ' );
    Qrymain.SQL.add('sum(T.INPUT_AmountInc)  as INPUT_AmountInc, ' );
    Qrymain.SQL.add('sum(T.OUTPUT_AmountEx)  as OUTPUT_AmountEx, ' );
    Qrymain.SQL.add('sum(T.OUTPUT_AmountInc) as OUTPUT_AmountInc, ' );
    Qrymain.SQL.add('sum(T.totalNet)    as totalNet , ' );
    Qrymain.SQL.add('sum(T.TotalTax)    as TotalTax , ' );
    Qrymain.SQL.add('T.Percentage       as Percentage, ' );
    Qrymain.SQL.add('if(not isnull(SC.ClientID),SC.Street,if(not isnull(PC.ClientID),PC.Street,"")) as Street,');
    Qrymain.SQL.add('if(not isnull(SC.ClientID),SC.Street2,if(not isnull(PC.ClientID),PC.Street2,"")) as Street2,');
    Qrymain.SQL.add('if(not isnull(SC.ClientID),SC.Suburb,if(not isnull(PC.ClientID),PC.Suburb,"")) as Suburb,');
    Qrymain.SQL.add('if(not isnull(SC.ClientID),SC.State,if(not isnull(PC.ClientID),PC.State,"")) as State,');
    Qrymain.SQL.add('if(not isnull(SC.ClientID),SC.Country,if(not isnull(PC.ClientID),PC.Country,"")) as Country,');
    Qrymain.SQL.add('if(not isnull(SC.ClientID),SC.PostCode,if(not isnull(PC.ClientID),PC.PostCode,"")) as PostCode');
    Qrymain.SQL.add('from ' + tablename +'1  T ' );
    Qrymain.SQL.add('left join tblsales S on T.type = "Sales" and T.TransId > 0 and S.SaleID = T.TransID');
    Qrymain.SQL.add('left join tblClients SC on S.ClientID = SC.ClientID');
    Qrymain.SQL.add('left join tblpurchaseorders P on T.type = "PO" and T.TransId > 0 and P.PurchaseOrderID = T.TransID');
    Qrymain.SQL.add('left join tblClients PC on P.ClientID = PC.ClientID');
    Qrymain.SQL.add('Where details =3 ');
    Qrymain.SQL.add('group by SubTaxCode, Taxcode, TransId' );
    //Qrymain.SQL.add('order by type, TransID, Taxcode, details, subtaxcode');
end;

Procedure TSubtaxSummaryreportGUI.CopyfilterParams(sender:TObject);
begin
  inherited;
    opendb(TSubtaxSummaryreportGUI(Sender).cboClassQry);
    TSubtaxSummaryreportGUI(Sender).cboClassQry.Locate('ClassName', cboClass.Text, [loCaseInsensitive]);
    TSubtaxSummaryreportGUI(Sender).cboClass.LookupValue  := cboClass.text;
    TSubtaxSummaryreportGUI(Sender).chkAllClass.Checked   := chkAllClass.checked;
    TSubtaxSummaryreportGUI(Sender).cboClass.Enabled      := cboClass.Enabled;
end;
procedure TSubtaxSummaryreportGUI.beforeshowTransAccountDetailsGUI(Sender: TObject);
begin
      with  TTransAccountDetailsGUI(Sender) do begin
        ToDate := self.dtTo.DateTime;
        FromDate := self.dtFrom.DateTime;
        fbDateRangeSupplied := true;
        qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_DebitsEx', 'DebitsEx');
        qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_CreditsEx', 'CreditsEx');
        qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_DebitsInc', 'DebitsInc');
        qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_CreditsInc', 'CreditsInc');
        qryMain.SQL.Add('AND (AccountName<>"Tax Paid" AND AccountName<>"Tax Collected") AND TaxCode = ' +
          QuotedStr(self.qryMainTaxCode.AsString) + ' Group by TransID;');
        WhereString := 'AND (AccountName<>"Tax Paid" AND AccountName<>"Tax Collected") ';
        if self.qryMainTaxCode.AsString    <> '' then WhereString := WhereString + ' AND ( TaxCode    = ' + QuotedStr(self.qryMainTaxCode.AsString) + ' )';
        //if self.Qrymainsubtaxcode.AsString <> '' then WhereString := WhereString + ' AND ( SubTaxCode = ' + QuotedStr(self.Qrymainsubtaxcode.AsString) + ' )';
        //FormStyle := fsmdiChild;
      end;
end;

procedure TSubtaxSummaryreportGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;
  RefreshQuery;
end;

procedure TSubtaxSummaryreportGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TSubtaxSummaryreportGUI.FormShow(Sender: TObject);
begin
  if cboClassQry.active = False then begin
    cboClassQry.Open;
    cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
    cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
    chkAllClass.Checked := true;
    cboClass.Enabled := false;
  end;
  inherited;
end;

end.
