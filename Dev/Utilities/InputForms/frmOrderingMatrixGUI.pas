unit frmOrderingMatrixGUI;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 25/07/05  1.00.01 DSP  Added functionality for use with stock adjustment.
                        Fixed fault where 'Create' button needed to be
                        clicked twice to function.
 09/03/06  1.00.02 DSP  Added functionality for stock transfer.
 12/04/05  1.00.03 DSP  Removed functionality for AdvMatrix.
 28/08/06  1.00.04 DSP  Fixed fault where the ordered quantity was being
                        stored in the Shipped value for purchase orders instead
                        of the Back Order value.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  SelectionDialog, AppEvnts, DB,  Grids, BaseGrid, AdvGrid, wwdblook,
  Sales, Cash, frmSmartOrderFrm, frmPurchaseOrders, MyAccess, MemDS, DBAccess,
  wwcheckbox, frmPartsFrm, DNMLib, KbmMemTable, ActnList, ActnMan,
  DataState, Types, AdvCGrid, Menus, AdvMenus, Shader;

const
  SX_SummariseTotals = WM_USER + 100;

type
  TOrderingMatrixGUI = class(TBaseInputGUI)
    cmdCreate: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    lblFrom: TLabel;
    lblYAxis: TLabel;
    cmdClear: TDNMSpeedButton;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    cboX: TwwDBLookupCombo;
    cboY: TwwDBLookupCombo;
    Bevel2: TBevel;
    lblXAxis: TLabel;
    qryDescAttribs: TMyQuery;
    cbShowAll: TwwCheckBox;
    Label5: TLabel;
    ChkAlphaX: TwwCheckBox;
    Label6: TLabel;
    ChkAlphaY: TwwCheckBox;
    Label1: TLabel;
    btnSelectAll: TDNMSpeedButton;
    btnClearAll: TDNMSpeedButton;
    lblTitle: TLabel;
    ActionManager1: TActionManager;
    actFocus: TAction;
    grdMatrix: TAdvStringGrid;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;

    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboXCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboYCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdClearClick(Sender: TObject);
    procedure cmdCreateClick(Sender: TObject);
    procedure grdMatrixSelectCell(Sender: TObject; ACol, ARow: integer; var CanSelect: boolean);
    procedure grdMatrixCellValidate(Sender: TObject; Col, Row: integer; var Value: string; var Valid: boolean);
    procedure ChkAlphaXClick(Sender: TObject);
    procedure ChkAlphaYClick(Sender: TObject);
    procedure cbShowAllClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure grdMatrixKeyPress(Sender: TObject; var Key: char);
    procedure actFocusUpdate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdMatrixKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
    iCount: integer;
    Sale: TBaseSaleGUI;
    Cash: TBaseCashGUI;
    Smart: TSmartOrderGUI;
    Parts: TfrmParts;
    StoredClassTo: string;
    fbFormStarting: boolean;
    PO: TPurchaseGUI;
    MatrixMode: TMatrixQtyMode;
    fiClassID, fiProductID: integer;
    fbAdvMartixMode: boolean;
    fbFromPriceMatrix: boolean;
    fbFromPriceMatrixQty: boolean;
    (*fbFromStockAdjustment: boolean;*)
    fbEditingStarted: boolean;
    fbFromStockTransfer: boolean;
    pmqMemData: TKbmMemTable;
    sPriceMatrixTempTableName: string;
    XDescAttribNo, YDescAttribNo: integer;
    procedure SetupGrid;
    procedure SetUpGridXYaxis(const XComboName: string; const YComboName: string);
    procedure SetUpGridXYaxisAdvMatrix(const XComboName: string; const YComboName: string);

    function GetComboList(const ComboName, Axis: string): string;
    function GetComboValueCount(const ComboName: string): integer;
    function GetComboValueCountAdvMatrixUOM: integer;
    function GetComboValueCountAdvMatrixSupp: integer;
    function GetComboListAdvMatrixUOM: string;
    function GetComboListAdvMatrixSupp: string;
    function AssignDescAttribcbo(const DescAttribNo: integer): TwwDBLookupCombo;
    function AssignDescAttribField(const DescAttribNo: integer): TStringField;
    function AddNewProductLine(const ProductID: integer; const XDescAttrib, YDescAttrib: string;
      const QtyOrdered: double; const FirstItem: boolean; const iCount: integer): boolean;
    procedure SummariseTotals(var Msg: TMessage); message SX_SummariseTotals;

    procedure SetUpAdvMatrixLockedCells;
    procedure SetUpMatrixLockedCells;

    function IsLockedCell(const UOM, Supp: string): boolean;
    function GetAutoBarcode(iOffset: integer): string;

    (*procedure AddNewStockAdjustmentLine(const ProductID: integer; const XDescAttrib, YDescAttrib: string;
      const Quantity: double; const FirstItem: boolean);*)
    procedure AddNewStockTransferLine(const ProductID: integer; const XDescAttrib, YDescAttrib: string;
      const Quantity: double; const FirstItem: boolean);
  public
    { Public declarations }
    qryMatrix: TMyQuery;
    property ProductID: integer read fiProductID write fiProductID;
    property ClassID: integer read fiClassID write fiClassID;
    property FromPriceMatrix: boolean read fbFromPriceMatrix write fbFromPriceMatrix default false;
    property FromPriceMatrixQty: boolean read fbFromPriceMatrixQty write fbFromPriceMatrixQty default false;
    (*property FromStockAdjustment: boolean read fbFromStockAdjustment write fbFromStockAdjustment default false;*)
    property FromStockTransfer: boolean read fbFromStockTransfer write fbFromStockTransfer default false;
    property PriceMatrixTempTableName: string read sPriceMatrixTempTableName write sPriceMatrixTempTableName;
    property PriceMatrixQtyMode: TMatrixQtyMode read MatrixMode write MatrixMode;

    property AdvMartixMode: boolean read fbAdvMartixMode write fbAdvMartixMode;
    property MyCount: integer read iCount write iCount default 0;

  end;

//var
//  OrderingMatrixGUI: TOrderingMatrixGUI;

implementation

uses
  DNMExceptions, CommonDbLib,  CommonLib, 
  (*frmStockTransfer, *)AppEnvironment, FastFuncs, frmStockAdjustEntryFlat;

{$R *.dfm}

// ---------- TOrderingMatrixGUI -----------------------------------------------------
procedure TOrderingMatrixGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  fbEditingStarted := false;
  grdMatrix.Options := grdMatrix.Options + [goEditing];
  (*fbFromStockAdjustment := false;*)
  fbFromStockTransfer := false;
  //  grdMatrix.Align := alClient;
end;

procedure TOrderingMatrixGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

//class function TOrderingMatrixGUI.Instance(fOwner: TComponent): TBaseInputGUI;
//begin
//  if not Assigned(OrderingMatrixGUI) then begin
//    OrderingMatrixGUI := TOrderingMatrixGUI.Create(fOwner);
//  end;
//
//  Result := OrderingMatrixGUI;
//end;

procedure TOrderingMatrixGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  grdMatrix.Parent := Self;
  CloseQueries;
  Action := caFree;
  inherited;
end;

