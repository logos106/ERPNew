unit frmUnassignedTaxCodesGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, wwcheckbox, DAScript,
  MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfrmUnassignedTaxCodeList = class(TBaseListingGUI)
    cboClassQry: TERPQuery;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    qryMainDate: TDateField;
    qryMainSaleID: TLargeintField;
    qryMainPurchaseOrderID: TLargeintField;
    qryMainType: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainClientID: TLargeintField;
    qryMainCompany: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainJobNumber: TLargeintField;
    qryMainGlobalRef: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainETADate: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainInvoiceDate: TWideStringField;
    qryMainCustPONumber: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainTerms: TWideStringField;
    qryMainHeld: TWideStringField;
    qryMainShipDate: TWideStringField;
    qryMainPaid: TWideStringField;
    qryMainClassID: TLargeintField;
    qryMainGJDID: TLargeintField;
    qryMainTaxCode: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure chkAllClassClick(Sender: TObject);
  private          
    procedure ChangeMainSQL(Const DateFrom, DateTo: TDateTime);
  protected
    procedure RefreshQuery; override;
  public

  end;

implementation

{$R *.dfm}
uses
  CommonLib,frmInvoice,
  AppEnvironment,frmSalesOrder,frmPurchaseOrders,frmJournalEntry,
  frmQuote;

procedure TfrmUnassignedTaxCodeList.RefreshQuery;
begin
  ProcessingCursor(True);
  try
    ChangeMainSQL(dtfrom.DateTime, dtto.DateTime);
    inherited;
    RefreshTotals;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TfrmUnassignedTaxCodeList.ChangeMainSQL(Const DateFrom, DateTo: TDateTime);
begin
  Processingcursor(True);
  try
    qryMain.Close;
    qryMain.Params.ParamByName('txtfrom').asDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').asDate   := dtto.DateTime;
    if not chkAllClass.Checked then qryMain.Params.ParamByName('xClassName').asString   := cboClass.Text
    else qryMain.Params.ParamByName('xClassName').asString   := '%';

    qryMain.Open;
  finally
    Processingcursor(False);
  end;
end;

procedure TfrmUnassignedTaxCodeList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmUnassignedTaxCodeList.FormShow(Sender: TObject);
begin
  cboClassQry.Open;
  cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
  cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
  chkAllClass.Checked := true;
  cboClass.Enabled := false;
  inherited; 
end;
    

procedure TfrmUnassignedTaxCodeList.grdMainDblClick(Sender: TObject);
var
  frm:TComponent;
begin
  if qryMain.FieldByName('Type').AsString = 'Quote' then begin
    if FormStillOpen('TQuoteGUI') then TForm(FindExistingComponent('TQuoteGUI')).Close;
    if not FormStillOpen('TQuoteGUI') then begin
      frm := GetComponentByClassName('TQuoteGUI',True,Self);
      if Assigned(frm) then begin
        with TQuoteGUI(frm) do begin
          KeyID := qryMain.FieldByName('Invoice Number').AsInteger;
          FormStyle := fsmdiChild;
        end;
      end;
    end else begin
      TSalesOrderGUI(FindExistingComponent('TInvoiceGUI')).Show;
    end;
  end;

  if qryMain.FieldByName('Type').AsString = 'Invoice' then begin
    if FormStillOpen('TInvoiceGUI') then TForm(FindExistingComponent('TInvoiceGUI')).Close;
    if not FormStillOpen('TInvoiceGUI') then begin
      frm := GetComponentByClassName('TInvoiceGUI',True,Self);
      if Assigned(frm) then begin
        with TInvoiceGUI(frm) do begin
          KeyID := qryMain.FieldByName('Invoice Number').AsInteger;
          FormStyle := fsmdiChild;
        end;
      end;
    end else begin
      TSalesOrderGUI(FindExistingComponent('TInvoiceGUI')).Show;
    end;
  end;

  if (qryMain.FieldByName('Type').AsString = 'Cash Sale')
    or (qryMain.FieldByName('Type').AsString = 'POS') then begin
    if FormStillOpen('TSalesOrderGUI') then TForm(FindExistingComponent('TSalesOrderGUI')).Close;
    if not FormStillOpen('TSalesOrderGUI') then begin
      frm := GetComponentByClassName('TSalesOrderGUI',True,Self);
      if Assigned(frm) then begin
        with TSalesOrderGUI(frm) do begin
          KeyID := qryMain.FieldByName('SaleID').AsInteger;
          FormStyle := fsmdiChild;
        end;
      end;
    end else begin
      TSalesOrderGUI(FindExistingComponent('TSalesOrderGUI')).Show;
    end;
  end else if qryMain.FieldByName('Type').AsString = 'Purchase Order' then begin
    if FormStillOpen('TPurchaseGUI') then TForm(FindExistingComponent('TPurchaseGUI')).Close;
    if not FormStillOpen('TPurchaseGUI') then begin
      frm := GetComponentByClassName('TPurchaseGUI',True,Self);
      if Assigned(frm) then begin
        with TPurchaseGUI(frm) do begin
           KeyID := qryMain.FieldByName('PurchaseOrderID').AsInteger;
          FormStyle := fsmdiChild;
        end;
      end;
    end else begin
      TPurchaseGUI(FindExistingComponent('TPurchaseGUI')).Show;
    end;
  end else if qryMain.FieldByName('Type').AsString = 'Journal Entry' then begin
    if FormStillOpen('TJournalEntryGUI') then TForm(FindExistingComponent('TJournalEntryGUI')).Close;
    if not FormStillOpen('TJournalEntryGUI') then begin
      frm := GetComponentByClassName('TJournalEntryGUI',True,Self);
      if Assigned(frm) then begin
        with TJournalEntryGUI(frm) do begin
           KeyID := qryMain.FieldByName('GJDID').AsInteger;
          FormStyle := fsmdiChild;
        end;
      end;
    end else begin
      TJournalEntryGUI(FindExistingComponent('TJournalEntryGUI')).Show;
    end;
  end;
end;

procedure TfrmUnassignedTaxCodeList.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TfrmUnassignedTaxCodeList);
end.
