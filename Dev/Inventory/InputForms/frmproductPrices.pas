unit frmproductPrices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel, wwdblook, Mask, DBCtrls, Grids, Wwdbigrd, Wwdbgrid,
  wwcheckbox, DNMSpeedButton, busobjPartsPriceMatrix, ProgressDialog;

type
  TfmproductPrices = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cboPartsQry: TERPQuery;
    QryCustomer: TERPQuery;
    QryCustomerclientID: TIntegerField;
    QryCustomercompany: TWideStringField;
    Panel1: TPanel;
    lblClassTitle: TLabel;
    cboPart: TwwDBLookupCombo;
    Panel2: TPanel;
    Label1: TLabel;
    cboCustomer: TwwDBLookupCombo;
    Panel4: TPanel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    edtPrice1: TDBEdit;
    edtPrice2: TDBEdit;
    edtPrice3: TDBEdit;
    edtPrice1inc: TDBEdit;
    edtPrice3inc: TDBEdit;
    edtPrice2inc: TDBEdit;
    Qrybaseprice: TERPQuery;
    dsbaseprice: TDataSource;
    QrybasepriceSellQTY1: TIntegerField;
    Qrybasepriceprice1: TFloatField;
    Qrybasepricepriceinc1: TFloatField;
    QrybasepriceSellQTY2: TIntegerField;
    Qrybasepriceprice2: TFloatField;
    Qrybasepricepriceinc2: TFloatField;
    QrybasepriceSellQTY3: TIntegerField;
    Qrybasepriceprice3: TFloatField;
    Qrybasepricepriceinc3: TFloatField;
    QryCustomerSpecialPrice: TERPQuery;
    dsCustomerSpecialPrice: TDataSource;
    QryCustomerSpecialPriceClientId: TIntegerField;
    QryCustomerSpecialPriceCompany: TWideStringField;
    QryCustomerSpecialPriceLineprice: TFloatField;
    Panel5: TPanel;
    grdCustomerlines: TwwDBGrid;
    qryExtraSellPrice: TERPQuery;
    dsExtraSellPrice: TDataSource;
    qryExtraSellPriceClientID: TIntegerField;
    qryExtraSellPricePartsId: TIntegerField;
    qryExtraSellPriceTypeName: TWideStringField;
    qryExtraSellPriceDateFrom: TDateField;
    qryExtraSellPriceDateTo: TDateField;
    qryExtraSellPriceUOM: TWideStringField;
    qryExtraSellPricePrice1: TFloatField;
    qryprodgroupdiscs: TERPQuery;
    dsprodgroupdiscs: TDataSource;
    qryprodgroupdiscsclientId: TIntegerField;
    qryprodgroupdiscscol1: TWideStringField;
    qryprodgroupdiscscol2: TWideStringField;
    qryprodgroupdiscscol3: TWideStringField;
    qryprodgroupdiscsdiscount: TFloatField;
    qrycustomerDiscount: TERPQuery;
    dscustomerDiscount: TDataSource;
    qrycustomerDiscountClientId: TIntegerField;
    qrycustomerDiscountCompany: TWideStringField;
    qrycustomerDiscountDiscount: TWideStringField;
    qrycustomerDiscountSpecialDiscount: TWideStringField;
    qrycustomerDiscountGroupDiscountOverridesAll: TWideStringField;
    qrycustomerDiscountSpecialProductPriceOverridesAll: TWideStringField;
    QryPriceMatrix: TERPQuery;
    dsPriceMatrix: TDataSource;
    QryPriceMatrixEntryValueRef: TWideMemoField;
    QryPriceMatrixPrice: TFloatField;
    Panel9: TPanel;
    grdPriceMatrix: TwwDBGrid;
    QryPriceMatrixEntryValueDesc: TStringField;
    cboPartsQryPARTSID: TIntegerField;
    cboPartsQryPartName: TWideStringField;
    QrybasepricePURCHTAXCODE: TWideStringField;
    QrybasepriceTAXCODE: TWideStringField;
    Panel10: TPanel;
    DBEdit9: TDBEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label13: TLabel;
    Price: TLabel;
    Label14: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    Panel11: TPanel;
    Label17: TLabel;
    EdtQty: TEdit;
    Label18: TLabel;
    edtPrice: TEdit;
    dsUnitOfMeasure: TDataSource;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitID: TIntegerField;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    qryUnitOfMeasureBaseUnitName: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    QryPriceMatrixID: TIntegerField;
    qryExtraSellPricePriceId: TIntegerField;
    qryprodgroupdiscsGrpDiscID: TIntegerField;
    QryCustomerSpecialPriceCustomerLinesID: TIntegerField;
    qryExtraSellPriceQtyPercent1: TFloatField;
    edtPriceinc: TEdit;
    Qrybasepricepurchaserate: TFloatField;
    Qrybasepricesalesrate: TFloatField;
    qryUnitOfMeasurePrice1: TFloatField;
    qryUnitOfMeasurePrice2: TFloatField;
    qryUnitOfMeasurePrice3: TFloatField;
    qryExtraSellPriceTerms: TWideStringField;
    qryExtraSellPriceAvgCost: TFloatField;
    qryExtraSellPriceLatestCost: TFloatField;
    DBEdit1: TDBEdit;
    lblBOMPrice: TLabel;
    edtBOMPrice: TDBEdit;
    DNMPanel1: TDNMPanel;
    Panel3: TPanel;
    Label2: TLabel;
    grdGroupdiscount: TwwDBGrid;
    Panel7: TPanel;
    Label6: TLabel;
    grduom: TwwDBGrid;
    DNMPanel2: TDNMPanel;
    Panel6: TPanel;
    lblclientDiscount: TLabel;
    memresult: TMemo;
    pnlExtraSellPrice: TPanel;
    Label5: TLabel;
    grdExtraSellPrice: TwwDBGrid;
    Panel8: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    edtPermanenntdiscount: TDBEdit;
    edtSpecialdiscount: TDBEdit;
    chkgroupdiscount: TwwCheckBox;
    chksplPrductdiscount: TwwCheckBox;
    DNMPanel3: TDNMPanel;
    Label10: TLabel;
    qrypartsforexcelprice: TERPQuery;
    dspartsforexcelprice: TDataSource;
    qrypartsforexcelpricePrice: TFloatField;
    qrypartsforexcelpriceOvirrides: TWideStringField;
    grdExcelPrices: TwwDBGrid;
    lblExcelPriceMsg: TLabel;
    lblMsg: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure QryPriceMatrixCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure wwDBLookupCombo1Change(Sender: TObject);
    procedure cboCustomerChange(Sender: TObject);
    procedure EdtQtyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdPriceMatrixCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdExtraSellPriceCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grduomCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdGroupdiscountCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdCustomerlinesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qryprodgroupdiscsAfterOpen(DataSet: TDataSet);
  private
    fiProductID: Integer;
    fiCustomerId: Integer;
    PriceMatrixID:Integer;
    fiESPID:Integer;
    fiGrpDiscID:Integer;
    fiCustomerLinesID:Integer;
    fiUOMID:Integer;
    fiUnitID:Integer;
    fMatrixItemObj :TMatrixItemObj;
    fdQty: Double;
    fdTaxRate: Double;
    fdMarginAmount: Double;
    fdMarginPercent: Double;
    fsMatrixRef: String;
    fsfTerms: String;
    fsMsg: String;
    fdBOMPrice:Double;

    Procedure RefreshQuery;
    procedure SetCustomerId(const Value: Integer);
    procedure SetProductID(const Value: Integer);
    Procedure doCalculateprice;
    procedure SetFontcolor(AFont: TFont; int1, int2: Integer);
    Function MatrixItemObj :TMatrixItemObj;
    Procedure RefreshResult(ClientPriceAllDiscounts:String);
    procedure setQty(const Value: Double);
    procedure setTerms(const Value: String);
    { Private declarations }
  public
    Property ProductID:Integer read fiProductID write SetProductID;
    Property CustomerId :Integer read fiCustomerId write SetCustomerId;
    Property Terms :String read fsfTerms write setTerms;
    Property uomid :Integer read fiUOMID write fiUOMID;
    Property Qty :Double read fdQty write setQty;
    Property TaxRate :Double read fdTaxRate write fdTaxRate;
    Property MarginAmount :Double read fdMarginAmount write fdMarginAmount;
    Property MarginPercent :Double read fdMarginPercent write fdMarginPercent;
    Property MatrixRef :String read fsMatrixRef write fsMatrixRef;
    Property Msg :String read fsMsg write fsMsg;
    Property BOMPrice :double read fdBOMPrice write fdBOMPrice;

    class Procedure showProduct(fProductID:Integer; fcustomerID:Integer;fTerms:String; fUOMId:Integer;fqty,fTaxRate:Double;fMatrixRef:String; fMarginamount, fMarginPercent :Double; fMsg:String=''; fBOMPrice :Double =0);
  end;