procedure TOrderingMatrixGUI.FormShow(Sender: TObject);
begin
  lblFrom.Caption := 'of Product - ' + GetPartName(fiProductID);
  pmqMemData := nil;
  qryMatrix := TMyQuery.Create(nil);

  try
    fbFormStarting := true;
    if AccessLevel <> 1 then begin
      AccessLevel := 6;   // all or none!!!
    end;

    inherited;

    // Are we using the Advanced matrix?
    if not fbAdvMartixMode then begin
      // No
      OpenQueries;
      cboX.Text := AppEnv.CompanyPrefs.XaxisComboName;
      cboY.Text := AppEnv.CompanyPrefs.YaxisComboName;
      if not FromPriceMatrixQty then begin
        ChkAlphaX.Checked := AppEnv.CompanyPrefs.OrderingMartixAplhaOrderX;
        ChkAlphaY.Checked := AppEnv.CompanyPrefs.OrderingMartixAplhaOrderY;
      end;
    end else begin
      // Yes
      TitleLabel.Caption := 'Advanced Ordering Matrix';
      pnlTitle.Left := 168;
      pnlTitle.Width := 383;
      Label3.Enabled := false;
      Label4.Enabled := false;
      //       cboX.Enabled := False;
      //       cboY.Enabled := False;
      Label1.Enabled := false;
      cbShowAll.Enabled := false;
      Label5.Enabled := false;
      Label6.Enabled := false;
      ChkAlphaX.Enabled := false;
      ChkAlphaY.Enabled := false;
    end;

    // Was this form called from the Parts form under the Price Matrix Tab?
    if FromPriceMatrix then begin
      // Yes, then setup interface.
      cbShowAll.Checked := true;
      grdMatrix.CheckTrue := 'T';
      grdMatrix.CheckFalse := 'F';
      btnClearAll.Visible := true;
      btnSelectAll.Visible := true;
      lblTitle.Visible := true;
      lblTitle.Caption := 'Please select your entries to place on the Price Matrix';
      cmdClear.Enabled := false;
      TitleLabel.Caption := 'Matrix Selection Panel';
      Self.Caption := 'Matrix Selection Panel';
      //       Bevel3.Visible := False;
      //       Label2.Visible := False;
      //       Bevel4.Visible := False;
      //       Bevel5.Visible := False;
      //       Bevel6.Visible := False;
      //       Bevel7.Visible := False;
      //       Bevel8.Visible := False;
      //       Bevel9.Visible := False;
      //       Bevel10.Visible := False;
      //       Bevel11.Visible := False;
      //       Bevel12.Visible := False;
      //       lblColumn1Total.Visible := False;
      //       lblColumn2Total.Visible := False;
      //       lblColumn3Total.Visible := False;
      //       lblColumn4Total.Visible := False;
      //       lblColumn5Total.Visible := False;
      //       lblColumn6Total.Visible := False;
      //       lblColumn7Total.Visible := False;
      //       lblColumn8Total.Visible := False;
      //       lblColumn9Total.Visible := False;
      grdMatrix.Height := 337;
      // Was this form called from the Parts form under the Price Matrix Qty Tab?
    end else if FromPriceMatrixQty then begin
      // Yes, then setup interface.
      cbShowAll.Checked := true;
      Self.Action := nil;
      TitleLabel.Caption := 'Matrix Display';
      Self.Caption := 'Matrix Display';
      grdMatrix.CheckTrue := 'T';
      grdMatrix.CheckFalse := 'F';
      grdMatrix.Options := grdMatrix.Options - [goEditing];
      grdMatrix.Options := grdMatrix.Options - [goRangeSelect];
      //       cboX.Enabled := False;
      //       cboY.Enabled := False;
      cmdClear.Enabled := false;
      cmdCreate.Enabled := false;
      lblTitle.Visible := true;

      // Determine Price Matrix Qty Mode.
      case PriceMatrixQtyMode of
        // Back Ordered on Invoices.
        mqmAllocatedBO:
          begin
            lblTitle.Caption := 'Allocated Invoice Back Orders';
          end;

        // Allocated on Sales Orders
        mqmAllocatedSO:
          begin
            lblTitle.Caption := 'Allocated on Sale Orders';
          end;

        // Sale order Back Orders
        mqmSOBO:
          begin
            lblTitle.Caption := 'Back Ordered Sales Orders';
          end;

        // Purchase Orders.
        mqmOnOrder:
          begin
            lblTitle.Caption := 'Purchases / On Order';
          end;

        // To Sell.
        mqmToSell:
          begin
            lblTitle.Caption := 'Available To Sell';
            pmqMemData := TKbmMemTable.Create(nil);
            pmqMemData.LoadFromDataset(TfrmParts(Owner).qryPriceMatrixQtys, [mtcpoStructure, mtcpoProperties]);
          end;

        // Currently In Stock
        mqmInStock:
          begin
            lblTitle.Caption := 'Quantity In Stock';
            pmqMemData := TKbmMemTable.Create(nil);
            pmqMemData.LoadFromDataset(TfrmParts(Owner).qryPriceMatrixQtys, [mtcpoStructure, mtcpoProperties]);
          end;

        // Currently available on Stock.
        mqmAvailable:
          begin
            lblTitle.Caption := 'Stock Available';
            pmqMemData := TKbmMemTable.Create(nil);
            pmqMemData.LoadFromDataset(TfrmParts(Owner).qryPriceMatrixQtys, [mtcpoStructure, mtcpoProperties]);
          end;
      end;

      PostMessage(Self.Handle, SX_SummariseTotals, 1, 0);
(*    end else if FromStockAdjustment then begin
      TitleLabel.Caption := 'Stock Adjustment Matrix';
      Caption := 'Stock Adjustment Matrix';*)
    end else if FromStockTransfer then begin
      TitleLabel.Caption := 'Stock Transfer Matrix';
      Caption := 'Stock Transfer Matrix';
    end;

    // Clear the Matrix Grid.
    grdMatrix.Clear;

    // Initialise our grid.
    SetupGrid;

    fbFormStarting    := false;
    grdMatrix.Options := grdMatrix.Options + [goEditing];
    //    grdMatrix.Options := grdMatrix.Options + [goAlwaysShowEditor];

    // Our exception handler.
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TOrderingMatrixGUI.SetUpGridXYaxis(const XComboName: string; const YComboName: string);
var
  ColCount, RowCount: integer;
begin
  //### X - axis ####
  ColCount := GetComboValueCount(XComboName) + 1;
  if (ColCount = 1) then ColCount := 2;
  grdMatrix.FixedCols := 1;
  grdMatrix.ColCount := ColCount;
  grdMatrix.ColumnHeaders.Text := #13 + GetComboList(XComboName, 'X');

  //### Y - axis ####
  RowCount := GetComboValueCount(YComboName) + 1;
  if (RowCount = 1) then RowCount := 2;
  grdMatrix.FixedRows := 1;
  grdMatrix.RowCount := RowCount;
  grdMatrix.RowHeaders.Text := #13 + GetComboList(YComboName, 'Y');

  // Setup Matrix Locked cells.
  SetUpMatrixLockedCells;
end;

procedure TOrderingMatrixGUI.SetUpGridXYaxisAdvMatrix(const XComboName, YComboName: string);
var
  ColCount, RowCount: integer;
begin
  //### X - axis #### UOM
  ColCount := GetComboValueCountAdvMatrixUOM + 1;
  if (ColCount = 1) then ColCount := 2;
  grdMatrix.FixedCols := 1;
  grdMatrix.ColCount := ColCount;
  grdMatrix.ColumnHeaders.Text := #13 + GetComboListAdvMatrixUOM;

  //### Y - axis #### Supplier
  RowCount := GetComboValueCountAdvMatrixSupp + 1;
  if (RowCount = 1) then RowCount := 2;
  grdMatrix.FixedRows := 1;
  grdMatrix.RowCount := RowCount;
  grdMatrix.RowHeaders.Text := #13 + GetComboListAdvMatrixSupp;

  // Setup the Advanced matrix locked cells.
  SetUpAdvMatrixLockedCells;
end;

function TOrderingMatrixGUI.GetComboList(const ComboName, Axis: string): string;
var
  qryTemp: TMyQuery;
  columnName: string;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    if not (FromPriceMatrixQty) then begin
      if Empty(ComboName) then Exit;
      if cbShowAll.Checked then begin
        qryTemp.Sql.Add('SELECT DescriptionAttribLineID, DescriptionAttribValue ');
        qryTemp.Sql.Add('FROM tbldescriptionattribsetup ');
        qryTemp.Sql.Add('INNER JOIN tbldescriptionattriblines USING(DescriptionAttribID) ');
        qryTemp.Sql.Add('Where ComboName = ' + QuotedStr(ComboName) + ' AND tbldescriptionattribsetup.Active="T"  ');

        if ((FastFuncs.UpperCase(Axis) = 'Y') and ChkAlphaY.Checked) or
          ((FastFuncs.UpperCase(Axis) = 'X') and ChkAlphaX.Checked) then begin
          qryTemp.SQL.Add(' ORDER BY DescriptionAttribValue;');
        end;

        qryTemp.Open;
      end else begin
        columnName := 'DescAttrib' + FastFuncs.IntToStr(GetDescAttribNo(ComboName));
        qryTemp.Close;
        qryTemp.SQL.Text :=
          'SELECT ' + columnName + ' AS DescriptionAttribValue From tbldescriptionattriblines ' +
          'INNER JOIN tblPricematrix on DescriptionAttribValue=' + columnName + ' ' + ' WHERE PartsID = ' +
          FastFuncs.IntToStr(fiProductID) + ' GROUP BY DescriptionAttribValue';

        if ((FastFuncs.UpperCase(Axis) = 'Y') and ChkAlphaY.Checked) or
          ((FastFuncs.UpperCase(Axis) = 'X') and ChkAlphaX.Checked) then begin
          qryTemp.SQL.Add(' ORDER BY DescriptionAttribValue;');
        end else begin
          qryTemp.SQL.Add(' ORDER BY DescriptionAttribLineID;');
        end;;

        // Execute query and return records.
        qryTemp.Open;
      end;
    end;

    // Are we coming from the Price Matrix Qty Tab in the Product Form?
    if (FromPriceMatrixQty) then begin
      // Yes, get first record.
      qryMatrix.Close;
