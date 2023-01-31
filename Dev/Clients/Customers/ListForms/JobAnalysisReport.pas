unit JobAnalysisReport;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/07/05  1.00.01 IJB  Modified to use newly linked Sales Lines amounts,
                        plus added "Difference" column.
 07/09/05  1.00.02 IJB  Modified to use new filtering on base listing.
 10/10/05  1.00.03 DLS  Added ServiceDate and Qty Columns
 04/01/06  1.00.04 DSP  Fixed fault caused by missing GROUP in SQL.

}



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TJobAnalysisReportGUI = class(TBaseListingGUI)
    qryMainCompany: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainHours: TFloatField;
    qryMainServiceName: TWideStringField;
    qryMainServiceDate: TDateField;
    qryMainChargeRate: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainTotalCharge: TFloatField;
    lblInvoiced: TLabel;
    edtInvoiced: TEdit;
    Label4: TLabel;
    edtClosingBalance: TEdit;
    qryMainBeenInvoiced: TWideStringField;
    qryMainInvoiceRef: TWideStringField;
    qryMainInvoiceDate: TDateField;
    qryMainID: TIntegerField;
    qryMainTotalInvoiced: TFloatField;
    qryMainDifference: TFloatField;
    qryMainQty: TFloatField;
    qryMainDetails: TLargeintField;
    qryMainEquipmentName: TWideStringField;
    qryMainNotes: TWideMemoField;

    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure chkAllClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;

  end;

//var
//  JobAnalysisReportGUI: TJobAnalysisReportGUI;

implementation

uses
    AppEnvironment, CommonLib, tcConst, MySQLConst;

{$R *.dfm}

procedure TJobAnalysisReportGUI.grpFiltersClick(Sender: TObject);
begin
  if Self.ErrorOccurred then Exit;
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Details = 0';
        SwapBaseIndexFieldPriority := false;
      end;

    1: 
      begin
        GroupFilterString := 'Details <= 1';
        qryMain.IndexFieldNames := 'Company ASC CIS; JobName ASC CIS; Details ASC';
        BaseIndexFieldNames := 'Company ASC CIS; JobName ASC CIS; Details ASC';
        SwapBaseIndexFieldPriority := true;
      end;
  end;

  inherited;
end;

procedure TJobAnalysisReportGUI.RefreshQuery;
var
  ctr:Integer;
  function fromDate:string;begin result := Quotedstr(Formatdatetime(MysqlDateFormat , FilterDateFrom)); end;
  function ToDate  :string;begin result := Quotedstr(Formatdatetime(MysqlDateFormat , FilterDateTo))  ; end;
