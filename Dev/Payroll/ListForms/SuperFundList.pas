//////////////////////////////////////////////////////////////////////////
  // If you alter the SQL in either qryMain or qryTotals,
  // then you will need to make corrections to the RefreshQuery and
  // RefreshTotals procedures to ensure you have not misaligned the WHERE
  // index clause.
  //////////////////////////////////////////////////////////////////////////
unit SuperFundList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, wwdblook, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker,
  ProgressDialog, wwcheckbox,  Shader, kbmMemTable, DAScript,
  MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfrmSuperFundListGUI = class(TBaseListingGUI)
    qryMainDate: TDateField;
    qryMainName: TWideStringField;
    qryMainAccountNo: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainAmount: TFloatField;
    DNMPanel1: TDNMPanel;
    Label4: TLabel;
    cboFunds: TwwDBLookupCombo;
    cbCheckAll: TCheckBox;
    qrySuperFunds: TERPQuery;
    qryMainFundName: TWideStringField;
    qryMainPayID: TIntegerField;
    Label5: TLabel;
    chkGroupSuperFund: TCheckBox;
    chkUseDatePaid: TwwCheckBox;
    Label6: TLabel;
    qryMainDetails: TLargeintField;
    qryMainDefaultClassName: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure cboFundsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdPrintClick(Sender: TObject);
    procedure cbCheckAllClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkUseDatePaidClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override; 

  private
    { Private declarations }
    fiPayID: integer;
    fiClientID: integer;

    procedure SetPayID(iValue: integer);

  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    function GetReportTypeID: integer; override;

  public
    { Public declarations }
    property PayIDFromList: integer read fiPayID write SetPayID;

  end;

const
  // These are line indexes
  MAIN_WHERE_START: integer   = 15;
  TOTALS_WHERE_START: integer = 7;

implementation

uses
  DNMLib, CommonLib, Forms, FastFuncs, MySQLConst, tcDataUtils;

{$R *.dfm}

procedure TfrmSuperFundListGUI.FormShow(Sender: TObject);
begin
  // This must be opened first!
  inherited;
  if not qryMain.Active then Exit;
  chkAdvancedPrinting.Visible := true;
  qrySuperFunds.Open;
  SetControlFocus(cboFunds);
  cbCheckAll.Checked := true;
end;

procedure TfrmSuperFundListGUI.cboFundsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
  RefreshTotals;
end;

procedure TfrmSuperFundListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('xDateFrom').AsDateTime := FilterDatefrom;
  qryMain.Params.ParamByName('xDateTo').AsDateTime := FilterDateto;
  if not cbCheckAll.Checked then begin
    qryMain.Params.ParamByName('xClientID').AsInteger := GetClientID(cboFunds.Text);
  end else begin
    qryMain.Params.ParamByName('xClientID').AsString := '%';
  end;
  inherited;
end;

procedure TfrmSuperFundListGUI.SetPayID(iValue: integer);
begin
  fiPayID := iValue;
end;

procedure TfrmSuperFundListGUI.RefreshTotals;
var
  Amount: double;
begin
  Amount := 0.00;
  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      if grpFilters.ItemIndex = 0 then begin
        if qryMainDetails.AsInteger = 0 then
          Amount := Amount + RoundCurrency(qryMainAmount.AsFloat);
      end
      else if grpFilters.ItemIndex = 1 then begin
        if qryMainDetails.AsInteger = 1 then
          Amount := Amount + RoundCurrency(qryMainAmount.AsFloat);
      end
      else begin
        if qryMainDetails.AsInteger = 2 then
          Amount := Amount + RoundCurrency(qryMainAmount.AsFloat);
      end;
      Next;
    end;
    First;
  end;
  qryMain.EnableControls;
  grdMain.ColumnByName('Amount').FooterValue := FloatToStrF(Amount, ffCurrency, 15, CurrencyRoundPlaces);
end;

function TfrmSuperFundListGUI.GetReportTypeID: integer;
begin
  Result := 50;
end;

procedure TfrmSuperFundListGUI.cmdPrintClick(Sender: TObject);
begin
  TemplateSQL := '';
  if not chkGroupSuperFund.Checked then begin
    ReportToPrint := 'Super By Fund Report';
    if not cbCheckAll.Checked then begin
      TemplateSQL := ' AND C.ClientID = ' + IntToStr(fiClientID) + ' ';
    end;
    TemplateSQL := TemplateSQL + ' AND P.PayDate BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date)) + ' ';
    TemplateSQL := TemplateSQL + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date)) + ' ';
    TemplateSQL := TemplateSQL + ' ORDER BY P.PayDate';
  end else begin
    ReportToPrint := 'Super By Fund Report - Grouped';
    if not cbCheckAll.Checked then begin
      TemplateSQL := ' AND C.ClientID = ' + IntToStr(fiClientID) + ' ';
    end;
    TemplateSQL := TemplateSQL + ' AND P.PayDate BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date)) + ' ';
    TemplateSQL := TemplateSQL + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date)) + ' ';
    TemplateSQL := TemplateSQL + ' ORDER BY C.Company,EmployeeName,P.PayDate';
  end;

  inherited;
end;

procedure TfrmSuperFundListGUI.cbCheckAllClick(Sender: TObject);
begin
  inherited;
  if cbCheckAll.Checked then begin
    cboFunds.Enabled := false;
    Label4.Enabled   := false;
    RefreshQuery;
    RefreshTotals;
  end else begin
    Label4.Enabled   := true;
    cboFunds.Enabled := true;
    RefreshQuery;
    RefreshTotals;
  end;
end;

procedure TfrmSuperFundListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshTotals;
end;

procedure TfrmSuperFundListGUI.chkUseDatePaidClick(Sender: TObject);
begin
  inherited;
  with qryMain do begin
    Close;
    if chkUseDatePaid.Checked then begin
      qryMain.SQL.Text := StringReplace(qryMain.SQL.Text,'P.PayDate','P.DatePaid',[rfReplaceAll,rfIgnoreCase]);RefreshOrignalSQL;
    end else begin
      qryMain.SQL.Text := StringReplace(qryMain.SQL.Text,'P.DatePaid','P.PayDate',[rfReplaceAll,rfIgnoreCase]);RefreshOrignalSQL;
    end;
  end;
  RefreshQuery;
  RefreshTotals;
end;

procedure TfrmSuperFundListGUI.grpFiltersClick(Sender: TObject);
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
    2: 
      begin  {Extra Details}
        GroupFilterString := '(Details <> 1)';
      end;
  end;
  inherited;
end;


procedure TfrmSuperFundListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if (qryMainDetails.AsInteger=0) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TfrmSuperFundListGUI.grdMainDblClick(Sender: TObject);
begin
  If qryMainPayID.AsInteger>0 then
    inherited;
end;

initialization
  RegisterClassOnce(TfrmSuperFundListGUI);
end.
