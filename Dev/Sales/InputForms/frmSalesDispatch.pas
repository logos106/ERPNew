unit frmSalesDispatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusobjSalesDispatch, wwdbdatetimepicker, BusObjBase,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdblook;

type
  TfmSalesDispatch = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    pnlBatch: TDNMPanel;
    edtBatch: TEdit;
    lblBatch: TLabel;
    DNMPanel5: TDNMPanel;
    QrySalesDispatch: TERPQuery;
    dsSalesDispatch: TDataSource;
    SaleDate_Label: TLabel;
    dtDispatchdate: TwwDBDateTimePicker;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    QrySalesDispatchLines: TERPQuery;
    dsSalesDispatchLines: TDataSource;
    QrySalesDispatchLinesID: TIntegerField;
    QrySalesDispatchLinesGlobalRef: TWideStringField;
    QrySalesDispatchLinesDispatchID: TIntegerField;
    QrySalesDispatchLinesSaleID: TIntegerField;
    QrySalesDispatchLinesSaleLineID: TIntegerField;
    QrySalesDispatchLinesQty: TFloatField;
    QrySalesDispatchLinesUOMQty: TFloatField;
    QrySalesDispatchLinesmstimestamp: TDateTimeField;
    QrySalesDispatchLinesmsUpdateSitecode: TWideStringField;
    QrySalesDispatchID: TIntegerField;
    QrySalesDispatchGlobalRef: TWideStringField;
    QrySalesDispatchDispatchDate: TDateTimeField;
    QrySalesDispatchmstimestamp: TDateTimeField;
    QrySalesDispatchmsUpdateSitecode: TWideStringField;
    btnNext: TDNMSpeedButton;
    QrySalesDispatchLinesBatchNo: TWideStringField;
    QrySalesDispatchLinesProductID: TIntegerField;
    QrySalesDispatchLinesUOMID: TIntegerField;
    QrySalesDispatchLinesProductName: TWideStringField;
    QrySalesDispatchLinesUOMMultiplier: TFloatField;
    QrySalesDispatchEmployeeID: TIntegerField;
    QrySalesDispatchEmployeeName: TWideStringField;
    cboEmployeeLookup: TERPQuery;
    Label48: TLabel;
    cboEmployee: TwwDBLookupCombo;
    cboEmployeeLookupEmployeeID: TIntegerField;
    cboEmployeeLookupEmployeeName: TWideStringField;
    btnDel: TDNMSpeedButton;
    QrySalesDispatchLinesShipFromInvoice: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtBatchExit(Sender: TObject);
    procedure edtBatchKeyPress(Sender: TObject; var Key: Char);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdTransactionsExit(Sender: TObject);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnDelClick(Sender: TObject);
  private
    SalesDispatch: TSalesDispatch;
    function SaveRecord: Boolean;
    procedure ProcessBarcode(Barcode: String);
    procedure PrintDelDocket;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
  end;


implementation

uses CommonLib, BusObjConst, DNMLib, BatchBarcodeObj, FormFactory, tcConst,
  AppEnvironment, tcDataUtils, CommonFormLib;

{$R *.dfm}

procedure TfmSalesDispatch.btnDelClick(Sender: TObject);
begin
  inherited;
  if SalesDispatch.Dirty then begin
    if CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
          if SaveRecord then begin
            try
              CommitTransaction;
            finally
              BeginTransaction;
            end;
          end else begin
            Exit;
          end;
    end else begin
      Exit;
    end;
  end;
  PrintDelDocket;
end;
procedure TfmSalesDispatch.PrintDelDocket;
var
  ssqL:String;
begin
    ssql := '~|||~Where SD.Id = ' + inttostr(SalesDispatch.ID) + ' Order by SaleId, ProductName, BAtchno';
    fbReportSQLSupplied := False;
    PrintTemplateReport(TemplateToPrint('Sales Dispatch Delivery Docket' ,False, 'Sales Dispatch Delivery Docket' ) , ssql, PrintReport(nil) , 1);
    Self.Close;
end;

procedure TfmSalesDispatch.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if accesslevel >3 then exit;
  if MessageDlgXP_Vista('Are you sure to delete this Batch from the Dispatch?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    SalesDispatch.Lines.Delete;
  end;
end;

procedure TfmSalesDispatch.btnNextClick(Sender: TObject);
begin
  inherited;
  if (SalesDispatch.Dirty) then begin
    if not SaveRecord then exit;
    SalesDispatch.Connection.CommitTransaction;
    SalesDispatch.Dirty := False;
  end;


  SalesDispatch.Connection.BeginTransaction;
  accesslevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
  if accesslevel <=3 then  AccessLevel := 1
  else Exit;

  if accesslevel <=3 then begin
    SalesDispatch.New;
    SalesDispatch.Lines;
    Setcontrolfocus(dtDispatchdate);
  end;
end;

procedure TfmSalesDispatch.cboEmployeeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  SalesDispatch.EmployeeId := cboEmployeeLookupEmployeeID.AsInteger;
  SalesDispatch.EmployeeName := cboEmployeeLookupEmployeeName.AsString;
end;

procedure TfmSalesDispatch.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmSalesDispatch.SaveRecord :Boolean;
begin
  result:= False;
  SalesDispatch.PostDB;
  if not(SalesDispatch.Save) then exit;
  SalesDispatch.Dirty := False;
  Result:= True;

end;


procedure TfmSalesDispatch.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  SalesDispatch.Connection.CommitTransaction;
  PrintDelDocket;
end;

procedure TfmSalesDispatch.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited ;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TSalesDispatch      then TSalesDispatch(Sender).Dataset       := QrySalesDispatch
        else if Sender is Tsalesdispatchlines then Tsalesdispatchlines(Sender).Dataset  := QrySalesDispatchLines;
     end else if (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) then begin
     end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_TransQtyChanged)  then begin

     end;
