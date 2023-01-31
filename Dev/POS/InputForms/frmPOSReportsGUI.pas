unit frmPOSReportsGUI;
{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 02/06/05  1.00.01 RM  deleted function that wrote to tblsales and used a tmp_sales
                       to avoid record locking and overcome the lack of a timeOfsale:DateTime
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls,StdCtrls,
  MemDS,DateUtils, DNMPanel, DNMSpeedButton, ImgList, ProgressDialog;

type
  TfrmPOSReports = class(TBaseInputGUI)
    qryEOP: TERPQuery;
    btnPrint: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edPeriodID: TEdit;
    edStart: TEdit;
    edEnd: TEdit;
    qryEOPPeriodID: TIntegerField;
    qryEOPGlobalRef: TWideStringField;
    qryEOPStartDate: TDateTimeField;
    qryEOPEndDate: TDateTimeField;
    qryEOPTillID: TIntegerField;
    qryEOPTillName: TWideStringField;
    ChkChooseRpt: TCheckBox;
    btnList: TDNMSpeedButton;
    optReports: TRadioGroup;
    chkPreview: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPrintClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnListClick(Sender: TObject);
    procedure optReportsClick(Sender: TObject);
  private
    tmp_tblsales: string;
    procedure PrintEOPProductSalesReport;
    procedure PrintEOPDailyBalance;
    procedure CreateTmp_tblsales;
    procedure DeleteTmp_tblsales;
    procedure AddDataToTmp_tblsales;
    Procedure PrintDailySalesStatistics;
    Procedure PrintProductGroupreport;
    function IsProductsalesreportSelected:Boolean;
    Function IsDailyBalanceWorkSheetSelected:Boolean;
    function IsDailySalesStatisticsSelected:boolean;
    function ISProductGroupReportSelected:boolean;
    Procedure  TemplateToPrint;
    Procedure ReadGuiprefs;
    Procedure WriteGuiPrefs;
    procedure initDailySalesStatistics(Sender: TObject);

  Protected
    Function GetReportTypeID:Integer ; override;
  public
    { Public declarations }
  end;

implementation
uses FastFuncs,FormFactory,CommonDbLib,  AppEnvironment, CommonLib,
  ReportTemplates, MySQLConst, tcDataUtils, POSLIB, CommonFormLib,
  DailySalesStatistics, tcConst, POSList;
{$R *.dfm}

procedure TfrmPOSReports.PrintEOPProductSalesReport;
var
  strSQL:String;

begin
  strSQL :=
    '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN '+
    ' FROM tblCompanyInformation AS CO   '+
    ' ~|||~{Details}SELECT SaleDate,  TimeOfSale , ' + tmp_tblSales + ' .GlobalRef, ' +
    'TotalLineAmountInc, PayMethod, ProductName, QtySold,Product_Description, ' +
    'tblpostills.TillName ' +
    'from tblSalesLines INNER JOIN  ' + tmp_tblSales  + ' ' +
    'ON tblSalesLines.SaleID = ' + tmp_tblSales + '.SaleID ' +
    'INNER JOIN tblpostills ON ' + tmp_tblSales + '.TillID = tblpostills.TillID ' +
    'WHERE IsLayby = "F" and IsPOS = "T" ' ;

  strSQL := strSQL+
    '~|||~{TransComments}SELECT C.Comments ' +
    ' FROM tblComments C ' +
    ' inner join tbltranscomments TC on C.CommentsID = TC.CommentID ' +
    ' inner join ' + tmp_tblSales  + ' S on S.SaleId = TC.TRansID ' +
    ' where TC.Transtype = ' + quotedstr('POS')+' ORDER BY S.SaleId,seqno';

  fbReportSQLSupplied := true;
  PrintTemplateReport(Reporttoprint , strSQL , not(Devmode) and not(chkPreview.checked) , 1);

(*var
  sReportName   : String;
  Templates : TReportTemplates;
begin

// Print Sale Report

  sReportName := 'Pos';
  Templates := TReportTemplates.Create;
  with Templates do try
      if not CreatedOk then exit;
      with GetMyQuery(2) do begin
        Close;
        GetSQLForReport(sReportName); // creates report stream
        Sql.Clear;

        Sql.Add('SELECT SaleDate,  TimeOfSale , ' + tmp_tblSales + ' .GlobalRef, ' +
          'TotalLineAmountInc, PayMethod, ProductName, QtySold,Product_Description, ' +
          'tblpostills.TillName ' +
          'from tblSalesLines INNER JOIN  ' + tmp_tblSales  + ' ' +
          'ON tblSalesLines.SaleID = ' + tmp_tblSales + '.SaleID ' +
          'INNER JOIN tblpostills ON ' + tmp_tblSales + '.TillID = tblpostills.TillID ' +
          'WHERE IsLayby = "F" and IsPOS = "T" ' +
          'AND  SaleDateTime  BETWEEN ');

        Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm:ss', Self.qryEOP.FieldByName('StartDate').AsDateTime)));
        Sql.Add(' AND ');
        Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm:ss', Self.qryEOP.FieldByName('EndDate').AsDateTime)));
        Sql.Add('and ' + tmp_tblSales+ ' .TillID = ' + IntToStr(Self.qryEOP.FieldByName('TillID').asInteger));

        Open;
        Application.ProcessMessages;
      end;

      Report.Template.LoadFromStream(ReportStream);

    //  if AppEnv.Employee.ShowPreview <> True then begin
    if devmode then
      Report.DeviceType := 'Screen'
    else
      Report.DeviceType := 'Printer';

        Report.ShowPrintDialog := AppEnv.Employee.ShowPrintDialog;
    //  end else begin
     //   Report.DeviceType := 'Screen';
    //  end;

      Try
        Report.Print;
      except
        on E: Exception do begin
          If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
            CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
          end else
            raise;
        end;
      end;

      Application.ProcessMessages;

    finally
      FreeAndNil(Templates);
    end;*)

end;

procedure TfrmPOSReports.ReadGuiprefs;
begin
  if guiprefs.active =False then guiprefs.active:= True;
  if GuiPrefs.Node.Exists('General') then begin
    chkChooseRpt.checked  := StrToBoolean(GuiPrefs.Node['General.ChooseTemplate'].AsString);
    OptReports.itemindex  :=  OptReports.items.IndexOf(GuiPrefs.Node['General.ReportName'].AsString);
    chkPreview.checked    := StrToBoolean(GuiPrefs.Node['General.ShowPreview'].AsString);
  end;
end;
Procedure TfrmPOSReports.PrintProductGroupreport;
var
  strSQL:String;
begin
  strSQL:= SalesCollatedByItemReportSQL(IntToStr(qryEOP.FieldByName('TillID').AsInteger), reporttoprint,   qryEOPStartDate.AsDateTime , qryEOPEndDate.AsDateTime);
  fbReportSQLSupplied := True;
  PrintTemplateReport(ReportToPrint , strSQL , not(Devmode) and not(chkPreview.checked) , 1);
end;

procedure TfrmPOSReports.PrintDailySalesStatistics;
var
  tablename :String;
  strSQL:String;
begin
  MakeHourlySalesStatistics(tablename , qryeopstartdate.asDatetime, qryeopenddate.asDatetime , Qryeoptillid.asInteger);
  strSQL:= DailyStatisticsReportSQL(Tablename, qryeopstartdate.asDatetime , qryeopenddate.asDatetime);
  fbReportSQLSupplied := True;
  PrintTemplateReport(ReportToPrint , strSQL , not(Devmode) and not(chkPreview.checked) , 1);
end;

procedure TfrmPOSReports.PrintEOPDailyBalance;

var
  NumOfTransactions     : integer;
  QtyExRounding         : integer;
  sTempTblName          : string;
  Templates             :TReportTemplates;

  procedure CreateTempPaymentsTable;
  var
    qry: TERPCommand;
  begin
    sTempTblName := 'tmp_tblposeoppayments_' + IntToStr(qryEOP.FieldByName('TillID').AsInteger);

    qry := TERPCommand.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      // delete previos temp table, if exists
      qry.Sql.Add('DROP TABLE IF EXISTS ' + sTempTblName + '; ');
      qry.Execute;

      // create temp payments table
      qry.Sql.Clear;

      qry.SQL.Add(' CREATE TABLE ' + sTempTblName + ' ( ');
      qry.SQL.Add('  `ID` int(10) NOT NULL auto_increment, ');
      qry.SQL.Add('  PRIMARY KEY  (`ID`)) ');
      qry.Sql.Add('SELECT p.PayMethod, p.Amount from tblSalesPayments as p ' +
        'INNER JOIN ' + tmp_tblSales + ' ' +
        'ON p.SaleID = ' + tmp_tblSales + '.SaleID ' +
        'where IsLayby <> "T" AND IsInvoice <> "T" and ' + tmp_tblSales+ '.Deleted <> "T" and ' +
        'p.Deleted <> "T" and IsPOS = "T" ' +
        'AND TillID = ' + IntToStr(qryEOP.FieldByName('TillID').AsInteger) +
        ' AND SaleDateTime BETWEEN ');
         qry.Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('StartDate').AsDateTime)));
         qry.Sql.Add(' AND ');
         qry.Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('EndDate').AsDateTime)));

      qry.SQL.Add('UNION ALL');
      qry.Sql.Add('SELECT PayMethod, Amount from tblPosEopPayments ' +
        'WHERE TillID = ' + IntToStr(qryEOP.FieldByName('TillID').AsInteger));
      qry.Execute;

    finally
      FreeAndNil(qry);
    end;
  end;

