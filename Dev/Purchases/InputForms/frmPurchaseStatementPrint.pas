unit frmPurchaseStatementPrint;
  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 29/06/05  1.00.01 DSP  Initial version. Prints a statement for suppliers
  //                        who do not send an invoice.
  // 04/07/05  1.00.02 DSP  Added a 'choose template' check box and grid search
  //                        functionality.
  // 15/11/05  1.00.03 DLS  Added RegisterClass.
  // 20/03/05  1.00.04  AL  Made Print Button to print default report == ReportToPrint := GetDefaultReport(75);

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  Buttons, DNMSpeedButton, StdCtrls, Grids, Wwdbigrd, Wwdbgrid,
  wwdbdatetimepicker, ExtCtrls, wwdblook, wwcheckbox, DNMPanel, ImgList,
  MemDS, Menus, AdvMenus, Shader, ProgressDialog;

type
  TfmPurchaseStatementPrint = class(TBaseInputGUI)
    imgPopup: TImageList;
    Panel4: TDNMPanel;
    lblClassTitle: TLabel;
    lblProgress: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    Bevel2: TBevel;
    Label1: TLabel;
    dtFrom: TwwDBDateTimePicker;
    Label2: TLabel;
    dtTo: TwwDBDateTimePicker;
    Bevel1: TBevel;
    grd: TwwDBGrid;
    btnSelect: TDNMSpeedButton;
    btnUnselect: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    dsStatements: TDataSource;
    qryStatement: TERPQuery;
    qryStatementSupplierName: TWideStringField;
    qryStatementTotalAmountInc: TFloatField;
    qryStatementClientID: TLargeintField;
    Label10: TLabel;
    btnAddFilter: TDNMSpeedButton;
    btnExecute: TDNMSpeedButton;
    btnClear: TDNMSpeedButton;
    edtSearch: TEdit;
    lblFilter: TLabel;
    chkChooseRpt: TCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPreviewOrPrintClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnUnselectClick(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure btnAddFilterClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure grdCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean;
      AFont: TFont; ABrush: TBrush);
    procedure qryStatementAfterOpen(DataSet: TDataSet);
  private
    flstFilter: TStringList;
    fsFilterString: string;
    FilterColumn: string;
    HighlightLocate: TColor;
    TempTableName: string;
    TempTableIsCreated: boolean;
    procedure RefreshQuery;
    procedure CreateTemporaryTable;
    procedure DestroyTemporaryTable;
    procedure PopulateTemporaryTable;
    function GetFilterString: string;
  protected
    function GetReportTypeID: integer; override;
  public
    //class function Instance: TBaseInputGUI; reintroduce;
  end;

//var
//  fmPurchaseStatementPrint: TfmPurchaseStatementPrint;

implementation

uses
  DNMExceptions, CommonDbLib,  AppEnvironment, CommonLib,
  FastFuncs, MySQLConst, tcDataUtils;

const
  HIGHLIGHTLOCATEDEF = $00DFFFFE; // a very light yellow

{$R *.dfm}

procedure TfmPurchaseStatementPrint.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;

  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  flstFilter := TStringList.Create;
  flstFilter.Sorted := true;
  flstFilter.Duplicates := dupError;
  FilterColumn := '';

  if AppEnv.Employee.ListSelectionColour = 0 then begin
    HighlightLocate := HIGHLIGHTLOCATEDEF;
  end else begin
    HighlightLocate := AppEnv.Employee.ListSelectionColour;
  end;

  dtFrom.OnChange := nil;
  dtTo.OnChange := nil;
  dtFrom.Date := Date - 120;
  dtTo.Date := Date;
  dtFrom.OnChange := dtFromChange;
  dtTo.OnChange := dtToChange;

  TempTableIsCreated := false;
  TempTableName := GetUserTemporaryTableName('PurchaseStatementPrint');
  CreateTemporaryTable;

  qryStatement.SQL.Text :=
    'SELECT SupplierName, Sum(TotalAmountInc) as TotalAmountInc, ClientID' + ' FROM ' + TempTableName +
    ' WHERE Paid <> "T"' + ' AND ((IsPO = "T") OR (IsBill = "T") OR (IsCredit = "T") OR (IsPOCredit = "T"))' +
    ' AND (OrderDate BETWEEN :DateFrom AND :DateTo)' + ' GROUP BY ClientId HAVING TotalAmountInc <> 0' +
    ' ORDER BY SupplierName';
end;

procedure TfmPurchaseStatementPrint.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmPurchaseStatementPrint.FormDestroy(Sender: TObject);
begin
  FreeAndNil(flstFilter);
  if TempTableIsCreated then DestroyTemporaryTable;
  inherited;
