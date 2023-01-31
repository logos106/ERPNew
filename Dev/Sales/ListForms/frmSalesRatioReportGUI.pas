unit frmSalesRatioReportGUI;

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
  TfrmSalesRatioReport = class(TBaseListingGUI)
    qryMainEmployeeName: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainLeads: TIntegerField;
    qryMainOverdue: TIntegerField;
    qryMainAverageOverdueForPeriod: TIntegerField;
    qryMainAverageFollowUpsForPeriod: TIntegerField;
    qryMainApproved: TIntegerField;
    qryMainNotApproved: TIntegerField;
    qryMainSales: TIntegerField;
    qryMainLineDate: TDateField;
    qryMainLeadsApprovedRatio: TWideStringField;
    qryMainLeadsSalesRatio: TWideStringField;
    qryMainApprovedSalesRatio: TWideStringField;
    qryMainFollowUps: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
  private
    tablename :String ;
    procedure CreateTempTable;
    function GetLeads(EmployeeID:integer):integer ;
    function GetApproved(EmployeeID:integer):integer ;
    function GetOverDueFollowUps(EmployeeID:integer):integer;
    function GetFollowUps(EmployeeID:integer):integer;
    function GetSales(EmployeeID:integer):integer;
  protected
    procedure RefreshQuery; override;
  public
    class Function  PopulateTable(dFrom, dto:TDatetime):String;
    procedure DeleteDataTempTable;
    procedure AddDataToTempTable;
  end;



implementation

{$R *.dfm}
uses
  CommonLib, CommonDbLib, MySQLConst, tcConst;

procedure TfrmSalesRatioReport.AddDataToTempTable;
var
  InsertSQL: string;
  qryTemp: TERPCommand;
  qryTemp2:TERPQuery;
  iApproved,iNotApproved,iLeads,iSales:integer;
  sName,sLeadsApprovedRatio,sLeadsSalesRatio,sApprovedSalesRatio:string;