//      qryMatrix.Connection := frmParts.qryPriceMatrixQtys.Connection;
      qryMatrix.Connection := TfrmParts(Owner).qryPriceMatrixQtys.Connection;
      qryMatrix.SQL.Clear;
      if (FastFuncs.UpperCase(Axis) = 'X') then begin
        qryMatrix.SQL.Add('SELECT DISTINCT DescAttrib1');
        qryMatrix.SQL.Add('FROM ' + PriceMatrixTempTableName);

        if ChkAlphaX.Checked then begin
          qryMatrix.SQL.Add('ORDER BY DescAttrib1');
        end else begin
          qryMatrix.SQL.Add('ORDER BY DescAttrib1ID, DescAttrib2ID');
        end;

        qryMatrix.Open;
        grdMatrix.ColCount := qryMatrix.RecordCount + 1;
      end else if (FastFuncs.UpperCase(Axis) = 'Y') then begin
        qryMatrix.SQL.Add('SELECT DISTINCT DescAttrib2');
        qryMatrix.SQL.Add('FROM ' + PriceMatrixTempTableName);

        if ChkAlphaY.Checked then begin
          qryMatrix.SQL.Add('ORDER BY DescAttrib2');
        end else begin
          qryMatrix.SQL.Add('ORDER BY DescAttrib1ID, DescAttrib2ID');
        end;

        qryMatrix.Open;
        grdMatrix.RowCount := qryMatrix.RecordCount + 1;
      end;

      // Process List
      while not qryMatrix.Eof do begin
        // Are we dealing with the X Axis?
        if (FastFuncs.UpperCase(Axis) = 'X') then begin
          Result := Result + qryMatrix.FieldByName('DescAttrib1').AsString + #13;
          // Are we dealing with the Y Axis?
        end else if (FastFuncs.UpperCase(Axis) = 'Y') then begin
          Result := Result + qryMatrix.FieldByName('DescAttrib2').AsString + #13;
        end;

        // Fetch next record.
        qryMatrix.Next;
      end;
    end else begin
      // No, do standard general setup of Axis.
      if not qryTemp.IsEmpty then begin
        // Get First record.
        qryTemp.First;
        while not qryTemp.Eof do begin
          Result := Result + qryTemp.FieldByName('DescriptionAttribValue').AsString + #13;
          // Fetch next record.
          qryTemp.Next;
        end;
      end else // Obvisouly the result is nothing, so empty string is the result.
        Result := '';
    end;
  finally
    // Release our used allocated objects.
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

function TOrderingMatrixGUI.GetComboValueCount(const ComboName: string): integer;
var
  qryTemp: TMyQuery;
  columnName: string;
begin
  Result := 0;
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    if Empty(ComboName) then Exit;
    if cbShowAll.Checked then begin
      qryTemp.Sql.Add('SELECT Count(*) as Count ');
      qryTemp.Sql.Add('FROM tbldescriptionattribsetup ');
      qryTemp.Sql.Add('INNER JOIN tbldescriptionattriblines USING(DescriptionAttribID) ');
      qryTemp.Sql.Add('Where ComboName = ' + QuotedStr(ComboName) + ' AND tbldescriptionattribsetup.Active="T"; ');
      qryTemp.Active := true;
    end else begin
      columnName := 'DescAttrib' + FastFuncs.IntToStr(GetDescAttribNo(ComboName));
      qryTemp.Close;
      qryTemp.SQL.Text :=
        'SELECT Count(' + columnName + ') as Count FROM tblPricematrix' + ' WHERE PartsID = ' +
        FastFuncs.IntToStr(fiProductID) + ' GROUP BY ' + columnName + ';';
      qryTemp.Open;
    end;

    if not qryTemp.IsEmpty then begin
      if cbShowAll.Checked then begin
        Result := qryTemp.FieldByName('Count').AsInteger;
      end else begin
        Result := qryTemp.RecordCount;
      end;
    end;

  finally
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

function TOrderingMatrixGUI.GetComboValueCountAdvMatrixSupp: integer;
//var
//  qryTemp: TMyQuery;
begin
  Result := 0;
//  qryTemp := TMyQuery.Create(nil);
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  qryTemp.ParamCheck := false;
//  try
//    qryTemp.Sql.Add('SELECT Count(*) as Count FROM tbladvmatrix ');
//    qryTemp.Sql.Add('Where PartsID=' + FastFuncs.IntToStr(fiProductID) + ' AND ClassID=' + FastFuncs.IntToStr(fiClassID) + ' ');
//    qryTemp.Sql.Add('Group By ClientID; ');
//    qryTemp.Active := true;
//    if not qryTemp.IsEmpty then begin
//      Result := qryTemp.RecordCount;
//    end else begin
//      Result := 0;
//    end;
//  finally
//    if Assigned(qryTemp) then FreeAndNil(qryTemp);
//  end;
end;


function TOrderingMatrixGUI.GetComboValueCountAdvMatrixUOM: integer;
//var
//  qryTemp: TMyQuery;
begin
  Result := 0;
//  qryTemp := TMyQuery.Create(nil);
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  qryTemp.ParamCheck := false;
//  try
//    qryTemp.Sql.Add('SELECT Count(*) as Count FROM tbladvmatrix ');
//    qryTemp.Sql.Add('WHERE PartsID=' + FastFuncs.IntToStr(fiProductID) + ' AND ClassID=' + FastFuncs.IntToStr(fiClassID) + ' ');
//    qryTemp.Sql.Add('GROUP By UnitofMeasure; ');
//    qryTemp.Active := true;
//    if not qryTemp.IsEmpty then begin
//      Result := qryTemp.RecordCount;
//    end else begin
//      Result := 0;
//    end;
//  finally
//    // Release our used allocated objects.
//    if Assigned(qryTemp) then FreeAndNil(qryTemp);
//  end;
end;

function TOrderingMatrixGUI.GetComboListAdvMatrixSupp: string;
//var
//  qryTemp: TMyQuery;
begin
  Result := '';
//  qryTemp := TMyQuery.Create(nil);
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  qryTemp.ParamCheck := false;
//  try
//    qryTemp.Sql.Add('SELECT CompanyName FROM tbladvmatrix ');
//    qryTemp.Sql.Add('Where PartsID=' + FastFuncs.IntToStr(fiProductID) + ' AND ClassID=' + FastFuncs.IntToStr(fiClassID) + ' ');
//    qryTemp.Sql.Add('Group By ClientID; ');
//    qryTemp.Active := true;
//    if not qryTemp.IsEmpty then begin
//      qryTemp.First;
//      while not qryTemp.Eof do begin
//        Result := Result + qryTemp.FieldByName('CompanyName').AsString + #13;
//        // Fetch next record.
//        qryTemp.Next;
//      end;
//    end else begin
//      Result := '';
//    end;
//  finally
//    FreeAndNil(qryTemp);
//  end;
end;

function TOrderingMatrixGUI.GetComboListAdvMatrixUOM: string;
//var
//  qryTemp: TMyQuery;
begin
  Result := '';
//  qryTemp := TMyQuery.Create(nil);
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  qryTemp.ParamCheck := false;
//  try
//    qryTemp.Sql.Add('SELECT UnitofMeasure FROM tbladvmatrix ');
//    qryTemp.Sql.Add('Where PartsID=' + FastFuncs.IntToStr(fiProductID) + ' AND ClassID=' + FastFuncs.IntToStr(fiClassID) + ' ');
//    qryTemp.Sql.Add('Group By UnitofMeasure; ');
//    qryTemp.Active := true;
//    if not qryTemp.IsEmpty then begin
//      qryTemp.First;
//      while not qryTemp.Eof do begin
//        Result := Result + qryTemp.FieldByName('UnitofMeasure').AsString + #13;
//        // Fetch next record.
//        qryTemp.Next;
//      end;
//    end else begin
//      Result := '';
//    end;
//  finally
//    // Release our used objects.
//    if Assigned(qryTemp) then FreeAndNil(qryTemp);
//  end;
end;

procedure TOrderingMatrixGUI.FormDestroy(Sender: TObject);
begin
  if Assigned(pmqMemData) then
    FreeandNil(pmqMemData);
  if Assigned(qryMatrix) then
    FreeandNil(qryMatrix);
  inherited;
end;

procedure TOrderingMatrixGUI.SetupGrid;
var
  X_Name, Y_Name: string;
  G, I: integer;
  sAttrib1, sAttrib2: string;
(*  dReceived: double;
  dSold: double;*)
  (*dStockAdjustment: double;*)
  dResult: double;
