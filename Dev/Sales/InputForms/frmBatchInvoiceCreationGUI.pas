unit frmBatchInvoiceCreationGUI;
  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 25/05/05  1.00.01 BJ  'Raise exception' is changed to MessageDlg for user messages

{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,   ExtCtrls,
  Grids, Wwdbigrd, Wwdbgrid, StdCtrls, Buttons, DNMSpeedButton, DNMPanel, wwdblook,
  wwcheckbox, QueryManipulationObj, ImgList, ProgressDialog, DBAccess,
  MyAccess,ERPdbComponents, DataState, BusObjBase, BusObjSales, Menus, AdvMenus, MemDS, Shader;

type
  TBatchInvoiceCreationGUI = class(TBaseInputGUI)
    Label9: TLabel;
    edtSearch: TEdit;
    btnClear: TDNMSpeedButton;
    btnExecute: TDNMSpeedButton;
    btnAddFilter: TDNMSpeedButton;
    grd: TwwDBGrid;
    btnSelect: TDNMSpeedButton;
    btnUnselect: TDNMSpeedButton;
    Label3: TLabel;
    Bevel1: TBevel;
    cmdCancel: TDNMSpeedButton;
    cmdCreate: TDNMSpeedButton;
    DSCustomers: TDataSource;
    qryCustomers: TERPQuery;
    Bevel2: TBevel;
    Panel4: TDNMPanel;
    Label4: TLabel;
    chkAll: TwwCheckBox;
    cboClientType: TwwDBLookupCombo;
    Label8: TLabel;
    qryClientTypes: TERPQuery;
    qryCustomersCompanyName: TWideStringField;
    qryCustomersJobName: TWideStringField;
    qryCustomersJobNumber: TIntegerField;
    qryCustomersAccountNo: TWideStringField;
    qryCustomersCustomerType: TWideStringField;
    qryCustomersStopCredit: TWideStringField;
    qryCustomersActive: TWideStringField;
    qryCustomersClientID: TIntegerField;
    qryCustomersClientTypeID: TIntegerField;
    imgPopup: TImageList;
    lblFrom: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectClick(Sender: TObject);
    procedure btnUnselectClick(Sender: TObject);
    procedure btnAddFilterClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure cmdCreateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkAllClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cboClientTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure edtSearchChange(Sender: TObject);
    procedure grdCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean;
      AFont: TFont; ABrush: TBrush);
    procedure grdCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure grdTitleButtonClick(Sender: TObject; const AFieldName: string);
  private
    { Private declarations }
    fInvoiceMasterRecord, fInvoiceDetailRecords: TDataset;
    fiSaleID: integer;
    QueryManipulationObj: TQueryManipulationObj;
    flstFilter: TStringList;
    fsFilterString: string;
    Invoice :TInvoice;
    NewInvoice :TInvoice;

    function GetFilterString: string;
    procedure RefreshQuery;
    procedure BinBatchAllocation(Const Sender: TBusObj; var Abort: boolean);    
  public
    { Public declarations }
    
    property CreateFromSaleID: integer write fiSaleID;
    property InvoiceMasterRecord: TDataset write fInvoiceMasterRecord;
    property InvoiceDetailRecords: TDataset write fInvoiceDetailRecords;
  end;

implementation
  
uses FastFuncs,DNMExceptions, (*frmBins_Batches, *)CommonDbLib, CommonLib,
  frmAllocation;
{$R *.dfm}

{ TBatchInvoiceCreationGUI }


procedure TBatchInvoiceCreationGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    lblFrom.Caption := 'From Invoice No.  -  ' + IntToStr(fiSaleID);
    try
      if AccessLevel <> 1 then begin
        AccessLevel := 6;   // all or none!!!
      end;
      inherited;
      RefreshQuery;
      OpenQueries;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TBatchInvoiceCreationGUI.RefreshQuery;
