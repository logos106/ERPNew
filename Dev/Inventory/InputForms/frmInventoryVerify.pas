unit frmInventoryVerify;

  //////////////////////////////////////////////////////////////////////////////////
  // Daniel: 13/5/2004
  // /////////////////
  //
  // Before showing this form, or just after creating the instance
  // of this form.  You need to setup the following properties.
  //
  // * TransLineDataset - This is the tbldetails that is used.
  // * ConvertingFrom   - String stating what you are converting from.  ie 'Quote'
  // * TransNo          - Integer value to represent Sale Number ie.. Quote No.
  // * SourceClassID    - This is the department / class your products relate too.
  // * SourceCustomerID - This is the ID of the customer.
  //////////////////////////////////////////////////////////////////////////////////

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,
  ActnList, StdCtrls, Grids, BaseGrid, AdvGrid, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  Sales, Cash, DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, Shader,
  BusObjSmartOrder, ImgList, AdvObj, Wwdbigrd, Wwdbgrid, ProgressDialog;

type
  TfmInventoryVerify = class(TBaseInputGUI)
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    ActionList1: TActionList;
    actCreateSmartOrder: TAction;
    btncontinue: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Qrymain: TERPQuery;
    grdmain: TwwDBGrid;
    dsMain: TDataSource;
    QrymainPARTNAME: TWideStringField;
    QrymainPARTSDESCRIPTION: TWideStringField;
    QrymainPURCHASEDESC: TWideStringField;
    QrymainBuyQTY1: TIntegerField;
    QrymainBuyQty2: TIntegerField;
    QrymainBuyQty3: TIntegerField;
    QrymainCost1: TFloatField;
    QrymainCost2: TFloatField;
    QrymainCost3: TFloatField;
    QrymainTAXCODE: TWideStringField;
    QrymainSellQty1: TIntegerField;
    QrymainSellQty2: TIntegerField;
    QrymainSellQty3: TIntegerField;
    QrymainPrice1: TFloatField;
    QrymainPrice2: TFloatField;
    QrymainPrice3: TFloatField;
    QrymainPREFEREDSUPP: TWideStringField;
    QrymainReorderAmount: TFloatField;
    QrymainPreferredLevel: TFloatField;
    QrymainProductID: TIntegerField;
    QrymainClassId: TIntegerField;
    QrymainInvoiceBOQty: TFloatField;
    QrymainOnOrder: TFloatField;
    QrymainInStockQty: TFloatField;
    QrymainSalesOrdersQty: TFloatField;
    QrymainoInvoiceBOQty: TFloatField;
    QrymainoOnOrder: TFloatField;
    QrymainoInStockQty: TFloatField;
    QrymainoSalesOrdersQty: TFloatField;
    QrymainTransQty: TFloatField;
    QrymainOnOrderQty: TFloatField;
    QrymainoOnOrderQty: TFloatField;
    QrymainSuggestedQty: TFloatField;
    QrymainIstoOrder: TWideStringField;
    QrymainLineHasTree: TWideStringField;
    QrymainTransLineID: TIntegerField;
    lblToOrder: TLabel;
    lblMsg: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grdPartsCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: integer; var Allow: boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure actCreateSmartOrderExecute(Sender: TObject);
    procedure actCreateSmartOrderUpdate(Sender: TObject);
    procedure btncontinueClick(Sender: TObject);
    procedure grdPartsCellValidate(Sender: TObject; Col, Row: integer; var Value: string; var Valid: boolean);
    procedure FormCreate(Sender: TObject);
    procedure grdmainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure QrymainIstoOrderChange(Sender: TField);
    procedure QrymainAfterOpen(DataSet: TDataSet);

  private
    { Private declarations }
    iSmartOrderID: integer;
    fiTransNo: Integer;
    iSourceID: integer;
    iCustomerID: integer;
    sConvertFrom: string;
    fTransLineDataset: TCustomMyDataSet;
    //frmSourceCashSaleForm: TBaseCashGUI;
    procedure CreateNewSmartOrder;
    procedure SetSourceID(const Value: integer);
  Protected
    ProductsToOrder: Integer;
    fsTablename :STring;
    Function  TransTableSQL                               :String;virtual;
    Function  TransLineIDfieldName                        :String;virtual;
    Function  TransLineQtyfieldName                       :String;virtual;
    procedure SetUpGridmain                                      ;virtual;
    Function  Extrafields                                 :String;virtual;
    Procedure InitProductinSOLine(Const SOLine:TSmartOrderLine)  ;virtual;
    Function LineHasTree :Boolean                                ;Virtual;

  public
    { Public declarations }
    property TransLineDataset: TCustomMyDataSet read fTransLineDataset write fTransLineDataset;
    property SourceClassID: integer read iSourceID write SetSourceID;

    //property SourceCashSalesForm: TBaseCashGUI read frmSourceCashSaleForm write frmSourceCashSaleForm;
    property SourceCustomerID: integer read iCustomerID write iCustomerID;
    property TransNo: integer read fiTransNo write fiTransNo;
    property ConvertingFrom: string read sConvertFrom write sConvertFrom;
    property SmartOrderID: integer read iSmartOrderID;
  end;