begin
  // Are we using Advanced Matrix Mode?
  if not fbAdvMartixMode then begin
    // No
    X_Name        := cboX.Text;
    Y_Name        := cboY.Text;
    XDescAttribNo := GetDescAttribNo(X_Name);
    YDescAttribNo := GetDescAttribNo(Y_Name);
  end else begin
    X_Name := 'Unit Of Measure';
    Y_Name := 'Supplier';
  end;

  if not Empty(Y_Name) or not Empty(X_Name) then begin
    if not fbAdvMartixMode then begin
      SetUpGridXYaxis(X_Name, Y_Name);
    end else begin
      SetUpGridXYaxisAdvMatrix(X_Name, Y_Name);
    end;

    lblYAxis.Caption := Y_Name;
    lblXAxis.Caption := X_Name;
  end;

  // Parse cells depending on mode and make cell alignment to center.
  for G := 0 to grdMatrix.RowCount - 1 do begin
    // If the row index is greater than zero then ..
    if (G > 0) and (FromPriceMatrixQty (*or FromStockAdjustment *)or FromStockTransfer) then begin
      // Get row attribute value.
      sAttrib2 := grdMatrix.Cells[0, G];
    end;

    // Process each column on the matrix.
    for I := 0 to grdMatrix.ColCount - 1 do begin
      // Set cell alignment property to center.
      grdMatrix.Alignments[I, G] := taCenter;
      // Are we coming from the Price Matrix tab on the Parts form?
      if FromPriceMatrix then begin
        // If the column and row is greater than 0 then...
        if (I > 0) and (G > 0) then begin
          // Turn this cell to a checkbox selection.
          grdMatrix.AddCheckBox(I, G, false, true);
          // Moving on...
          Continue;
        end;
      end;

      // Are we coming from the Price Matrix Qty Tab in the Parts form?
      if FromPriceMatrixQty (*or FromStockAdjustment *)or FromStockTransfer then begin
        // If the column index is greater than zero then ..
        if (I > 0) then begin
          // Get column attribute value.
          sAttrib1 := grdMatrix.Cells[I, 0];
        end;

        if (I > 0) and (G > 0) then begin
          case PriceMatrixQtyMode of
            // Requesting what is available?
            mqmAvailable:
              begin
                pmqMemData.Filtered := false;
                pmqMemData.Filter := 'DescAttrib1 = ' + QuotedStr(sAttrib1) + ' AND DescAttrib2 = ' + QuotedStr(sAttrib2);
                pmqMemData.Filtered := true;
                if pmqMemData.RecordCount > 0 then begin
                  dResult := pmqMemData.FieldByName('Available').AsFloat;;
                  if dResult <> 0 then begin
                    // Show Quantity value.
                    grdMatrix.Cells[I, G] := FloatToStrF(dResult, ffFixed, 15, 0);
                  end else begin
                    // Show nothing.
                    grdMatrix.Cells[I, G] := '';
                  end;
                end else begin
                  // Show nothing.
                  grdMatrix.Cells[I, G] := '';
                end;
              end;

            mqmToSell:
              begin
                pmqMemData.Filtered := false;
                pmqMemData.Filter := 'DescAttrib1 = ' + QuotedStr(sAttrib1) + ' AND DescAttrib2 = ' + QuotedStr(sAttrib2);
                pmqMemData.Filtered := true;
                if pmqMemData.RecordCount > 0 then begin
                  dResult := pmqMemData.FieldByName('ToSell').AsFloat;;
                  if dResult <> 0 then begin
                    // Show Quantity value.
                    grdMatrix.Cells[I, G] := FloatToStrF(dResult, ffFixed, 15, 0);
                  end else begin
                    // Show nothing.
                    grdMatrix.Cells[I, G] := '';
                  end;
                end else begin
                  // Show nothing.
                  grdMatrix.Cells[I, G] := '';
                end;
              end;

            // In Stock Mode?
            mqmInStock:
              begin
                pmqMemData.Filtered := false;
                pmqMemData.Filter := 'DescAttrib1 = ' + QuotedStr(sAttrib1) + ' AND DescAttrib2 = ' + QuotedStr(sAttrib2);
                pmqMemData.Filtered := true;
                if pmqMemData.RecordCount > 0 then begin
                  dResult := pmqMemData.FieldByName('InStock').AsFloat;
                  if dResult <> 0 then begin
                    // Show Quantity value.
                    grdMatrix.Cells[I, G] := FloatToStrF(dResult, ffFixed, 15, 0);
                  end else begin
                    // Show nothing.
                    grdMatrix.Cells[I, G] := '';
                  end;
                end else begin
                  // Show nothing.
                  grdMatrix.Cells[I, G] := '';
                end;
              end;
            else begin
                (*if FromStockAdjustment then begin
                  dSold := GetCellQtyValue(ProductID, sAttrib1, sAttrib2, '', '', '', mqmSold, nil);
                  dReceived := GetCellQtyValue(ProductID, sAttrib1, sAttrib2, '', '', '', mqmReceivedStock, nil);
                  dStockAdjustment := GetCellQtyValue(ProductID, sAttrib1, sAttrib2, '', '', '', mqmStockAdjustment, nil);
                  dResult := dReceived - dSold + dStockAdjustment;

                  if dResult <> 0 then
                    grdMatrix.FontColors[I, G] := clRed;
                end
                else begin
                  dResult := GetCellQtyValue(ProductID, sAttrib1, sAttrib2, '', '', '', PriceMatrixQtyMode, nil);

                  if FromStockTransfer and  (dResult <> 0) then
                    grdMatrix.FontColors[I, G] := clRed;
                end;*)
                dResult := GetCellQtyValue(ProductID, sAttrib1, sAttrib2, '', '', '', PriceMatrixQtyMode, nil);

                  if FromStockTransfer and  (dResult <> 0) then
                    grdMatrix.FontColors[I, G] := clRed;
              end;

              if dResult <> 0 then begin
                // Show Quantity value.
                grdMatrix.Cells[I, G] := FloatToStrF(dResult, ffFixed, 15, 0);
              end else begin
                  // Show nothing.
                  grdMatrix.Cells[I, G] := '';
                end;
          end;
        end;
      end;
    end;
  end;

  if not FromPriceMatrixQty then begin
    SetControlFocus(grdMatrix);
  end;
end;

procedure TOrderingMatrixGUI.cboXCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    grdMatrix.Clear;
    SetupGrid;
  end;
end;

procedure TOrderingMatrixGUI.cboYCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    grdMatrix.Clear;
    SetupGrid;
  end;
end;

procedure TOrderingMatrixGUI.cmdClearClick(Sender: TObject);
begin
  inherited;
  grdMatrix.Clear;
  SetupGrid;
end;

function TOrderingMatrixGUI.AssignDescAttribcbo(const DescAttribNo: integer): TwwDBLookupCombo;
begin
  Result := nil;
  if Assigned(Sale) then begin
    case DescAttribNo of
      1: Result := Sale.cboDescAttrib1;
      2: Result := Sale.cboDescAttrib2;
      3: Result := Sale.cboDescAttrib3;
      4: Result := Sale.cboDescAttrib4;
      5: Result := Sale.cboDescAttrib5;
      100: Result := Sale.cboUnitOfMeasure;
      101: Result := Sale.cboSupplier;
    end;
  end else if Assigned(Cash) then begin
    case DescAttribNo of
      1: Result := Cash.cboDescAttrib1;
      2: Result := Cash.cboDescAttrib2;
      3: Result := Cash.cboDescAttrib3;
      4: Result := Cash.cboDescAttrib4;
      5: Result := Cash.cboDescAttrib5;
      100: Result := Cash.cboUnitOfMeasure;
      101: Result := Cash.cboSupplier;
    end;
  end else if Assigned(PO) then begin
    case DescAttribNo of
      1: Result := PO.cboDescAttrib1;
      2: Result := PO.cboDescAttrib2;
      3: Result := PO.cboDescAttrib3;
      4: Result := PO.cboDescAttrib4;
      5: Result := PO.cboDescAttrib5;
      100: Result := PO.cboUnitOfMeasure;
    end;
  end else if Assigned(Smart) then begin
    case DescAttribNo of
      1: Result := Smart.cboDescAttrib1;
      2: Result := Smart.cboDescAttrib2;
      3: Result := Smart.cboDescAttrib3;
      4: Result := Smart.cboDescAttrib4;
      5: Result := Smart.cboDescAttrib5;
    end;
  end else if FromPriceMatrix then begin
    case DescAttribNo of
      1: Result := Parts.cboDescAttrib1;
      2: Result := Parts.cboDescAttrib2;
      3: Result := Parts.cboDescAttrib3;
      4: Result := Parts.cboDescAttrib4;
      5: Result := Parts.cboDescAttrib5;
    end;
  end;
end;

