unit SchemeSaleLinePriceObj;

interface

uses
  contnrs, MemPriceSchemeObj, IntegerListObj, DataTreeObj;

type

  TSaleLinePriceRec = class(TObject)
  private
    FCalcDone: boolean;
    FSaleLineId: integer;
    FProductId: integer;
    FRefId: integer;
    FQty: double;
    FDescription: string;
    FIsComboItem: boolean;
    fSchemeProductRecList: TMemSchemeProductRecList;
    fDataTree: TDataTreeNode;
    fSchemeNode: TDataTreeNode;
    FQtyAllocated: double;
    FSchemeProductRec: TMemSchemeProductRec;
    fDirty: boolean;
    FLinePriceInc: double;
    FAmount: double;
    FLinePrice: double;
    FTaxRate: double;
    FMultiplier: double;
    procedure SetCalcDone(const Value: boolean);
    procedure SetProductID(const Value: integer);
    procedure SetRefId(const Value: integer);
    procedure SetSaleLineId(const Value: integer);
    procedure SetQty(const Value: double);
    procedure SetDescription(const Value: string);
    procedure SetIsComboItem(const Value: boolean);
    function GetCustomData: string;
    function GetDataTree: TDataTreeNode;
    procedure SetCustomData(const Value: string);
    procedure SetQtyAllocated(const Value: double);
    procedure SetSchemeProductRec(const Value: TMemSchemeProductRec);
    procedure SetAmount(const Value: double);
    procedure SetLinePrice(const Value: double);
    procedure SetLinePriceInc(const Value: double);
    procedure SetTaxRate(const Value: double);
    procedure SetMultiplier(const Value: double);
  public
    constructor Create;
    destructor Destroy; override;
    property Qty: double read FQty write SetQty;
    property QtyAllocated: double read FQtyAllocated write SetQtyAllocated;
    property LinePrice: double read FLinePrice write SetLinePrice;
    property LinePriceInc: double read FLinePriceInc write SetLinePriceInc;
    property Amount: double read FAmount write SetAmount;
    property TaxRate: double read FTaxRate write SetTaxRate;
    property Description: string read FDescription write SetDescription;
    property ProductId: integer read FProductId write SetProductID;
    property SaleLineId: integer read FSaleLineId write SetSaleLineId;
    property RefId: integer read FRefId write SetRefId;
    property Multiplier: double read FMultiplier write SetMultiplier;
    property CalcDone: boolean read FCalcDone write SetCalcDone;
    property IsComboItem: boolean read FIsComboItem write SetIsComboItem;
    property SchemeProductRecList: TMemSchemeProductRecList read fSchemeProductRecList;
    property CustomData: string read GetCustomData write SetCustomData;
    property DataTree: TDataTreeNode read GetDataTree;
    property SchemeProductRec: TMemSchemeProductRec read FSchemeProductRec write SetSchemeProductRec;
    function QtyAllocatedToComboSchemes: double;
    procedure DeleteNonComboSchemes;
    procedure DeleteSchemes;
    function IsUsingScheme(aPriceSchemeID: integer): boolean;
    property Dirty: boolean read fDirty write fDirty;
    function SchemeAssigned: boolean;
    function QtyAvailable: double; 
  end;

  TSaleSchemeList = class;
  TSaleSchemeRec = class;

  TSaleLinePriceRecList = class(TObject)
  private
    fList: TObjectList;
    FSaleDate: TDateTime;
    fLastSender: TObject;
    fLineListNeedsNeedsRedisplay: boolean;
    fSchemeIdList: TIntegerList;
    fSaleSchemeList: TSaleSchemeList;
    function GetItem(const index: integer): TSaleLinePriceRec;
    procedure SetSaleDate(const Value: TDateTime);
    function GetCount: integer;
    function CalcListPrices: boolean;
    procedure LoadSchemeProductInfo;
    function StripDescriptionSchemeInfo(const aDesc: string): string;
    function AvailItemForPriceList(const aPriceListId: integer;
                                   var LineRec: TSaleLinePriceRec;
                                   var ProdRec: TMemSchemeProductRec;
                                   const FindCheapest: boolean = false): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[const index: integer]: TSaleLinePriceRec read GetItem; default;
    procedure Clear;
    procedure Add(const aItem: TSaleLinePriceRec); overload;
    property SaleDate: TDateTime read FSaleDate write SetSaleDate;
    function ItemForPriceListAndQty(const aPriceListId: integer): TSaleLinePriceRec;
    function LineIndex(const aLine: TSaleLinePriceRec): integer;
    procedure CalcSalePrices(const Sender, LineList: TObject; const LineChanged: boolean);
    procedure CheckSalesListRefresh(const Sender: TObject);
    property SchemeIdList: TIntegerList read fSchemeIdList;
    function SchemeQtyFound(const aScheme: TMemPriceScheme; const aSaleSchemeRec: TSaleSchemeRec = nil): double;
    function QtyAvailableForPriceList(const aPriceListId: integer): double;
    function TotalListAvailableForPriceList(const aPriceListId: integer): double;
    property SaleSchemeList: TSaleSchemeList read fSaleSchemeList;
    procedure ClearAllocated;
    procedure CalcScheme(const aScheme: TMemPriceScheme; const aSaleSchemeRec: TSaleSchemeRec);
    procedure GetNonSchemePrices(const aSaleSchemeRec: TSaleSchemeRec);
    procedure UpdateListFromSaleScheme(const aSaleScheme: TSaleSchemeRec; const SchemeList: TMemPriceSchemeList);
  end;

  TLineSchemeRec = class(TObject)
  private
    fQty: double;
    fPrice: double;
    fProductId: integer;
    fPriceSchemeId: integer;
    fLineId: integer;
    fPriceListId: integer;
    fListPrice: double;
  public
    property LineId: integer read fLineId write fLineId;
    property PriceSchemeId: integer read fPriceSchemeId write fPriceSchemeId;
    property ProductId: integer read fProductId write fProductId;
    property PriceListId: integer read fPriceListId write fPriceListId;
    property Qty: double read fQty write fQty;
    property Price: double read fPrice write fPrice;
    property ListPrice: double read fListPrice write fListPrice;
  end;

  TSaleSchemeRec = class(TObject)
  private
    fList: TObjectList;
    fSaleTotal: double;
    function GetCount: integer;
    function GetItem(const index: integer): TLineSchemeRec;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    procedure Clear;
    procedure Add(const aItem: TLineSchemeRec);
    property Item[const index: integer]: TLineSchemeRec read GetItem;
    function ContainsScheme(const aPriceSchemeId: integer): boolean;
    function BestPriceItemForLine(const aLineId, aProductId: integer; var QtyAllocated: double): TLineSchemeRec;
    property SaleTotal: double read fSaleTotal;
    procedure CalcOrderTotal;
  end;

  TSaleSchemeList = class(TObject)
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItem(const index: integer): TSaleSchemeRec;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    procedure Clear;
    procedure Add(const aItem: TSaleSchemeRec);
    property Item[const index: integer]: TSaleSchemeRec read GetItem;
  end;