implementation

{$R *.dfm}
uses
  DNMExceptions,
  frmSmartOrderFrm, CommonDbLib, CommonLib, FastFuncs,
  BusObjBase, ProductQtyLib, ProcessDataUtils,
  AppEnvironment, tcDataUtils, tcConst,  BusObjStock, PQALib;

const
  // Grid Columns
  COL_NAME      = 0;
  COL_DESC      = 1;
  COL_RQD       = 2;
  COL_AVAIL     = 3;
  COL_ONORDER   = 4;
  COL_SUGGESTED = 5;
  COL_ORDER     = 6;
  COL_ID        = 7;

procedure TfmInventoryVerify.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    iSmartOrderID := 0;
    try
      if AccessLevel <> 1 then AccessLevel := 6;
      inherited;
      SetUpGridmain;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmInventoryVerify.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caHide;
  Notify;
end;
procedure TfmInventoryVerify.FormCreate(Sender: TObject);
begin
  inherited;
  fsTableName :=GetUserTemporaryTableName('SalesInvVerify') ;
end;


procedure TfmInventoryVerify.SetSourceID(const Value: integer);
var
  s:String;
begin
  iSourceID:= value;
  s:= tcDatautils.getclassName(Value);
  grdmain.Selected[3] := 'InStockQty'#9'9'#9'Available'#9'F'#9+s;
  grdmain.Selected[4] := 'OnOrderQty'#9'9'#9'On Order'#9'F'#9+s;
  grdmain.Selected[5] := 'oInStockQty'#9'9'#9'Available'#9'F'#9'All Other ' + AppEnv.Defaultclass.ClassHeading;
  grdmain.Selected[6] := 'oOnOrderQty'#9'9'#9'On Order'#9'F'#9'All Other ' + AppEnv.Defaultclass.ClassHeading;
  grdmain.Applyselected;
end;

procedure TfmInventoryVerify.grdmainCalcTitleAttributes(Sender: TObject;
  AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  ABrush.color := $00E0E0E0;
end;

procedure TfmInventoryVerify.grdPartsCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: integer;
  var Allow: boolean);
begin
  inherited;
  // We don't want them changing any cell other than clicking the ok button
  if NewCol = COL_ORDER then begin
    Allow := true;
  end else begin
    Allow := false;
  end;
end;

procedure TfmInventoryVerify.btnCancelClick(Sender: TObject);
begin
  inherited;
  // Since this form is shown as Modal, we pass a result
  // to ModalResult on the form and it will be passed
  // back and the form will close.
  Self.ModalResult := 3;
end;