begin
          CreateTempPaymentsTable;
          try

          //### Print Summary Report ########
          Templates := TReportTemplates.Create;
          with Templates do try
              if not CreatedOk then exit;
              with GetMyQuery(1) do begin
                Close;
                GetSQLForReport(Reporttoprint); // creates  report stream
                Sql.Clear;
                Sql.Add('SELECT Count(*) AS NumOfTrans FROM ' + tmp_tblSales + ' ' +
                  'WHERE IsLayby = "F" AND Deleted = "F" ' +
                  'AND IsPOS = "T" ' + 'AND TillID = ' + IntToStr(qryEOP.FieldByName('TillID').AsInteger));

                (*Sql.Add(' AND  SaleDateTime  BETWEEN ');
                Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('StartDate').AsDateTime)));
                Sql.Add(' AND ');
                Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('EndDate').AsDateTime)));*)

                Open;
                NumOfTransactions := FieldByName('NumOfTrans').AsInteger;

                Sql.Clear;

                Sql.Add('SELECT "Net Sales" as Title, Count(*) as NumOfTrans, ' +
                  '"        " as Percent, SUM(Shipped) as Qty, ' +

                  'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmountInc),2)) as AmountInc, ' +
                  '"       " as Percent2, ' +
                  'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmount),2)) as AmountEx, "       " as Percent3, ' +
                  '"1" as Dummy, ' + QuotedStr(qryEOP.FieldByName('TillName').AsString) + ' as Till, ' +
                  'ProductName ' +
                  'from tblSalesLines INNER JOIN ' + tmp_tblSales + ' ' +
                  'ON tblSalesLines.SaleID = ' + tmp_tblSales + '.SaleID ' +
                  'where IsLayby = "F" and ' + tmp_tblSales + '.Deleted = "F" ' +
                  'and tblSalesLines.Deleted = "F" and IsPOS = "T" ' +
                  'AND TillID = ' + IntToStr(qryEOP.FieldByName('TillID').AsInteger) + ' AND ProductName <> "Rounding" ');
                (*Sql.Add(' AND  SaleDateTime  BETWEEN ');
                Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('StartDate').AsDateTime)));
                Sql.Add(' AND ');
                Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('EndDate').AsDateTime)));*)
                Sql.Add('GROUP BY Title');
                Open;
                QtyExRounding := FieldByName('Qty').AsInteger;

                Sql.Clear;

                Sql.Add('SELECT "                           " as Title, ' +
                  '"          " as NumOfTrans, "        " as Percent, ' +
                  '"        " as Qty, ' +
                  '"            " as AmountInc, "       " as Percent2, ' +
                  '"            " as AmountEx, "       " as Percent3, ' +
                  '"1" as Dummy, ');
                Sql.Add(QuotedStr(qryEOP.FieldByName('TillName').AsString) +
                  'as Till');//from tblSalesLines ');
                Sql.Add('UNION ');

                // net sales
                Sql.Add('SELECT "Net Sales" as Title, ' + IntToStr(NumOfTransactions) + ' as NumOfTrans, ' +
                  '"        " as Percent, ' + IntToStr(QtyExRounding) + ' as Qty, ' +
                  'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmountInc),2)) as AmountInc, ' +
                  '"       " as Percent2, ' +

                  'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmount),2)) as AmountEx, "       " as Percent3, ' +
                  '"2" as Dummy, ' + QuotedStr(qryEOP.FieldByName('TillName').AsString) + ' as Till ' +
                  'from tblSalesLines INNER JOIN ' + tmp_tblSales  + ' ' +
                  'ON tblSalesLines.SaleID = ' + tmp_tblSales + '.SaleID ' +
                  'where IsLayby = "F" and ' + tmp_tblSales + '.Deleted = "F" ' +
                  'and tblSalesLines.Deleted = "F" and IsPOS = "T" ' +
                  'AND TillID = ' + IntToStr(qryEOP.FieldByName('TillID').AsInteger) );
                (*Sql.Add('AND  SaleDateTime  BETWEEN ');
                Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('StartDate').AsDateTime)));
                Sql.Add(' AND ');
                Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('EndDate').AsDateTime)));*)
                Sql.Add('GROUP BY Title');

                Sql.Add(' UNION ');

                // blank line
                Sql.Add('SELECT "" as Title, "" as NumOfTrans, "" as Percent, ' +
                  '"" as Qty, "" as AmountInc, "" as Percent2, ' +
                  '"" as AmountEx, "" as Percent3, "3" As Dummy, ' +
                  '' + QuotedStr(qryEOP.FieldByName('TillName').AsString) + ' as Till ');//from tblSalesLines ');
                Sql.Add(' UNION ');

                // taxable sales
                Sql.Add('SELECT "Taxable Sales" as Title, "" as NumOfTrans, ' +
                  '" " as Percent, " " as Qty, ' +
                  'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmountInc),2)) as AmountInc, "100%" as Percent2, ' +
                  'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmount),2)) as AmountEx, "100%" as Percent3, ' +
                  '"4" as Dummy, ' + QuotedStr(qryEOP.FieldByName('TillName').AsString) + ' AS Till ' +
                  ' from tblSalesLines INNER JOIN ' + tmp_tblSales  + ' ' +
                  'ON tblSalesLines.SaleID = ' + tmp_tblSales + '.SaleID ' +
                  'where IsLayby = "F" and ' + tmp_tblSales + '.Deleted = "F" and ' +
                  'tblSalesLines.Deleted = "F" and IsPOS = "T" and ' +
                  'LineTaxRate <> 0.0 AND TillID = ' + IntToStr(qryEOP.FieldByName('TillID').AsInteger));