function TOrderingMatrixGUI.AssignDescAttribField(const DescAttribNo: integer): TStringField;
begin
  Result := nil;
  if Assigned(Sale) then begin
    case DescAttribNo of
      1: Result := Sale.tblDetailsDescAttrib1;
      2: Result := Sale.tblDetailsDescAttrib2;
      3: Result := Sale.tblDetailsDescAttrib3;
      4: Result := Sale.tblDetailsDescAttrib4;
      5: Result := Sale.tblDetailsDescAttrib5;
      100: Result := Sale.tblDetailsUnitofMeasureSaleLines;
      101: Result := Sale.tblDetailsSupplier;
    end;
  end else if Assigned(Cash) then begin
    case DescAttribNo of
      1: Result := Cash.tblDetailsDescAttrib1;
      2: Result := Cash.tblDetailsDescAttrib2;
      3: Result := Cash.tblDetailsDescAttrib3;
      4: Result := Cash.tblDetailsDescAttrib4;
      5: Result := Cash.tblDetailsDescAttrib5;
      100: Result := Cash.tblDetailsUnitofMeasureSaleLines;
      101: Result := Cash.tblDetailsSupplier;
    end;
  end else if Assigned(PO) then begin
    case DescAttribNo of
      1: Result := PO.tblDetailsDescAttrib1;
      2: Result := PO.tblDetailsDescAttrib2;
      3: Result := PO.tblDetailsDescAttrib3;
      4: Result := PO.tblDetailsDescAttrib4;
      5: Result := PO.tblDetailsDescAttrib5;
      100: Result := PO.tblDetailsUnitofMeasurePOLines;
    end;
  end else if Assigned(Smart) then begin
    case DescAttribNo of
      1: Result := Smart.tblDetailsDescAttrib1;
      2: Result := Smart.tblDetailsDescAttrib2;
      3: Result := Smart.tblDetailsDescAttrib3;
      4: Result := Smart.tblDetailsDescAttrib4;
      5: Result := Smart.tblDetailsDescAttrib5;
    end;
  end else if FromPriceMatrix then begin
    case DescAttribNo of
      1: Result := Parts.qryPriceMatrixDescAttrib1;
      2: Result := Parts.qryPriceMatrixDescAttrib2;
      3: Result := Parts.qryPriceMatrixDescAttrib3;
      4: Result := Parts.qryPriceMatrixDescAttrib4;
      5: Result := Parts.qryPriceMatrixDescAttrib5;
    end;
  end;
end;

procedure TOrderingMatrixGUI.cmdCreateClick(Sender: TObject);
var
  C, R: integer;
  TempQty: double;
  Save_Cursor: TCursor;
  FirstItem: boolean;
  BlackColour: boolean;
begin
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  FirstItem := true;
  try
    inherited;
    if FromPriceMatrix then begin
      Parts := TfrmParts(Owner);
      Parts.qryPriceMatrix.DisableControls;
    end;

    MyCount := 0;
    for R := 1 to grdMatrix.RowCount - 1 do begin
      for C := 1 to grdMatrix.ColCount - 1 do begin
        TempQty := StrValue(grdMatrix.Cells[C, R]);
        BlackColour := (grdMatrix.Colors[C, R] = clBlack);
        // Was this matrix form called from the Parts Price Matrix Tab?
        if FromPriceMatrix then begin
          // Yes, is this cell selected to be added?
          if grdMatrix.Cells[C, R] = grdMatrix.CheckTrue then begin
            // Yes, add data line.
            AddNewProductLine(fiProductID, grdMatrix.Cells[C, 0], grdMatrix.Cells[0, R], TempQty, FirstItem, MyCount);
            FirstItem := false;
          end;
          // Was this matrix called from the stock adjustment form?
       (* end else if FromStockAdjustment then begin
          if grdMatrix.FontColors[C, R] = clBlack then begin
            AddNewStockAdjustmentLine(ProductID, grdMatrix.Cells[C, 0], grdMatrix.Cells[0, R],
              StrValue(grdMatrix.Cells[C, R]), FirstItem);
            FirstItem := false;
          end;*)
        end else if FromStockTransfer then begin
          if grdMatrix.FontColors[C, R] = clBlack then begin
            AddNewStockTransferLine(ProductID, grdMatrix.Cells[C, 0], grdMatrix.Cells[0, R],
              StrValue(grdMatrix.Cells[C, R]), FirstItem);
            FirstItem := false;
          end;
          // Otherwise we are using standard input scenerio
        end else if (TempQty <> 0.00) and (not BlackColour) then begin
          AddNewProductLine(fiProductID, grdMatrix.Cells[C, 0], grdMatrix.Cells[0, R], TempQty, FirstItem, 0);
          FirstItem := false;
        end;

        // Increment Counter for Auto Barcode option.
        iCount := iCount + 1;
      end;
    end;

    if FromPriceMatrix then begin
      Parts.qryPriceMatrix.EnableControls;
    end;

    Self.Close;
  finally
    Screen.Cursor := Save_Cursor;
  end;
end;

function TOrderingMatrixGUI.AddNewProductLine(const ProductID: integer; const XDescAttrib, YDescAttrib: string;
  const QtyOrdered: double; const FirstItem: boolean; const iCount: integer): boolean;
var
  cboDescAttribX: TwwDBLookupCombo;
  cboDescAttribY: TwwDBLookupCombo;
  DescAttribX: TStringField;
  DescAttribY: TStringField;
  oPartInfo: TProductInfo;
  DescAttribXRO , DescAttribYRO :boolean;