implementation

uses
  Classes, MyAccess,ERPdbComponents, CommonLib, CommonDBLib, 
  SysUtils, tcTypes, BusObjSaleBase, GlobalEventsObj, BusObjPriceScheme,
  FastFuncs, MySQLConst, tcConst;

const
  PriceSchemeDescriptionPrefix = '[*';
  PriceSchemeDescriptionSufex = '*]';

{ TSaleLinePriceRec }

constructor TSaleLinePriceRec.Create;
begin
  inherited;
  FCalcDone:= false;
  FDescription:= '';
  FSaleLineId:= 0;
  FProductId:= 0;
  FRefId:= 0;
  FQty:= 0;
  FQtyAllocated:= 0;
  FMultiplier:= 0;
  FIsComboItem:= false;
  fSchemeProductRecList:= TMemSchemeProductRecList.Create;
  fDataTree:= TDataTreeNode.Create;
end;

procedure TSaleLinePriceRec.DeleteNonComboSchemes;
var x: integer;
begin
  x:= 0;
  while x < DataTree['Schemes'].Count do begin
    if DataTree['Schemes'].Items[x].ItemByName['SchemeType'].AsString =
      TPriceScheme.SchemeTypeToStr(pstCombo) then
      DataTree['Schemes'].Delete(x)
    else
      Inc(x);
  end;
end;

procedure TSaleLinePriceRec.DeleteSchemes;
begin
  while DataTree['Schemes'].Count > 0 do
    DataTree['Schemes'].Delete(0);
end;

destructor TSaleLinePriceRec.Destroy;
begin
  fSchemeProductRecList.Free;
  fDataTree.Free;
  inherited;
end;

function TSaleLinePriceRec.GetCustomData: string;
begin
  result:= fDataTree.XML;
end;

function TSaleLinePriceRec.GetDataTree: TDataTreeNode;
begin
  result:= fSchemeNode;
end;

function TSaleLinePriceRec.IsUsingScheme(aPriceSchemeID: integer): boolean;
var x: integer;
begin
  result:= false;
  for x:= 0 to DataTree['Schemes'].Count -1 do begin
    if DataTree['Schemes'].Items[x].ItemByName['PriceSchemeId'].AsInteger = aPriceSchemeID then begin
      result:= true;
      break;
    end;
  end;
end;

function TSaleLinePriceRec.QtyAllocatedToComboSchemes: double;
var x: integer;
begin
  result:= 0;
  for x:= 0 to DataTree['Schemes'].Count -1 do begin
    if DataTree['Schemes'].Items[x].ItemByName['SchemeType'].AsString =
      TPriceScheme.SchemeTypeToStr(pstCombo) then begin
      result:= result + DataTree['Schemes'].Items[x].ItemByName['TotalQtyAllocated'].AsFloat;
    end;
  end;
end;

function TSaleLinePriceRec.QtyAvailable: double;
begin
  result:= Qty - QtyAllocated;
end;

function TSaleLinePriceRec.SchemeAssigned: boolean;
begin
  result:= DataTree['Schemes'].Count > 0;
end;

procedure TSaleLinePriceRec.SetAmount(const Value: double);
begin
  if FAmount <> Value then begin
    FAmount := Value;
    fDirty:= true;
  end;
end;

procedure TSaleLinePriceRec.SetCalcDone(const Value: boolean);
begin
  if FCalcDone <> Value then begin
    FCalcDone := Value;
    fDirty:= true;
  end;
end;

procedure TSaleLinePriceRec.SetCustomData(const Value: string);
begin
  fDataTree.XML:= Value;
  if fDataTree.RootNode.NodeName = '' then begin
    fDataTree.RootNode.NodeName:= 'PriceScheme';
    fSchemeNode:= TDataTreeNode(fDataTree.RootNode);
  end
  else begin
    if fDataTree.RootNode.NodeName = 'PriceScheme' then
      fSchemeNode:= TDataTreeNode(fDataTree.RootNode)
    else
      fSchemeNode:= TDataTreeNode(fDataTree.RootNode.FindItemByName('PriceScheme',true));
  end;
  fDirty:= true;
end;

procedure TSaleLinePriceRec.SetDescription(const Value: string);
begin
  if FDescription <> Value then begin
    FDescription := Value;
    fDirty:= true;
  end;
end;

procedure TSaleLinePriceRec.SetIsComboItem(const Value: boolean);
begin
  if FIsComboItem <> Value then begin
    FIsComboItem := Value;
    fDirty:= true;
  end;
end;

procedure TSaleLinePriceRec.SetLinePrice(const Value: double);
begin
  if FLinePrice <> Value then begin
    FLinePrice := Value;
    fDirty:= true;
  end;
end;