begin
  DeleteDataTempTable;
  qryTemp2 := CommonDbLib.TempMyQuery;
  qryTemp2.SQL.Clear;
  qryTemp2.SQL.Add('SELECT E.EmployeeID,E.EmployeeName,MLL.CreationDate');
  qryTemp2.SQL.Add('FROM  tblmarketingleadlines MLL');
  qryTemp2.SQL.Add('INNER JOIN tblemployees E ON MLL.EmployeeID=E.EmployeeID');
  qryTemp2.SQL.Add('INNER JOIN tblmarketingleads ML ON ML.LeadID=MLL.LeadID');
  qryTemp2.SQL.Add('INNER JOIN tblsimpletypes ST ON MLL.ActionType =ST.Id AND ST.TypeCode="LeadActiontype"');
  qryTemp2.SQL.Add(' WHERE MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
  qryTemp2.SQL.Add('AND E.Active="T"');
  if grpFilters.ItemIndex = 1 then qryTemp2.Sql.Add(' AND E.Rep = "T"');
  qryTemp2.Sql.Add(' GROUP BY E.EmployeeName');
  qryTemp2.Open;

  qryTemp2.First;
  qryTemp := TERPCommand.Create(nil);
  InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + Tablename + '(EmployeeName,Leads,OverDue,FollowUps,Approved,NotApproved,LeadsApprovedRatio,Sales,LeadsSalesRatio,ApprovedSalesRatio)';
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    while not qryTemp2.Eof do begin
      iLeads            := GetLeads(qryTemp2.fieldByName('EmployeeID').AsInteger);
      iApproved         := GetApproved(qryTemp2.fieldByName('EmployeeID').AsInteger);
      iNotApproved      := iLeads - iApproved;   
      iSales            := GetSales(qryTemp2.fieldByName('EmployeeID').AsInteger);
      sName             := qryTemp2.fieldByName('EmployeeName').AsString;  
      sLeadsApprovedRatio := '   = ' + FormatFloat('#0.0',(Divzer(iApproved,iLeads) * 100)) + ' %';
      sLeadsSalesRatio    := '   = ' + FormatFloat('#0.0',(Divzer(iSales,iLeads) * 100)) + ' %';
      sApprovedSalesRatio := '   = ' + FormatFloat('#0.0',(Divzer(iSales,iApproved) * 100)) + ' %';

      qryTemp.Sql.Clear;
      qryTemp.Sql.Add(InsertSQL);
      qryTemp.Sql.Add(' VALUES(' + QuotedStr(sName) + ',' + IntToStr(iLeads) +  ',' +
                         IntToStr(GetOverDueFollowUps(qryTemp2.fieldByName('EmployeeID').AsInteger)) + ',' + IntToStr(GetFollowUps(qryTemp2.fieldByName('EmployeeID').AsInteger)) + ',' +
                         IntToStr(iApproved) + ',' + IntToStr(iNotApproved) +
                          ',' + QuotedStr(IntToStr(iLeads) + ':' + IntToStr(iApproved) + sLeadsApprovedRatio) + ',' +
                          IntToStr(iSales) + ',' +
                          QuotedStr(IntToStr(iLeads) + ':' + IntToStr(iSales) + sLeadsSalesRatio) + ',' +
                          QuotedStr(IntToStr(iApproved) + ':' + IntToStr(iSales) + sApprovedSalesRatio) +
                         ')');
      qryTemp.Execute;
      qryTemp2.Next;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TfrmSalesRatioReport.GetSales(EmployeeID:integer):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;
//    qry.SQL.Add('SELECT MLL.ResultTypeName,MLL.LeadID,');
//    qry.SQL.Add('tblSales.saleId, tblSales.clientID');
//    qry.SQL.Add('FROM tblmarketingleadlines as MLL');
//    qry.SQL.Add('inner join tblmarketingleads ML on MLL.LeadID=ML.LeadID');
//    qry.SQL.Add('inner join tblSales on  tblSales.ClientID=ML.ClientID  and tblSales.Converted  <> "T"  and tblSales.IsQuote <> "T"');
//    qry.SQL.Add('WHERE MLL.EmployeeID= ' + IntToStr(EmployeeID));
//    qry.SQL.Add('AND (MLL.ResultTypeName = "Invoice") OR (MLL.ResultTypeName = "SalesOrder")');
//     qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
//      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
//    qry.SQL.Add('Group by  tblSales.SaleID');

    qry.SQL.Add('select S.SaleID');
    qry.SQL.Add('from tblmarketingleadlines MLL, tblsales S');
    qry.SQL.Add('where S.SaleID = MLL.ActionID');
    qry.SQL.Add('and MLL.ResultTypeName in ("Invoice","SalesOrder")');
    qry.SQL.Add('and MLL.CreationDate Between "'+FormatDateTime(MysqlDateFormat, dtfrom.DateTime)+'" AND "'+FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1)+'"');
    qry.SQL.Add('and S.Converted  <> "T"');
    qry.SQL.Add('and MLL.EmployeeID = ' +IntToStr(EmployeeID));

    qry.Open;
    Result := qry.RecordCount;
  finally
    FreeAndNil(qry);
  end;
end; 

function TfrmSalesRatioReport.GetFollowUps(EmployeeID:integer):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT Count(MLL.LeadLineID) as FollowUpCount,');
    qry.SQL.Add('MLL.EmployeeID,MLL.CreationDate');
    qry.SQL.Add('FROM tblmarketingleadlines as MLL');
    qry.SQL.Add('INNER JOIN tblsimpletypes ST ON MLL.ActionType =ST.Id');
    qry.SQL.Add('WHERE ST.TypeCode="LeadActiontype"');
    qry.SQL.Add(' AND ST.Name= "Follow-up"');
