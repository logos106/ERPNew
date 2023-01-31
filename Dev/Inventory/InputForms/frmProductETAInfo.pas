unit frmProductETAInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  ExtCtrls, DNMPanel, MemDS, Grids, Wwdbigrd,
  Wwdbgrid, StdCtrls, Buttons, DNMSpeedButton, KbmMemTable, Menus, AdvMenus, Shader,
  ImgList, ProgressDialog;

const
  SX_CalcTotalsMsg = WM_USER + 100;

type
  TfrmProductETAInfoGUI = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    qryETA: TERPQuery;
    dsETA: TDataSource;
    qryETAProductName: TWideStringField;
    qryETAProductID: TIntegerField;
    qryETABackorder: TFloatField;
    qryETAPO: TIntegerField;
    qryETADept: TWideStringField;
    qryETAETADate: TDateField;
    qryETAGlobalRef: TWideStringField;
    Label1: TLabel;
    btnSalesOrder: TDNMSpeedButton;
    btnInvoice: TDNMSpeedButton;
    grdETAs: TwwDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnInvoiceClick(Sender: TObject);
    procedure btnSalesOrderClick(Sender: TObject);
    procedure grdETAsDblClick(Sender: TObject);
    procedure qryETAAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
    fbSalesOrderMode: boolean;
    fbBlockMode: boolean;
    fConnection:TERPConnection;
    procedure PerformCalcTotals(var Msg: TMessage); message SX_CalcTotalsMsg;

  public
    { Public declarations }
    property SalesOrderMode: boolean read fbSalesOrderMode write fbSalesOrderMode;
    property BlockMode: boolean read fbBlockMode write fbBlockMode;
    property Connection :TERPConnection read fConnection write fConnection;
  end;

implementation

uses pqalib, DNMExceptions, DNMLib, FormFactory, frmInvoice, frmSalesOrder,
  frmPurchaseOrders, AppContextObj, CommonLib, FastFuncs, ProductQtyLib,
  tcConst, CommonFormLib;

{$R *.dfm}

{ TBaseInputGUI }

procedure TfrmProductETAInfoGUI.FormShow(Sender: TObject);
var
  iClassID: integer;
begin
  DisableForm;
  try
    iClassID := 0;
    try
      inherited;
      if Self.Connection <> nil then begin
        qryETA.Connection := Self.Connection;
      end;

      qryETA.SQL.Clear;
      qryETA.SQL.Add('SELECT P.GlobalRef,');
      qryETA.SQL.Add('PL.ProductName, PL.ProductID, PL.ETADate,');
      qryETA.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tPOBO) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+')   AS Backorder,');
      qryETA.SQL.add('PL.Class AS "Dept", PL.PurchaseOrderID AS "PO #"');
      qryETA.SQL.add('FROM tblpurchaselines AS PL');
      qryETA.SQL.add('INNER JOIN tblpurchaseorders AS P Using(PurchaseOrderID)');
      qryETA.SQL.add('inner join tblPQA PQA  ON `PL`.`PurchaseLineID` = `PQA`.`TransLineID` ');
      qryETA.SQL.add('AND `PL`.`PurchaseOrderID` = `PQA`.`TransID`  ');
      qryETA.SQL.add('AND `PL`.`PurchaseLineID` = `PQA`.`TransLineID`');
      qryETA.SQL.add('and  `PQA`.`TransType`   in ('+ POTranstypes+') ');
      qryETA.SQL.add('and `PQA`.`IsBO` =  "T" and PQA.Active = "T"');
      qryETA.SQL.add('WHERE P.IsPO="T" AND PL.ProductID = ' +IntToStr(KeyID));
      if AppContext.ContextExists('PartDrillInfo') then begin
        if AppContext['PartDrillInfo'].VarExists('Department') then begin
          iClassID := AppContext['PartDrillInfo'].IntVar['Department'];
        end;
        AppContext.DeleteContext('PartDrillInfo');
      end;

      if iClassID <> 0 then begin
        qryETA.SQL.Add('AND PL.ClassID = ' + IntToStr(iClassID));
      end;

      qryETA.SQL.add('GROUP BY PL.PurchaseOrderID , PL.Class;');
      OpenQueries;

      // Are we to disable Invoice and Sales
      // Order button?
      if BlockMode then begin
        // Yes, disable.
        btnSalesOrder.Enabled := false;
        btnInvoice.Enabled := false;
        // If we were invoked from a sales order then
        // disable the sales order button.
      end else if SalesOrderMode then begin
        btnSalesOrder.Enabled := false;
      end;

      // Our exception handler.
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;

      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmProductETAInfoGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // Release form from memory.
  Action := caFree;