implementation

uses CommonLib, ProductQtyLib, PartsPriceMatrixLib, tcConst, AppEnvironment,
  BusObjStock, BusObjBase, ClientDiscountObj, FastFuncs, SystemLib, tcDataUtils;

{$R *.dfm}
procedure TfmproductPrices.cboCustomerChange(Sender: TObject);
begin
  inherited;
  CustomerID:= QryCustomerClientID.asInteger;
end;

procedure TfmproductPrices.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  doCalculateprice;
end;

procedure TfmproductPrices.doCalculateprice;
var
  baseprice, qty:double;
  Product:TProduct;
  fClientDiscountObj : TClientDiscountObj;
  RetPriceEx:Double;
  RetDiscountPercent:Double;
  RetDesc:String;
  RetMsg:String;
  Procedure ShowExcelPriceMsg;
  var
    errMsg:String;
  begin
  if not HasExcelPriceforProduct(ProductID, errmsg) then
    if (errmsg<> '') then begin
       lblExcelPriceMsg.caption := errmsg;
       lblExcelPriceMsg.visible := True;
       lblExcelPriceMsg.Refresh;
       grdExcelPrices.visible := False;
    end;
  end;
begin
  fiESPID:= 0;
  fiGrpDiscID:=0;
  fiCustomerLinesID:= 0;
  fiunitId:=qryUnitOfMeasureUnitID.asInteger;
  Product := TProduct.create(Self);
  try
    Product.connection := TMyDacDataConnection.create(Product);
    Product.connection.connection := Self.MyConnection;
    Product.Load(ProductID);
    qty := strToFloat(EdtQty.text);
    //grdExtraSellPrice.Font.color    := clblack;
    edtPermanenntdiscount.font.color:= clblack;
    edtSpecialdiscount.font.color   := clblack;
    grdCustomerlines.font.color     := clblack;
    grdgroupdiscount.font.color     := clblack;
    //grdPriceMatrix.font.color:=  clblack;
    edtPrice1.font.color := clblack;
    edtPrice2.font.color := clblack;
    edtPrice3.font.color := clblack;

    if QryPriceMatrix.recordcount >0 then begin
      baseprice:= QryPriceMatrixPrice.asFloat;
      (*grdPriceMatrix.font.color:= clred;*)
      PriceMatrixID:= QryPriceMatrixID.asInteger;
    end else if BOMPrice =0 then begin
    end else begin
      baseprice:= Product.GetPriceForQty(qty);
      if Qty<QrybasepriceSellQTY2.asFloat then edtPrice1.font.color := clred
      else if Qty<QrybasepriceSellQTY3.asFloat then edtPrice2.font.color := clred
      else edtPrice3.font.color := clred
    end;
    if customerID<>0 then begin
      fClientDiscountObj := TClientDiscountObj.Create;
      try
        if fClientDiscountObj.ClientPrice_Discounts(
               customerID,
               Terms,
               ProductId,
               qryUnitOfMeasureUnitID.asInteger,
               appenv.DefaultClass.ClassID,
               qty,
               date,
               False,
               RetPriceEx,
               RetDiscountPercent,
               RetDesc,
               RetMsg,
               True , QryPriceMatrixEntryValueRef.asString ) then begin
               if baseprice> RetPriceEx then baseprice:= RetPriceEx;
               if fClientDiscountObj.discounttype = EXTRA_SELL      then begin fiESPID := fClientDiscountObj.ExtraSellpriceId;
          end else if fClientDiscountObj.discounttype = PERMANENT       then begin edtPermanenntdiscount.font.color := clred;
          end else if fClientDiscountObj.discounttype = SPEC_DISC       then begin edtSpecialdiscount.font.color    := clred;
          end else if fClientDiscountObj.discounttype = SPEC_PRICE_DISC then begin fiCustomerLinesID:= fClientDiscountObj.CustomerLinesID;
          end else if fClientDiscountObj.discounttype = PROD_GROUP_DISC then begin fiGrpDiscID := fClientDiscountObj.GrpDiscID;
          end;
          CloseDb(qrypartsforexcelprice);
          if not fClientDiscountObj.Haspartsforexcelprice then
               qrypartsforexcelprice.SQL.text := 'Select 0.0  as Price, "F" as Ovirrides'
          else qrypartsforexcelprice.SQL.text := 'Select convert(' + Floattostr(fClientDiscountObj.partsforexcelprice)+',DECIMAL)  as Price, '+
                                                    'convert('+ quotedstr(BooleantoStr(fClientDiscountObj.partsforexcelpriceOverrides))+', char(10)) as Ovirrides';

          OpenDB(qrypartsforexcelprice);
          if   RetDiscountPercent <> 0 then  baseprice := baseprice - baseprice*(RetDiscountPercent);
          lblclientDiscount.caption:= fClientDiscountObj.ClientPriceDiscount;
          if trim(lblclientDiscount.caption) = '' then lblclientDiscount.caption := 'No Discount';
          lblBOMPrice.visible := bomprice<>0;
          edtBOMPrice.visible := bomprice<>0;
          edtBOMPrice.text :=  floattoStrF(bomprice,  ffCurrency, 15 , 2);
          refreshResult(fClientDiscountObj.ClientPriceAllDiscounts);
        end;
        edtPrice.text := floattoStrF(baseprice*qty,  ffCurrency, 15 , 2);
        if fdTaxRate<> 0 then baseprice := baseprice + baseprice*fdTaxRate
          else baseprice := baseprice + baseprice*QrybasepriceSalesRate.asFloat;
        edtPriceinc.text := floattoStrF(baseprice*qty,  ffCurrency, 15 , 2);
        ShowExcelPriceMsg;
        Repaint;
      finally
        Freeandnil( fClientDiscountObj);
      end;
    end;
  finally
      Freeandnil( Product);
  end;