procedure TfmInventoryVerify.actCreateSmartOrderExecute(Sender: TObject);
//Var Form : TComponent;
begin
  inherited;
  // Create new Sales Order
  CreateNewSmartOrder;

  // Now Show Sales Order.
  if iSmartOrderID <> 0 then begin
//    Form := GetComponentByClassName('TSmartOrderGUI');
//    if Assigned(Form) then begin //if has acess
//      with TSmartOrderGUI(Form) do begin
//        KeyID := Self.iSmartOrderID;
//        FormStyle := fsMDIChild;
//        BringToFront;
//      end;
//    end;

    // Since this form is shown as Modal, we pass a result
    // to ModalResult on the form and it will be passed
    // back and the form will close.
    Self.ModalResult := 1;
  end;
end;

procedure TfmInventoryVerify.actCreateSmartOrderUpdate(Sender: TObject);
begin
  inherited;
  actCreateSmartOrder.Enabled := ProductsToOrder>0;
  lblToOrder.Caption := 'Products To Order : ' + inttostr(ProductsToOrder);
end;

procedure TfmInventoryVerify.CreateNewSmartOrder;
var
    SmartOrder : TSmartOrder;

    procedure CreateSmartOrderLines;
    begin
        TransLineDataset.First;
        Qrymain.first;
        while Qrymain.eof = False do begin
          if QrymainistoOrder.asBoolean then begin
(*                if not TransLineDataset.Locate(QrymainProductId.asInteger,QrymainProductID.asInteger,[]) then
                  raise Exception.Create(Self.classname + ' - could not locate PartID ' + inttostr(QrymainProductID.asInteger));*)

                if SameText(ConvertingFrom , 'Repair') then begin
                  TransLineDataset.Locate('RepairPartsID' , qrymaintranslineId.AsInteger,[]) ;
                end else begin
                  TransLineDataset.Locate('SaleLineID' , qrymaintranslineId.AsInteger,[]);
                end;

                SmartOrder.Lines.New;
                InitProductinSOLine(SmartOrder.Lines);
                SmartOrder.Lines.PODesc          := Qrymain.FieldByName('PurchaseDesc').AsString;
                SmartOrder.Lines.Suppliername    := Qrymain.FieldByName('PREFEREDSUPP').AsString;
                SmartOrder.Lines.ToPurchaseUOMQtyexWastagePercentage(*ToPurchaseUOMQty*):= QrymainSuggestedQty.asFloat;
                SmartOrder.Lines.ClassID         := SourceClassID;
                SmartOrder.Lines.CusJobID        := SourceCustomerID;
                SmartOrder.Lines.costEx          := TProduct.GetCostForQty( QrymainproductID.AsInteger, QrymainTRansQty.AsFloat);
                if SameText(ConvertingFrom , 'Repair') then begin
                  SmartOrder.Lines.repairID := TransNo;
                  if TransLineDataset.Locate('RepairPartsID' , qrymaintranslineId.AsInteger,[]) then begin
                      SmartOrder.Lines.LinePrice            := TransLineDataset.fieldbyname('Linecost').AsFloat;
                      SmartOrder.Lines.CustomerEquipmentID  := TransLineDataset.fieldbyname('CustomerEquipmentID').asInteger;
                      SmartOrder.Lines.EquipmentName        := TransLineDataset.fieldbyname('Equipment').AsString;
                      SmartOrder.Lines.RepairPartsID        := qrymaintranslineId.AsInteger;
                  end;
                end else begin
                  SmartOrder.Lines.SaleLineID := qrymaintranslineId.AsInteger;
                  if TransLineDataset.Locate('SaleLineID' , qrymaintranslineId.AsInteger,[]) then
                      SmartOrder.Lines.LinePrice := TransLineDataset.fieldbyname('LineCost').AsFloat;
                end;
                SmartOrder.Lines.PostDB;
            end;
            Qrymain.NExt;
        end;
    End;