(*                Sql.Add(' AND  SaleDateTime  BETWEEN ');
                Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('StartDate').AsDateTime)));
                Sql.Add(' AND ');
                Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('EndDate').AsDateTime)));*)

                Sql.Add(' UNION  ');

                // Tax Collected
                Sql.Add('SELECT "Tax Collected" as Title, "" as NumOfTrans, ' +
                  '"" as Percent, "" as Qty, "" as AmountInc, "" as Percent2, ' +
                  'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format((SUM(LineTax)*100/100),2)) as AmountEx, ' +
                  '"10%" as Percent3, "5" as Dummy, ' + QuotedStr(qryEOP.FieldByName('TillName').AsString) + ' as Till ' +
                  ' from tblSalesLines ' +
                  'INNER JOIN ' + tmp_tblSales + ' ' +
                  'ON tblSalesLines.SaleID = ' + tmp_tblSales + '.SaleID ' +
                  'where IsLayby = "F" and ' + tmp_tblSales + '.Deleted = "F" and ' +
                  'tblSalesLines.Deleted = "F" and IsPOS = "T" and ' +
                  'TillID = ' + IntToStr(qryEOP.FieldByName('TillID').AsInteger));
(*                Sql.Add(' AND  SaleDateTime  BETWEEN ');
                Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('StartDate').AsDateTime)));
                Sql.Add(' AND ');
                Sql.Add(QuotedStr(FormatDateTime('yyyy-mm-dd h:mm:ss AM/PM', Self.qryEOP.FieldByName('EndDate').AsDateTime)));*)

                Sql.Add(' UNION  ');

                // Account Payments
                Sql.Add('SELECT "Account Payments" as Title, Count(*) as NumOfTrans, ' +
                  '"" as Percent, " " as Qty, ' +
                  'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(Amount),2)) as AmountInc, ' +
                  '"" as Percent2, ' +
                  '"" as AmountEx, "       " as Percent3, ' +
                  '"6" as Dummy, ' + QuotedStr(qryEOP.FieldByName('TillName').AsString) + ' as Till ' +
                  'from tblPosEopPayments ' +
                  'WHERE TillID = ' + IntToStr(qryEOP.FieldByName('TillID').AsInteger) + ' GROUP BY Title');
                Sql.Add(' UNION ');

                // blank line
                Sql.Add('SELECT "" as Title, "" as NumOfTrans, ' +
                  '"" as Percent, "" as Qty, ' +
                  '"" as AmountInc, "" as Percent2, ' +
                  '"" as AmountEx, "" as Percent3, "7" As Dummy, ' + QuotedStr(qryEOP.FieldByName('TillName').AsString) + ' As Till ');
                Sql.Add(' UNION ');

                // payments
                Sql.Add('SELECT PayMethod as Title, Count(*) as NumOfTrans, ' +
                  '"" as Percent, "" as Qty, ' +
                  'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(Amount),2)) as AmountInc, "" as Percent2, ' +
                  '"" as AmountEx, "" as Percent3, "8" as Dummy, ' + QuotedStr(qryEOP.FieldByName('TillName').AsString) + ' as Till ' +
                  'FROM ' + sTempTblName +
                  ' GROUP BY PayMethod UNION ');

                // total in drawer
                Sql.Add('SELECT "Total in Drawer" as Title, "" as NumOfTrans,  ' +
                  '"" as Percent, "" as Qty, ' +
                  'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(Amount),2)) as AmountInc, "" as Percent2, ' +
                  '"" as AmountEx, "" as Percent3, "9" As Dummy, ' + QuotedStr(qryEOP.FieldByName('TillName').AsString) + ' as Till ' +
                  'FROM ' + sTempTblName);
                Open;
                Application.ProcessMessages;
              end;

              Report.Template.LoadFromStream(ReportStream);

              if (AppEnv.Employee.ShowPreview <> True) and (not(devmode)) then begin
                Report.DeviceType := 'Printer';
                Report.ShowPrintDialog := AppEnv.Employee.ShowPrintDialog;
              end else begin
                Report.DeviceType := 'Screen';
              end;


              Try
                Report.Print;
              except
                on E: Exception do begin
                  If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
                    CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
                  end else
                    raise;
                end;
              end;

              Application.ProcessMessages;
            finally
              FreeAndNil(Templates);
            end;
          finally
              CommonDbLib.DestroyUserTemporaryTable(sTempTblName);
          end;