end;

procedure TfmproductPrices.EdtQtyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = vk_return then
    doCalculateprice;
end;

procedure TfmproductPrices.FormCreate(Sender: TObject);
begin
  qryprodgroupdiscs.SQL.clear;
  qryprodgroupdiscs.SQL.add('	Select GrpDiscID, GD.clientId, GD.col1,GD.col2,GD.col3,GD.discount  '+
                            ' from tblprodgroupdiscs GD '+
                            ' inner join tblParts P on ' +Firstcolumn('P') +'=GD.Col1 ' +
                            ' OR ' +secondcolumn('P') +'=GD.Col2 '+
                            ' OR ' +thirdcolumn('P') +'=GD.Col3 '+
                            ' Where P.PartsID =:ProductId AND GD.ClientID = :ClientId');
  Qrybaseprice.Params.Parambyname('xRegionID').asInteger := AppEnv.RegionalOptions.ID;
  inherited;
  fbTabSettingEnabled := False;
    fiProductID:=0;
    fiCustomerId:=0;
    PriceMatrixID:= 0;
    fiESPID:= 0;
    fiUOMID:=0;
    fiunitID:=0;
    fiGrpDiscID:= 0;
    fiCustomerLinesID:=0;
    fMatrixItemObj:= nil;
    fdQty:=0;
    fsMatrixRef:= '';
    fdTaxRate:=0;
    fdMarginAmount:=0;
    fdMarginPercent:=0;