begin
  Processingcursor(True);
  try
    qryCustomers.Close;
    if chkAll.Checked then begin
      qryCustomers.SQL.Text := QueryManipulationObj.OriginalSQL;
    end else begin
      QueryManipulationObj.ProcessSearch('ClientTypeID', cboClientType.LookupTable.FieldByName('ClientTypeID').AsString);
      qryCustomers.SQL.Text := QueryManipulationObj.ModifiedSQL;
    end;
    //qryCustomers.Prepared := true;
    qryCustomers.Open;
    qryCustomers.IndexFieldNames := '[CompanyName] ASC';
  finally
    Processingcursor(False);
  end;
end;

procedure TBatchInvoiceCreationGUI.FormCreate(Sender: TObject);
begin
  flstFilter := TStringList.Create;
  flstFilter.Sorted := true;
  flstFilter.Duplicates := dupError;
  QueryManipulationObj := TQueryManipulationObj.Create(qryCustomers.SQL.Text);
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TBatchInvoiceCreationGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TBatchInvoiceCreationGUI.btnSelectClick(Sender: TObject);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(self);
  grd.SelectedList.Clear;
  try
    {***IJB need to replace clone with function?}
    // qry.Clone(qryCustomers);
    CloneDataSet(qryCustomers, qry);
    qry.First;
    while not qry.Eof do begin
      {$ifdef COMPILER_22_UP}
      grd.SelectedList.CurrentRowSelected:= true;
      {$else}
      grd.SelectedList.Add(qry.GetBookmark);
      {$endif}
      qry.Next;
    end;
    grd.Refresh;
  finally
    FreeAndNil(qry);
  end;
end;


procedure TBatchInvoiceCreationGUI.btnUnselectClick(Sender: TObject);
begin
  inherited;
  grd.SelectedList.Clear;
  grd.Refresh;
end;

procedure TBatchInvoiceCreationGUI.btnAddFilterClick(Sender: TObject);
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

procedure TBatchInvoiceCreationGUI.btnExecuteClick(Sender: TObject);
var
  sTemp: string;
begin
  try
    if not Empty(fsFilterString) then begin
      sTemp := ' AND ';
    end;
    qryCustomers.Filter   := fsFilterString + sTemp + GetFilterString;
    qryCustomers.Filtered := true;
    qryCustomers.IndexFieldNames     := '[CompanyName] ASC';
  except
    on e: Exception do begin
      raise Exception.Create(e.Message + Chr(13) + 'Please review your filter and try again.' +
        Chr(13) + 'Filter :' + qryCustomers.Filter);
    end;
  end;
end;


procedure TBatchInvoiceCreationGUI.btnClearClick(Sender: TObject);
begin
  flstFilter.Clear;
  if Empty(fsFilterString) then begin
    qryCustomers.Filtered := false;
  end else begin
    qryCustomers.Filter := fsFilterString;
  end;
end;

procedure TBatchInvoiceCreationGUI.cmdCreateClick(Sender: TObject);
var
  i: integer;
  qry: TERPQuery;
  ProgressDialog: TProgressDialog;
begin
  if qryCustomers.RecordCount = 0 then Exit;
  qry := TERPQuery.Create(self);
  Invoice := TInvoice.Create(Self);
  Try
      Invoice.Load(fiSaleID);
      ProgressDialog := TProgressDialog.Create(nil);
      try
       {***IJB need to replace clone with function?}
        //qry.Clone(qryCustomers);
        CloneDataSet(qryCustomers, qry);
        Processingcursor(True);
        try
            ProgressDialog.Caption  := 'Please Wait .......';
            ProgressDialog.MinValue := 0;
            ProgressDialog.MaxValue := grd.SelectedList.Count;
            ProgressDialog.Step     := 1;
            ProgressDialog.Execute;
            Invoice.Connection.BeginTransaction;
            Try
                for i := 0 to grd.SelectedList.Count - 1 do begin
                  ProgressDialog.Stepit;
                  Application.ProcessMessages;
                  qry.GotoBookmark(grd.SelectedList.Items[i]);
                  TfmAllocation.ShowProductDetails(True);
                  try
                    NewInvoice := TInvoice(Invoice.CopyTrans('ClientID',qry.FieldByName('ClientID').AsInteger, False , 'SaleID'));
                  finally
                     TfmAllocation.ShowProductDetails(False);
                  end;
                  if NewInvoice = nil then begin
                    Raise Exception.Create(Invoice.ResultStatus.Messages);
                    Exit;
                  end;
                  NewInvoice.IterateRecords(BinBatchAllocation);
                  NewInvoice.Save;
                end;
                Invoice.Connection.CommitTransaction;
            Except
                Invoice.Connection.RollbackTransaction;
            end;
            Self.Close;
          finally
            FreeAndNil(qry);
            FreeandNil(ProgressDialog);
          end;
      finally
        Processingcursor(False);
      end;
  Finally
      if Assigned(NewInvoice) then FreeandNil(NewInvoice);
      if Assigned(Invoice)    then FreeandNil(Invoice);
  End;