end;

procedure TfrmPOSReports.FormActivate(Sender: TObject);
begin
  inherited;
  Self.qryEOP.Params.ParamByName('xKeyID').asInteger := KeyID;
  Self.qryEOP.Open;

end;

procedure TfrmPOSReports.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
    Action := caFree;
end;

procedure TfrmPOSReports.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   WriteGuiprefs;
   inherited;
end;

procedure TfrmPOSReports.FormCreate(Sender: TObject);
begin
  inherited;
  tmp_tblSales := 'tmp_tblSales_' + GetTemporaryTableNameSuffix;
end;

procedure TfrmPOSReports.btnPrintClick(Sender: TObject);
begin
  TemplateToPrint;
  if Reporttoprint ='' then exit;

  DisableForm;
  try
    inherited;
    if SAmetext(OptReports.items[OptReports.itemindex ] , 'Product Sales Report') then begin
      PrintEOPProductSalesReport;
    end else if SAmetext(OptReports.items[OptReports.itemindex ]  , 'Daily Balance Work Report') then begin
      PrintEOPDailyBalance;
    end else if SAmetext(OptReports.items[OptReports.itemindex ]  , 'Daily Sales Statistics') then begin
      PrintDailySalesStatistics;
    end else if SAmetext(OptReports.items[OptReports.itemindex ]  , 'Product Group Report') then begin
      PrintProductGroupreport;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmPOSReports.btnCancelClick(Sender: TObject);