end;

procedure TfmproductPrices.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_f5 then
    doCalculateprice;
end;

procedure TfmproductPrices.FormShow(Sender: TObject);
begin
  inherited;
  OpenDB(cboPartsQry);
  OpenDB(QryCustomer);

  RefreshQuery;

  if productID<> 0 then
    if cboPartsQry.locate('PartsID' , ProductID, []) then
      cboPart.text :=cboPartsQryPartname.asString;
  if customerId <> 0 then
    if QryCustomer.locate('clientID' ,customerId , []) then
      cboCustomer.text :=QryCustomercompany.asString;

  if fiUOMID <> 0 then
    qryUnitOfMeasure.locate('unitId', fiUOMID , []);

  if fsMatrixRef <> '' then
    QryPriceMatrix.Locate('EntryValueRef' ,fsMatrixRef , []);

  if qty <> 0 then doCalculateprice;

end;



procedure TfmproductPrices.QryPriceMatrixCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryPriceMatrixEntryValueDesc.asString :=   MatrixValueReftoMatrixValue(QryPriceMatrixEntryValueRef.asString, MatrixItemObj);
end;

procedure TfmproductPrices.qryprodgroupdiscsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryprodgroupdiscscol1.displaylabel := AppEnv.DefaultClass.FirstColumn;
  qryprodgroupdiscscol2.displaylabel := AppEnv.DefaultClass.SecondColumn;
  qryprodgroupdiscscol3.displaylabel := AppEnv.DefaultClass.ThirdColumn;