end;

procedure TBatchInvoiceCreationGUI.BinBatchAllocation(Const Sender: TBusObj; var Abort: boolean);
begin
(*    frmBins_Batches.DoBinBatchform(NewInvoice.Lines, SNrequest);*)
    NewInvoice.Lines.postdb;
    TfmAllocation.DoBinBatchform(NewInvoice.Lines.PQA,Self )
end;

function TBatchInvoiceCreationGUI.GetFilterString: string;
var
  iIndex: integer;
begin
  for iIndex := 0 to flstFilter.Count - 1 do begin
    Result := Result + flstFilter.Strings[iIndex] + ' OR ' + Chr(13);
  end;
  Result := Copy(Result, 0,char_length(Result) - 5);
end;

procedure TBatchInvoiceCreationGUI.FormDestroy(Sender: TObject);
begin
  flstFilter.Clear;
  FreeandNil(flstFilter);
  FreeandNil(QueryManipulationObj);
  inherited;
end;

procedure TBatchInvoiceCreationGUI.chkAllClick(Sender: TObject);
begin
  inherited;
  cboClientType.Enabled := not chkAll.Checked;
  RefreshQuery;
end;

procedure TBatchInvoiceCreationGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TBatchInvoiceCreationGUI.cboClientTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TBatchInvoiceCreationGUI.edtSearchChange(Sender: TObject);
var
  sFieldName: string;
begin
  if (edtSearch.Text <> '') and (qryCustomers.RecordCount > 2) then begin
    sFieldName        := 'CompanyName';
    qryCustomers.IndexFieldNames := '[' + sFieldName + '] ASC';
    DSCustomers.Dataset.Locate(sFieldName, edtSearch.Text, [loCaseInsensitive, loPartialKey]);
  end;
end;

procedure TBatchInvoiceCreationGUI.grdCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qryCustomersStopCredit.AsBoolean then begin
    AFont.Color := clRed;
  end;
end;

procedure TBatchInvoiceCreationGUI.grdCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  inherited;
  if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' ASC', qryCustomers.IndexFieldNames) > 0 then begin
    TitleImageAttributes.ImageIndex := 0;
  end else if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' DESC', qryCustomers.IndexFieldNames) > 0 then begin
    TitleImageAttributes.ImageIndex := 1;
  end else begin
    TitleImageAttributes.ImageIndex := -1;
  end;
end;

procedure TBatchInvoiceCreationGUI.grdTitleButtonClick(Sender: TObject; const AFieldName: string);
begin
  inherited;
  if (qryCustomers.FieldByName(AFieldName).FieldKind <> fkLookup) and
    (qryCustomers.FieldByName(AFieldName).FieldKind <> fkCalculated) then begin
    if FastFuncs.PosEx('[' + AFieldName + ']' + ' ASC', qryCustomers.IndexFieldNames) <> 0 then begin
      qryCustomers.IndexFieldNames := '[' + AFieldName + ']' + ' DESC';
    end else begin
      qryCustomers.IndexFieldNames := '[' + AFieldName + ']' + ' ASC';
    end;
  end;
end;

initialization
  RegisterClassOnce(TBatchInvoiceCreationGUI);

end.