end;

procedure TfmPurchaseStatementPrint.FormShow(Sender: TObject);
begin
  try
    inherited;

    // If user does not have access to this form don't process any further
    if ErrorOccurred then Exit;

    qryStatement.Connection := CommonDbLib.GetSharedMyDacConnection;
    RefreshQuery;

    // set controlls based on access level
    { 1  - (Full Access)
      2  - (Full Access, No Delete)
      3  - (Create + Read)
      5  - (Read Only)
      6  - (No Access)  }

    //if Self.AccessLevel =

    // Exception Handler
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TfmPurchaseStatementPrint.btnPreviewOrPrintClick(Sender: TObject);
var
  DoPrint: boolean;
  ListIndex: integer;
  SQLPortion: string;
  SQLPortionOrderBy: string;
  DateFrom: string;
  DateTo: string;
begin
  DisableForm;
  try
    inherited;

    //
    // Exit if no records are available or if available none are selected
    //
    if (qryStatement.RecordCount = 0) or (grd.SelectedList.Count = 0) then Exit;

    //
    // Use non-form connection and set the 'from' and 'to' date variables
    // to the values in the combo boxes
    //
    fbTemplateUsesNonFormConnection := true;
    DateFrom := FormatDateTime(MysqlDateFormat, dtFrom.DateTime);
    DateTo := FormatDateTime(MysqlDateFormat, dtTo.DateTime);

    if Sender = btnPrint then DoPrint := true
    else DoPrint := false;

    //
    // Set the report type to print
    //
    if chkChooseRpt.Checked then begin
      LoadReportTypes;

      if dlgReportSelect.Execute then begin
        ReportToPrint := dlgReportSelect.SelectedItems.Text;
      end;
    end else begin
      ReportToPrint := tcdatautils.GetDefaultReport(75);
      if ReportToPrint = '' then
        ReportToPrint := 'Recipient Invoice Statement';
    end;

    //  ReportToPrint := 'Recipient Invoice Statement';
    SQLPortion := ' AND P.ClientID IN (';
    qryStatement.DisableControls;

    try
      //
      // Concatenate a list of selected client ID's (suppliers) to display on the
      // report
      //
      for ListIndex := 0 to grd.SelectedList.Count - 1 do begin
        qryStatement.GotoBookmark(grd.SelectedList.Items[ListIndex]);
        SQLPortion := SQLPortion + qryStatement.FieldByName('ClientID').AsString + ',';
      end;

      fbTemplateUsesNonFormConnection := true;
      Setlength(SQLPortion, char_length(SQLPortion) - 1);

      SQLPortion := SQLPortion + ') AND (P.OrderDate BETWEEN ' + QuotedStr(DateFrom) + ' AND ' + QuotedStr(DateTo) + ') ';

      //SQLPortionOrderBy := ' ORDER BY C.Company, P.OrderDate';
      SQLPortionOrderBy := ' Order by  P.ClientId , P.PurchaseOrderId';

      SQLPortion := SQLPortion + SQLPortionOrderBy; // + '~|||~' + SQLPortion; // + ' HAVING PL.PurchaseOrderID = :PurchaseOrderID';

      PrintTemplateReport(ReportToPrint, SQLPortion, DoPrint, 1);
    finally
      qryStatement.EnableControls;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfmPurchaseStatementPrint.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmPurchaseStatementPrint.btnSelectClick(Sender: TObject);
begin
  inherited;
  grd.SelectAll;
end;

procedure TfmPurchaseStatementPrint.btnUnselectClick(Sender: TObject);
begin
  inherited;
  grd.UnselectAll;
end;

procedure TfmPurchaseStatementPrint.dtFromChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmPurchaseStatementPrint.dtToChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmPurchaseStatementPrint.RefreshQuery;
begin
  qryStatement.Close;
  qryStatement.ParamByName('DateFrom').AsString := FormatDateTime(MysqlDateFormat, dtFrom.DateTime);
  qryStatement.ParamByName('DateTo').AsString := FormatDateTime(MysqlDateFormat, dtTo.DateTime);
  qryStatement.Open;
end;

procedure TfmPurchaseStatementPrint.CreateTemporaryTable;
var
  qry: TERPQuery;
