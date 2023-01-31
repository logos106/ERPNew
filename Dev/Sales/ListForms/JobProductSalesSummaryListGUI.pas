unit JobProductSalesSummaryListGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TJobProductSalesSummaryList = class(TBaseListingGUI)
    qryMainCustomerJobNumber: TWideStringField;
    qryMainDetailType: TLargeintField;
    qryMainParentClientID: TIntegerField;
    qryMainCustomer: TWideStringField;
    qryMainClientID: TLargeintField;
    qryMainJobCustomer: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainQtyShipped: TFloatField;
    qryMainTotalDiscount: TFloatField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainTotalTax: TFloatField;
    btnPrintSummary: TDNMSpeedButton;
    btnSelectAll: TDNMSpeedButton;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnPrintSummaryClick(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
  private
    procedure PrintSummary(aClientID: integer; FromDate, ToDate: TDateTime);
  protected
    function GetReportTypeID: integer; override;
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
  public
  end;

implementation

uses
  DateUtils, AppEnvironment, MySQLConst, DNMLib, ReportTemplateBase, CommonLib,
  DateTimeUtils, IntegerListObj, tcConst, tcDataUtils;

{$R *.dfm}

{ TJobProductSalesSummaryList }

procedure TJobProductSalesSummaryList.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin { Summary }
        GroupFilterString := '(DetailType = 0)';
        btnSelectAll.Enabled := true;
      end;
    1:
      begin { Detail }
        GroupFilterString := '';
        btnSelectAll.Enabled := false;
      end;
  end;
  inherited;
end;

procedure TJobProductSalesSummaryList.btnPrintSummaryClick(Sender: TObject);
var
  //x: integer;
  clientIDs :TIntegerList;
  ctr:Integer;
begin
  inherited;
  if grdMain.SelectedList.Count = 0 then exit;

  ReportToPrint := 'Job Sales Summary';
  if chkChooseRpt.checked then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then ReportToPrint := dlgReportSelect.SelectedItems.Text;
  end;
  PrintTemplate.CancelPreviewAll:= False;


  clientIDs := TIntegerList.create;
  try
    clientIDs.commatext := Qrymain.Groupconcat('ParentClientID' , '',False,',' , '','',False, True);
    if clientIDs.Count  =0  then exit;

      DoShowProgressbar(clientIDs.count , WAITMSG + ' Printing for  ' + inttostr(clientIDs.count)+' Custoemr(s)');
      try
        for ctr := 0 to clientIDs.count -1 do begin
          DoStepProgressbar(inttostr(ctr+1)+' of ' + inttostr(clientIDs.count));
          PrintSummary(clientIDs[ctr],filterDateFrom, FilterdateTo);
          if PrintTemplate.CancelPreviewAll then break;
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      Freeandnil(clientIDs);
    end;


(*    qryMain.DisableControls;
    try
      for x := 0 to grdMain.SelectedList.Count -1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList.Items[x]);
        if qryMainDetailType.AsInteger = 0 then begin
          PrintSummary(qryMainParentClientID.AsInteger,dtFrom.Date, dtTO.Date);
          if PrintTemplate.CancelPreviewAll then break;
        end;
      end;
    finally
      qryMain.EnableControls;
    end;*)
end;

procedure TJobProductSalesSummaryList.btnSelectAllClick(Sender: TObject);
var
  bm: TBookmark;
begin
  inherited;
  qryMain.DisableControls;
  try
    bm := qryMain.GetBookmark;
    try
      if btnSelectAll.Caption = 'Unselect All' then begin
        grdMain.UnselectAll;
        btnSelectAll.Caption := 'Select All';
        exit;
      end;
      qryMain.First;
      while not qryMain.Eof do begin
//        if (qryMainDetails.asInteger <> 1) and (qryMainBalanceamount.asfloat <> 0) then
        grdMain.SelectRecord;
        qryMain.Next;
      end;
      btnSelectAll.Caption := 'Unselect All';
      qryMain.GotoBookmark(bm);
    finally
      qryMain.FreeBookmark(bm);
    end;
  finally
    qryMain.EnableControls;
  end;
end;

procedure TJobProductSalesSummaryList.chkIgnoreDatesClick(Sender: TObject);
begin
  inherited;
  btnPrintSummary.Enabled := not chkIgnoreDates.Checked;
end;

function TJobProductSalesSummaryList.GetReportTypeID: integer;
begin
  result :=  152;
end;

procedure TJobProductSalesSummaryList.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainDetailType.AsInteger = 0 then
    AFont.Style := [fsBold];

end;

procedure TJobProductSalesSummaryList.PrintSummary(aClientID: integer; FromDate,
  ToDate: TDateTime);
var
  sql: string;
  yearStart: TDateTime;
  fsjobIds:String;