end;

procedure TfrmProductETAInfoGUI.FormCreate(Sender: TObject);
begin
  // Ignore Access Levels.
  Self.fbIgnoreAccessLevels := true;
  fbSalesOrderMode := false;
  inherited;
end;

procedure TfrmProductETAInfoGUI.btnInvoiceClick(Sender: TObject);
var
  oProductInfo: TProductInfo;
  Form : TComponent;
begin
  inherited;
  oProductInfo := GetProductInfo(KeyID);
  Form := GetComponentByClassName('TInvoiceGUI');
  if Assigned(Form) then begin //if has acess
    with TInvoiceGUI(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
      tblDetails.Edit;
      cboProductQry.Locate('PartsID', KeyID, [loCaseInsensitive]);
      cboProductR.Text := oProductInfo.ProductName;
      tblDetails.FieldByName('ProductName').AsString := oProductInfo.ProductName;
      tblDetails.FieldByName('ProductID').AsInteger := KeyID;
      doOnProductchange;
    end;
  end;

  Close;
end;

procedure TfrmProductETAInfoGUI.btnSalesOrderClick(Sender: TObject);
var
  oProductInfo: TProductInfo;
  Form : TComponent;
begin
  inherited;
  oProductInfo := GetProductInfo(KeyID);
  Form := GetComponentByClassName('TSalesOrderGUI');
  if Assigned(Form) then begin //if has acess
    with TSalesOrderGUI(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
      tblDetails.Edit;
      cboProductQry.Locate('PartsID', KeyID, [loCaseInsensitive]);
      cboProductR.Text := oProductInfo.ProductName;
      tblDetails.FieldByName('ProductName').AsString := oProductInfo.ProductName;
      tblDetails.FieldByName('ProductID').AsInteger := KeyID;
      DoOnClientChange;
    end;
  end;
  Close;
end;

procedure TfrmProductETAInfoGUI.grdETAsDblClick(Sender: TObject);
//Var Form : TComponent;
begin
  inherited;
  if qryETA.FieldByName('PO #').AsInteger =0 then exit;
  OpenERPForm('TPurchaseGUI' , qryETA.FieldByName('PO #').AsInteger);
  Self.CloseWithParentform;
(*  // If the PO # is valid then open related purchase order.
  if (not qryETA.FieldByName('PO #').IsNull) and (qryETA.FieldByName('PO #').AsInteger <> 0) then begin
    Form := GetComponentByClassName('TPurchaseGUI');
    if Assigned(Form) then begin //if has acess
      with TPurchaseGUI(Form) do begin
        KeyID := qryETA.FieldByName('PO #').AsInteger;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end;
 // Close;*)
end;

procedure TfrmProductETAInfoGUI.qryETAAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryETA.IndexFieldNames := 'ETADate ASC CIS';
  PostMessage(Self.Handle, SX_CalcTotalsMsg, 0, 0);
end;

procedure TfrmProductETAInfoGUI.PerformCalcTotals(var Msg: TMessage);
var
  mem: TKbmMemTable;
  dTotal: double;
begin
  dTotal := 0;
  mem := TKbmMemTable.Create(nil);
  try
    mem.LoadFromDataset(qryETA, [mtcpoStructure, mtcpoProperties]);
    mem.First;

    while not mem.Eof do begin
      // Accumulate total.
      dTotal := dTotal + mem.FieldByName('Backorder').AsFloat;
      // Fetch next record.
      mem.Next;
    end;

    // Now show in footer.
    grdETAs.ColumnByName('Backorder').FooterValue := FloatToStrF(dTotal, ffFixed, 15, 4);
  finally
    // Free our allocated objects.
    if Assigned(mem) then
      FreeAndNil(mem);
  end;
end;

procedure TfrmProductETAInfoGUI.FormDestroy(Sender: TObject);
begin
  Self.Connection := nil;
  inherited;             
end;

initialization
  RegisterClassOnce(TfrmProductETAInfoGUI);
  with FormFact do begin
   // RegisterMe(TfrmProductETAInfoGUI, 'TProductListGUI_On Order_OnOrderRequest=PARTSID');
 //   RegisterMe(TfrmProductETAInfoGUI, 'TProductSalesListGUI_On Order=PartsID');
  end;
end.
