unit JobProductSalesDetailList;

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
  TJobProductSalesDetailListGUI = class(TBaseListingGUI)
    qryMainDetailType: TLargeintField;
    qryMainCustomerID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainContactName: TWideStringField;
    qryMainJobCustomerName: TWideStringField;
    qryMainClientNo: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainCustomerStreet: TWideStringField;
    qryMainCustomerStreet2: TWideStringField;
    qryMainCustomerStreet3: TWideStringField;
    qryMainCustomerSuburb: TWideStringField;
    qryMainCustomerState: TWideStringField;
    qryMainCustomerPostcode: TWideStringField;
    qryMainJobID: TIntegerField;
    qryMainJobClientNo: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainJobRegistration: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainJobWarrantyPeriod: TFloatField;
    qryMainJobNotes: TWideMemoField;
    qryMainSaleCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainSaleDateTime: TDateTimeField;
    qryMainSaleTotalEx: TFloatField;
    qryMainSaleAmountInc: TFloatField;
    qryMainSaleTax: TFloatField;
    qryMainSaleDepartment: TWideStringField;
    qryMainSaleComments: TWideMemoField;
    qryMainSaleCustField1: TWideStringField;
    qryMainSaleCustField2: TWideStringField;
    qryMainSaleCustField3: TWideStringField;
    qryMainSaleCustField4: TWideStringField;
    qryMainSaleCustField5: TWideStringField;
    qryMainSaleCustField6: TWideStringField;
    qryMainSaleCustField7: TWideStringField;
    qryMainSaleCustField8: TWideStringField;
    qryMainSaleCustField9: TWideStringField;
    qryMainSaleCustField10: TWideStringField;
    qryMainSaleTerms: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainDocketNumber: TWideStringField;
    qryMainMemoLine: TWideMemoField;
    qryMainUomQtySold: TFloatField;
    qryMainUomQtyShipped: TFloatField;
    qryMainUomQtyBackorder: TFloatField;
    qryMainUomName: TWideStringField;
    qryMainAmountEx: TFloatField;
    qryMainAmountInc: TFloatField;
    qryMainAmountTax: TFloatField;
    qryMainTaxCode: TWideStringField;
    qryMainAmountDiscount: TFloatField;
    qryMainDiscountPerUnit: TFloatField;
    Label79: TLabel;
    cboCustomer: TwwDBLookupCombo;
    cboClientLookup: TERPQuery;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupClientID: TIntegerField;
    chkAllClients: TwwCheckBox;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkAllClientsClick(Sender: TObject);
    procedure cboCustomerChange(Sender: TObject);
  private
  protected
    procedure RefreshQuery; override;
    function GetReportTypeID: integer; override;
    procedure ApplyQueryFilter; override;
  public

  end;

implementation

uses
  DateUtils, ReportTemplateBase, CommonLib, MySQLConst, DateTimeUtils,
  AppEnvironment, IntegerListObj, DbSharedObjectsObj, CommonDbLib, tcDataUtils,
  tcConst;

{$R *.dfm}

{ TJobProductSalesDetailListGUI }

procedure TJobProductSalesDetailListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin { Summary }
        GroupFilterString := '(DetailType = 0)';
      end;
    1:
      begin { Detail }
        GroupFilterString := '((DetailType = 0) or (DetailType = 1))';
      end;
    2:
      begin { Extra Detail }
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TJobProductSalesDetailListGUI.cboCustomerChange(Sender: TObject);
begin
  inherited;
  if not cboCustomer.Focused then exit;
  RefreshQuery;
end;

procedure TJobProductSalesDetailListGUI.chkAllClientsClick(Sender: TObject);
begin
  inherited;
  if not chkAllClients.Focused then exit;
  RefreshQuery;
end;

procedure TJobProductSalesDetailListGUI.cmdPrintClick(Sender: TObject);
var
  sql: string;
  yearStart: TDateTime;
  clientIDs :TIntegerList;
  ctr:Integer;
  fsjobIds:String;
  cSQL:String;