end;

procedure TfmproductPrices.RefreshQuery;
begin
  Qrybaseprice.disablecontrols;
  qryExtraSellPrice.disablecontrols;
  QryCustomerSpecialPrice.disablecontrols;
  qryprodgroupdiscs.disablecontrols;
  qrycustomerDiscount.disablecontrols;
  QryPriceMatrix.disablecontrols;
  qryUnitOfMeasure.disablecontrols;
  try
    CloseDB(Qrybaseprice);
    CloseDB(qryExtraSellPrice);
    CloseDB(QryCustomerSpecialPrice);
    CloseDB(qryprodgroupdiscs);
    CloseDB(qrycustomerDiscount);
    CloseDB(QryPriceMatrix);
    CloseDB(qryUnitOfMeasure);


    Qrybaseprice.Params.Parambyname('ProductId').asInteger            := ProductId;
    qryExtraSellPrice.Params.Parambyname('ProductId').asInteger       := ProductId;
    QryCustomerSpecialPrice.Params.Parambyname('ProductId').asInteger := ProductId;
    qryprodgroupdiscs.Params.Parambyname('ProductId').asInteger       := ProductId;
    QryPriceMatrix.Params.Parambyname('ProductId').asInteger          := ProductId;
    qryUnitOfMeasure.Params.Parambyname('xPartId').asInteger          := ProductID;

    qrycustomerDiscount.Params.Parambyname('customerId').asInteger    := CustomerId;
    qryExtraSellPrice.Params.Parambyname('customerId').asInteger      := customerId;
    QryCustomerSpecialPrice.Params.Parambyname('customerId').asInteger:= customerId;
    qryprodgroupdiscs.Params.Parambyname('ClientId').asInteger        := customerId;


    qryExtraSellPrice.Params.Parambyname('Terms').asString:= TErms;

    OpenDB(Qrybaseprice);
    OpenDB(qryExtraSellPrice);
    OpenDB(QryCustomerSpecialPrice);
    OpenDB(qryprodgroupdiscs);
    OpenDB(qrycustomerDiscount);
    OpenDB(QryPriceMatrix);
    OpenDB(qryUnitOfMeasure);
    OpenDB(qrypartsforexcelprice);
  finally
    Qrybaseprice.enablecontrols;
    qryExtraSellPrice.enablecontrols;
    QryCustomerSpecialPrice.enablecontrols;
    qryprodgroupdiscs.enablecontrols;
    qrycustomerDiscount.enablecontrols;
    QryPriceMatrix.enablecontrols;
    qryUnitOfMeasure.enablecontrols;
  end;
end;

procedure TfmproductPrices.RefreshResult(ClientPriceAllDiscounts: String);
var
  st:TStringlist;
  ctr:Integer;