begin
(*
  sql :=
    { Customer }
    ' ~|||~ and pc.ClientID = ' + IntToStr(aClientID) +
    ' and (tblSales.SaleDateTime between ' + QuotedStr(FormatDateTime(MysqlDateFormat,FromDate)) +
    ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,(ToDate + 1)- OneSecond)) + ')' +
    { Detail }
    ' ~|||~ and pc.ClientID = ' + IntToStr(aClientID) +
    ' and (tblSales.SaleDateTime between ' + QuotedStr(FormatDateTime(MysqlDateFormat,FromDate)) +
    ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,(ToDate + 1)- OneSecond)) + ')' +
    ' group by tblsaleslines.ProductName ' +
    { YTD }
    ' ~|||~ and pc.ClientID = ' + IntToStr(aClientID) +
    ' and (tblSales.SaleDateTime between ' + QuotedStr(FormatDateTime(MysqlDateFormat,GetCurrentFiscalYearStart(FromDate))) +
    ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,(ToDate + 1)- OneSecond)) + ')' +
    { Payments }
    ' ~|||~ and pc.ClientID = ' + IntToStr(aClientID) +
    ' and (tblSales.SaleDateTime between ' + QuotedStr(FormatDateTime(MysqlDateFormat,GetCurrentFiscalYearStart(FromDate))) +
    ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,(ToDate + 1)- OneSecond)) + ')' ;
//    { Overdue }
//    ' ~|||~ and pc.ClientID = ' + IntToStr(aClientID) +
////    ' and (tblSales.SaleDateTime < ' + QuotedStr(FormatDateTime(MysqlDateFormat,GetCurrentFiscalYearStart(FromDate))) + ')';
//    ' and (tblSales.SaleDateTime < ' + QuotedStr(FormatDateTime(MysqlDateFormat,FromDate)) + ')';

  ReportSQLSupplied := False;
  PrintTemplateReport(ReporttoPrint, sql, (not(Appenv.Employee.ShowPreview) and (not chkPreview.Checked)), 1, nil, true);

*)
  fsjobIds := jobIds(aClientID);
  sql := TReportTemplateBase.GetReportSQL(ReportToPrint);
  if sql = '' then begin
    CommonLib.MessageDlgXP_Vista('Error loading Template "' + ReportToPrint + '", Report SQL is Empty',mtInformation,[mbOk],0);
    exit;
  end;
  if (Pos('1970-01-01',sql) < 1) or (Pos('2999-01-01',sql) < 1) or
     (Pos('1970-01-02',sql) < 1) or (Pos('2999-01-02',sql) < 1) then begin
    CommonLib.MessageDlgXP_Vista('Error loading Template "' + ReportToPrint + '", Report SQL has been altered and does not contain required date Place Holders',mtInformation,[mbOk],0);
    exit;
  end;
  if (Pos('999999',sql) < 1) then begin
    CommonLib.MessageDlgXP_Vista('Error loading Template "' + ReportToPrint + '", Report SQL has been altered and does not contain required date Place Holders for PC.ClientID (999999)',mtInformation,[mbOk],0);
    exit;
  end;

    sql := SysUtils.StringReplace(sql,'1970-01-01',FormatDateTime(MysqlDateFormat,dtFrom.Date),[rfReplaceAll]);
    sql := SysUtils.StringReplace(sql,'2999-01-01',FormatDateTime(MysqlDateTimeFormat,(dtTo.Date + 1) - OneSecond),[rfReplaceAll]);
    yearStart := FiscalYearStart(dtTo.Date, AppEnv.CompanyPrefs.FiscalYearStarts);
    sql := SysUtils.StringReplace(sql,'1970-01-02',FormatDateTime(MysqlDateFormat,yearStart),[rfReplaceAll]);
    sql := SysUtils.StringReplace(sql,'2999-01-02',FormatDateTime(MysqlDateTimeFormat,(dtTo.Date + 1) - OneSecond),[rfReplaceAll]);

    sql := SysUtils.StringReplace(sql,'999999',IntToStr(aClientID),[rfReplaceAll]);

  ReportSQLSupplied := true;
  PrintTemplateReport(ReporttoPrint, sql, (not(Appenv.Employee.ShowPreview) and (not chkPreview.Checked)), 1, nil, '', true);
end;

procedure TJobProductSalesSummaryList.RefreshQuery;
begin
  qryMain.ParamByName('ClientId').AsInteger := 0;
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDateTime := 0;
    qryMain.ParamByName('DateTo').AsDateTime := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDateTime := dtFrom.Date;
    qryMain.ParamByName('DateTo').AsDateTime := (dtTo.Date + 1) - OneSecond;
  end;
  inherited;

end;

initialization
  RegisterClass(TJobProductSalesSummaryList);


end.