procedure TSaleLinePriceRec.SetLinePriceInc(const Value: double);
begin
  if FLinePriceInc <> Value then begin
    FLinePriceInc := Value;
    fDirty:= true;
  end;
end;

procedure TSaleLinePriceRec.SetMultiplier(const Value: double);
begin
  if FMultiplier <> Value then begin
    FMultiplier := Value;
    fDirty:= true;
  end;
end;

procedure TSaleLinePriceRec.SetProductID(const Value: integer);
begin
  if FProductId <> Value then begin
    FProductId := Value;
    fDirty:= true;
  end;
end;

procedure TSaleLinePriceRec.SetQty(const Value: double);
begin
  if FQty <> Value then begin
    FQty := Value;
    fDirty:= true;
  end;  
end;

procedure TSaleLinePriceRec.SetQtyAllocated(const Value: double);
begin
  FQtyAllocated := Value;
end;

procedure TSaleLinePriceRec.SetRefId(const Value: integer);
begin
  if FRefId <> Value then begin
    FRefId := Value;
    fDirty:= true;
  end;  
end;

procedure TSaleLinePriceRec.SetSaleLineId(const Value: integer);
begin
  if FSaleLineId <> Value then begin
    FSaleLineId := Value;
    fDirty:= true;
  end;
end;

procedure TSaleLinePriceRec.SetSchemeProductRec(
  const Value: TMemSchemeProductRec);
begin
  if FSchemeProductRec <> Value then begin
    FSchemeProductRec := Value;
    fDirty:= true;
  end;  
end;

procedure TSaleLinePriceRec.SetTaxRate(const Value: double);
begin
  if FTaxRate <> Value then begin
    FTaxRate := Value;
    fDirty:= true;
  end;  
end;

{ TSaleLinePriceRecList }

constructor TSaleLinePriceRecList.Create;
begin
  inherited;
  fList:= TObjectList.Create;
  fLastSender:= nil;
  fLineListNeedsNeedsRedisplay:= false;
  fSchemeIdList:= TIntegerList.Create;
  fSaleSchemeList:= TSaleSchemeList.Create;
end;

destructor TSaleLinePriceRecList.Destroy;
begin
  fList.Free;
  fSchemeIdList.Free;
  fSaleSchemeList.Free;
  inherited;
end;

procedure TSaleLinePriceRecList.Add(const aItem: TSaleLinePriceRec);
begin
  fList.Add(aItem);
end;

procedure TSaleLinePriceRecList.Clear;
begin
  fList.Clear;
end;

function TSaleLinePriceRecList.GetItem(const index: integer): TSaleLinePriceRec;
begin
  result:= TSaleLinePriceRec(fList[index]);
end;

procedure TSaleLinePriceRecList.SetSaleDate(const Value: TDateTime);
begin
  FSaleDate := Value;
end;

function TSaleLinePriceRecList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TSaleLinePriceRecList.CalcListPrices: boolean;
var
  x, y: integer;
  SchemeList: TMemPriceSchemeList;
  aSchemeId: integer;
  intList: TIntegerList;
  totPrice: double;

  procedure CalcCombos(depth: integer);
  var
    idx, idx2: integer;
    aScheme: TMemPriceScheme;
    aSaleSchemeRec: TSaleSchemeRec;    
  begin
    for idx:= 0 to SchemeIdList.Count -1 do begin
      if not intList.InList(SchemeIdList[idx]) then begin
        intList.Add(SchemeIdList[idx]);
        if depth < (SchemeIdList.Count -1) then begin
          { next level }
          CalcCombos(depth +1);
          while intList.Count > depth do
            intList.Delete(intList.Count-1);
        end
        else begin
          { output }
          ClearAllocated;
          aSaleSchemeRec:= TSaleSchemeRec.Create;
          for idx2:= 0 to SchemeIdList.Count -1 do begin
            aScheme:= SchemeList.SchemeById[SchemeIdList[idx2]];
            CalcScheme(aScheme,aSaleSchemeRec);
          end;
          { get non-scheme prices for sale and calc sale total }
          GetNonSchemePrices(aSaleSchemeRec);
          aSaleSchemeRec.CalcOrderTotal;

          SaleSchemeList.Add(aSaleSchemeRec);
        end;
      end;
    end;
  end;


begin
  result:= false;
  SchemeList:= TMemPriceSchemeList.Create;
  SchemeList.LoadSchemes(true, SaleDate);
  LoadSchemeProductInfo;
  SchemeIdList.Clear;
  try
    { First build a list of all price schemes that fit the list of products in the sale }
    for x:= 0 to Count -1 do begin
      for y:= 0 to Item[x].SchemeProductRecList.Count -1 do begin
        aSchemeId:= Item[x].SchemeProductRecList.Item[y].PriceSchemeId;
        if (not SchemeIdList.InList(aSchemeId)) and (SchemeQtyFound(SchemeList.SchemeById[aSchemeId]) > 0) then
          SchemeIdList.Add(aSchemeId);
      end;
    end;

    { now find the combination of schemes that gives the best total sale price }
    SaleSchemeList.Clear;
    intList:= TIntegerList.Create;
    try
      { build list of all possible scheme combinations }
      CalcCombos(0);

      if SaleSchemeList.Count > 0 then begin
        { which combination has best price }
        totPrice:= SaleSchemeList.Item[0].SaleTotal;
        y:= 0;
        for x:= 0 to SaleSchemeList.Count-1 do begin
          if SaleSchemeList.Item[x].SaleTotal < totPrice then begin
            totPrice:= SaleSchemeList.Item[x].SaleTotal;
            y:= x;
          end;
        end;
        { now update sale list with data }
        UpdateListFromSaleScheme(SaleSchemeList.Item[y], SchemeList);
        result:= true;
      end
      else begin
        if SchemeList.Count > 0 then begin
          UpdateListFromSaleScheme(nil, SchemeList);
          result:= true;
        end;
      end;

    finally
      intList.Free;
    end;
  finally
    SchemeList.Free;
  end;