begin
  // No problems? If so, just exit.
  if Self.ErrorOccurred then Exit;

  qryMain.Close;
  (*if not chkAll.Checked then begin
    qryMain.ParamCheck := true;
  end else begin
    qryMain.ParamCheck := false;
  end;*)

  qryMain.SQL.Clear;
  for ctr := 1 to 2 do begin
    qryMain.SQL.Add('SELECT');
    qryMain.SQL.Add('1 AS Details, ' );
    qryMain.SQL.Add(SplitField('C' , 'Company' , 1) +' as Company, ');
    qryMain.SQL.Add('C.JobName,C.JobNumber AS JobNumber, ');
    qryMain.SQL.Add('T.Hours AS Hours, T.ServiceName,T.ServiceDate,SUM(T.Qty) AS Qty , ');
    qryMain.SQL.Add('T.ChargeRate, T.EmployeeName,');
    if AppEnv.PayPrefs.UseEmployeeServiceAsEmployeeCost then begin
      qryMain.SQL.Add('T.ClassName, T.Notes, T.ChargeRate As TotalCharge,');
      qryMain.SQL.Add('IF(T2.SaleLineId > 0, LinePriceInc, T2.ChargeRate) AS TotalInvoiced,');
    end else begin
      qryMain.SQL.Add('T.ClassName, T.Notes, (T.ChargeRate * T.Hours) As TotalCharge,');
      qryMain.SQL.Add('IF(T2.SaleLineId > 0, TotalLineAmountInc, T2.ChargeRate * T.Hours) AS TotalInvoiced,');
    end;

    qryMain.SQL.Add('if(ifnull(T.SalesID,0) = 0 , "T", "F") AS "BeenInvoiced",');
    qryMain.SQL.Add('S.InvoiceDocNumber AS "Invoice Ref #", S.SaleDate AS "Invoice Date", T.ID,');
    if ctr = 1 then qryMain.SQL.Add('"" as EquipmentName')
    else qryMain.SQL.Add('E.EquipmentName as EquipmentName');
    qryMain.SQL.Add('FROM tbltimesheets AS T');
    qryMain.SQL.Add('INNER JOIN tblclients AS C on T.JobID = C.ClientID');
    qryMain.SQL.Add('LEFT JOIN tblSales AS S on T.SalesID = S.SaleID');
    qryMain.SQL.Add('LEFT JOIN tbltimesheets AS T2 on T2.ID = T.ID AND T2.SalesID <> 0');
    qryMain.SQL.Add('LEFT JOIN tblSalesLines AS SL on SL.SaleLineId = T2.SaleLineId');
    if ctr = 1 then begin
      {no equipment}
      qryMain.SQL.Add('WHERE  (ifnull(T.CustomerEquipmentID,0) = 0)');
    end else begin
      {with equipment}
      qryMain.SQL.Add('Inner Join tblcustomerequip AS CE ON T.CustomerEquipmentID = CE.id');
      qryMain.SQL.Add('Inner Join tblequipment AS E ON CE.EquipmentID = E.EquipmentID');
      qryMain.SQL.Add('WHERE  (ifnull(T.CustomerEquipmentID,0) <> 0)');
    end;

    (*if not chkAll.Checked then*)
      qryMain.SQL.Add('AND (T.TimesheetDate BETWEEN '+fromdate+' AND ' +ToDate+')');

    qryMain.SQL.Add('GROUP BY T.ID');
    qryMain.SQL.Add('UNION ALL');
  end;

  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('0 AS Details, SUBSTRING_INDEX(C.Company,"^",1) as Company, C.JobName, C.JobNumber,');
  qryMain.SQL.Add('SUM(T.Hours), NULL, NULL AS ChargeRate,NULL as ServiceDate,SUM(T.Qty) AS Qty, NULL,');
  if AppEnv.PayPrefs.UseEmployeeServiceAsEmployeeCost then begin
    qryMain.SQL.Add('NULL, NULL AS Notes, SUM(T.ChargeRate) As TotalCharge,');
    qryMain.SQL.Add('IF(T2.SaleLineId > 0, SUM(LinePriceInc), SUM(T2.ChargeRate)) AS TotalInvoiced,');
  end else begin
    qryMain.SQL.Add('NULL, NULL AS Notes, SUM(T.ChargeRate * T.Hours) As TotalCharge,');
    qryMain.SQL.Add('IF(T2.SaleLineId > 0, SUM(TotalLineAmountInc), SUM(T2.ChargeRate * T.Hours)) AS TotalInvoiced,');
  end;
  qryMain.SQL.Add('NULL AS "BeenInvoiced", NULL, NULL, NULL,NULL');
  qryMain.SQL.Add('FROM tbltimesheets AS T');
  qryMain.SQL.Add('INNER JOIN tblclients AS C on T.JobID = C.ClientID');
  qryMain.SQL.Add('LEFT JOIN tblSales AS S on T.SalesID = S.SaleID');
  qryMain.SQL.Add('LEFT JOIN tbltimesheets AS T2 on T2.ID = T.ID AND T2.SalesID <> 0');
  qryMain.SQL.Add('LEFT JOIN tblSalesLines AS SL on SL.SaleLineId = T2.SaleLineId');

  (*if not chkAll.Checked then*)
    qryMain.SQL.Add('WHERE (T.TimesheetDate BETWEEN '+fromdate+' AND ' +ToDate+')');
  qryMain.SQL.Add('GROUP BY C.Company, C.JobName');
  RefreshOrignalSQL(False);

  // Open our query.
  inherited;
end;

procedure TJobAnalysisReportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMain.FieldByName('Details').AsInteger = 0 then begin
    AFont.Style := [fsBold];
  end else begin
    AFont.Style := [];
  end;
end;

procedure TJobAnalysisReportGUI.FormShow(Sender: TObject);
begin
  if Self.ErrorOccurred then Exit;
  inherited;
  //  if AppEnv.PayPrefs.UseEmployeeServiceAsEmployeeCost then begin
  Label4.Caption := 'Un-Invoiced';
  //  end else Begin
  //    Label4.caption := 'Closing Balance';
  //  end;

  GuiPrefs.DbGridElement[grdMain].RemoveFields('Id');

end;