begin
  inherited;
  DeleteTmp_tblsales;
  Close;
end;

procedure TfrmPOSReports.btnListClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TDailySalesStatisticsGUI' , initDailySalesStatistics);
end;
procedure TfrmPOSReports.initDailySalesStatistics(Sender: TObject);
begin
  if not(Sender is TDailySalesStatisticsGUI) then exit;
  TDailySalesStatisticsGUI(sender).dtTo.datetime := QryEOPStartDate.AsDateTime;
end;
procedure TfrmPOSReports.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    ReadGuiprefs;
    edPeriodID.Text := IntToStr(KeyID);
    edStart.Text    := FormatDateTime('dd-mm-yyyy hh:mm:ss', POSEOPStarttime(Self.qryEOP.FieldByName('StartDate').AsDateTime));
    edEnd.Text      := FormatDateTime('dd-mm-yyyy hh:mm:ss', POSEOPEndtime(Self.qryEOP.FieldByName('EndDate').AsDateTime));
    CreateTmp_tblsales;
    AddDataToTmp_tblsales;
    btnList.hint := 'This will open the ''Daily Statistics'' for the EOP date - '+Quotedstr(formatDateTime(FormatSettings.shortdateformat , Qryeopstartdate.asDateTime))+NL+
                    'ie, Data of all EOPs done on '+Quotedstr(formatDateTime(FormatSettings.shortdateformat , Qryeopstartdate.asDateTime))+' and all Sales to be processed'+NL;

  finally
    EnableForm;
  end;