begin
    iSmartOrderID           := 0;
    SmartOrder              := TsmartOrder.Create(nil);
    SmartOrder.connection   := TMydacdataconnection.Create(SmartOrder);
    SmartOrder.Connection.Connection    := CommonDbLib.GetNewMyDacConnection(SmartOrder);
    SmartOrder.Connection.BeginTransaction;
    try
        SmartOrder.New;
        SmartOrder.SmartOrderDesc   := 'Created from ' + ConvertingFrom + ' #' + inttostr(TransNo);
        SmartOrder.ProjectLineID    := 0;
        SmartOrder.PostDB;
        CreateSmartOrderLines;
        SmartOrder.Save;
        iSmartOrderID               := SmartOrder.ID;
    Finally
        SmartOrder.Connection.CommitTransaction;
        SmartOrder.Free;
    End;
end;

function TfmInventoryVerify.Extrafields: String;
begin
  Result:= '';
end;

procedure TfmInventoryVerify.btncontinueClick(Sender: TObject);
begin
  inherited;
  // Since this form is shown as Modal, we pass a result
  // to ModalResult on the form and it will be passed
  // back and the form will close.
  Self.ModalResult := 2;
end;

procedure TfmInventoryVerify.grdPartsCellValidate(Sender: TObject; Col, Row: integer;
  var Value: string; var Valid: boolean);
begin
  inherited;
  if Col = COL_NAME then begin
    Valid := false;
  end;
end;

procedure TfmInventoryVerify.InitProductinSOLine(const SOLine: TSmartOrderLine);
begin

end;

function TfmInventoryVerify.LineHasTree: Boolean;
begin
  REsult:= False;
end;


procedure TfmInventoryVerify.QrymainAfterOpen(DataSet: TDataSet);
var
  ctr:Integer;
begin
  inherited;
  ctr:=qrymain.recordcount ;
  try
    if qrymain.recordcount > 0 then begin
        Qrymain.First;
        ProductsToOrder:=0;
        while Qrymain.Eof = False do begin
          Qrymain.edit;
          QrymainLineHasTree.asboolean := LineHasTree;
          if Qrymainistoorder.asBoolean then ProductsToOrder := ProductsToOrder +1;
          Qrymain.Next;
        end;
    end;
  finally
    if ctr> qrymain.recordcount then
      TimerMsg(lblMsg , 'BOM Product(s) are not listed for quantity varification')
  end;

end;

procedure TfmInventoryVerify.QrymainIstoOrderChange(Sender: TField);
begin
  inherited;
  if QrymainISToOrder.AsBoolean then ProductsToOrder := ProductsToOrder +1 else ProductsToOrder :=ProductsToOrder -1;
end;

procedure TfmInventoryVerify.SetUpGridmain;
var
  tmpfilename:STring;
