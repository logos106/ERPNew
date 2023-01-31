unit frmUnInvoicedPurchItemList;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 08/06/05  1.00.01 IJB  Changed to lonly list PO's where sold qty is less than
  //                        invoiced quantity for a client.      
  // 25/07/05  1.00.02 IJB Removed HandleUnknownException (now handled by new
  //                       ExceptionalMagic code).


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook,
  kbmMemTable, Shader, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfmUnInvoicedPurchItemList = class(TBaseListingGUI)
    qryTempTable: TERPQuery;
    qryMainID: TIntegerField;
    qryMainPurchaseOrderId: TIntegerField;
    qryMainPurchaseOrderNumber: TWideStringField;
    qryMainSupplierName: TWideStringField;
    qryMainProductDescription: TWideStringField;
    qryMainQtyOrdered: TFloatField;
    qryMainQtyReceived: TFloatField;
    qryMainQtyBackOrdered: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMainOrderedFor: TWideStringField;
    qryMainOrderedValue: TFloatField;
    qryMainQtyInvoiced: TFloatField;
    qryMainOrderDate: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainUpdateFooter(Sender: TObject);
    procedure dtFromCloseUp(Sender: TObject);
    procedure dtToCloseUp(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 

  private
    { Private declarations }
    bFooterCalcInProgress: boolean;
    procedure CreateTemporaryTable;
    function GetTemporaryTableName: string;
    procedure PopulateTemporaryTable;
    procedure DropTemporaryTable;
    procedure ClearTemporaryTable;

  protected
    procedure RefreshQuery; override;
    //    procedure RefreshTotals; override;

  public
    { Public declarations }

  end;

//var
//  fmUnInvoicedPurchItemList: TfmUnInvoicedPurchItemList;

implementation

{$R *.dfm}

uses
  frmPurchaseOrders, CommonDbLib,  DNMExceptions,
  CommonLib,  AppEnvironment, MySQLConst, tcConst;

procedure TfmUnInvoicedPurchItemList.FormCreate(Sender: TObject);
begin
  inherited;
  if ErrorOccurred then Exit;
  bFooterCalcInProgress := false;
  qryMain.Close;
  CreateTemporaryTable;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT * FROM `' + GetTemporaryTableName + '`;');
  RefreshOrignalSQL;
end;

procedure TfmUnInvoicedPurchItemList.FormDestroy(Sender: TObject);
begin
  DropTemporaryTable;
  inherited;
end;

procedure TfmUnInvoicedPurchItemList.FormShow(Sender: TObject);
begin
  try
    inherited;
    if ErrorOccurred then Exit;
    RefreshQuery;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    on e: Exception do raise;
  end;
end;

procedure TfmUnInvoicedPurchItemList.RefreshQuery;
begin
  PopulateTemporaryTable;
  inherited;

  qryMainOrderedValue.DisplayFormat := AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK;
  grdMain.ColumnByName('PurchaseOrderNumber').DisplayWidth := 10;
  grdMain.ColumnByName('PurchaseOrderNumber').DisplayLabel := 'PO Number';
  grdMain.ColumnByName('OrderDate').DisplayWidth := 9;
  grdMain.ColumnByName('OrderDate').DisplayLabel := 'PO Date';
  grdMain.ColumnByName('SupplierName').DisplayWidth := 23;
  grdMain.ColumnByName('SupplierName').DisplayLabel := 'Supplier Name';
  grdMain.ColumnByName('ProductDescription').DisplayWidth := 23;
  grdMain.ColumnByName('ProductDescription').DisplayLabel := 'Product Description';
  grdMain.ColumnByName('QtyOrdered').DisplayWidth := 10;
  grdMain.ColumnByName('QtyOrdered').DisplayLabel := 'Qty Ordered';
  grdMain.ColumnByName('QtyReceived').DisplayWidth := 10;
  grdMain.ColumnByName('QtyReceived').DisplayLabel := 'Qty Received';
  grdMain.ColumnByName('OrderedValue').DisplayWidth := 13;
  grdMain.ColumnByName('OrderedValue').DisplayLabel := 'Line Value';
  grdMain.ColumnByName('OrderedFor').DisplayWidth := 23;
  grdMain.ColumnByName('OrderedFor').DisplayLabel := 'Ordered For';
  grdMain.ColumnByName('QtyInvoiced').DisplayWidth := 10;
  grdMain.ColumnByName('QtyInvoiced').DisplayLabel := 'Qty Invoiced';
end;

procedure TfmUnInvoicedPurchItemList.CreateTemporaryTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE IF NOT EXISTS `' + GetTemporaryTableName + '` (`ID` INT(11) NOT NULL AUTO_INCREMENT,');
    qry.SQL.Add('`PurchaseOrderId` int (11), `PurchaseOrderNumber` VARCHAR (30),');
    qry.SQL.Add('`OrderDate` datetime, `SupplierName` VARCHAR (255), `ProductDescription` VARCHAR (255),');
    qry.SQL.Add('`QtyOrdered` double, `QtyReceived` double, `QtyBackOrdered` double, `LineCostInc` double,');
    qry.SQL.Add('`OrderedFor` VARCHAR (255), `OrderedValue` double, `QtyInvoiced` double,');
    qry.SQL.Add('PRIMARY KEY(`ID`), UNIQUE(`ID`))  TYPE = MyISAM;');

    // Create temporary table.
    qry.Execute;

  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TfmUnInvoicedPurchItemList.GetTemporaryTableName: string;
begin
  Result := 'tmp_UnInvoicedPurchItemList_' + GetMachineIdentification(true, true, true, true);
end;

procedure TfmUnInvoicedPurchItemList.DropTemporaryTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetTemporaryTableName + '`;');
    qry.Execute;
  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfmUnInvoicedPurchItemList.ClearTemporaryTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM `' + GetTemporaryTableName + '` WHERE ID <> 0;');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfmUnInvoicedPurchItemList.PopulateTemporaryTable;
var
  qry: TERPQuery;
  cmd: TERPCommand;
  //qryRuns: TERPQuery;
  ProgressDialog: TProgressDialog;
  QtyInvoicedStr: string;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  cmd := TERPCommand.Create(nil);
  //qryRuns := TERPQuery.Create(nil);
  ProgressDialog := TProgressDialog.Create(nil);

  qryMain.Close;
  ClearTemporaryTable;

  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    cmd.Connection := CommonDbLib.GetSharedMyDacConnection;

    qry.SQL.Text := 'SELECT SUM(SL.Shipped)' + ' FROM tblSales S, tblSalesLines SL' +
      ' WHERE SL.SaleId = S.SaleId' + ' AND S.ClientId = :ClientID' + ' AND SL.Product_Description = :ProductDescription';

    qryTempTable.Close;
    qryTempTable.ParamByName('DateStart').AsDateTime := dtFrom.Date;
    qryTempTable.ParamByName('DateEnd').AsDateTime   := dtTo.Date;
    qryTempTable.Open;

    ProgressDialog.Caption  := 'Checking for Un-Invoiced Purchase Order Lines';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := qryTempTable.RecordCount;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    while not qryTempTable.Eof do begin
      QtyInvoicedStr := '0';
      qry.ParamByName('ClientId').AsInteger := qryTempTable.FieldByName('CustomerJobId').AsInteger;
      qry.ParamByName('ProductDescription').AsString := qryTempTable.FieldByName('ProductDescription').AsString;
      qry.Open;
      if qry.Fields[0].AsFloat < qryTempTable.FieldByName('QtyOrdered').AsFloat then begin
        // insert this line into tempory table
        QtyInvoicedStr := qry.Fields[0].AsString;
        if QtyInvoicedStr = '' then QtyInvoicedStr := '0';
        cmd.SQL.Text := 'INSERT HIGH_PRIORITY INTO ' + GetTemporaryTableName + ' VALUES(' + ' NULL,' +
          qryTempTable.FieldByName('PurchaseOrderId').AsString + ',' +
          QuotedStr(qryTempTable.FieldByName('PurchaseOrdernumber').AsString) + ',' +
          QuotedStr(FormatDateTime(MysqlDateFormat, qryTempTable.FieldByName('OrderDate').AsDateTime)) + ',' +
          QuotedStr(qryTempTable.FieldByName('SupplierName').AsString) + ',' +
          QuotedStr(qryTempTable.FieldByName('ProductDescription').AsString) + ',' +
          qryTempTable.FieldByName('QtyOrdered').AsString + ',' + qryTempTable.FieldByName('QtyReceived').AsString + ',' +
          qryTempTable.FieldByName('QtyBackOrdered').AsString + ',' + qryTempTable.FieldByName('LineCostInc').AsString +
          ',' + QuotedStr(qryTempTable.FieldByName('OrderedFor').AsString) + ',' +
          qryTempTable.FieldByName('OrderedValue').AsString + ',' + QtyInvoicedStr + ')';
        cmd.Execute;
      end;
      qry.Close;

      qryTempTable.Next;

      // Advance the progress status.
      ProgressDialog.StepIt;
    end;
    qryMain.Open;

  finally

    qryTempTable.Close;
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(cmd) then
      FreeAndNil(cmd);
    if Assigned(ProgressDialog) then
      FreeAndNil(ProgressDialog);
  end;
end;



procedure TfmUnInvoicedPurchItemList.grdMainUpdateFooter(Sender: TObject);
var
  dValue: double;
  oRecPointer: TBookmark;
begin
  inherited;
  if not bFooterCalcInProgress then begin
    bFooterCalcInProgress := true;
    qryMain.DisableControls;
    oRecPointer := qryMain.GetBookmark;
    try
      dValue := 0.00;
      qryMain.First;
      while not qryMain.Eof do begin
        dValue := dValue + qryMain.FieldByName('OrderedValue').AsFloat;
        qryMain.Next;
      end;
      grdMain.ColumnByName('OrderedValue').FooterValue := FloatToStrF(dValue, ffCurrency, 15, CurrencyRoundPlaces);
    finally
      qryMain.GoToBookmark(oRecPointer);
      qryMain.FreeBookmark(oRecPointer);
      qryMain.EnableControls;
      bFooterCalcInProgress := false;
    end;
  end;
end;

procedure TfmUnInvoicedPurchItemList.dtFromCloseUp(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmUnInvoicedPurchItemList.dtToCloseUp(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmUnInvoicedPurchItemList.grdMainDblClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  tmpComponent := GetComponentByClassName('TPurchaseGUI');
  If not Assigned(tmpComponent) then Exit;
  with TPurchaseGUI(tmpComponent) do begin
    KeyID := qryMain.FieldByName('PurchaseOrderId').AsInteger;
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

initialization
  RegisterClassOnce(TfmUnInvoicedPurchItemList);
end.