begin
  inherited;
  if (Owner.ClassName = 'TSmartOrderGUI') then begin
    Smart := TSmartOrderGUI(Owner);
    Cash  := nil;
    Sale  := nil;
    Parts := nil;
  end else if (Owner.ClassParent.ClassName = 'TBaseCashGUI') then begin
    Cash  := TBaseCashGUI(Owner);
    Sale  := nil;
    Parts := nil;
    Smart := nil;
  end else if (Owner.ClassParent.ClassName = 'TBaseSaleGUI') then begin
    Sale  := TBaseSaleGUI(Owner);
    Cash  := nil;
    Parts := nil;
    Smart := nil;
  end else if FromPriceMatrix then begin
    Parts     := TfrmParts(Owner);
    oPartInfo := GetProductInfo(ProductID);
    Sale      := nil;
    Cash      := nil;
    Smart     := nil;
  end else begin
    Parts := nil;
    Sale  := nil;
    Cash  := nil;
    Smart := nil;
  end;

  if Owner.ClassName = 'TPurchaseGUI' then begin
    PO := TPurchaseGUI(Owner);
  end else begin
    PO := nil;
  end;

  //Create ProductLines
  if Assigned(Sale) then begin
    if FirstItem then begin
      Sale.tblDetails.Edit;
    end else begin
      Sale.tblDetails.Append;
    end;

    Sale.cboProductX.Text := GetPartName(ProductID);
    Sale.tblDetailsProductName.AsString := GetPartName(ProductID);
    if Sale.tblDetails.State in [dsInsert, dsEdit] then
      Sale.tblDetails.Post;
    Sale.tblDetails.Edit;
    Sale.cboProductXCloseUp(Sale.cboProductX, Sale.cboProductX.LookupTable, Sale.cboProductX.DataSource.DataSet, true);
    Sale.tblDetails.Edit;
    if not fbAdvMartixMode then begin
      if (XDescAttribNo <> 0) then begin
        cboDescAttribX := AssignDescAttribcbo(XDescAttribNo);
        DescAttribX := AssignDescAttribField(XDescAttribNo);
	    DescAttribXRO :=DescAttribX.Readonly;
        DescAttribX.Readonly :=  False;
        Try
            cboDescAttribX.Text := XDescAttrib;
            DescAttribX.AsString := XDescAttrib;
        Finally
            DescAttribX.Readonly := DescAttribXRO;
        end;
      end;

      if (YDescAttribNo <> 0) then begin
        cboDescAttribY := AssignDescAttribcbo(YDescAttribNo);
        DescAttribY := AssignDescAttribField(YDescAttribNo);
        DescAttribYRO :=DescAttribY.Readonly;
        DescAttribY.Readonly :=  False;
        Try
            cboDescAttribY.Text := YDescAttrib;
            if not (Sale.tblDetails.State in [dsInsert, dsEdit]) then Sale.tblDetails.Edit;
            DescAttribY.AsString := YDescAttrib;
        Finally
            DescAttribY.Readonly := DescAttribYRO;
        end;
      end;
    end else begin
      cboDescAttribX := AssignDescAttribcbo(100);
      DescAttribX := AssignDescAttribField(100);
	  DescAttribXRO :=DescAttribX.Readonly;
      DescAttribX.Readonly :=  False;
      Try
        cboDescAttribX.Text := XDescAttrib;
        DescAttribX.AsString := XDescAttrib;
      Finally
            DescAttribX.Readonly := DescAttribXRO;
      end;
      cboDescAttribY := AssignDescAttribcbo(101);
      DescAttribY := AssignDescAttribField(101);
	    DescAttribYRO :=DescAttribY.Readonly;
        DescAttribY.Readonly :=  False;
        Try
            cboDescAttribY.Text := YDescAttrib;
            if not (Sale.tblDetails.State in [dsInsert, dsEdit]) then Sale.tblDetails.Edit;
            DescAttribY.AsString := YDescAttrib;
        Finally
            DescAttribY.Readonly := DescAttribYRO;
        end;
    end;

    if not (Sale.tblDetails.State in [dsInsert, dsEdit]) then
      Sale.tblDetails.Edit;
    Sale.tblDetailsUnitofMeasureQtySold.AsFloat := QtyOrdered;
    if Sale.tblDetails.State in [dsInsert, dsEdit] then
      Sale.tblDetails.Post;
    Sale.tblDetails.Edit;
  end else if Assigned(Cash) then begin
    if FirstItem then begin
      Cash.tblDetails.Edit;
    end else begin
      Cash.tblDetails.Append;
    end;

    Cash.cboProductX.Text := GetPartName(ProductID);
    Cash.tblDetailsProductName.AsString := GetPartName(ProductID);
    if Cash.tblDetails.State in [dsInsert, dsEdit] then
      Cash.tblDetails.Post;
    Cash.tblDetails.Edit;
    Cash.cboProductXCloseUp(Cash.cboProductX, Cash.cboProductX.LookupTable, Cash.cboProductX.DataSource.DataSet, true);
    Cash.tblDetails.Edit;
    if not fbAdvMartixMode then begin
      if (XDescAttribNo <> 0) then begin
        cboDescAttribX := AssignDescAttribcbo(XDescAttribNo);
        DescAttribX := AssignDescAttribField(XDescAttribNo);
	    DescAttribXRO :=DescAttribX.Readonly;
        DescAttribX.Readonly :=  False;
        Try
            cboDescAttribX.Text := XDescAttrib;
            DescAttribX.AsString := XDescAttrib;
        Finally
            DescAttribX.Readonly := DescAttribXRO;
        end;
      end;

      if (YDescAttribNo <> 0) then begin
        cboDescAttribY := AssignDescAttribcbo(YDescAttribNo);
        DescAttribY := AssignDescAttribField(YDescAttribNo);
	    DescAttribYRO :=DescAttribY.Readonly;
        DescAttribY.Readonly :=  False;
        Try
            cboDescAttribY.Text := YDescAttrib;
            if not (Cash.tblDetails.State in [dsInsert, dsEdit]) then Cash.tblDetails.Edit;
            DescAttribY.AsString := YDescAttrib;
        Finally
            DescAttribY.Readonly := DescAttribYRO;
        end;
      end;
    end else begin
      cboDescAttribX := AssignDescAttribcbo(100);
      DescAttribX := AssignDescAttribField(100);
	    DescAttribXRO :=DescAttribX.Readonly;
        DescAttribX.Readonly :=  False;
        Try
            cboDescAttribX.Text := XDescAttrib;
            DescAttribX.AsString := XDescAttrib;
        Finally
            DescAttribX.Readonly := DescAttribXRO;
        end;
      cboDescAttribY := AssignDescAttribcbo(101);
      DescAttribY := AssignDescAttribField(101);
      DescAttribYRO :=DescAttribY.Readonly;
      DescAttribY.Readonly :=  False;
      Try
            cboDescAttribY.Text := YDescAttrib;
            if not (Cash.tblDetails.State in [dsInsert, dsEdit]) then Cash.tblDetails.Edit;
            DescAttribY.AsString := YDescAttrib;
      Finally
            DescAttribY.Readonly := DescAttribYRO;
      end;
    end;

    Cash.tblDetailsRefundQty.AsFloat := QtyOrdered;
    if Cash.tblDetails.State in [dsInsert, dsEdit] then
      Cash.tblDetails.Post;
    Cash.tblDetails.Edit;

    // Going to Purchase Order Form.
  end else if Assigned(PO) then begin
    if FirstItem then begin
      if not (PO.tblDetails.state in [dsEdit,dsinsert]) then PO.tblDetails.Edit;
    end else begin
      PO.tblDetails.Append;
    end;
    {for the first line the product is already selected, so don;t select it again}
    if PO.tblDetailsProductName.AsString <> GetPartName(ProductID) then begin
        PO.cboProductX.Text := GetPartName(ProductID);
        PO.tblDetailsProductName.AsString := GetPartName(ProductID);
        if PO.tblDetails.State in [dsInsert, dsEdit] then
          PO.tblDetails.Post;
        if not (PO.tblDetails.state in [dsEdit,dsinsert]) then PO.tblDetails.Edit;
        PO.cboProductXCloseUp(PO.cboProductX, PO.cboProductX.LookupTable, PO.cboProductX.DataSource.DataSet, true);
    End;

    if not (PO.tblDetails.state in [dsEdit, dsinsert]) then
      PO.tblDetails.Edit;

    if not fbAdvMartixMode then begin
      if (XDescAttribNo <> 0) then begin
        cboDescAttribX := AssignDescAttribcbo(XDescAttribNo);
        DescAttribX := AssignDescAttribField(XDescAttribNo);
	    DescAttribXRO :=DescAttribX.Readonly;
        DescAttribX.Readonly :=  False;
        Try
            cboDescAttribX.Text := XDescAttrib;
            DescAttribX.AsString := XDescAttrib;
        Finally
            DescAttribX.Readonly := DescAttribXRO;
        end;
      end;

      if (YDescAttribNo <> 0) then begin
        cboDescAttribY := AssignDescAttribcbo(YDescAttribNo);
        DescAttribY := AssignDescAttribField(YDescAttribNo);
	    DescAttribYRO :=DescAttribY.Readonly;
        DescAttribY.Readonly :=  False;
        Try
            cboDescAttribY.Text := YDescAttrib;
            if not (PO.tblDetails.State in [dsInsert, dsEdit]) then PO.tblDetails.Edit;
            DescAttribY.AsString := YDescAttrib;
        Finally
            DescAttribY.Readonly := DescAttribYRO;
        end;
      end;
    end else begin
      cboDescAttribX := AssignDescAttribcbo(100);
      DescAttribX := AssignDescAttribField(100);
	    DescAttribXRO :=DescAttribX.Readonly;
        DescAttribX.Readonly :=  False;
        Try
            cboDescAttribX.Text := XDescAttrib;
            DescAttribX.AsString := XDescAttrib;
        Finally
            DescAttribX.Readonly := DescAttribXRO;
        end;
    end;
    if not (PO.tblDetails.State in [dsInsert, dsEdit]) then PO.tblDetails.Edit;
    PO.tblDetailsUnitofMeasureShipped.AsFloat := 0;
    PO.tblDetailsQtySold.AsFloat := QtyOrdered;
    PO.tblDetailsUnitofMeasureQtySold.AsFloat := QtyOrdered;
    if not (PO.tblDetails.State in [dsInsert, dsEdit]) then PO.tblDetails.Edit;
    PO.tblDetailsBackOrder.AsFloat := QtyOrdered;
    PO.tblDetailsUnitofMeasureBackOrder.AsFloat := QtyOrdered;

    if not (PO.tblDetails.state in [dsEdit, dsinsert])
      then PO.tblDetails.Edit;