end;

procedure TSaleLinePriceRecList.LoadSchemeProductInfo;
var
  qry: TERPQuery;
  IdList: TIntegerList;
  x: integer;
begin
  IdList:= TIntegerList.Create;
  qry:= CommonDbLib.TempMyQuery;
  try
    for x:= 0 to Count -1 do begin
      IdList.AddIfNotInList(Item[x].ProductId);
    end;
    qry.SQL.Add('SELECT DISTINCT s.PriceSchemeId, pl.PriceListId,');
    qry.SQL.Add('pli.ProductId, pli.ListPrice, si.QuantityThreshold');
    qry.SQL.Add('FROM tblPriceScheme s, tblSchemePriceListItem si,');
    qry.SQL.Add('tblPriceList pl, tblPriceListItem pli');
    qry.SQL.Add('WHERE s.PriceSchemeId = si.PriceSchemeId');
    qry.SQL.Add('AND si.PriceListId = pl.PriceListId');
    qry.SQL.Add('AND pl.PriceListId = pli.PriceListId');
    qry.SQL.Add('AND s.Active = "T" AND pl.Active = "T"');
    qry.SQL.Add('AND pli.ProductId IN (' + IdList.CommaText + ')');
    if SaleDate > 0 then begin
      qry.SQL.Add('AND ((s.DateFrom IS NULL) OR (s.DateFrom <= ' + QuotedStr(FormatDateTime(MysqlDateFormat,SaleDate)) + '))');
      qry.SQL.Add('AND ((s.DateTo IS NULL) OR (s.DateTo >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,SaleDate)) + '))');
    end;
    qry.Open;
    while not qry.Eof do begin
      for x:= 0 to Count -1 do begin
        if Item[x].ProductId = qry.FieldByName('ProductId').AsInteger then
          Item[x].SchemeProductRecList.Add(qry.FieldByName('ProductId').AsInteger,
              qry.FieldByName('PriceListId').AsInteger,
              qry.FieldByName('PriceSchemeId').AsInteger,
              qry.FieldByName('ListPrice').AsFloat,
              qry.FieldByName('QuantityThreshold').AsFloat);
      end;
      qry.Next;
    end;
  finally
    qry.Free;
    IdList.Free;
  end;
end;

function TSaleLinePriceRecList.ItemForPriceListAndQty(const aPriceListId: integer): TSaleLinePriceRec;
var
  ItemIdx, PriceListIdx: integer;
  availQty: double;
begin
  result:= nil;
  for ItemIdx:= 0 to self.Count -1 do begin
    for PriceListIdx:= 0 to Item[ItemIdx].SchemeProductRecList.Count -1 do begin
      if (Item[ItemIdx].SchemeProductRecList[PriceListIdx].PriceListId = aPriceListID) then begin
        availQty:= Item[ItemIdx].Qty - Item[ItemIdx].QtyAllocatedToComboSchemes;
        if (availQty >= Item[ItemIdx].SchemeProductRecList[PriceListIdx].QuantityThreshold) then begin
          result:= Item[ItemIdx];
          result.SchemeProductRec:= result.SchemeProductRecList[PriceListIdx];
          break;
        end;
      end;
    end;
    if Assigned(result) then
      break;
  end;
end;

procedure TSaleLinePriceRecList.CalcSalePrices(const Sender, LineList: TObject;
  const LineChanged: boolean);
var
  x: integer;
  PosRec: ^TLineItemRec; // used in POS Screen and POS Customer Display
  newRec: TSaleLinePriceRec;
begin
  self.Clear;
  fLastSender:= Sender;
  if (LineList is TList) then begin
    for x:= 0 to TList(LineList).Count -1 do begin
      PosRec:= TList(LineList)[x];
      newRec:= TSaleLinePriceRec.Create;
      newRec.CustomData:= PosRec^.CustomData;
      newRec.DeleteSchemes;
      newRec.Multiplier:= PosRec^.Multiplier;
      newRec.TaxRate:= PosRec^.TaxRate;
      newRec.Qty:= PosRec^.Qty * newRec.Multiplier;
      newRec.LinePrice:= PosRec^.LinePrice;
      newRec.LinePriceInc:= PosRec^.LinePriceInc;
      newRec.Amount:= PosRec^.Amount;
      newRec.Description:= PosRec^.ProductDescription;
      newRec.ProductId:= PosRec^.ProductID;
      newRec.SaleLineId:= x;
//      if LineChanged and (x = TList(LineList).Count -1) then begin
        { store the price values calculated by POS }
        newRec.DataTree['OriginalLinePrice'].AsFloat:= PosRec^.LinePrice;
        newRec.DataTree['OriginalLinePriceInc'].AsFloat:= PosRec^.LinePriceInc;
        newRec.DataTree['OriginalAmount'].AsFloat:= PosRec^.Amount;
        newRec.DataTree['OriginalDescription'].AsString:=
          StripDescriptionSchemeInfo(PosRec^.ProductDescription);
//      end;
      newRec.Dirty:= false;
      Add(newRec);
    end;
    if (Count > 0) then begin
      if CalcListPrices then begin
        {write back to pos lines}
        for x:= 0 to TList(LineList).Count -1 do begin
          PosRec:= TList(LineList)[x];
            PosRec^.LinePriceInc:= Item[x].LinePriceInc;
            PosRec^.LinePrice:= Item[x].LinePrice;
            PosRec^.Amount:= Item[x].Amount;
            PosRec^.CustomData:= Item[x].CustomData;
            PosRec^.ProductDescription:= Item[x].Description;
            fLineListNeedsNeedsRedisplay:= true;
        end;
      end;
    end;
  end
  else if (LineList is TSalesLineBase) then begin