begin
  if chkAdvancedPrinting.Checked then begin
    ReportToPrint := 'Job Sales Detail';
    if chkChooseRpt.Checked then begin
      LoadReportTypes;
      if dlgReportSelect.Execute then ReportToPrint := dlgReportSelect.SelectedItems.Text;
    end;
    if chkIgnoreDates.Checked then begin
      CommonLib.MessageDlgXP_Vista('A Date Range must be Selected to Print this Report (Ignore Dates can not be ticked)',mtInformation,[mbOk],0);
      exit;
    end;
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
    if (Pos('(C.Company like "%")',sql) < 1) and (Pos('(C.Company like ''%'')',sql) < 1) then begin
      CommonLib.MessageDlgXP_Vista('Error loading Template "' + ReportToPrint + '", Report SQL has been altered and does not contain required Company Place Holder',mtInformation,[mbOk],0);
      exit;
    end ;
    clientIDs := TIntegerList.create;
    try
      clientIDs.commatext := Qrymain.Groupconcat('CustomerID' , '',False,',' , '','',False, True);
      if clientIDs.Count  =0  then exit;


      sql := replacestr(sql,'1970-01-01',FormatDateTime(MysqlDateTimeFormat,FilterdateFrom));
      sql := replacestr(sql,'2999-01-01',FormatDateTime(MysqlDateTimeFormat,FilterdateTo));

      yearStart := FiscalYearStart(dtTo.Date, AppEnv.CompanyPrefs.FiscalYearStarts);
      sql := replacestr(sql,'1970-01-02',FormatDateTime(MysqlDateFormat,yearStart));
      sql := replacestr(sql,'2999-01-02',FormatDateTime(MysqlDateTimeFormat,FilterdateTo));

      DoShowProgressbar(clientIDs.count , WAITMSG + ' Printing for  ' + inttostr(clientIDs.count)+' Custoemr(s)');
      try
        for ctr := 0 to clientIDs.count -1 do begin
          DoStepProgressbar(inttostr(ctr+1)+' of ' + inttostr(clientIDs.count));
          fsjobIds := jobIds(clientIDs[ctr]);
          if fsjobIds  ='' then fsjobIds  := '0';
          ReportSQLSupplied := true;
          csql := sql;
          csql := replacestr(csql,'(C.Company like "%")'  ,'(C.clientId in (' +fsjobIds  +' ))');
          csql := replacestr(csql,'(C.Company like ''%'')','(C.clientId in (' +fsjobIds  +' ))');
          csql := replacestr(csql , 'clientId in (1)','clientId in (' +fsjobIds  +' )') ;

          PrintTemplateReport(ReporttoPrint, csql , (not(Appenv.Employee.ShowPreview) and (not chkPreview.Checked)), 1, nil, '', true);
          if PrintTemplate.CancelPreviewAll then break;
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      Freeandnil(clientIDs);
    end;
  end  else begin
    inherited;
  end;
end;
procedure TJobProductSalesDetailListGUI.FormShow(Sender: TObject);
begin
  inherited;
  cboClientLookup.Open;
end;

function TJobProductSalesDetailListGUI.GetReportTypeID: integer;
begin
  result :=  154;
end;

procedure TJobProductSalesDetailListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (qryMainDetailType.AsInteger = 0) then
    AFont.Style := [fsBold]
  else if (qryMainDetailType.AsInteger = 1) then begin
    AFont.Style := [fsBold];
    AFont.Color := clMaroon;
  end;
end;

procedure TJobProductSalesDetailListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDateTime := 0;
    qryMain.ParamByName('DateTo').AsDateTime := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDateTime := dtFrom.Date;
    qryMain.ParamByName('DateTo').AsDateTime := (dtTo.Date + 1) - OneSecond;
  end;
  if chkAllClients.Checked then
    qryMain.ParamByName('ClientId').AsInteger := 0
  else
    qryMain.ParamByName('ClientId').AsInteger := cboClientLookup.FieldByName('ClientId').AsInteger;
  inherited;

end;

initialization
  RegisterClass(TJobProductSalesDetailListGUI);

end.