//    PO.tblDetailsUnitofMeasureShipped.AsFloat := QtyOrdered;

    if PO.tblDetails.State in [dsEdit, dsInsert] then begin
      PO.tblDetails.Post;
      PO.tblDetails.Edit;
    end;

    // Going to the Parts - Price Matrix Area.
  end else if FromPriceMatrix then begin
    if FirstItem then begin
      if Parts.qryPriceMatrix.RecordCount = 0 then begin
        Parts.qryPriceMatrix.Edit;
      end else begin
        Parts.qryPriceMatrix.Append;
      end;
    end else begin
      Parts.qryPriceMatrix.Append;
    end;

    Parts.qryPriceMatrix.FieldByName('UnitOfMeasure').AsString := 'Units';
    Parts.qryPriceMatrix.FieldByName('PartsID').AsInteger      := ProductID;
    Parts.qryPriceMatrix.FieldByName('AllClients').AsString    := 'T';
    Parts.qryPriceMatrix.FieldByName('InActive').AsString      := 'F';
    Parts.qryPriceMatrix.FieldByName('CalcSellQty1').AsFloat   := 1;
    Parts.qryPriceMatrix.FieldByName('ClientTypeName').AsString := 'Default';
    Parts.qryPriceMatrix.FieldByName('ClientTypeID').AsInteger := 1;
    Parts.qryPriceMatrix.FieldByName('QtyPercent1').AsFloat    := 0;
    Parts.qryPriceMatrix.FieldByName('CalcPrice1').AsFloat     := Parts.qryProduct.FieldByName('Price1').AsFloat;
    Parts.qryPriceMatrix.FieldByName('QtyPercent2').AsFloat    := 0;
    Parts.qryPriceMatrix.FieldByName('CalcPrice2').AsFloat     := Parts.qryProduct.FieldByName('Price2').AsFloat;
    Parts.qryPriceMatrix.FieldByName('QtyPercent3').AsFloat    := 0;
    Parts.qryPriceMatrix.FieldByName('CalcPrice3').AsFloat     := Parts.qryProduct.FieldByName('Price3').AsFloat;
    Parts.qryPriceMatrix.FieldByName('UOMPrice').AsFloat       := GetAmountInc(Parts.qryProduct.FieldByName('Price1').AsFloat,
      GetTaxRate(Parts.qryProduct.FieldByName('TaxCode').AsString));

    // Are we auto creating barcodes?
    if AppEnv.CompanyPrefs.AutoAddBarcodes then begin
      // Yes, get next barcode.
      Parts.qryPriceMatrix.FieldByName('Barcode').AsString := GetAutoBarcode(iCount);
    end;

    if not fbAdvMartixMode then begin
      if (XDescAttribNo <> 0) then begin
        cboDescAttribX := AssignDescAttribcbo(XDescAttribNo);
        DescAttribX := AssignDescAttribField(XDescAttribNo);
	    DescAttribXRO :=DescAttribX.Readonly;
        DescAttribX.Readonly :=  False;
        Try
            cboDescAttribX.Text := XDescAttrib;
            DescAttribX.AsString := XDescAttrib;
        Finally
            DescAttribX.Readonly := DescAttribXRO;
        end;
      end;

      if (YDescAttribNo <> 0) then begin
        cboDescAttribY := AssignDescAttribcbo(YDescAttribNo);
        DescAttribY := AssignDescAttribField(YDescAttribNo);
	    DescAttribYRO :=DescAttribY.Readonly;
        DescAttribY.Readonly :=  False;
        Try
            cboDescAttribY.Text := YDescAttrib;
            if not (Parts.qryPriceMatrix.State in [dsInsert, dsEdit]) then Parts.qryPriceMatrix.Edit;
            DescAttribY.AsString := YDescAttrib;
        Finally
            DescAttribY.Readonly := DescAttribYRO;
        end;
      end;
    end else begin
      cboDescAttribX := AssignDescAttribcbo(100);
      DescAttribX := AssignDescAttribField(100);
	    DescAttribXRO :=DescAttribX.Readonly;
        DescAttribX.Readonly :=  False;
        Try
            cboDescAttribX.Text := XDescAttrib;
            DescAttribX.AsString := XDescAttrib;
        Finally
            DescAttribX.Readonly := DescAttribXRO;
        end;
    end;

    if Parts.qryPriceMatrix.State in [dsInsert, dsEdit] then
      Parts.qryPriceMatrix.Post;
    Parts.qryPriceMatrix.Edit;

    if Parts.qryDescAttrib1.Locate('DescriptionAttribValue', Parts.cboDescAttrib1.Text, [loCaseInsensitive]) then begin
      Parts.cboDescAttrib1CloseUp(Self, Parts.qryDescAttrib1, Parts.qryPriceMatrix, true);
    end;

    if Parts.qryDescAttrib2.Locate('DescriptionAttribValue', Parts.cboDescAttrib2.Text, [loCaseInsensitive]) then begin
      Parts.cboDescAttrib2CloseUp(Self, Parts.qryDescAttrib2, Parts.qryPriceMatrix, true);
    end;

    if Parts.qryPriceMatrix.State in [dsInsert, dsEdit] then
      Parts.qryPriceMatrix.Post;
    Parts.qryPriceMatrix.Edit;

    // Going to Smart Order
  end else if Assigned(Smart) then begin
    (*if FirstItem then begin
      Smart.tblDetails.Edit;
    end else begin
      Smart.tblDetails.Append;
    end;*)
    Smart.SmartOrder.Lines.PartsName := GetPartName(ProductID);
    Smart.cboProduct.Text := GetPartName(ProductID);
    Smart.SmartOrder.Lines.SearchFilter := Smart.SmartOrder.Lines.PartsName;
    Smart.SmartOrder.Lines.SearchFilterCopy:= Smart.SmartOrder.Lines.PartsName;
    Smart.SmartOrder.Lines.PostDB;
    Smart.SmartOrder.Lines.UnitofMeasureQty := QtyOrdered;
    Smart.cboProductCloseUp(Smart.cboProduct, Smart.cboProduct.LookupTable, Smart.cboProduct.DataSource.DataSet, true);
    Smart.SmartOrder.Lines.PostDB;

    if not fbAdvMartixMode then begin
      if (XDescAttribNo <> 0) then begin
        cboDescAttribX := AssignDescAttribcbo(XDescAttribNo);
        DescAttribX := AssignDescAttribField(XDescAttribNo);
	    DescAttribXRO :=DescAttribX.Readonly;
        DescAttribX.Readonly :=  False;
        Try
            cboDescAttribX.Text := XDescAttrib;
            DescAttribX.AsString := XDescAttrib;
        Finally
            DescAttribX.Readonly := DescAttribXRO;
        end;
      end;

      if (YDescAttribNo <> 0) then begin
        cboDescAttribY := AssignDescAttribcbo(YDescAttribNo);
        DescAttribY := AssignDescAttribField(YDescAttribNo);
	    DescAttribYRO :=DescAttribY.Readonly;
        DescAttribY.Readonly :=  False;
        Try
            cboDescAttribY.Text := YDescAttrib;
            Smart.SmartOrder.Lines.EditDB;
            DescAttribY.AsString := YDescAttrib;
        Finally
            DescAttribY.Readonly := DescAttribYRO;
        end;
      end;
    end else begin
      cboDescAttribX := AssignDescAttribcbo(100);

      DescAttribX := AssignDescAttribField(100);
	  DescAttribXRO :=DescAttribX.Readonly;
      DescAttribX.Readonly :=  False;
      Try
            cboDescAttribX.Text := XDescAttrib;
            DescAttribX.AsString := XDescAttrib;
      Finally
            DescAttribX.Readonly := DescAttribXRO;
      end;
    end;
    Smart.SmartOrder.Lines.PostDB;
  end;
  Result := true;
end;

procedure TOrderingMatrixGUI.SetUpMatrixLockedCells;
var
  G, I: integer;
  qryTemp: TMyQuery;
  XName, YName: string;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    if (XDescAttribNo = 0) or (YDescAttribNo = 0) then Exit;
    if cbShowAll.Checked then Exit;
    XName := 'DescAttrib' + FastFuncs.IntToStr(XDescAttribNo);
    YName := 'DescAttrib' + FastFuncs.IntToStr(YDescAttribNo);
    qryTemp.SQL.Text :=
      'SELECT ' + XName + ', ' + YName + ' FROM tblPriceMatrix ' + 'WHERE PartsID = ' +
      FastFuncs.IntToStr(fiProductID) + ' ' + 'GROUP BY ' + XName + ', ' + YName + ';';
    qryTemp.Open;

    for G := 1 to grdMatrix.RowCount - 1 do begin
      for I := 1 to grdMatrix.ColCount - 1 do begin
        if not qryTemp.Locate(XName + ';' + YName, VarArrayOf([grdMatrix.Cells[I, 0], grdMatrix.Cells[0, G]]), []) then
        begin
          grdMatrix.Colors[I, G] := clBlack;
        end;
      end;
    end;
  finally
    // Release our used objects.
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

procedure TOrderingMatrixGUI.SetUpAdvMatrixLockedCells;
var
  G, I: integer;
begin
  //Center Text
  for G := 1 to grdMatrix.RowCount - 1 do begin
    for I := 1 to grdMatrix.ColCount - 1 do begin
      if IsLockedCell(grdMatrix.Cells[I, 0], grdMatrix.Cells[0, G]) then begin
        grdMatrix.Colors[I, G] := clBlack;
      end;
    end;
  end;
end;

function TOrderingMatrixGUI.IsLockedCell(const UOM, Supp: string): boolean;
//var
//  qryTemp: TMyQuery;
begin
  Result := False;
//  qryTemp := TMyQuery.Create(nil);
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  qryTemp.ParamCheck := false;
//  try
//    if cbShowAll.Checked then begin
//      qryTemp.Sql.Add('SELECT AdvMatrixID FROM tbladvmatrix ');
//      qryTemp.Sql.Add('Where PartsID=' + FastFuncs.IntToStr(fiProductID) + ' AND ClassID=' + FastFuncs.IntToStr(fiClassID) + ' ');
//      qryTemp.Sql.Add('AND UnitofMeasure =' + QuotedStr(UOM) + ' AND CompanyName=' + QuotedStr(Supp) + '; ');
//      qryTemp.Active := true;
//    end;
//
//    if qryTemp.IsEmpty then begin
//      Result := true;
//    end else begin
//      Result := false;
//    end;
//
//  finally
//    // Release our used our allocated objects.
//    if Assigned(qryTemp) then FreeAndNil(qryTemp);
//  end;
end;