//    qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
//      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');

    qry.SQL.Add('AND MLL.CreationDate <= "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime) + '" ');
    qry.SQL.Add(' AND MLL.EmployeeID= ' + IntToStr(EmployeeID));
    qry.SQL.Add(' GROUP BY MLL.EmployeeID');
    qry.Open;
    Result := qry.FieldByName('FollowUpCount').AsInteger;
  finally
    FreeAndNil(qry);
  end;
end;

function TfrmSalesRatioReport.GetApproved(EmployeeID:integer):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;        //assume type will be "approved" only on one leadline for the lead
    qry.SQL.Add('SELECT Count(MLL.LeadID) as ApprovedCount,');
    qry.SQL.Add(' MLL.EmployeeID,MLL.CreationDate');
    qry.SQL.Add(' FROM tblmarketingleadlines as MLL');
    qry.SQL.Add(' INNER JOIN tblsimpletypes ST ON MLL.ActionType =ST.Id');
    qry.SQL.Add(' AND ST.TypeCode="LeadActiontype"');
    qry.SQL.Add(' AND ST.Name= "approved"');
    qry.SQL.Add(' AND MLL.EmployeeID= ' + IntToStr(EmployeeID));
    qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add(' GROUP BY MLL.ActionType');
    qry.Open;
    Result := qry.FieldByName('ApprovedCount').AsInteger;
  finally
    FreeAndNil(qry);
  end;
end; 

function TfrmSalesRatioReport.GetOverDueFollowUps(EmployeeID:integer):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT  F1.LeadId, S1.Name,C1.company,F1.EmployeeID,S1.Typecode,');
    qry.SQL.Add('Count(Typecode) as OverDueCount');
    qry.SQL.Add('FROM tblMarketingleadlines as F1');
    qry.SQL.Add('inner join tblMarketingleads as C3 on C3.LeadID = F1.LeadID');
    qry.SQL.Add('inner join tblmarketingcontacts as C1 on  (C1.ID = C3.MarketingContactID)');
    qry.SQL.Add(' AND (ifnull(C3.ClientID,0) = 0)');
    qry.SQL.Add('INNER JOIN tblsimpletypes S1 ON F1.ActionType=S1.Id');
    qry.SQL.Add('WHERE F1.IsLead = "T"');
    qry.SQL.Add('AND F1.Done <> "T"');
    qry.SQL.Add('AND F1.EmployeeID = ' + IntToStr(EmployeeId));
    qry.SQL.Add('AND F1.CreationDate <= "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime) + '"');
    qry.SQL.Add('GROUP BY TypeCode');

    qry.Open;
    Result := qry.FieldByName('OverDueCount').AsInteger;
   finally
     FreeAndNil(qry);
   end;
end;

function TfrmSalesRatioReport.GetLeads(EmployeeID:integer):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT MLL.LeadID,MLL.EmployeeID,MLL.CreationDate');
    qry.SQL.Add('FROM tblmarketingleadlines as MLL');
    qry.SQL.Add('WHERE MLL.EmployeeID = ' + IntToStr(EmployeeID));
    qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add('AND MLL.IsLead = "T"');
    qry.SQL.Add('GROUP BY MLL.LeadID');
    qry.Open;      
    Result := qry.RecordCount;
   finally
     FreeAndNil(qry);
   end;
end;

procedure TfrmSalesRatioReport.CreateTempTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + Tablename + ' ;');
(*    qryTemp.Execute;

    qryTemp.Sql.Clear;*)
    qryTemp.Sql.Add('CREATE TABLE IF NOT EXISTS ' + Tablename + ' ( ');
    qryTemp.Sql.Add('`ID` int(11) NOT NULL auto_increment, ');
    qryTemp.Sql.Add('`EmployeeName` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`LineDate` date default NULL, ');
    qryTemp.Sql.Add('`GlobalRef` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Leads` int(11) default NULL, ');
    qryTemp.Sql.Add('`Overdue` int(11) default NULL, ');
    qryTemp.Sql.Add('`AverageOverdueForPeriod` int(11) default NULL, ');
    qryTemp.Sql.Add('`FollowUps` int(11) default NULL, ');
    qryTemp.Sql.Add('`AverageFollowUpsForPeriod` int(11) default NULL, ');
    qryTemp.Sql.Add('`Approved` int(11) default NULL, ');
    qryTemp.Sql.Add('`NotApproved` int(11) default NULL, ');
    qryTemp.Sql.Add('`LeadsApprovedRatio` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Sales` int(11) default NULL, '); //Sales Order or Invoice
    qryTemp.Sql.Add('`LeadsSalesRatio` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`ApprovedSalesRatio` varchar(255) default NULL, ');
    qryTemp.Sql.Add('PRIMARY KEY  (`ID`),  KEY `Dates` (`LineDate`)) ENGINE=MyISAM; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;



procedure TfrmSalesRatioReport.DeleteDataTempTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DELETE FROM  ' + Tablename + '; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TfrmSalesRatioReport.RefreshQuery;
var
TotalLeads,TotalOverDue,TotalFollowUps,TotalApproved,TotalNotApproved,TotalSales:integer;
begin
  DeleteDataTempTable;
  AddDataToTempTable;
  inherited;
  TotalLeads            := 0;
  TotalSales            := 0;
  TotalOverdue          := 0;
  TotalFollowUps        := 0;
  TotalApproved         := 0;
  TotalNotApproved      := 0;

  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      TotalSales        := TotalSales + qryMain.FieldByName('Sales').AsInteger;
      TotalOverDue      := TotalOverDue + qryMain.FieldByName('OverDue').AsInteger;
      TotalLeads        := TotalLeads + qryMain.FieldByName('Leads').AsInteger;
      TotalApproved     := TotalApproved + qryMain.FieldByName('Approved').AsInteger;
      TotalNotApproved  := TotalNotApproved + qryMain.FieldByName('NotApproved').AsInteger;
      TotalFollowUps    := TotalFollowUps + qryMain.FieldByName('FollowUps').AsInteger;
      Next;
    end;
  end;
  qryMain.EnableControls;
  grdMain.ColumnByName('OverDue').FooterValue := IntToStr(TotalOverDue);
  grdMain.ColumnByName('FollowUps').FooterValue := IntToStr(TotalFollowUps);
  grdMain.ColumnByName('Leads').FooterValue := IntToStr(TotalLeads);
  grdMain.ColumnByName('Approved').FooterValue := IntToStr(TotalApproved);
  grdMain.ColumnByName('NotApproved').FooterValue := IntToStr(TotalNotApproved);
  grdMain.ColumnByName('Sales').FooterValue := IntToStr(TotalSales);
  qryMain.First;
end;

procedure TfrmSalesRatioReport.FormCreate(Sender: TObject);
begin
  inherited;
  tablename := GetUserTemporaryTableName('tmp_SalesRatios_');
  if not ErrorOccurred then begin
    CreateTempTable;
    qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'FROM aaaaa', 'FROM ' + Tablename);
    RefreshOrignalSQL;
  end;
end;

procedure TfrmSalesRatioReport.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;
end;

procedure TfrmSalesRatioReport.FormShow(Sender: TObject);
begin
  inherited;
  if not ErrorOccurred then begin
    AddDataToTempTable;
    RefreshQuery;
(*    Application.ShowHint := true;
    Application.HintPause := 100;
    Application.HintHidePause := 5000;*)
    grdMain.ShowHint := true;
    grdMain.Hint := 'LEGEND: Employee Name - Representative.' + #10#13+
                    '               Leads               - New leads given for the date range.'    + NL+
                    '               Overdue          - Follow-ups Over Due for the "To Date".'  + NL+
                    '               Follow-Ups       - Number of Records Followed up on for the "To Date".'  + NL+
                    '               Approved        - Number of Leads with an "Approved" line.' + NL+
                    '               Not Approved - Number of leads with a "Not Approved" line.' + NL+
                    '               Sales               - Leads that have been converted into a Sales Order or Invoice.' + NL;

  end;
end;

procedure TfrmSalesRatioReport.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmSalesRatioReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DeleteDataTempTable;
  inherited;  
end;

procedure TfrmSalesRatioReport.grdMainDblClick(Sender: TObject);
var
  frm:TComponent;
begin
  Processingcursor(True);
  try
    if grdMain.GetActiveField.FieldName = 'Leads' then begin
      frm := GetComponentByClassName('TMarketingLeadsGUI');
      if Assigned(frm) then begin
        with TForm(frm) do begin
          Show;
          exit;
        end;
      end;
    end;
  finally
    Processingcursor(False);
  end; 
  inherited;
end;

procedure TfrmSalesRatioReport.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  RefreshQuery;
end;

procedure TfrmSalesRatioReport.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmSalesRatioReport.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmSalesRatioReport.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

class function TfrmSalesRatioReport.PopulateTable(dFrom, dto:TDatetime):String;
var
  frm : TfrmSalesRatioReport;
begin
  frm := TfrmSalesRatioReport(GetComponentByClassName('TfrmSalesRatioReport' , False ,nil, False));
//  With TfrmSalesRatioReport(GetComponentByClassName('TfrmSalesRatioReport' , False ,nil, False)) do
  try
    REsult:= GetUserTemporaryTableName('tmp_DashBoard_SalesRatios');
    // you MUST set dtTo BEFORE dtFrom!!!!
    frm.dtto.date := dto;
    frm.dtFrom.Date := dfrom;
//    frm.dtto.date := dto;
    frm.DeleteDataTempTable;
    frm.AddDataToTempTable;
    With CommonDbLib.TempMyQuery do
    try
      SQL.add('Drop table if exists ' +Result +';');
      SQL.add('Create table ' + Result +' Select * from ' + frm.tablename);
      Execute;
    finally
      if Active then
        close;
      Free;
    end;
  finally
      frm.Free;
  end;

end;

initialization
  RegisterClassOnce(TfrmSalesRatioReport);
end.