end;


procedure TfrmPOSReports.CreateTmp_tblsales;
var
  qry: TERPQuery;
  begin

    qry := TERPQuery.Create(Self);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      // delete previous temp table, if exists
      qry.Sql.Add('DROP TABLE IF EXISTS ' + tmp_tblsales);
      qry.Execute;

      // create temp payments table
      qry.Sql.Clear;

      qry.SQL.Add(' CREATE TABLE ' + tmp_tblsales + ' ( ');
      qry.SQL.Add('  `ID` int(10) NOT NULL auto_increment, ');

      qry.SQL.Add('  `SaleID` int(10) unsigned, ');
      qry.Sql.Add('`GlobalRef` varchar(32) default NULL, ');
      qry.Sql.Add('`SaleDate` date default NULL, ');
      qry.Sql.Add('`TimeOfSale` varchar(32) default NULL, ');
      qry.Sql.Add('`SaleDateTime` datetime default NULL, ');
      qry.Sql.Add('`PayMethod` varchar(32) default NULL, ');
      qry.Sql.Add('`IsLayby` varchar(32) default NULL, ');
      qry.Sql.Add('`IsPOS` varchar(32) default NULL, ');
      qry.Sql.Add('`Deleted` varchar(32) default NULL, ');
      qry.Sql.Add('`IsInvoice` varchar(32) default NULL, ');
      qry.Sql.Add('`TillID` varchar(32) default NULL, ');

      qry.SQL.Add('  PRIMARY KEY  (`ID`) ');
      qry.Sql.Add(') ENGINE=InnoDB; ');


      qry.Execute;
    finally

    end;
end;

procedure TfrmPOSReports.AddDataToTmp_tblsales;
var
  cmd: TERPCommand;