//    SaleLine:= TSalesLineBase(LineList);
//    SaleLineId:= SaleLine.Id;
//    SaleLine.Dataset.DisableControls;
//    try
//      SaleLine.First;
//      while not SaleLine.EOF do begin
//        if not SaleLine.Deleted then begin
//          newRec:= Add(SaleLine.QtySold, SaleLine.LinePrice, SaleLine.ProductDescription, SaleLine.CustomData, SaleLine.ProductID, SaleLine.Id);
//          newRec.DeleteSchemes;
//          if LineChanged and (SaleLine.Id = SaleLineId) then begin
//            { store the prices calculated by sale logic }
//            newRec.DataTree['OriginalLinePrice'].AsFloat:= SaleLine.LinePrice;
//            newRec.DataTree['OriginalLinePriceInc'].AsFloat:= SaleLine.LinePriceInc;
//            newRec.DataTree['OriginalDescription'].AsString:= SaleLine.ProductDescription;
//          end;
//        end;
//        SaleLine.Next;
//      end;
//      if (Count > 0) then begin
//        CalcListPrices;
//        {write back to sale lines}
//        for x:= 0 to Count -1 do begin
//          if SaleLine.Dataset.Locate('SaleLineID', Item[x].SaleLineId, []) then begin
//            SaleLine.LinePriceInc:= Item[x].LinePriceInc;
//            SaleLine.LinePrice:= Item[x].LinePrice;
//            SaleLine.CustomData:= Item[x].CustomData;
//            SaleLine.ProductDescription:= Item[x].Description;
//          end;
//        end;
//      end;
//
//    finally
//      SaleLine.Dataset.EnableControls;
//      SaleLine.Dataset.Locate('SaleLineID', SaleLineId, []);
//    end;
  end;
end;

function TSaleLinePriceRecList.LineIndex(
  const aLine: TSaleLinePriceRec): integer;
begin
  result:= fList.IndexOf(aLine);
end;

procedure TSaleLinePriceRecList.CheckSalesListRefresh(const Sender: TObject);
begin
  if (Sender = fLastSender) and fLineListNeedsNeedsRedisplay then begin
    fLineListNeedsNeedsRedisplay:= false;
    GlobalEvents.Notify(self,GEVENT_POS_DoRebuildGrid);
  end;
end;

function TSaleLinePriceRecList.SchemeQtyFound(const aScheme: TMemPriceScheme; const aSaleSchemeRec: TSaleSchemeRec = nil): double;
var
  qtyAvail, qtyTemp: double;
  x: integer;
begin
  result:= 0;
  case aScheme.SchemeType of
    pstPriceList:
      begin
        result:= QtyAvailableForPriceList(aScheme.PriceLists[0].PriceListId);
      end;
    pstQtyFree,
    pstDiscount,
    pstQtyDiscount,
    pstPrice:
      begin
        qtyAvail:= QtyAvailableForPriceList(aScheme.PriceLists[0].PriceListId);
        if (qtyAvail > 0) then
            result:= Trunc(qtyAvail / aScheme.PriceLists[0].QuantityThreshold);
      end;
    pstCredit:
      begin
        if (not Assigned(aSaleSchemeRec)) or
          (aSaleSchemeRec.ContainsScheme(aScheme.RelatedSchemeId)) then begin
          qtyAvail:= QtyAvailableForPriceList(aScheme.PriceLists[0].PriceListId);
          if (qtyAvail > 0) then begin
            { this type can be based on the quantity or the total value }
            if aScheme.PriceLists[0].QuantityThreshold > 0 then
              result:= Trunc(qtyAvail / aScheme.PriceLists[0].QuantityThreshold)
            else if (aScheme.Price > 0) then begin
              if self.TotalListAvailableForPriceList(aScheme.PriceLists[0].PriceListId) > aScheme.Price then
                result:= qtyAvail;
            end;
          end;
        end;  
      end;
    pstCombo:
      begin
        for x:= 0 to aScheme.PriceLists.Count -1 do begin
          qtyAvail:= QtyAvailableForPriceList(aScheme.PriceLists[x].PriceListId);
          if qtyAvail >= aScheme.PriceLists[x].QuantityThreshold then begin
            qtyTemp:= Trunc(qtyAvail / aScheme.PriceLists[x].QuantityThreshold);
            if (result = 0) or (qtyTemp < result) then
              result:= qtyTemp;
          end
          else begin
            { not enough of required price list qty }
            result:= 0;
            break;
          end;
        end;
      end;
  end;
end;

procedure TSaleLinePriceRecList.CalcScheme(const aScheme: TMemPriceScheme;
  const aSaleSchemeRec: TSaleSchemeRec);
var
  aSchemeQty, totToAllocate: double;
  SchemeTotalListPrice, SchemeTotal, Total, SchemeTotalQty: double;
  x, y: integer;
  aLineSchemeRec: TLineSchemeRec;
  ProductRec: TMemSchemeProductRec;
  factor: double;
  IdList: TIntegerList;
  LineRec: TSaleLinePriceRec;
  qtyFree, listFree, lineQtyFree: double;
  OrderByCheapest: boolean;
  diffAmt, adjAmt: double;