begin
  if TempTableIsCreated then Exit;
  DestroyTemporaryTable;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;

  try
    //
    // Create a temporary table so credit fields can be changed to negative
    // values for easy summation of the the columns
    //
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text   :=
      'CREATE TABLE IF NOT EXISTS ' + TempTableName + '(' + ' `PurchaseOrderID` int(11) NOT NULL,' +
      ' `ClientID` int(11) unsigned,' + ' `OrderDate` date,' + ' `SupplierName` varchar(255),' +
      ' `TotalAmount` double,' + ' `TotalAmountInc` double,' + ' `Paid` enum("T","F") default "F",' +
      ' `IsPO` enum("T","F") default "F",' + ' `IsBill` enum("T","F") default "F",' +
      ' `IsCredit` enum("T","F") default "F",' + ' `IsPOCredit` enum("T","F") default "F",' +
      ' PRIMARY KEY (`PurchaseOrderID`)) ENGINE=MyISAM';
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;

  PopulateTemporaryTable;
  TempTableIsCreated := true;
end;

procedure TfmPurchaseStatementPrint.DestroyTemporaryTable;
begin
  DestroyUserTemporaryTable(TempTableName);
end;

procedure TfmPurchaseStatementPrint.PopulateTemporaryTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;

  try
    //
    // Negate the total amount fields tagged as credits and store in the
    // temporary table
    //
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text   :=
      'INSERT HIGH_PRIORITY INTO ' + TempTableName + ' (SELECT PurchaseOrderID, ClientID, OrderDate, SupplierName,' +
      ' TotalAmount, IF((IsCredit = "T") OR (IsPOCredit = "T"), -TotalAmountInc, TotalAmountInc) as TotalAmountInc, Paid, IsPO, IsBill, IsCredit, IsPOCredit' +
      ' FROM tblPurchaseOrders' + ' WHERE Paid <> "T"' +
      ' AND ((IsPO = "T") OR (IsBill = "T") OR (IsCredit = "T") OR (IsPOCredit = "T"))' + ' ORDER BY SupplierName)';
    qry.Execute;

  finally
    FreeAndNil(qry);
  end;
end;

procedure TfmPurchaseStatementPrint.btnAddFilterClick(Sender: TObject);
begin
  inherited;

  try
    flstFilter.Add('[' + grd.GetActiveField.FieldName + ']=' +
      QuotedStr(grd.GetActiveField.AsString));
  except
    on e: EStringListError do begin
      CommonLib.MessageDlgXP_Vista('The value you are trying to add is already in your filter list. ' +
        'Please try again.', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmPurchaseStatementPrint.btnExecuteClick(Sender: TObject);
var
  sTemp: string;
begin
  inherited;

  try
    if not Empty(fsFilterString) then begin
      sTemp := ' AND ';
    end;
    {Need to do some work here to filter when the form is opened inside a parent}
    qryStatement.Filter   := fsFilterString + sTemp + GetFilterString;
    qryStatement.Filtered := true;
  except
    on e: Exception do begin
      raise Exception.Create(e.Message + Chr(13) +
        'Please review your filter and try again.' + Chr(13) + 'Filter :' +
        qryStatement.Filter);
    end;
  end;
end;

procedure TfmPurchaseStatementPrint.btnClearClick(Sender: TObject);
begin
  inherited;
  flstFilter.Clear;

  if Empty(fsFilterString) then begin
    qryStatement.Filtered := false;
  end else begin
    qryStatement.Filter := fsFilterString;
  end;
end;

function TfmPurchaseStatementPrint.GetFilterString: string;
var
  iIndex: integer;
begin
  for iIndex := 0 to flstFilter.Count - 1 do begin
    Result := Result + flstFilter.Strings[iIndex] + ' OR ' + Chr(13);
  end;

  Result := Copy(Result, 1, char_length(Result) - 5);
end;

procedure TfmPurchaseStatementPrint.edtSearchChange(Sender: TObject);
var
  sFieldName: string;
begin
  inherited;
  sFieldName := FilterColumn;
  dsStatements.Dataset.Locate(sFieldName, edtSearch.Text, [loCaseInsensitive,
    loPartialKey]);
end;

function TfmPurchaseStatementPrint.GetReportTypeID: integer;
begin
  Result := 75;
end;

procedure TfmPurchaseStatementPrint.grdCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;

  if (edtSearch.Text <> '') then begin
    if not (gdSelected in State) and not Empty(FilterColumn) and
      (FastFuncs.PosEx(uppercase(edtSearch.Text),
      uppercase(qryStatement.FieldByName(FilterColumn).AsString)) = 1) then begin
      ABrush.Color := HighlightLocate;
    end;
  end;
end;

procedure TfmPurchaseStatementPrint.qryStatementAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FilterColumn := 'SupplierName';
end;

initialization
  RegisterClassOnce(TfmPurchaseStatementPrint);
end.
