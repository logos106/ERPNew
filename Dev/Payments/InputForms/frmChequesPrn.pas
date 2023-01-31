unit frmChequesPrn;
  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 25/05/05  1.00.01 BJ  'Raise exception' is changed to MessageDlg for user messages

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, AppEvnts, DB,  
  Grids, Wwdbigrd, Wwdbgrid, DNMPanel, SelectionDialog, Buttons, DNMSpeedButton, Menus, AdvMenus, ImgList,
  ActnList, StrUtils, DBAccess, MyAccess,ERPdbComponents, DataState, MemDS, Shader, dmGUIStylers,
  ProgressDialog;

type
  TChequesPrnGUI = class(TBaseInputGUI)
    btnPrint: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    dtFrom: TDateTimePicker;
    dtTo: TDateTimePicker;
    dsCheques: TDataSource;
    grd: TwwDBGrid;
    qryCheques: TERPQuery;
    btnSelect: TDNMSpeedButton;
    btnUnselect: TDNMSpeedButton;
    Bevel1: TBevel;
    Label3: TLabel;
    chkPrintFlag: TCheckBox;
    Label4: TLabel;
    actlstFilters: TActionList;
    actAddToFilter: TAction;
    actExecuteFilter: TAction;
    actClearFilter: TAction;
    imgPopup: TImageList;
    mnuFilter: TAdvPopupMenu;
    mnuAddFilter: TMenuItem;
    mnuExecute: TMenuItem;
    mnuClear: TMenuItem;
    HeaderPanel: TDNMPanel;
    Panel2: TDNMPanel;
    pnlButtons: TDNMPanel;
    btnAddFilter: TDNMSpeedButton;
    btnExecute: TDNMSpeedButton;
    btnClear: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    cboFilter: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    edtSearch: TEdit;
    qryChequesPurchaseOrderID: TAutoIncField;
    qryChequesClientID: TAutoIncField;
    qryChequesCompany: TWideStringField;
    qryChequesPONum: TWideStringField;
    qryChequesOrderDate: TDateTimeField;
    qryChequesComments: TWideStringField;
    qryChequesContact1: TWideStringField;
    qryChequesPrintFlag: TWideStringField;
    qryChequesETADate: TDateField;
    qryChequesPhone: TWideStringField;
    qryChequesInvoiced: TWideStringField;
    qryChequesInvoiceNumber: TWideStringField;
    qryChequesIsRA: TWideStringField;
    qryChequesDeleted: TWideStringField;
    qryChequesSalesComments: TWideStringField;
    qryChequesReferenceNo: TWideStringField;
    qryChequesChequeNumber: TWideStringField;
    qryChequesTotalAmountEx: TFloatField;
    qryChequesTotalTax: TFloatField;
    qryChequesTotalAmountInc: TFloatField;
    chkChooseRpt: TCheckBox;
    Label7: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkUseChequeNo: TCheckBox;
    Label8: TLabel;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure RefreshQuery;
    procedure FormShow(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectClick(Sender: TObject);
    procedure btnUnselectClick(Sender: TObject);
    procedure btnPreviewPrintClick(Sender: TObject);
    procedure LoadTemplate(bPrint: boolean; PurchaseOrderID: integer); reintroduce;
    procedure chkPrintFlagClick(Sender: TObject);
    procedure actAddToFilterExecute(Sender: TObject);
    procedure actAddToFilterUpdate(Sender: TObject);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure actExecuteFilterUpdate(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure actClearFilterUpdate(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure grdCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean;
      AFont: TFont; ABrush: TBrush);
    procedure grdColEnter(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
  private
    { Private declarations }
    HIGHLIGHTLOCATE: TColor;
    flstFilter: TStringList;
    PurchaseID: integer;
    fsFilterString: string;

    function GetFilterString: string;
    procedure PopulateFilterCombo;
    procedure ReadguiPref;
    procedure WriteGuiPrefs;
  protected
    function GetReportTypeID: integer; override;
  public
    { Public declarations }
    
  end;

//var
//  ChequesPrnGUI: TChequesPrnGUI;

implementation

uses FastFuncs, DnMLib, DNMExceptions, CommonDbLib, AppEnvironment, CommonLib,
  BusObjPrintDoc, busobjExpenses, tcTypes, tcDataUtils, tcConst;


const
  HIGHLIGHTLOCATEDEF = $00DFFFFE;  // a very light yellow rw

  {$R *.dfm}

procedure TChequesPrnGUI.FormCreate(Sender: TObject);
begin
  flstFilter := TStringList.Create;
  flstFilter.Sorted := true;
  flstFilter.Duplicates := dupError;
  inherited;
  dtFrom.Date := Date - 7;
  dtTo.Date := Date;
  if AppEnv.Employee.ListSelectionColour = 0 then begin
    HIGHLIGHTLOCATE := HIGHLIGHTLOCATEDEF;
  end else begin
    HIGHLIGHTLOCATE := AppEnv.Employee.ListSelectionColour;
  end;
end;

procedure TChequesPrnGUI.ReadguiPref;
begin
  ActivateGuiPrefs(True);
  chkChooseRpt.Checked := GuiPrefs.Node['Options.ChooseTemplate'].asBoolean;
  chkPrintFlag.Checked := GuiPrefs.Node['Options.ShowPrinted'].asBoolean;
  chkUseChequeNo.Checked := GuiPrefs.Node['Options.UseChequeNo'].asBoolean;
end;

procedure TChequesPrnGUI.RefreshQuery;
begin
  with qryCheques do begin
    Close;
    ParamByName('dtFrom').asDate := dtFrom.DateTime;
    ParamByName('dtTo').asDate   := dtTo.DateTime;

    if not chkPrintFlag.Checked then ParamByName('PrintFlag').asString := 'T'
    else ParamByName('PrintFlag').asString := 'F';
    // to show T -and- F together on grid
    // SQL:  ... where printflag <> :printflag  (print unless it's 'T')
    Prepared := true;
    Open;
  end;
end;

procedure TChequesPrnGUI.WriteGuiPrefs;
begin
  GuiPrefs.Node['Options.ChooseTemplate'].asBoolean  := chkChooseRpt.Checked;
  GuiPrefs.Node['Options.ShowPrinted'].asBoolean     := chkPrintFlag.Checked ;
  GuiPrefs.Node['Options.UseChequeNo'].asBoolean     := chkUseChequeNo.Checked ;

end;

procedure TChequesPrnGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TChequesPrnGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    if AccessLevel <> 1 then begin
      AccessLevel := 6
    end;
    try
      inherited;
      RefreshQuery;
      PopulateFilterCombo;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
    ReadguiPref;
  finally
    EnableForm;
  end;   
end;

procedure TChequesPrnGUI.dtFromChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TChequesPrnGUI.dtToChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TChequesPrnGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPrefs;
  inherited;
  Action := caFree;
//  ChequesPrnGUI := nil;
  inherited;
end;

procedure TChequesPrnGUI.btnSelectClick(Sender: TObject);
begin
  grd.SelectAll;
end;

procedure TChequesPrnGUI.btnUnselectClick(Sender: TObject);
begin
  grd.UnselectAll;
end;

procedure TChequesPrnGUI.btnPreviewPrintClick(Sender: TObject);
var 
  i: integer;
  SavedPrintDialogPref:Boolean;
  fPrintDoc :TBusObjPrintDoc;
  chequeno,s :String;

  Procedure NextChequeno;
  begin
    try
      chequeno := inttostr(strtoInt(trim(chequeno))+1);
    Except
    end;
  end;

  procedure UpdatePrintedFlag(iPurchaseID: integer);
  var
    qryUpdate: TERPCommand;
  begin
    qryUpdate := TERPCommand.Create(nil);
    try
      qryUpdate.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE tblpurchaseorders SET EditedFlag="T",PrintFlag="T"');
      if  chequeno <> '' then begin
        qryUpdate.SQL.Add(',RefNo =' +quotedstr(chequeno));
        SetSequenceNumber(SEQ_LAST_CHEQUENO, chequeno);
        nextchequeno;
      end;
      qryUpdate.SQL.Add('WHERE PurchaseOrderID=' + IntToStr(iPurchaseID) + ';');
      qryUpdate.Execute;
    finally
      FreeAndNil(qryUpdate);
    end;
  end;
begin
  DisableForm;
  SavedPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
  try
    if qryCheques.RecordCount = 0 then Exit;
    if grd.SelectedList.Count =0 then exit;
    fPrintDoc := TBusObjPrintDoc.Create(self);
    Try

      if chkUseChequeNo.Checked then begin
        Chequeno:= GetNextSequenceNumber(SEQ_LAST_CHEQUENO);
        Repeat
          s := trim(inputbox('Cheque no' , 'Please provide the first cheque number. (Cheque number has to be a number)' , chequeno));
        Until IsInteger(s) or (s='');
        Chequeno := s;
      end else begin
        Chequeno := '';
      end;

      for i := 0 to grd.SelectedList.Count - 1 do begin
        grd.DataSource.DataSet.GotoBookmark(grd.SelectedList.Items[i]);
        PurchaseID := grd.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger;
        UpdatePrintedFlag(PurchaseID);
        if Sender = btnPreview then begin
          LoadTemplate(false, grd.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger);
          fPrintDoc.Printdoc(TCheque.Classname ,   grd.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger, dtMain, Self.Classname ,dotPreview , ReportToPrint);
          if i < grd.SelectedList.Count - 1 then
            if CommonLib.MessageDlgXP_Vista('Continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then break;
        end else begin
          LoadTemplate(true, grd.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger);
          fPrintDoc.Printdoc(TCheque.Classname ,   grd.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger, dtMain, Self.Classname ,dotPrint , ReportToPrint);
        end;
        AppEnv.Employee.ShowPrintDialog := False;
      end;
    Finally
      Freeandnil(fPrintDoc);
    End;
    Self.Close;
  finally
    EnableForm;
    AppEnv.Employee.ShowPrintDialog := SavedPrintDialogPref;
  end;  
end;

procedure TChequesPrnGUI.LoadTemplate(bPrint: boolean; PurchaseOrderID: integer);
var
  sSQL: string;
  smoney: string;
  Neg: Boolean;
begin
  if chkChooseRpt.Checked then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then begin
      ReportToPrint := dlgReportSelect.SelectedItems.Text;
      //  inherited;
    end;
  end else begin
    //  inherited;
  end;
  Neg := (qryCheques.FieldByName('Total Amount (Inc)').AsFloat<0.00);
  sMoney := CurrToStrF(qryCheques.FieldByName('Total Amount (Inc)').AsFloat, ffCurrency, 2);
  sMoney := FastFuncs.RightStr(sMoney, char_length(sMoney) - 1);
  If Neg then sMoney := '-' + sMoney;
  sMoney := '**' + sMoney;
 (* sSQL := Format('Select d2.Orderdate as DateEntered, ' + '"%s" as AmountInWords, ' + '"%s" as DisplayAmount, ' +
    'tblCompanyInformation.CompanyName ,   Concat(Address," ",Address2," ",City," ", ' +
    'tblCompanyInformation.State," ",tblCompanyInformation.Postcode) AS CompanyAddress, ' +
    'Concat("Phone? ",PhoneNumber," Fax? ",tblCompanyInformation.FaxNumber) AS PhoneFax, ' +
    'Concat("ABN? ",tblCompanyInformation.ABN) AS ABN,  d2.PurchaseOrderID,d2.Account, ' +
    'SupplierName,ShipTo,OrderDate, Payment,d2.TotalAmountInc, d2.Comments, d2.SalesComments  as InternalComments, EmployeeName,PurchaseOrderNumber, ' +
    'InvoiceNumber,LineTaxCode,LineCost,LineTax,LineCostInc,Product_Description, ' +
    'CustomerJob,AccountName,Class  FROM tblCompanyInformation, ' + 'tblPurchaseOrders d2 LEFT JOIN tblPurchaseLines ' +
    'ON d2.PurchaseOrderID=tblPurchaseLines.PurchaseOrderID ' + 'LEFT JOIN tblClients C ON d2.ClientID=C.ClientID ' +
    'WHERE d2.PurchaseOrderID = %d', [MoneyWords(qryCheques.FieldByName('Total Amount (Inc)').AsFloat), sMoney, PurchaseID]);*)
  sSQL := '{CompanyInfo}Select * from tblCompanyInformation '+
          ' ~|||~{TransDet}select ' +
          Quotedstr(MoneyWords(qryCheques.FieldByName('Total Amount (Inc)').AsFloat))+' as AmountInWords, '+
          Quotedstr(sMoney) +'  as DisplayAmount,'+
          ' C.*,  '+
          ' d2.PurchaseOrderID,d2.Account,d2.SupplierName,d2.ShipTo, '+
          ' d2.OrderDate,d2.Payment,d2.TotalAmountInc, d2.EmployeeName, '+
          ' d2.PurchaseOrderNumber,d2.InvoiceNumber, '+
          ' d2.Refno,d2.Comments,d2.SalesComments  as InternalComments, '+
          ' tblPurchaseLines.LineTaxCode,tblPurchaseLines.LineCost, '+
          ' tblPurchaseLines.LineTax,tblPurchaseLines.LineCostInc, '+
          ' tblPurchaseLines.Product_Description,tblPurchaseLines.CustomerJob, '+
          ' tblPurchaseLines.AccountName,tblPurchaseLines.Class '+
          ' FROM tblPurchaseOrders d2   '+
          ' LEFT JOIN tblPurchaseLines  ON d2.PurchaseOrderID=tblPurchaseLines.PurchaseOrderID    '+
          ' LEFT JOIN tblClients C ON d2.ClientID=C.ClientID '+
          ' WHERE d2.PurchaseOrderID = ' +IntToStr(PurchaseID)+
          '~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,     '+
          ' Sum(TTCL.`TaxAmount`) TaxAmount    '+
          ' from tblpurchasetaxcodelines TTCL    '+
          ' inner join tblpurchasetaxcodes TTC on TTCL.PurchaseTaxCodeID = TTC.ID    '+
          ' where TTC.PurchaseOrderID =  ' +IntToStr(PurchaseID) +
          ' group by TTCL.`SubTaxCode` '+
          ' ~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value    '+
          ' from  tblpurchaseorders  Trans     '+
          ' inner join tblclientscustomfieldvalues CCV on Trans.ClientID = CCV.MasterID    '+
          ' inner join tblcustomfieldlist CFL on CFL.ID = CCV.CustomFieldlistId    '+
          ' where ifnull(CCV.Value,"")<>""     and CFL.ListType = "ltSupplier"  '+
          ' and Trans.PurchaseOrderID =  ' +IntToStr(PurchaseID)+' ';
  fbReportSQLSupplied := true;

  if Empty(ReportToPrint) then begin
    ReportToPrint := GetDefaultReport(7);
  end else begin
    ReportToPrint := TemplateNameToTemplateClassName(Trim(ReportToPrint));
  end;
  PrintTemplateReport(ReportToPrint, sSQL, bPrint, 1);
  //  PrintTemplateReport('TfrmCheque', sSQL, bPrint, 1);
end;

procedure TChequesPrnGUI.chkPrintFlagClick(Sender: TObject);
begin
  inherited;
  grd.SelectedList.Clear;
  RefreshQuery;
end;


procedure TChequesPrnGUI.actAddToFilterExecute(Sender: TObject);
begin
  try
    flstFilter.Add('[' + grd.GetActiveField.FieldName + ']=' + QuotedStr(grd.GetActiveField.AsString));
  except
    on e: EStringListError do begin
      {raise Exception.Create('The value you are trying to add is already in your filter list. ' +
                             'Please try again.');}
      CommonLib.MessageDlgXP_Vista('The value you are trying to add is already in your filter list. ' +
        'Please try again.', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TChequesPrnGUI.actExecuteFilterExecute(Sender: TObject);
var
  sTemp: string;
begin
  try
    if not Empty(fsFilterString) then begin
      sTemp := ' AND ';
    end;
    {Need to do some work here to filter when the form is opened inside a parent}
    qryCheques.Filter   := fsFilterString + sTemp + GetFilterString;
    qryCheques.Filtered := true;
  except
    on e: Exception do begin
      raise Exception.Create(e.Message + Chr(13) + 'Please review your filter and try again.' +
        Chr(13) + 'Filter :' + qryCheques.Filter);
    end;
  end;
end;

procedure TChequesPrnGUI.actClearFilterUpdate(Sender: TObject);
begin
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  actClearFilter.Enabled := flstFilter.Count > 0;
end;

procedure TChequesPrnGUI.actClearFilterExecute(Sender: TObject);
begin
  flstFilter.Clear;
  if Empty(fsFilterString) then begin
    qryCheques.Filtered := false;
  end else begin
    qryCheques.Filter := fsFilterString;
  end;
end;


procedure TChequesPrnGUI.actExecuteFilterUpdate(Sender: TObject);
begin
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  actExecuteFilter.Enabled := flstFilter.Count > 0;
end;

procedure TChequesPrnGUI.actAddToFilterUpdate(Sender: TObject);
begin
  If (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  If (grd.GetActiveField=nil) then Exit;
  actAddToFilter.Enabled := not Empty(grd.GetActiveField.AsString) and
    ((flstFilter.IndexOfName('[' + grd.GetActiveField.FieldName + ']') <> -1) or (flstFilter.Count = 0));
end;

function TChequesPrnGUI.GetFilterString: string;
var
  iIndex: integer;
begin
  for iIndex := 0 to flstFilter.Count - 1 do begin
    Result := Result + flstFilter.Strings[iIndex] + ' OR ' + Chr(13);
  end;
  Result := Copy(Result, 0, char_length(Result) - 5);
end;

procedure TChequesPrnGUI.edtSearchChange(Sender: TObject);
var
  sFieldName: string;
begin
  if (qryCheques.RecordCount > 1) and (edtSearch.Text <> '') then begin
    sFieldName      := 'Company';//TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).FieldName;
    qryCheques.IndexFieldNames := '[' + sFieldName + '] ASC';
    dsCheques.Dataset.Locate(sFieldName, edtSearch.Text, [loCaseInsensitive, loPartialKey]);
  end;
end;

procedure TChequesPrnGUI.PopulateFilterCombo;
var
  {iIndex: Integer; }
  sLabel: string;
begin
  cboFilter.Items.Clear;
  //for iIndex := 0 to qryCheques.fields.count - 1 do begin
  //  if (qryCheques.fields[iIndex].Visible) and
  //      ((qryCheques.Fields[iIndex].DataType = ftString) or
  //      (qryCheques.Fields[iIndex].DataType = ftWideString)) then begin
  sLabel := 'Company'; //grd.ColumnByName(qryCheques.Fields[iIndex].FieldName).DisplayLabel;
  cboFilter.Items.AddObject(sLabel, qryCheques.FieldByName('Company')); //[iIndex]);

  //  end;
  //  end;
  cboFilter.ItemIndex := 0;
end;

procedure TChequesPrnGUI.grdCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
{  
if (not Empty(cboFilter.Text)) and
   (not (gdSelected in State) or not TwwDBGrid(Sender).Focused) and
   (FastFuncs.PosEx(uppercase(edtSearch.Text),
   uppercase(qryCheques.FieldByName(TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).FieldName).AsString)) = 1) then Begin
   ABrush.Color := HIGHLIGHTLOCATE;
   AFont.Color := clBlack;
   end;   }
end;


procedure TChequesPrnGUI.grdColEnter(Sender: TObject);
var
  iIndex: integer;
begin
  iIndex := cboFilter.Items.IndexOf(TwwDBGrid(Sender).ColumnByName(TwwDBGrid(Sender).GetActiveField.FieldName).DisplayLabel);
  if iIndex <> -1 then cboFilter.ItemIndex := iIndex;
end;

procedure TChequesPrnGUI.Button1Click(Sender: TObject);
begin
  inherited;
  grd.SelectedList.Clear;
  RefreshQuery;
end;

function TChequesPrnGUI.GetReportTypeID: integer;
begin
  Result := 7;
end;

procedure TChequesPrnGUI.btnEmailClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

Initialization
  RegisterClassOnce(TChequesPrnGUI);

end.