begin
  aSchemeQty:= SchemeQtyFound(aScheme, aSaleSchemeRec);

  if aSchemeQty > 0 then begin
    { first allocate the quantities required by scheme .. or multiples of scheme }
    IdList:= TIntegerList.Create;
    try
      SchemeTotalListPrice:= 0;
      case aScheme.SchemeType of
        pstQtyFree,
        pstDiscount,
        pstQtyDiscount,
        pstPrice,
        pstPriceList,
        pstCredit:
          begin
            if (aScheme.SchemeType = pstPriceList) or
              ((aScheme.SchemeType = pstCredit) and (aScheme.Price > 0)) then
              totToAllocate:= aSchemeQty
            else
              totToAllocate:= aScheme.PriceLists[0].QuantityThreshold * aSchemeQty;

            OrderByCheapest:= aScheme.SchemeType in [pstQtyFree];
            while AvailItemForPriceList(aScheme.PriceLists[0].PriceListId,LineRec,ProductRec,OrderByCheapest) do begin
              aLineSchemeRec:= TLineSchemeRec.Create;
              aLineSchemeRec.LineId:= LineRec.SaleLineId;
              aLineSchemeRec.PriceSchemeId:= aScheme.PriceSchemeId;
              aLineSchemeRec.ProductId:= LineRec.ProductId;
              aLineSchemeRec.PriceListId:= aScheme.PriceLists[0].PriceListId;
              aLineSchemeRec.ListPrice:= ProductRec.ListPrice;
              if LineRec.QtyAvailable < totToAllocate then
                aLineSchemeRec.Qty:= LineRec.QtyAvailable
              else
                aLineSchemeRec.Qty:= totToAllocate;
              totToAllocate:= totToAllocate - aLineSchemeRec.Qty;
              aSaleSchemeRec.add(aLineSchemeRec);
              IdList.Add(aSaleSchemeRec.Count-1);
              LineRec.QtyAllocated:= LineRec.QtyAllocated + aLineSchemeRec.Qty;
              SchemeTotalListPrice:= SchemeTotalListPrice + (aLineSchemeRec.Qty * aLineSchemeRec.ListPrice);
              if totToAllocate = 0 then
                break;
            end;

          end;
        pstCombo:
          begin
            for y:= 0 to aScheme.PriceLists.Count -1 do begin
              totToAllocate:= aScheme.PriceLists[y].QuantityThreshold * aSchemeQty;

              while AvailItemForPriceList(aScheme.PriceLists[y].PriceListId,LineRec,ProductRec,true) do begin
                aLineSchemeRec:= TLineSchemeRec.Create;
                aLineSchemeRec.LineId:= LineRec.SaleLineId;
                aLineSchemeRec.PriceSchemeId:= aScheme.PriceSchemeId;
                aLineSchemeRec.ProductId:= LineRec.ProductId;
                aLineSchemeRec.PriceListId:= aScheme.PriceLists[0].PriceListId;
                aLineSchemeRec.ListPrice:= ProductRec.ListPrice;
                if LineRec.QtyAvailable < totToAllocate then
                  aLineSchemeRec.Qty:= LineRec.QtyAvailable
                else
                  aLineSchemeRec.Qty:= totToAllocate;
                totToAllocate:= totToAllocate - aLineSchemeRec.Qty;
                aSaleSchemeRec.add(aLineSchemeRec);
                IdList.Add(aSaleSchemeRec.Count-1);
                LineRec.QtyAllocated:= LineRec.QtyAllocated + aLineSchemeRec.Qty;
                SchemeTotalListPrice:= SchemeTotalListPrice + (aLineSchemeRec.Qty * aLineSchemeRec.ListPrice);
                if totToAllocate = 0 then
                  break;
              end;
            end;
          end;
      end;

      {now work out the actual prices}
      if SchemeTotalListPrice > 0 then begin
        factor:= 1;
        SchemeTotal:= 0;
        case aScheme.SchemeType of
          pstQtyFree:
            begin
              { work out discount using cheapest items first }
              qtyFree:= aScheme.DiscountOrQtyFree * aSchemeQty;
              SchemeTotalQty:= aScheme.PriceLists.Item[0].QuantityThreshold * aSchemeQty;
              listFree:= 0;
              for x:= 0 to IdList.Count -1 do begin
                aLineSchemeRec:= aSaleSchemeRec.Item[IdList[x]];

                if SchemeTotalQty > 0 then begin
                  { have not accounted for full scheme qty }

                  lineQtyFree:= 0;
                  if qtyFree > 0 then begin
                    { how many items will be free on this line }
                    if aLineSchemeRec.Qty >= qtyFree then
                      lineQtyFree:= qtyFree
                    else
                      lineQtyFree:= aLineSchemeRec.Qty;
                    qtyFree:= qtyFree - lineQtyFree;
                    { total up discount amount }
                    listFree:= ListFree + (lineQtyFree * aLineSchemeRec.ListPrice);
                  end;

                  { scheme total }
                  if (aLineSchemeRec.Qty - lineQtyFree) >= SchemeTotalQty then begin
                    SchemeTotal:= SchemeTotal + (SchemeTotalQty * aLineSchemeRec.ListPrice);
                    SchemeTotalQty:= 0;
                  end
                  else begin
                    SchemeTotalQty:= SchemeTotalQty - (aLineSchemeRec.Qty - lineQtyFree);
                    SchemeTotal:= SchemeTotal + ((aLineSchemeRec.Qty - lineQtyFree) * aLineSchemeRec.ListPrice);
                  end;
                end;