procedure TOrderingMatrixGUI.grdMatrixSelectCell(Sender: TObject; ACol, ARow: integer; var CanSelect: boolean);
begin
  inherited;
  if {fbAdvMartixMode AND} (grdMatrix.Colors[ACol, ARow] = clBlack) then begin
    CanSelect := false;
  end else begin
    CanSelect := true;
  end;
end;

procedure TOrderingMatrixGUI.grdMatrixCellValidate(Sender: TObject; Col, Row: integer; var Value: string;
  var Valid: boolean);
begin
  inherited;
  fbEditingStarted := true;
  if {fbAdvMartixMode AND} (grdMatrix.Colors[Col, Row] = clBlack) then begin
    Valid := false;
    Value := '';
  end else begin
    Valid := true;
  end;
end;

procedure TOrderingMatrixGUI.ChkAlphaXClick(Sender: TObject);
begin
  inherited;
  grdMatrix.Clear;
  SetupGrid;
end;

procedure TOrderingMatrixGUI.ChkAlphaYClick(Sender: TObject);
begin
  inherited;
  grdMatrix.Clear;
  SetupGrid;
end;

procedure TOrderingMatrixGUI.cbShowAllClick(Sender: TObject);
begin
  if fbFormStarting then Exit;
  inherited;
  grdMatrix.Clear;
  SetupGrid;
end;

procedure TOrderingMatrixGUI.btnClearAllClick(Sender: TObject);
var
  R, C: integer;
begin
  inherited;
  for R := 1 to grdMatrix.RowCount - 1 do begin
    for C := 1 to grdMatrix.ColCount - 1 do begin
      grdMatrix.Cells[C, R] := 'F';
    end;
  end;
end;

procedure TOrderingMatrixGUI.btnSelectAllClick(Sender: TObject);
var
  R, C: integer;
begin
  inherited;
  for R := 1 to grdMatrix.RowCount - 1 do begin
    for C := 1 to grdMatrix.ColCount - 1 do begin
      grdMatrix.Cells[C, R] := 'T';
    end;
  end;
end;

function TOrderingMatrixGUI.GetAutoBarcode(iOffset: integer): string;
var
  qry: TMyQuery;
  sResult: string;
begin
  Result := '';
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  Inc(iOffset);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := false;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT');
    qry.SQL.Add('MAX(Truncate(P.Barcode, 0)) + ' + FastFuncs.IntToStr(iOffset) + ' AS Barcode');
    qry.SQL.Add('FROM tblparts P');
    qry.Open;

    sResult := qry.FieldByName('Barcode').AsString;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT');
    qry.SQL.Add('MAX(Truncate(PM.Barcode, 0)) + ' + FastFuncs.IntToStr(iOffset) + ' AS Barcode');
    qry.SQL.Add('FROM tblpricematrix PM');
    qry.Open;

    Result := GetLargestResult(sResult, qry.FieldByName('Barcode').AsString);

  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TOrderingMatrixGUI.grdMatrixKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  // Ensure that the user can insert numerical data only.
  if ((Key <> '.') and (Key <> #8) and (Key <> '-') and ((Key < '0') or (Key > '9'))) then begin
    Key := #0;
  end;

  if ((*FromStockAdjustment or*) FromStockTransfer) and ((Key = '-') or ((Key >= '0') and (Key <= '9'))) then
    grdMatrix.FontColors[grdMatrix.RealCol, grdMatrix.RealRow] := clBlack;
end;

procedure TOrderingMatrixGUI.actFocusUpdate(Sender: TObject);
begin
  inherited;
  if (FromPriceMatrix) or (FromPriceMatrixQty) then Exit;
  if (not grdMatrix.Focused) and (fbEditingStarted) and (not (ActiveControl is TDNMSpeedButton)) then begin
    SetActiveWindow(Self.Handle);
    Self.FocusControl(grdMatrix);
    fbEditingStarted := false;
  end;
end;

procedure TOrderingMatrixGUI.SummariseTotals(var Msg: TMessage);
begin
  //  if not (FromPriceMatrixQty) then exit;
  //
  //  // Now display totals
  //  lblColumn1Total.Caption := FloatToStrF(grdMatrix.ColumnSum(Msg.WParamLo, 1, grdMatrix.RowCount-1), ffFixed, 15, 0);
  //  lblColumn2Total.Caption := FloatToStrF(grdMatrix.ColumnSum(Msg.WParamLo + 1, 1, grdMatrix.RowCount-1), ffFixed, 15, 0);
  //  lblColumn3Total.Caption := FloatToStrF(grdMatrix.ColumnSum(Msg.WParamLo + 2, 1, grdMatrix.RowCount-1), ffFixed, 15, 0);
  //  lblColumn4Total.Caption := FloatToStrF(grdMatrix.ColumnSum(Msg.WParamLo + 3, 1, grdMatrix.RowCount-1), ffFixed, 15, 0);
  //  lblColumn5Total.Caption := FloatToStrF(grdMatrix.ColumnSum(Msg.WParamLo + 4, 1, grdMatrix.RowCount-1), ffFixed, 15, 0);
  //  lblColumn6Total.Caption := FloatToStrF(grdMatrix.ColumnSum(Msg.WParamLo + 5, 1, grdMatrix.RowCount-1), ffFixed, 15, 0);
  //  lblColumn7Total.Caption := FloatToStrF(grdMatrix.ColumnSum(Msg.WParamLo + 6, 1, grdMatrix.RowCount-1), ffFixed, 15, 0);
  //  lblColumn8Total.Caption := FloatToStrF(grdMatrix.ColumnSum(Msg.WParamLo + 7, 1, grdMatrix.RowCount-1), ffFixed, 15, 0);
  //  lblColumn9Total.Caption := FloatToStrF(grdMatrix.ColumnSum(Msg.WParamLo + 8, 1, grdMatrix.RowCount-1), ffFixed, 15, 0);
end;

(*procedure TOrderingMatrixGUI.AddNewStockAdjustmentLine(const ProductID: integer;
  const XDescAttrib, YDescAttrib: string; const Quantity: double; const FirstItem: boolean);
var
  Stock: TfmStockAdjustEntryflat;
begin
  Stock := TfmStockAdjustEntryflat(Owner);

  with Stock do begin
    if FirstItem then
      tblDetails.Edit
    else
      tblDetails.Append;

    cboProduct.Text := GetPartName(ProductID);
    tblDetailsProductName.AsString := GetPartName(ProductID);
    cboDescAttrib1.Text := XDescAttrib;
    tblDetailsDescAttrib1.AsString := XDescAttrib;
    cboDescAttrib2.Text := YDescAttrib;
    tblDetailsDescAttrib2.AsString := YDescAttrib;
    tblDetailsFinalQty.AsFloat := Quantity;
    cboProductCloseUp(cboProduct, cboProduct.LookupTable, cboProduct.DataSource.DataSet, true);
    tblDetailsFinalQtyChange(nil);
    tblDetails.Post;
  end;
end;*)

procedure TOrderingMatrixGUI.AddNewStockTransferLine(const ProductID: integer;
  const XDescAttrib, YDescAttrib: string; const Quantity: double; const FirstItem: boolean);
begin
  {TODO PQA - stocktransfer}
(*var
  Stock: TStockTransferGUI;
begin
  Stock := TStockTransferGUI(Owner);

  with Stock do begin
    if FirstItem then
    begin
      tblDetails.Edit;
      StoredClassTo := cboClassTo.Text;
    end
    else
    begin
      tblDetails.Append;
      cboClassTo.Text := StoredClassTo;
      cboProduct.Text := GetPartName(ProductID);
      tblDetailsProductName.AsString := GetPartName(ProductID);
      tblDetailsTransferID.AsInteger := tblMasterTransferID.AsInteger;
      tblDetailsClassIDTo.AsInteger := GetClassID(StoredClassTo);
      cboProductCloseUp(cboProduct, cboProduct.LookupTable, cboProduct.DataSource.DataSet, true);
    end;

    cboDescAttrib1.Text := XDescAttrib;
    tblDetailsDescAttrib1.AsString := XDescAttrib;
    cboDescAttrib2.Text := YDescAttrib;
    tblDetailsDescAttrib2.AsString := YDescAttrib;
    tblDetailsUOMTransferQty.AsFloat := Quantity;
    tblDetails.Post;
  end;*)
end;

procedure TOrderingMatrixGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_ESCAPE then Begin
    Key := 0;
    cmdCancel.Click;
  end;
end;

procedure TOrderingMatrixGUI.grdMatrixKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_ESCAPE then begin
    Key := 0;
    cmdCancel.Click;
  end;
end;

initialization
  RegisterClassOnce(TOrderingMatrixGUI);

end.