procedure TJobAnalysisReportGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := 'Company ASC CIS; JobName ASC CIS; Details ASC';
  BaseIndexFieldNames := 'Company ASC CIS; JobName ASC CIS; Details ASC';
  SwapBaseIndexFieldPriority := true;
end;

procedure TJobAnalysisReportGUI.RefreshTotals;
var
  dTotal, dHours, dInvTotal, dNONInvTotal, dClosing: double;
begin
  if not qryMain.Active then Exit;

  inherited;

  dTotal := 0;
  dHours := 0;
  dInvTotal := 0;
  dNONInvTotal := 0;
  try
    qryMain.First;
    qryMain.DisableControls;
    while not qryMain.Eof do begin
      case grpFilters.ItemIndex of
        0: 
          begin
            if qryMain.FieldByName('Details').AsInteger = 0 then begin
              // Has this job service been invoiced?
              dTotal := dTotal + qryMain.FieldByName('TotalCharge').AsFloat;
              dHours := dHours + qryMain.FieldByName('Hours').AsFloat;
              dInvTotal := dInvTotal + qryMain.FieldByName('TotalInvoiced').AsFloat;
            end;
          end;

        1: 
          begin
            if qryMain.FieldByName('Details').AsInteger <> 0 then begin
              // Has this job service been invoiced?
              dTotal := dTotal + qryMain.FieldByName('TotalCharge').AsFloat;
              dHours := dHours + qryMain.FieldByName('Hours').AsFloat;
              if qryMain.FieldByName('BeenInvoiced').AsString = 'Yes' then begin
                dInvTotal := dInvTotal + qryMain.FieldByName('TotalInvoiced').AsFloat;
              end else begin
                dNONInvTotal := dNONInvTotal + qryMain.FieldByName('TotalCharge').AsFloat;
              end;
            end;
          end;
      end;

      // Fetch next record.
      qryMain.Next;
    end;

    // Store accumulated total.
    grdMain.ColumnByName('TotalCharge').FooterValue := FloatToStrF(dTotal, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('Hours').FooterValue := FloatToStrF(dHours, ffFixed, 15, 2);
    grdMain.ColumnByName('TotalInvoiced').FooterValue := FloatToStrF(dInvTotal, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('Difference').FooterValue := FloatToStrF(dInvTotal - dTotal, ffCurrency, 15, CurrencyRoundPlaces);
    edtInvoiced.Text := FloatToStrF(dInvTotal, ffCurrency, 15, CurrencyRoundPlaces);
    if AppEnv.CompanyPrefs.UseTimesheetRateIncAsInvoiceCost then begin
      dClosing := dNONInvTotal;
    end else begin
      dClosing := dTotal - dInvTotal;
    end;
    edtClosingBalance.Text := FloatToStrF(dClosing, ffCurrency, 15, CurrencyRoundPlaces);

  finally
    qryMain.EnableControls;
  end;
end;

procedure TJobAnalysisReportGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  case grpFilters.ItemIndex of
    1: 
      begin
        if SortColumnName <> AFieldName then begin
          qryMain.IndexFieldNames := 'Company ASC CIS; JobName ASC CIS; Details ASC';
          BaseIndexFieldNames := 'Company ASC CIS; JobName ASC CIS; Details ASC';
        end;
        SwapBaseIndexFieldPriority := true;
      end;
  end;

  inherited;
end;

procedure TJobAnalysisReportGUI.chkAllClick(Sender: TObject);
begin
  inherited;
(*  if chkAll.Checked then begin
    cboDateRange.Enabled := false;
    lblFrom.Enabled      := false;
    lblTo.Enabled        := false;
    dtFrom.Enabled       := false;
    dtTo.Enabled         := false;
  end else begin
    cboDateRange.Enabled := true;
    lblFrom.Enabled      := true;
    lblTo.Enabled        := true;
    dtFrom.Enabled       := true;
    dtTo.Enabled         := true;
  end;*)

  RefreshQuery;
end;

procedure TJobAnalysisReportGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMain.FieldByName('Details').AsInteger = 1 then begin
    SubsequentID := Chr(95) + 'JobAnalysisDetails';
    inherited;
  end;
end;

procedure TJobAnalysisReportGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  self.qryMainDifference.AsFloat := qryMainTotalInvoiced.AsFloat - qryMainTotalCharge.AsFloat;
end;

procedure TJobAnalysisReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;
end;

initialization
  RegisterClassOnce(TJobAnalysisReportGUI);
end.