//                if aLineSchemeRec.Qty > qtyFree then begin
//                  listFree:= ListFree + (qtyFree * aLineSchemeRec.ListPrice);
//                  qtyFree:= 0;
//                end
//                else begin
//                  listFree:= ListFree + (aLineSchemeRec.Qty * aLineSchemeRec.ListPrice);
//                  qtyFree:= qtyFree - aLineSchemeRec.Qty;
//                end;
//                if qtyFree = 0 then
//                  break;
              end;

              factor:= (SchemeTotalListPrice - listFree) / SchemeTotalListPrice;
            end;
          pstQtyDiscount:
            begin
              { work out discount using cheapest items first }
              if IdList.Count > 0 then begin
                aLineSchemeRec:= aSaleSchemeRec.Item[IdList[0]];

                factor:=
                  (SchemeTotalListPrice -
                   ((1.0 - aScheme.DiscountOrQtyFree) * aLineSchemeRec.ListPrice))
                   / SchemeTotalListPrice;
              end;

            end;
          pstDiscount:
              factor:= (1 - aScheme.DiscountOrQtyFree);
          pstPrice:
            begin
              factor:= aScheme.Price / (SchemeTotalListPrice / aSchemeQty);
              SchemeTotal:= aScheme.Price * aSchemeQty;
            end;
          pstPriceList:
              factor:= 1;
          pstCredit:
              factor:= ((SchemeTotalListPrice / aSchemeQty) - aScheme.Credit) / (SchemeTotalListPrice / aSchemeQty);
          pstCombo:
            begin
              factor:= aScheme.Price / (SchemeTotalListPrice / aSchemeQty);
              SchemeTotal:= aScheme.Price * aSchemeQty;
            end;
        end;
        Total:= 0;
        aLineSchemeRec:= nil;
        for x:= 0 to IdList.Count-1 do begin
          aLineSchemeRec:= aSaleSchemeRec.Item[IdList[x]];
          aLineSchemeRec.Price:=
            CommonLib.Round(aLineSchemeRec.ListPrice * factor,CurrencyRoundPlaces);
          Total:= Total + (aLineSchemeRec.Price * aLineSchemeRec.Qty);
        end;
        if Assigned(aLineSchemeRec) and (SchemeTotal > 0) and (SchemeTotal <> Total) then begin
          { adjust price of last item to fix rounding }
          diffAmt:= SchemeTotal - Total;
          adjAmt:= CommonLib.Round((diffAmt) / aLineSchemeRec.Qty,CurrencyRoundPlaces);

          { NOTE: Because some combinations of qty and price will never round
                  exactly to Scheme Total here we make sure that total is not
                  greater than Scheme total ... if it is a cent or two less
                  pos will round the sale up }
          while (Total + (adjAmt * aLineSchemeRec.Qty)) > SchemeTotal do
            adjAmt:= adjAmt - 0.01;
          aLineSchemeRec.Price := aLineSchemeRec.Price + adjAmt;
        end;

      end;
    finally
      IdList.Free;
    end;
  end;
end;

function TSaleLinePriceRecList.QtyAvailableForPriceList(const aPriceListId: integer): double;
var
  x: integer;
begin
  result:= 0;
  for x:= 0 to Count -1 do begin
    if Item[x].SchemeProductRecList.ContainsPriceListId(aPriceListId) then
      result:= result + Item[x].QtyAvailable;
  end;
end;

function TSaleLinePriceRecList.TotalListAvailableForPriceList(const aPriceListId: integer): double;
var
  x: integer;
  ProductRec: TMemSchemeProductRec;
begin
  result:= 0;
  for x:= 0 to Count -1 do begin
    if Item[x].QtyAvailable > 0 then begin
      ProductRec:= Item[x].SchemeProductRecList.ItemForPriceList(aPriceListId);
      if Assigned(ProductRec) then
        result:= result + Item[x].QtyAvailable * ProductRec.ListPrice;
    end;
  end;
end;

procedure TSaleLinePriceRecList.ClearAllocated;
var
  x: integer;
begin
  for x:= 0 to Count-1 do
    Item[x].QtyAllocated:= 0;
end;

procedure TSaleLinePriceRecList.GetNonSchemePrices(const aSaleSchemeRec: TSaleSchemeRec);
var
  x: integer;
  qtyAlloc: double;
  newLineSchemeRec, bestLineSchemeRec: TLineSchemeRec;
begin
  { add price records for remainder of qty that does not match scheme }
  for x:= 0 to Count -1 do begin
    qtyAlloc:= 0;
    bestLineSchemeRec:=
      aSaleSchemeRec.BestPriceItemForLine(Item[x].SaleLineId,Item[x].ProductId, QtyAlloc);
    if Item[x].Qty > qtyAlloc then begin
      { not all of this lines quantity has been allocated to schemes ..
        so make a dummy entry to hold the balance }
      newLineSchemeRec:= TLineSchemeRec.Create;
      newLineSchemeRec.LineId:= Item[x].SaleLineId;
      newLineSchemeRec.PriceSchemeId:= 0;
      newLineSchemeRec.ProductId:= 0;
      newLineSchemeRec.PriceListId:= 0;
      newLineSchemeRec.Qty:= Item[x].Qty - qtyAlloc;
      newLineSchemeRec.ListPrice:= 0;
      if Assigned(bestLineSchemeRec) then begin
        newLineSchemeRec.ListPrice:= bestLineSchemeRec.ListPrice;
        newLineSchemeRec.Price:= bestLineSchemeRec.ListPrice;
      end
      else begin
        newLineSchemeRec.Price:= Item[x].DataTree['OriginalLinePriceInc'].AsFloat;
      end;
      aSaleSchemeRec.Add(newLineSchemeRec);
    end;
  end;
end;

procedure TSaleLinePriceRecList.UpdateListFromSaleScheme(const aSaleScheme: TSaleSchemeRec; const SchemeList: TMemPriceSchemeList);
var
  x, y: integer;
  s: string;
  totLine, totLineQty, NStotLine, NStotLineQty: double;
  node: TDataTreeNode;