begin
  cmd := TERPCommand.Create(Self);
  cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    if not qryEOP.Active then qryEOP.Open;
    (*cmd.SQL.Add('INSERT HIGH_PRIORITY INTO ' + tmp_tblsales + '(SaleID,GlobalRef,SaleDate,TimeOfSale,');
    cmd.SQL.Add('PayMethod,IsLayby,IsPOS,Deleted,IsInvoice,TillID)');

    cmd.Sql.Add('SELECT S.SaleID,S.GlobalRef,');
    cmd.Sql.Add('S.SaleDate, ');
    cmd.Sql.Add('S.TimeOfSale, ');
    cmd.Sql.Add('S.PayMethod,S.IsLayby,S.IsPOS,S.Deleted,S.IsInvoice,S.TillID ');
    cmd.Sql.Add('FROM   tblsales S WHERE S.IsPos = "T"');                            IncDay(Date, - 1);
    cmd.Sql.Add(' AND S.SaleDatetime BETWEEN ');
    cmd.Sql.Add(QuotedStr(FormatDateTime(MysqlDatetimeFormat, Self.qryEOP.FieldByName('StartDate').AsDateTime)));
    cmd.Sql.Add(' AND ');
    cmd.Sql.Add(QuotedStr(FormatDateTime(MysqlDatetimeFormat, Self.qryEOP.FieldByName('EndDate').AsDateTime)) + ';');
    cmd.Sql.Add('update ' + tmp_tblsales + ' set saledatetime = AddTime(saleDate, TimeOfSale);');*)
    cmd.SQL.Add('INSERT HIGH_PRIORITY INTO ' + tmp_tblsales +
                '(SaleDateTime, SaleID,GlobalRef,SaleDate,TimeOfSale,PayMethod,IsLayby,IsPOS,Deleted,IsInvoice,TillID)');
    cmd.Sql.Add('SELECT s.SaleDatetime , S.SaleID,S.GlobalRef,');
    cmd.Sql.Add('S.SaleDate,');
    cmd.Sql.Add('S.TimeOfSale,');
    cmd.Sql.Add('S.PayMethod,S.IsLayby,S.IsPOS,S.Deleted,S.IsInvoice,S.TillID');
    cmd.Sql.Add('FROM tblposeop EOP Left  join');
    cmd.Sql.Add('tblsales S on S.saledatetime >= EOP.StartDate and S.saleDateTime <= EOP.EndDate and  S.IsPos = "T"');
    cmd.Sql.Add('where EOP.periodID = ' + inttostr(qryEOPPeriodID.asInteger) +';');
    cmd.Execute;

  finally
    FreeAndNil(cmd);
  end;
end;

procedure TfrmPOSReports.DeleteTmp_tblsales;
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    // delete previous temp table, if exists
    qry.Sql.Add('DROP TABLE IF EXISTS ' + tmp_tblsales + '; ');
    qry.Execute;

  finally
    FreeAndNil(qry);
  end;
end;
function TfrmPOSReports.GetReportTypeID: Integer;
begin
         if IsProductsalesreportSelected    then result := 17   //'POS - Product Sales'
    else if IsDailyBalanceWorkSheetSelected then result := 18   //'POS - Summary';
    else if IsDailySalesStatisticsSelected  then result := 141 //'Daily Sales Statistics';
    else if ISProductGroupReportSelected    then result := 140 //'Daily Sales Statistics';
    Else Result := 0;
end;
function TfrmPOSReports.IsDailyBalanceWorkSheetSelected: Boolean; begin result := sametext(OptReports.items[OptReports.itemindex ]  , 'Daily Balance Work Report') ;end;
function TfrmPOSReports.IsDailySalesStatisticsSelected : boolean; begin result := sametext(OptReports.items[OptReports.itemindex ]  , 'Daily Sales Statistics')    ;end;
function TfrmPOSReports.ISProductGroupReportSelected   : boolean; begin result := sametext(OptReports.items[OptReports.itemindex ]  , 'Product Group Report')    ;end;
function TfrmPOSReports.IsProductsalesreportSelected   : Boolean; begin result := sametext(OptReports.items[OptReports.itemindex ]  , 'Product Sales Report')      ;end;
procedure TfrmPOSReports.optReportsClick(Sender: TObject);
begin
  inherited;
  btnList.visible := IsDailySalesStatisticsSelected;
end;

procedure TfrmPOSReports.TemplateToPrint;
begin
    ReportToPrint :='';
    if ChkChooseRpt.Checked = false then
      ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
    if ChkChooseRpt.checked or (ReportToPrint = '') then begin
      LoadReportTypes;
      if dlgReportSelect.Execute then
        ReportToPrint  := dlgReportSelect.SelectedItems.Text;
    end;
end;

procedure TfrmPOSReports.WriteGuiPrefs;
begin
    GuiPrefs.Node['General.ChooseTemplate'].asBoolean := chkChooseRpt.checked;
    if OptReports.itemindex  >=0 then GuiPrefs.Node['General.ReportName'].AsString := OptReports.items[OptReports.itemindex ] ;
    GuiPrefs.Node['General.ShowPreview'].asBoolean := chkPreview.checked;
end;

initialization
  RegisterClassOnce(TfrmPOSReports);
  FormFact.RegisterMe(TfrmPOSReports, 'TfrmEndOfPeriodPOS_*=PeriodID');

end.