begin
  With TempMyScript do try
   SQL.add('Drop table if exists ' +fstablename +';');
   SQL.add('CREATE TABLE `' +fstablename +'` ( ' +
            ' `PARTNAME`          varchar(60) DEFAULT NULL,' +
            ' `PARTSDESCRIPTION`  varchar(255) DEFAULT NULL,' +
            ' `PURCHASEDESC`      varchar(255) DEFAULT NULL,' +
            ' `BuyQTY1`           int(11) DEFAULT NULL,' +
            ' `BuyQty2`           int(11) DEFAULT NULL,' +
            ' `BuyQty3`           int(11) DEFAULT NULL,' +
            ' `Cost1`             double NOT NULL DEFAULT 0,' +
            ' `Cost2`             double NOT NULL DEFAULT 0,' +
            ' `Cost3`             double NOT NULL DEFAULT 0,' +
            ' `TAXCODE`           varchar(15) DEFAULT NULL,' +
            ' `SellQty1`          int(11) DEFAULT NULL,' +
            ' `SellQty2`          int(11) DEFAULT NULL,' +
            ' `SellQty3`          int(11) DEFAULT NULL,' +
            ' `Price1`            double NOT NULL DEFAULT 0,' +
            ' `Price2`            double NOT NULL DEFAULT 0,' +
            ' `Price3`            double NOT NULL DEFAULT 0,' +
            ' `PREFEREDSUPP`      varchar(55) DEFAULT NULL,' +
            ' `ReorderAmount`     double DEFAULT 0,' +
            ' `PreferredLevel`    double DEFAULT 0,' +
            ' `ProductID`         int(11) NOT NULL DEFAULT 0,' +
            ' `ClassId`           int(11) DEFAULT NULL,' +
            ' `TransLineID`       int(11) NOT NULL DEFAULT 0,' +
            ' `InvoiceBOQty`      double DEFAULT NULL,' +
            ' `OnOrder`           double DEFAULT NULL,' +
            ' `InStockQty`        double DEFAULT NULL,' +
            ' `SalesOrdersQty`    double DEFAULT NULL,' +
            ' `oInvoiceBOQty`     double DEFAULT NULL,' +
            ' `oOnOrder`          double DEFAULT NULL,' +
            ' `oInStockQty`       double DEFAULT NULL,' +
            ' `oSalesOrdersQty`   double DEFAULT NULL,' +
            ' `TransQty`          double NOT NULL DEFAULT 0,' +
            ' `OnOrderQty`        double DEFAULT NULL,' +
            ' `oOnOrderQty`       double DEFAULT NULL,' +
            ' `SuggestedQty`      double DEFAULT NULL,' +
            ' `IstoOrder`         enum("T","F") DEFAULT "F",' +
            ' `LineHasTree`       enum("T","F") DEFAULT "F"' +
            ') ENGINE=MyISAM DEFAULT CHARSET=utf8;' );
    Execute;
    SQL.Clear;

    Connection := TERPConnection(TransLineDataset.Connection);

      SQL.Add(CreateTemporaryTableusingfile('' ,' SELECT'+
                  ' P.PARTNAME, PARTSDESCRIPTION, PURCHASEDESC,'+
                  'BuyQTY1, BuyQty2, BuyQty3, Cost1, Cost2, Cost3, P.TAXCODE,'+
                  'SellQty1, SellQty2, SellQty3, Price1, Price2, Price3, PREFEREDSUPP,'+
                  'PC.ReorderAmount, '+
                  'PC.PreferredLevel, '+
                  'P.PartsId ProductID,PC.ClassId, '+
                  transLineIDfieldname +' as TransLineID , '+
                   'Round(Sum(if(PC.ClassID  = ' + inttostr(SourceClassID) +'  ,' +ProductQtyLib.SQL4QtyField(tInvBO  )+',0)),' + IntToStr(tcConst.GeneralRoundPlaces) +') as InvoiceBOQty,'+
                   'Round(Sum(if(PC.ClassID  = ' + inttostr(SourceClassID) +'  ,' +ProductQtyLib.SQL4QtyField(tPOBO   )+',0)),' + IntToStr(tcConst.GeneralRoundPlaces) +') as OnOrder,'+
                   'Round(Sum(if(PC.ClassID  = ' + inttostr(SourceClassID) +'  ,' +ProductQtyLib.SQL4QtyField(tInStock)+',0)),' + IntToStr(tcConst.GeneralRoundPlaces) +') as InStockQty,'+
                   'Round(Sum(if(PC.ClassID  = ' + inttostr(SourceClassID) +'  ,' +ProductQtyLib.SQL4QtyField(tSO     )+',0)),' + IntToStr(tcConst.GeneralRoundPlaces) +') as SalesOrdersQty,'+
                   'Round(Sum(if(PC.ClassID <> ' + inttostr(SourceClassID) +'  ,' +ProductQtyLib.SQL4QtyField(tInvBO  )+',0)),' + IntToStr(tcConst.GeneralRoundPlaces) +') as oInvoiceBOQty,'+
                   'Round(Sum(if(PC.ClassID <> ' + inttostr(SourceClassID) +'  ,' +ProductQtyLib.SQL4QtyField(tPOBO   )+',0)),' + IntToStr(tcConst.GeneralRoundPlaces) +') as oOnOrder,'+
                   'Round(Sum(if(PC.ClassID <> ' + inttostr(SourceClassID) +'  ,' +ProductQtyLib.SQL4QtyField(tInStock)+',0)),' + IntToStr(tcConst.GeneralRoundPlaces) +') as oInStockQty,'+
                   'Round(Sum(if(PC.ClassID <> ' + inttostr(SourceClassID) +'  ,' +ProductQtyLib.SQL4QtyField(tSO     )+',0)),' + IntToStr(tcConst.GeneralRoundPlaces) +') as oSalesOrdersQty, '+
                   TransLineQtyfieldName +' as TransQty '+
                  ' FROM ' + replaceStr(ProductQtyLib.ProductTables(tSummary) , 'INNER JOIN'  , 'LEFT JOIN')+ ' '+
                  TransTableSQL+
                  ' group by P.PartsID' ,
                  '`PARTNAME`,`PARTSDESCRIPTION`,`PURCHASEDESC`,`BuyQTY1`,`BuyQty2`,`BuyQty3`,`Cost1`,`Cost2`,`Cost3`,`TAXCODE`,`SellQty1`,`SellQty2`,'+
                  '`SellQty3`,`Price1`,`Price2`,`Price3`,`PREFEREDSUPP`,`ReorderAmount`,`PreferredLevel`,`ProductID`,`ClassId`,`TransLineID`,`InvoiceBOQty`,'+
                  '`OnOrder`,`InStockQty`,`SalesOrdersQty`,`oInvoiceBOQty`,`oOnOrder`,`oInStockQty`,`oSalesOrdersQty`,`TransQty`' ,
                  fstablename , tmpfilename)+';');


    (*SQL.add('Alter table ' +fsTablename +' add column OnOrderQty Double ;');
    SQL.add('Alter table ' +fsTablename +' add column oOnOrderQty Double ;');
    SQL.add('Alter table ' +fsTablename +' add column SuggestedQty Double ;');
    SQL.add('Alter table ' +fsTablename +' add column IstoOrder Enum("T","F") Default "F" ;');
    SQL.add('Alter table ' +fsTablename +' add column LineHasTree Enum("T","F") Default "F" ;');*)
    SQL.add('update ' +fsTablename +' Set OnOrderQty  = OnOrder + InvoiceBOQty +  InvoiceBOQty ;');
    SQL.add('update ' +fsTablename +' Set oOnOrderQty  = oOnOrder + oInvoiceBOQty +  oInvoiceBOQty ;');
    SQL.add('update ' +fsTablename +' Set SuggestedQty  = PreferredLevel - (InStockQty - SalesOrdersQty - InvoiceBOQty +OnOrder) ;');
    SQL.add('update ' +fsTablename +' Set SuggestedQty  = ifnull(ReorderAmount,0) WHERE ifnull(SuggestedQty,0) < ifnull(ReorderAmount,0);');
    SQL.add('update ' +fsTablename +' Set SuggestedQty  = TransQty WHERE ifnull(SuggestedQty,0) =0;');
    SQL.add(Extrafields);
    Execute;
  finally
    AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename, '.tmp' , '*.tmp'));
    Free;
  end;

  CloseDB(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select * from ' +fsTablename );
  Qrymain.Open;
end;
function TfmInventoryVerify.TransLineIDfieldName: String;
begin
  REsult:= '';
end;

function TfmInventoryVerify.TransLineQtyfieldName: String;
begin
  REsult:= '';
end;

function TfmInventoryVerify.TransTableSQL: String;
begin
  REsult:='';
end;

end.