begin
  for x:= 0 to count -1 do begin
    s:= '';
    totLine:= 0;
    totLineQty:= 0;
    NStotLine:= 0;
    NStotLineQty:= 0;
    if Assigned(aSaleScheme) then begin
      for y:= 0 to aSaleScheme.Count -1 do begin
        if aSaleScheme.Item[y].LineId = Item[x].SaleLineId then begin
          totLine:= totLine + aSaleScheme.Item[y].Price * aSaleScheme.Item[y].Qty;
          totLineQty:= totLineQty + aSaleScheme.Item[y].Qty;
          if aSaleScheme.Item[y].PriceSchemeId > 0 then begin
            if s <> '' then s:= s + ', ';
            s:= s +
              SchemeList.SchemeById[aSaleScheme.Item[y].PriceSchemeId].SchemeName + ' ' +
              FloatToStr(aSaleScheme.Item[y].Qty) + '@' +
              FormatFloat('#,##0.00;(#,##0.00)',aSaleScheme.Item[y].Price);

            node:= TDataTreeNode(Item[x].DataTree['Schemes'].AddNode('Scheme'));
            node['PriceSchemeId'].AsInteger:= aSaleScheme.Item[y].PriceSchemeId;
            node['ListPrice'].AsFloat:= aSaleScheme.Item[y].ListPrice;
            node['Price'].AsFloat:= aSaleScheme.Item[y].Price;
            node['Qty'].AsFloat:= aSaleScheme.Item[y].Qty;
          end
          else begin
            NStotLine:= NStotLine + aSaleScheme.Item[y].Price * aSaleScheme.Item[y].Qty;
            NStotLineQty:= NStotLineQty + aSaleScheme.Item[y].Qty;
          end;
        end;
      end;
    end;  
    if s <> '' then begin
      if NStotLineQty > 0 then
        s:= s + ' & ' +
          FloatToStr(NStotLineQty) + '@' +
          FormatFloat('#,##0.00;(#,##0.00)',NStotLine);

      Item[x].Description:=
        Item[x].DataTree['OriginalDescription'].AsString + ' ' +
        PriceSchemeDescriptionPrefix + ' ' + s + ' ' +
        PriceSchemeDescriptionSufex;
      Item[x].LinePriceInc:= CommonLib.Round(totLine / Item[x].Qty / Item[x].Multiplier,CurrencyRoundPlaces);
      Item[x].LinePrice:= CommonLib.Round(Item[x].LinePriceInc / (1.0 + Item[x].TaxRate),GeneralRoundPlaces);;
      Item[x].Amount:= Item[x].LinePriceInc * Item[x].Qty;
    end
    else begin
      { no schemes for this line, use original values from sale }
      Item[x].Description:= Item[x].DataTree['OriginalDescription'].AsString;
      Item[x].Amount:= Item[x].DataTree['OriginalAmount'].AsFloat;
      Item[x].LinePrice:= Item[x].DataTree['OriginalLinePrice'].AsFloat;
      Item[x].LinePriceInc:= Item[x].DataTree['OriginalLinePriceInc'].AsFloat;
    end;
  end;
end;

function TSaleLinePriceRecList.StripDescriptionSchemeInfo(const aDesc: string): string;
var
  posn1, posn2: integer;
begin
  result:= aDesc;
  posn1:= FastFuncs.PosEx(PriceSchemeDescriptionPrefix, result);
  posn2:= FastFuncs.PosEx(PriceSchemeDescriptionSufex, result);
  if (posn1 > 0) and (posn2 > 0) and (posn2 > posn1) then begin
    result:= TrimRight(Copy(result,1,posn1-1));
  end;
end;

function TSaleLinePriceRecList.AvailItemForPriceList(
  const aPriceListId: integer;
  var LineRec: TSaleLinePriceRec;
  var ProdRec: TMemSchemeProductRec;
  const FindCheapest: boolean): boolean;
var
  x: integer;
  tmpProdRec: TMemSchemeProductRec;
begin
  result:= false;
  LineRec:= nil;
  ProdRec:= nil;
  for x:= 0 to count -1 do begin
    if (Item[x].QtyAvailable > 0) then begin
      tmpProdRec:= Item[x].SchemeProductRecList.ItemForPriceList(aPriceListId, FindCheapest);
      if Assigned(tmpProdRec) then begin
        if not Assigned(LineRec) then
          LineRec:= Item[x];
        if not Assigned(ProdRec) then begin
          ProdRec:= tmpProdRec;
          result:= true;
          if (not FindCheapest) then
            Break;
        end
        else begin
          if tmpProdRec.ListPrice < ProdRec.ListPrice then begin
            ProdRec:= tmpProdRec;
            LineRec:= Item[x];
          end;
        end;
      end;
    end;
  end;
end;

{ TSaleSchemeRec }

constructor TSaleSchemeRec.Create;
begin
  inherited;
  fList:= TObjectList.Create(true);
end;

destructor TSaleSchemeRec.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TSaleSchemeRec.Add(const aItem: TLineSchemeRec);
begin
  fList.Add(aItem);
end;

procedure TSaleSchemeRec.Clear;
begin
  fList.Clear;
end;

function TSaleSchemeRec.GetCount: integer;
begin
  result:= fList.Count;
end;

function TSaleSchemeRec.GetItem(const index: integer): TLineSchemeRec;
begin
  result:= TLineSchemeRec(fList[index]);
end;

function TSaleSchemeRec.ContainsScheme(const aPriceSchemeId: integer): boolean;
var x: integer;
begin
  result:= false;
  for x:= 0 to Count -1 do begin
    if Item[x].PriceSchemeId = aPriceSchemeId then begin
      result:= true;
      break;
    end;
  end;
end;

function TSaleSchemeRec.BestPriceItemForLine(const aLineId, aProductId: integer;
  var QtyAllocated: double): TLineSchemeRec;
var x: integer;  
begin
  result:= nil;
  QtyAllocated:= 0;
  for x:= 0 to Count -1 do begin
    if Item[x].LineId = aLineId then
      QtyAllocated:= QtyAllocated + Item[x].Qty;
    if Item[x].ProductId = aProductId then begin
      if (not Assigned(result)) or (Item[x].ListPrice < result.ListPrice) then
        result:= Item[x];
    end;
  end;
end;

procedure TSaleSchemeRec.CalcOrderTotal;
var x: integer;
begin
  fSaleTotal:= 0;
  for x:= 0 to Count -1 do begin
    fSaleTotal:= fSaleTotal + (Item[x].Price * Item[x].Qty);
  end;
end;

{ TSaleSchemeList }

constructor TSaleSchemeList.Create;
begin
  inherited;
  fList:= TObjectList.Create(true);
end;

destructor TSaleSchemeList.Destroy;
begin

  inherited;
end;

procedure TSaleSchemeList.Add(const aItem: TSaleSchemeRec);
begin
  fList.Add(aItem);
end;

procedure TSaleSchemeList.Clear;
begin
  fList.Clear;
end;

function TSaleSchemeList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TSaleSchemeList.GetItem(const index: integer): TSaleSchemeRec;
begin
  result:= TSaleSchemeRec(fList[index]);
end;

end.
