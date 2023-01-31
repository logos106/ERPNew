unit frmSalesPipelineReportGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox;

type
  TfrmSalesPipelineReport = class(TBaseListingGUI)
    qryMainRecID: TIntegerField;
    qryMainDetails: TIntegerField;
    qryMainLeadStatus: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainRep: TWideStringField;
    qryMainActionDate: TDateField;
    qryMainAction: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainLeadID: TIntegerField;
    qryMainLeadStatusID: TIntegerField;
    qryMainLeadCount: TIntegerField;
    qryMainQuoteValue: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    fsTablename:String;
 //   function GetLeadCount(Const MediaType:String):integer;
  protected
    procedure xRefreshQuery; //override;
    procedure CreateTemporaryTable;
    procedure DestroyTemporaryTable;
  public
    { Public declarations }
  end;


const
  SALESPIPE_TABLENAME = 'salespipe';

implementation
uses
  CommonDbLib, CommonLib, AppEnvironment, MySQLConst, frmQuote;
{$R *.dfm}

procedure TfrmSalesPipelineReport.xRefreshQuery;
var
  qry:TERPQuery;
  dTotalValue:double;
  sTempValue:string;
begin
  qry := CommonDBLib.TempMyQuery;

  qrymain.disablecontrols;
  try
    qryMain.Close;
    qryMain.SQL.Clear;
    qryMain.SQL.Add('SELECT *');
    qryMain.SQL.Add('FROM ' + fsTableName);
    RefreshOrignalSQL;
    DeleteContentsFromUserTemporaryTable(fsTableName);

    {Quote header}
    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO ' + fsTableName);
    qry.SQL.Add('(Details,LeadID, LeadStatus,LeadStatusID, Company, Rep, ActionDate, Action, Notes, LeadCount, QuoteValue)');
    qry.SQL.Add('SELECT');
    qry.SQL.Add('0 as Details,');
    qry.SQL.Add('0 as LeadID,');

    qry.SQL.Add('"NON LEAD QUOTES" as LeadStatus,');
    qry.SQL.Add('2 as LeadStatusID,');
    qry.SQL.Add('"" as Company,');
    qry.SQL.Add('"" as Rep,');
    qry.SQL.Add('null as ActionDate,');
    qry.SQL.Add('"" as Action,');
    qry.SQL.Add('"" as Notes,');
    qry.SQL.Add('NULL as LeadCount,');
    qry.SQL.Add('NULL as QuoteValue');
    qry.SQL.Add('FROM tblsales');
    qry.SQL.Add('GROUP BY Company');

    qry.Execute;
    {Quote subheader}
    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO ' + fsTableName);
    qry.SQL.Add('(Details,LeadID, LeadStatus,LeadStatusID, Company, Rep, ActionDate, Action, Notes, LeadCount, QuoteValue)');

    qry.SQL.Add('SELECT');
    qry.SQL.Add('0 as Details,');
    qry.SQL.Add('0 as LeadID,');
    qry.SQL.Add('QuoteStatus,');
    qry.SQL.Add('0 as LeadStatusID,');
    qry.SQL.Add('"" as Company,');
    qry.SQL.Add('"" as Rep,');
    qry.SQL.Add('null as ActionDate,');
    qry.SQL.Add('"" as Action,');
    qry.SQL.Add('"" as notes,');
    qry.SQL.Add('null as LeadCount,');
    qry.SQL.Add('Concat(' + QuotedStr(AppEnv.RegionalOptions.CurrencySymbol)  + ', Format(Sum(tblsales.TotalAmountInc),2)) as QuoteValue');
    qry.SQL.Add('FROM tblsales');
    qry.SQL.Add('LEFT JOIN tblmarketingleads ON tblsales.ClientID = tblmarketingleads.ClientID');
    qry.SQL.Add('LEFT JOIN tblsimpletypes  ON tblmarketingleads.LeadStatus=tblsimpletypes.Name');
    qry.SQL.Add('WHERE tblsales.IsQuote = "T"');
    qry.SQL.Add('AND tblsimpletypes.TypeCode IS NULL');
    qry.SQL.Add(' AND tblsales.ShipDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add('Group by QuoteStatus');

    {Quote details}
    qry.SQL.Add('UNION ALL');
    qry.SQL.Add('SELECT');
    qry.SQL.Add('3 as Details,');
    qry.SQL.Add('tblsales.SaleID as LeadID,');
 //   qry.SQL.Add('tblsales.QuoteStatus as LeadStatus,');
    qry.SQL.Add('QuoteStatus,');
    qry.SQL.Add('0 as LeadStatusID,');
    qry.SQL.Add('tblsales.customerName as Company,');
    qry.SQL.Add('"" as Rep,');
    qry.SQL.Add('tblsales.Shipdate as ActionDate,');
    qry.SQL.Add('"QUOTE" as Action,');
    qry.SQL.Add('tblsales.comments as Notes,');
    qry.SQL.Add('NULL as LeadCount,');
    qry.SQL.Add('Concat(' + QuotedStr(AppEnv.RegionalOptions.CurrencySymbol)  + ', Format(tblsales.TotalAmountInc,2)) as QuoteValue');
    qry.SQL.Add('FROM tblsales');
    qry.SQL.Add('LEFT JOIN tblmarketingleads ON tblsales.ClientID = tblmarketingleads.ClientID');
    qry.SQL.Add('LEFT JOIN tblsimpletypes  ON tblmarketingleads.LeadStatus=tblsimpletypes.Name');
    qry.SQL.Add('WHERE tblsales.IsQuote = "T"');

    qry.SQL.Add('AND tblsimpletypes.TypeCode IS NULL');

    qry.SQL.Add(' AND tblsales.ShipDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');

    qry.SQL.Add('Group by tblsales.saleID');
    qry.SQL.Add('ORDER BY QuoteStatus,Details');
    qry.Execute;

     {Leads header}
    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO ' + fsTableName);
    qry.SQL.Add('(Details,LeadID, LeadStatus,LeadStatusID, Company, Rep, ActionDate, Action, Notes, LeadCount, QuoteValue)');
    qry.SQL.Add('SELECT');
    qry.SQL.Add('0 as Details,');
    qry.SQL.Add('0 as LeadID,');

    qry.SQL.Add('"LEADS" as LeadStatus,');
    qry.SQL.Add('2 as LeadStatusID,');
    qry.SQL.Add('"" as Company,');
    qry.SQL.Add('"" as Rep,');
    qry.SQL.Add('null as ActionDate,');
    qry.SQL.Add('"" as Action,');
    qry.SQL.Add('"" as Notes,');
    qry.SQL.Add('NULL as LeadCount,');
    qry.SQL.Add('NULL as QuoteValue');
    qry.SQL.Add('FROM tblsales');
    qry.SQL.Add('GROUP BY Company');

    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO ' + fsTableName);
    qry.SQL.Add('(Details,LeadID, LeadStatus,LeadStatusID, Company, Rep, ActionDate, Action, Notes, LeadCount, QuoteValue)');
    {Sub Header: Quote Totals}
    qry.SQL.Add('SELECT');
    qry.SQL.Add('0 as Details,');
    qry.SQL.Add('0 as LeadID,');
    qry.SQL.Add('LeadStatus,');
    qry.SQL.Add('tblsimpletypes.ID as LeadStatusID,');
    qry.SQL.Add('Concat( "Quote Total (",LeadStatus,")") as Company,');
    qry.SQL.Add('"" as Rep,');
    qry.SQL.Add('null as ActionDate,');
    qry.SQL.Add('"" as Action,');
    qry.SQL.Add('"" AS Notes,');
    qry.SQL.Add('Count(tblsimpletypes.ID) as LeadCount,');
  //  qry.SQL.Add(IntToStr(GetLeadCount()) + ' as LeadCount,');
    qry.SQL.Add('if(Sum(DISTINCT(S.TotalAmountInc)) is null,' + QuotedStr(AppEnv.RegionalOptions.CurrencySymbol)  + '"0.00",Concat(' + QuotedStr(AppEnv.RegionalOptions.CurrencySymbol)  + ', Format(Sum(DISTINCT(S.TotalAmountInc)),2))) as QuoteValue');
    qry.SQL.Add('FROM tblmarketingleads');
    qry.SQL.Add('LEFT JOIN tblsimpletypes  ON tblmarketingleads.LeadStatus=tblsimpletypes.Name');
    qry.SQL.Add('LEFT OUTER JOIN tblsales S ON tblmarketingleads.ClientID = S.ClientID'); //customerName?
    qry.SQL.Add('LEFT JOIN tblsalesLines SL ON S.SaleID = SL.SaleID');
    qry.SQL.Add('WHERE S.IsQuote = "T"');
    qry.SQL.Add('AND SL.ShipDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add('OR SL.ShipDate is NULL');
    qry.SQL.Add('GROUP BY LeadStatusID');

    qry.SQL.Add('UNION  ALL');
    {Leads Detail}
    qry.SQL.Add('SELECT ');
    qry.SQL.Add('1 as Details,');
    qry.SQL.Add('L.LeadID,');
    qry.SQL.Add('L.LeadStatus,');
    qry.SQL.Add( '0 as LeadStatusID,');
    qry.SQL.Add('L.Company,');
    qry.SQL.Add('E.EmployeeName as Rep,');
    qry.SQL.Add('LL.ActionDate as ActionDate,');
    qry.SQL.Add('ST.Name as Action,');
    qry.SQL.Add('LL.Notes,');
    qry.SQL.Add('null as LeadCount,');
    qry.SQL.Add('null as QuoteValue');
    qry.SQL.Add('FROM tblmarketingleadlines LL');
    qry.SQL.Add('INNER JOIN tblmarketingleads L ON L.LeadID=LL.LeadID');
    qry.SQL.Add('INNER JOIN tblsimpletypes ST ON LL.ActionType=ST.id');
    qry.SQL.Add('INNER JOIN tblemployees E ON LL.EmployeeId= E.EmployeeID');
    qry.SQL.Add(' WHERE LL.ActionDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add('ORDER BY LeadStatus,Details');


    qry.Execute;
    qryMain.Open;
    // Show totals.
    dTotalValue := 0;
    qryMain.First;

    while not qryMain.Eof do begin
      try
        if qryMain.FieldByName('QuoteValue').AsString <> '' then
          sTempValue := ReplaceStr(qryMain.FieldByName('QuoteValue').AsString,'$','')
        else sTempValue := '0';

        sTempValue := ReplaceStr(sTempValue,',','');
        dTotalValue := dTotalValue + StrToFloat(sTempValue);
      except
      end;
      qryMain.Next;
    end;
    grdMain.ColumnByName('QuoteValue').FooterValue  := FloatToStrF(dTotalValue, ffCurrency, 15, CurrencyRoundPlaces);
   // inherited;
  finally
    FreeAndNil(qry);
    qryMain.First;
    qrymain.enablecontrols;
  end;
end;

//function TfrmSalesPipelineReport.GetLeadCount(Const MediaType:String):integer;
//var
//  qry:TERPQuery;
//begin
//  qry := CommonDbLib.TempMyQuery;
//  try
//    qry.SQL.Clear;
//    qry.SQL.Add('SELECT ML.LeadID,ML.ClientID,MC.Source');
//    qry.SQL.Add('FROM tblmarketingleads ML');
//    qry.SQL.Add('INNER JOIN tblmarketingleadlines MLL ON ML.LeadID = MLL.LeadID');
//    qry.SQL.Add('INNER JOIN tblmarketingcontacts MC ON  MC.Company=ML.Company');
//    qry.SQL.Add('AND MLL.IsLead = "T"');
//    qry.SQL.Add('WHERE MC.Source = ' + QuotedStr(MediaType));
//
//
//    qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
//      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
//    qry.SQL.Add('Group by ML.LeadID');
//    qry.Open;
//
//    Result := qry.RecordCount;
//   finally
//     FreeAndNil(qry);
//   end;
//end;

procedure TfrmSalesPipelineReport.CreateTemporaryTable;
var
  slSQL: TStringList;
begin
  DestroyUserTemporaryTable(fsTableName);
  slSQL := TStringList.Create;
  try
    slSQL.Clear;
    slSQL.Add('CREATE TABLE `' + fsTableName + '` (');
    slSQL.Add('`RecID` INT(11) AUTO_INCREMENT,');
    slSQL.Add('`Details` INT(11),');
    slSQL.Add('`LeadID` INT(11),');
    slSQL.Add('`LeadStatus` VARCHAR(255),');
    slSQL.Add('`LeadStatusID` INT(11),');
    slSQL.Add('`Company` VARCHAR(255),');
    slSQL.Add('`Rep` VARCHAR(255),');
    slSQL.Add('`ActionDate` Date,');
    slSQL.Add('`Action` VARCHAR(255),');
    slSQL.Add('`Notes` VARCHAR(255),');
 //   slSQL.Add('`LeadCount` VARCHAR(255),');
    slSQL.Add('`LeadCount` INT(11),');
    slSQL.Add('`QuoteValue` VARCHAR(255),');
    slSQL.Add('PRIMARY KEY (`RecID`)) ENGINE=MyISAM;');
    CreateUserTemporaryTable(slSQL);
  finally
    if Assigned(slSQL) then FreeandNil(slSQL);
  end;
end;

procedure TfrmSalesPipelineReport.DestroyTemporaryTable;
begin
  DestroyUserTemporaryTable(fsTableName);
end;

procedure TfrmSalesPipelineReport.FormCreate(Sender: TObject);
begin
  fsTablename := GetUserTemporaryTableName(SALESPIPE_TABLENAME);
  CreateTemporaryTable;
  inherited;
  if ErrorOccurred then Exit;
end;

procedure TfrmSalesPipelineReport.FormDestroy(Sender: TObject);
begin
  DestroyTemporaryTable;
  inherited;
end;

procedure TfrmSalesPipelineReport.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(Details = 0)';
      end;
    1:
      begin {Details}
        GroupFilterString := '(Details <> 2)';
      end;
  end;
  inherited;
end;

procedure TfrmSalesPipelineReport.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMainDetails.AsInteger = 0 then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
  if qryMainDetails.AsInteger = 1 then begin
    if (qryMain.FieldByName('LeadStatus').AsString = 'NON LEAD QUOTES') or (qryMain.FieldByName('LeadStatus').AsString = 'LEADS') then
      AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TfrmSalesPipelineReport.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  xRefreshQuery;
end;

procedure TfrmSalesPipelineReport.dtFromChange(Sender: TObject);
begin
  inherited;
  xRefreshQuery;
end;

procedure TfrmSalesPipelineReport.dtToChange(Sender: TObject);
begin
  inherited;
  xRefreshQuery;
end;

procedure TfrmSalesPipelineReport.grdMainDblClick(Sender: TObject);
Var
  frm:TComponent;
begin
  if qryMain.FieldByName('LeadID').asInteger = 0 then exit;

  if qryMain.FieldByName('Action').asString = 'QUOTE' then begin
    frm := GetComponentByClassName('TQuoteGUI');
    if Assigned(frm) then begin
      with TQuoteGUI(frm) do begin
        TQuoteGUI(frm).KeyID := qryMain.fieldByName('LeadID').AsInteger; {the quoteID was put in this field}
        ShowModal;
        Self.grdMain.SetFocus;
        exit;
      end;
    end;
  end;
  inherited;
end;

procedure TfrmSalesPipelineReport.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmSalesPipelineReport.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmSalesPipelineReport.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmSalesPipelineReport.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfrmSalesPipelineReport);
end.