begin
  memresult.lines.clear;
  st:= tStringList.create;
  try
    Split(ClientPriceAllDiscounts , chr(13)  , st);
    memresult.lines.Clear;
    if Msg<> '' then memresult.lines.add(Msg);
    if marginPercent <> 0 then memresult.lines.add('Sales Margin (%) : ' + FloatToStrF(round(marginPercent,2) , ffGeneral , 15,2)+' %');
    if Marginamount  <> 0 then memresult.lines.add('Sales Margin Amount : ' + FloatToStrF(Marginamount , ffCurrency , 15,2));

    for ctr := 0 to st.count-1 do
      memresult.lines.add(st[ctr]);

  finally
    freeandNil(st);
  end;
end;

procedure TfmproductPrices.SetCustomerId(const Value: Integer);
begin
  fiCustomerId := Value;
  //RefreshQuery;
end;

procedure TfmproductPrices.SetProductID(const Value: Integer);
begin
  fiProductID := Value;
  //RefreshQuery;
end;


procedure TfmproductPrices.setQty(const Value: Double);
begin
  fdQty := value;
  if fdQty =0 then begin
    fdQty := 1;
    timermsg(lblMsg , 'Sales Quantity is 0, This Price is Calculated for Default Qty 1');
  end;
  EdtQty.text := FloatTostr(Value);
end;

procedure TfmproductPrices.setTerms(const Value: String);
begin
  fsfTerms := Value;
  //RefreshQuery;
end;

class procedure TfmproductPrices.showProduct(fProductID, fcustomerID:Integer; fTerms:String;fUOMId: Integer; fqty, fTaxRate: Double;fMatrixRef:String;  fMarginamount, fMarginPercent :Double; fMsg:String=''; fBOMPrice :Double =0);
var
  form :TfmproductPrices;
begin
  form := TfmproductPrices.create(nil);
  try
    Form.customerId := fcustomerId;
    Form.Terms := fTerms;
    Form.ProductId := fProductID;
    Form.uomid:= fUOMID;
    Form.Qty := fQty;
    Form.TaxRate := fTaxRate;
    Form.MatrixRef := fMatrixRef;
    Form.Marginamount := fMarginamount;
    Form.MarginPercent := fMarginPercent;
    Form.Msg := fMsg;
    Form.BOMPrice := fBOMPrice;
    Form.Showmodal;
  finally
    Freeandnil(Form);
  end;

end;

procedure TfmproductPrices.wwDBLookupCombo1Change(Sender: TObject);
begin
  inherited;
  ProductId := cboPartsQryPartsId.asInteger;
end;
procedure TfmproductPrices.SetFontcolor(AFont: TFont;int1,int2:Integer);
begin
  if int1=int2 then AFont.color:= clred else AFont.color := clblack;
end;
procedure TfmproductPrices.grdGroupdiscountCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);
begin
  SetFontcolor(AFont, qryprodgroupdiscsGrpDiscID.asInteger ,fiGrpDiscID);
end;
procedure TfmproductPrices.grdCustomerlinesCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);
begin
  SetFontcolor(AFont,QryCustomerSpecialPriceCustomerLinesID.asInteger,fiCustomerLinesID);
end;

procedure TfmproductPrices.grdExtraSellPriceCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);
begin
  SetFontcolor(AFont,qryExtraSellPricePriceId.asInteger,fiESPID);
end;

procedure TfmproductPrices.grduomCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);
begin
  SetFontcolor(AFont,qryUnitOfMeasureUnitID.asInteger, fiunitId);
end;
procedure TfmproductPrices.grdPriceMatrixCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);
begin
  SetFontcolor(AFont,QryPriceMatrixID.asInteger, PriceMatrixID );
end;

function TfmproductPrices.MatrixItemObj: TMatrixItemObj;
begin
  if not(Assigned(fMatrixItemObj)) then begin
    fMatrixItemObj := TMatrixItemObj.create(Self);
    fMatrixItemObj.productID:=ProductID;
  end;
  result := fMatrixItemObj;
end;

initialization
  RegisterClassOnce(TfmproductPrices);

end.