end;

procedure TfmSalesDispatch.edtBatchExit(Sender: TObject);
var
  keyChar: char;
begin
  inherited;
  if TEdit(Sender).Modified then begin
    TEdit(Sender).Modified:= false;
    keyChar:= chr(VK_RETURN);
    self.edtBatchKeyPress(edtBatch, keyChar);
  end;
end;
procedure TfmSalesDispatch.ProcessBarcode(Barcode:String);
var
  fdQty :Double;
  SalesDispatchBatchBarcode : TSalesDispatchBatchBarcode;
begin
  SalesDispatchBatchBarcode := TSalesDispatchBatchBarcode.create;
  try
    SalesDispatchBatchBarcode.Barcode := Barcode;
    if not SalesDispatchBatchBarcode.IsBarCodeValid then begin
        MessageDlgXP_Vista(SalesDispatchBatchBarcode.BarcodevalidationMsg, mtWarning, [mbOK], 0);
        Exit;
    end;
      fdQty := SalesDispatch.QtyTobedispatched(SalesDispatchBatchBarcode.InvoiceLineID,SalesDispatchBatchBarcode.batchno,0);
      if fdQty <>0 then begin
        SalesDispatch.NewDispatchEntry(SalesDispatchBatchBarcode.InvoiceLineID, SalesDispatchBatchBarcode.Batchno, fdQty);
        Exit;
      end;

      if  (SalesDispatchBatchBarcode.SalesOrderLineID =0) and (SalesDispatchBatchBarcode.InvoiceLineID <> 0) then begin
        fdQty := SalesDispatch.QtyTobeShipped(SalesDispatchBatchBarcode.InvoiceLineID,SalesDispatchBatchBarcode.batchno,0);
        if fdQty <> 0 then begin
          SalesDispatch.NewInvoiceDispatchEntry(SalesDispatchBatchBarcode.InvoiceLineID, SalesDispatchBatchBarcode.Batchno, fdQty);
          Exit;
        end;
      end;

      MessageDlgXP_Vista('This Batch is completely dispatched', mtWarning, [mbOK], 0);
      Exit;

  finally
    Freeandnil(SalesDispatchBatchBarcode);
  end;
end;
procedure TfmSalesDispatch.edtBatchKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

      if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin

        if (Accesslevel > 3) and (edtBatch.Text <> '') then begin
          edtBatch.Text := '';
          CommonLib.MessageDlgXP_Vista('You have ''Read-only'' access to ' + GetFormDescription(Self.ClassName), mtInformation, [mbOK], 0);
          exit;
        end;

        ProcessBarcode(Uppercase(edtBatch.Text));
        edtBatch.Text := '';
        SetControlfocus(edtBatch);
        Application.ProcessMessages;
      end;
end;

procedure TfmSalesDispatch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmSalesDispatch.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if SalesDispatch.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          SalesDispatch.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmSalesDispatch.FormCreate(Sender: TObject);
begin
  inherited;
  SalesDispatch := TSalesDispatch.CreateWithNewConn(Self);
  SalesDispatch.Connection.connection := Self.MyConnection;
  SalesDispatch.BusObjEvent := DoBusinessObjectEvent;
  ShowControlhint(pnlBatch , 'These Sale-Batch Barcodes can be printed from the Invoice form. Invoice->Print->Dispatch Barcode'+NL+
                              '(Please note that these barcodes are different from the Product Barcode.)' +NL+
                              'These can be printed from the ' + Quotedstr(AppEnv.AccessLevels.GetFormDescription('TSalesDispatchBatchesGUI'))+' as Well.'+NL);
end;
procedure TfmSalesDispatch.FormShow(Sender: TObject);
var
  Msg:String;
begin
  inherited;
  SalesDispatch.Load(KeyID);
      if not SalesDispatch.Lock then begin
          AccessLevel             := 5;
          grdTransactions.Options := grdTransactions.Options - [dgEditing];
          Msg :=SalesDispatch.UserLock.LockMessage;
          Msg := replaceStr(Msg, 'Unable to update data.' , 'Unable to Create a Dispatch.');
          Msg := replaceStr(Msg, 'accessing this record' , 'Creating a Dispatch');
          Msg := replaceStr(Msg, 'Record has been in use' , 'Module has been in use');
          MessageDlgXP_Vista(Msg,mtInformation,[mbOk],0);
          Exit
      end;
  if accesslevel <=3 then  AccessLevel := 1;

  SalesDispatch.connection.BeginTransaction;
  if SalesDispatch.count=0 then begin
    if Accesslevel <= 3 then begin
      SalesDispatch.new;
      SalesDispatch.PostDB;
    end;
  end else begin
    Accesslevel := 5;
  end;
  SalesDispatch.Lines;

  OpenQueries;
  Setcontrolfocus(edtBatch);
end;


procedure TfmSalesDispatch.grdTransactionsExit(Sender: TObject);
begin
  inherited;
  SalesDispatch.Lines.postDB;
end;

initialization
  RegisterClassOnce(TfmSalesDispatch);
  with FormFact do
  begin
    RegisterMe(TfmSalesDispatch, 'TSalesDispatchesGUI_*=DispatchID');
  end;


end.

