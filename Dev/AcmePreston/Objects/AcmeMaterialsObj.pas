unit AcmeMaterialsObj;

interface

uses
  Classes, Contnrs, MyAccess, SysUtils, daBase, DB, Variants, XMLIntf;

type
  tdaCustomPrintItem = class(TdaBase)
  private

    FKey: integer;
    FOvers: integer;
    FQty_Qt: integer;
    FQty: integer;
    FBrd_Size_L1: integer;
    FSize3_LC: integer;
    FSize2_LC: integer;
    FBrd_Size_W3: integer;
    FBrd_Size_W2: integer;
    FBrd_Size_W1: integer;
    FSize3_WC: integer;
    FSize2_WC: integer;
    FSize1_LC: integer;
    FLay: integer;
    FSize1_LF: integer;
    FBrd_Tot_Cost3: currency;
    FBrd_Tot_Cost2: currency;
    FBrd_Tot_Cost1: currency;
    FTot_Cost3: currency;
    FTot_Cost2: currency;
    FTot_Cost1: currency;
    FBrd_Stk2: real;
    FBrd_Stk1: real;
    FStk_Qty3: real;
    FStk_Qty2: real;
    FStk_Qty1: real;
    FBrd_Unit3: integer;
    FBrd_Stk3: real;
    FBrd_Unit2: integer;
    FSize1_WC: integer;
    FGrip: integer;
    FSize1_WF: integer;
    FBrd_Unit1: integer;
    FQty_Unit3: integer;
    FQty_Unit1: integer;
    FQty_Unit2: integer;
    FWork_Tot_Cost: currency;
    FMetal_Code2: integer;
    FMetal_Code1: integer;
    FInk_Code: integer;
    FBrd_Code3: integer;
    FBrd_Code3width: integer;
    FBrd_Code3length: integer;
    FBrd_Code2: integer;
    FBrd_Code2width: integer;
    FBrd_Code2length: integer;
    FBrd_Code1: integer;
    FBrd_Code1width: integer;
    FBrd_Code1length: integer;
    FMT_Key3: integer;
    FMT_Key2: integer;
    FMT_Key1: integer;
    FMT_Key3width: integer;
    FMT_Key2width: integer;
    FMT_Key1width: integer;
    FMT_Key3length: integer;
    FMT_Key2length: integer;
    FMT_Key1length: integer;
    FOther_Material: integer;
    FMetalTotalCost1: currency;
    FUnit_Cost_Inc: currency;
    FMetalTotalCost2: currency;
    FInk_Tot_Cost: currency;
    FBrd_Qty3: integer;
    FBrd_Qty2: integer;
    FBrd_Qty1: integer;
    FInked_PC: real;
    FNUM_UPL: integer;
    FQty2: integer;
    FQty1: integer;
    FGap: integer;
    FNUM_UPW: integer;
    FQty3: integer;
    FArea: double;
    FBrd_Size_L3: integer;
    FBrd_Size_L2: integer;
    FCost_Art: currency;
    FCost_Tooling: currency;
    FCost_Film: currency;
    FUnit_Cost_Ex: currency;
    FUnit_Cost_Ex_S: currency;
    FTotal_Inc_S: currency;
    FMetal_Price2: currency;
    FPrice3: currency;
    FOther_Mat_Cost: currency;
    FUnit_Cost_Inc_S: currency;
    FTotal_ExTax_S: currency;
    FMat_Tot_Cost: currency;
    FTotal_ExTax: currency;
    FInk_Price: currency;
    FBrd_Price3: currency;
    FBrd_Price2: currency;
    FBrd_Price1: currency;
    FMetal_Price1: currency;
    FPrice2: currency;
    FPrice1: currency;
    FTax_Amount_S: currency;
    FMarkup_PC: real;
    FMat_Markup_PC: real;
    FMarkup_Tax: real;

    FMach_Cost_Hr: currency;
    FPrints_Hr: integer;
    FNum_Up: integer;
    FColour_lbl: integer;
    FColours_pass: integer;
    FScreen_Cost: currency;
    FSetup_Cost: currency;
    FTot_Prn_Cost: currency;
    FD_Setup_Cost: currency;
    FD_Num_Up: integer;
    FCost_Hr: currency;
    FImps_Hr: integer;
    FTot_Die_Cast: currency;
    FBackSlit_Cost: currency;
    FHandWork_Cost: currency;
    FGuillotine_Cost: currency;
    FPack_Cost: currency;
    FDel_Cost: currency;
    FSubCon_Cost: currency;
    FE_Setup_Cost: currency;
    FCutPVC_Cost: currency;
    FCutBrd_Cost: currency;
    FPreWeld_Cost: currency;
    FMain_Weld_Up: integer;
    FMain_Welds_Day: integer;
    FMach_Cost_Day: currency;
    FWeld_Cost: currency;
    FPost_Weld_Cost: currency;
    FTot_Weld_Cost: currency;
    FRivet_Cost: currency;
    FWorkTot_Cost: currency;
    FNotes: string;
    FProd_Qty: integer;
    FProd_Qty_Qt: integer;
    FProd_Overs: integer;
    FNum_UPT: integer;
    FLays_Brd: integer;
    FRivets: integer;
    FSlit_YN: boolean;

    //calculation variables for main calc
    Nps: real;
    Psl: integer;
    Psw: integer;
    psoms: real;
    qms: real;
    comat: currency;
    mprice: real;
    item: integer;
    mwidth: integer;
    mlength: integer;
    //
    procedure MainCalc;
    function NilZero(const V,defaultvalue: integer): integer;

  protected

    procedure SaveToXMLNode(const node: IXMLNode); override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
  public
    procedure MaterialCalc;
    procedure TotalCalc;
    procedure ProductionCalc;
    procedure LoadDescPrice(const MTDesc: TStringList; const MT_KeyID: TStringList; const MT_Price: TStringList);
    function LoadSizesLength(const PartsID: integer): integer;
    function LoadSizesWidth(const PartsID: integer): integer;
    //    procedure SaveCustomData(da: TdaBase);
    //    procedure LoadCustomData(da: TdaBase);

    {field specific methods}

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Key: integer read FKey write Fkey;

    property Overs: integer read FOvers write FOvers;
    property Qty_Qt: integer read FQty_Qt write FQty_Qt;
    property Qty: integer read FQty write FQty;
    property Brd_Size_L1: integer read FBrd_Size_L1 write FBrd_Size_L1;
    property Size2_LC: integer read FSize2_LC write FSize2_LC;
    property Size3_LC: integer read FSize3_LC write FSize3_LC;
    property Brd_Size_W3: integer read FBrd_Size_W3 write FBrd_Size_W3;
    property Brd_Size_W2: integer read FBrd_Size_W2 write FBrd_Size_W2;
    property Brd_Size_W1: integer read FBrd_Size_W1 write FBrd_Size_W1;
    property Size3_WC: integer read FSize3_WC write FSize3_WC;
    property Size2_WC: integer read FSize2_WC write FSize2_WC;
    property Size1_LC: integer read FSize1_LC write FSize1_LC;
    property Lay: integer read FLay write FLay;
    property Size1_LF: integer read FSize1_LF write FSize1_LF;
    property Brd_Tot_Cost3: currency read FBrd_Tot_Cost3 write FBrd_Tot_Cost3;
    property Brd_Tot_Cost2: currency read FBrd_Tot_Cost2 write FBrd_Tot_Cost2;
    property Brd_Tot_Cost1: currency read FBrd_Tot_Cost1 write FBrd_Tot_Cost1;
    property Tot_Cost3: currency read FTot_Cost3 write FTot_Cost3;
    property Tot_Cost2: currency read FTot_Cost2 write FTot_Cost2;
    property Tot_Cost1: currency read FTot_Cost1 write FTot_Cost1;
    property Brd_Stk2: real read FBrd_Stk2 write FBrd_Stk2;
    property Brd_Stk1: real read FBrd_Stk1 write FBrd_Stk1;
    property Stk_Qty3: real read FStk_Qty3 write FStk_Qty3;
    property Stk_Qty2: real read FStk_Qty2 write FStk_Qty2;
    property Stk_Qty1: real read FStk_Qty1 write FStk_Qty1;
    property Brd_Unit3: integer read FBrd_Unit3 write FBrd_Unit3;
    property Brd_Stk3: real read FBrd_Stk3 write FBrd_Stk3;
    property Brd_Unit2: integer read FBrd_Unit2 write FBrd_Unit2;
    property Size1_WC: integer read FSize1_WC write FSize1_WC;
    property Grip: integer read FGrip write FGrip;
    property Size1_WF: integer read FSize1_WF write FSize1_WF;
    property Brd_Unit1: integer read FBrd_Unit1 write FBrd_Unit1;
    property Qty_Unit3: integer read FQty_Unit3 write FQty_Unit3;
    property Qty_Unit1: integer read FQty_Unit1 write FQty_Unit1;
    property Qty_Unit2: integer read FQty_Unit2 write FQty_Unit2;
    property Work_Tot_Cost: currency read FWork_Tot_Cost write FWork_Tot_Cost;

    property Metal_Code2: integer read FMetal_Code2 write FMetal_Code2;
    property Metal_Code1: integer read FMetal_Code1 write FMetal_Code1;
    property Ink_Code: integer read FInk_Code write FInk_Code;
    property Brd_Code3: integer read FBrd_Code3 write FBrd_Code3;
    property Brd_Code3width: integer read FBrd_Code3width write FBrd_Code3width;
    property Brd_Code3length: integer read FBrd_Code3length write FBrd_Code3length;
    property Brd_Code2: integer read FBrd_Code2 write FBrd_Code2;
    property Brd_Code2width: integer read FBrd_Code2width write FBrd_Code2width;
    property Brd_Code2length: integer read FBrd_Code2length write FBrd_Code2length;
    property Brd_Code1: integer read FBrd_Code1 write FBrd_Code1;
    property Brd_Code1width: integer read FBrd_Code1width write FBrd_Code1width;
    property Brd_Code1length: integer read FBrd_Code1length write FBrd_Code1length;
    property MT_Key3: integer read FMT_Key3 write FMT_Key3;
    property MT_Key3width: integer read FMT_Key3width write FMT_Key3width;
    property MT_Key3length: integer read FMT_Key3length write FMT_Key3length;
    property MT_Key2: integer read FMT_Key2 write FMT_Key2;
    property MT_Key2width: integer read FMT_Key2width write FMT_Key2width;
    property MT_Key2length: integer read FMT_Key2length write FMT_Key2length;
    property MT_Key1: integer read FMT_Key1 write FMT_Key1;
    property MT_Key1width: integer read FMT_Key1width write FMT_Key1width;
    property MT_Key1length: integer read FMT_Key1length write FMT_Key1length;

    property Other_Material: integer read FOther_Material write FOther_Material;
    property MetalTotalCost1: currency read FMetalTotalCost1 write FMetalTotalCost1;
    property Unit_Cost_Inc: currency read FUnit_Cost_Inc write FUnit_Cost_Inc;
    property MetalTotalCost2: currency read FMetalTotalCost2 write FMetalTotalCost2;
    property Ink_Tot_Cost: currency read FInk_Tot_Cost write FInk_Tot_Cost;
    property Brd_Qty3: integer read FBrd_Qty3 write FBrd_Qty3;
    property Brd_Qty2: integer read FBrd_Qty2 write FBrd_Qty2;
    property Brd_Qty1: integer read FBrd_Qty1 write FBrd_Qty1;
    property Inked_PC: real read FInked_PC write FInked_PC;
    property NUM_UPL: integer read FNUM_UPL write FNUM_UPL;
    property Qty2: integer read FQty2 write FQty2;
    property Qty1: integer read FQty1 write FQty1;
    property Gap: integer read FGap write FGap;
    property NUM_UPW: integer read FNUM_UPW write FNUM_UPW;
    property Qty3: integer read FQty3 write FQty3;
    property Area: double read FArea write FArea;
    property Brd_Size_L3: integer read FBrd_Size_L3 write FBrd_Size_L3;
    property Brd_Size_L2: integer read FBrd_Size_L2 write FBrd_Size_L2;
    property Cost_Art: currency read FCost_Art write FCost_Art;
    property Cost_Tooling: currency read FCost_Tooling write FCost_Tooling;
    property Cost_Film: currency read FCost_Film write FCost_Film;
    property Unit_Cost_Ex: currency read FUnit_Cost_Ex write FUnit_Cost_Ex;
    property Unit_Cost_Ex_S: currency read FUnit_Cost_Ex_S write FUnit_Cost_Ex_S;
    property Total_Inc_S: currency read FTotal_Inc_S write FTotal_Inc_S;
    property Metal_Price2: currency read FMetal_Price2 write FMetal_Price2;
    property Price3: currency read FPrice3 write FPrice3;
    property Other_Mat_Cost: currency read FOther_Mat_Cost write FOther_Mat_Cost;
    property Unit_Cost_Inc_S: currency read FUnit_Cost_Inc_S write FUnit_Cost_Inc_S;
    property Total_ExTax_S: currency read FTotal_ExTax_S write FTotal_ExTax_S;
    property Mat_Tot_Cost: currency read FMat_Tot_Cost write FMat_Tot_Cost;
    property Total_ExTax: currency read FTotal_ExTax write FTotal_ExTax;
    property Ink_Price: currency read FInk_Price write FInk_Price;
    property Brd_Price3: currency read FBrd_Price3 write FBrd_Price3;
    property Brd_Price2: currency read FBrd_Price2 write FBrd_Price2;
    property Brd_Price1: currency read FBrd_Price1 write FBrd_Price1;
    property Metal_Price1: currency read FMetal_Price1 write FMetal_Price1;
    property Price2: currency read FPrice2 write FPrice2;
    property Price1: currency read FPrice1 write FPrice1;
    property Tax_Amount_S: currency read FTax_Amount_S write FTax_Amount_S;
    property Markup_PC: real read FMarkup_PC write FMarkup_PC;
    property Mat_Markup_PC: real read FMat_Markup_PC write FMat_Markup_PC;
    property Markup_Tax: real read FMarkup_Tax write FMarkup_Tax;

    property Mach_Cost_Hr: currency read FMach_Cost_Hr write FMach_Cost_Hr;
    property Prints_Hr: integer read FPrints_Hr write FPrints_Hr;
    property Num_Up: integer read FNum_Up write FNum_Up;
    property Colour_lbl: integer read FColour_lbl write FColour_lbl;
    property Colours_pass: integer read FColours_pass write FColours_pass;
    property Screen_Cost: currency read FScreen_Cost write FScreen_Cost;
    property Setup_Cost: currency read FSetup_Cost write FSetup_Cost;
    property Tot_Prn_Cost: currency read FTot_Prn_Cost write FTot_Prn_Cost;
    property D_Setup_Cost: currency read FD_Setup_Cost write FD_Setup_Cost;
    property D_Num_Up: integer read FD_Num_Up write FD_Num_Up;
    property Cost_Hr: currency read FCost_Hr write FCost_Hr;
    property Imps_Hr: integer read FImps_Hr write FImps_Hr;
    property Tot_Die_Cost: currency read FTot_Die_Cast write FTot_Die_Cast;
    property BackSlit_Cost: currency read FBackSlit_Cost write FBackSlit_Cost;
    property HandWork_Cost: currency read FHandWork_Cost write FHandWork_Cost;
    property Guillotine_Cost: currency read FGuillotine_Cost write FGuillotine_Cost;
    property Pack_Cost: currency read FPack_Cost write FPack_Cost;
    property Del_Cost: currency read FDel_Cost write FDel_Cost;
    property SubCon_Cost: currency read FSubCon_Cost write FSubCon_Cost;
    property E_Setup_Cost: currency read FE_Setup_Cost write FE_Setup_Cost;
    property CutPVC_Cost: currency read FCutPVC_Cost write FCutPVC_Cost;
    property CutBrd_Cost: currency read FCutBrd_Cost write FCutBrd_Cost;
    property PreWeld_Cost: currency read FPreWeld_Cost write FPreWeld_Cost;
    property Main_Weld_Up: integer read FMain_Weld_Up write FMain_Weld_Up;
    property Main_Welds_Day: integer read FMain_Welds_Day write FMain_Welds_Day;
    property Mach_Cost_Day: currency read FMach_Cost_Day write FMach_Cost_Day;
    property Weld_Cost: currency read FWeld_Cost write FWeld_Cost;
    property Post_Weld_Cost: currency read FPost_Weld_Cost write FPost_Weld_Cost;
    property Tot_Weld_Cost: currency read FTot_Weld_Cost write FTot_Weld_Cost;
    property Rivet_Cost: currency read FRivet_Cost write FRivet_Cost;
    property WorkTot_Cost: currency read FWorkTot_Cost write FWorkTot_Cost;
    property Notes: string read FNotes write FNotes;
    property Prod_Qty: integer read FProd_Qty write FProd_Qty;
    property Prod_Qty_Qt: integer read FProd_Qty_Qt write FProd_Qty_Qt;
    property Prod_Overs: integer read FProd_Overs write FProd_Overs;
    property Num_UPT: integer read FNum_UPT write FNum_UPT;
    property Lays_Brd: integer read FLays_Brd write FLays_Brd;
    property Rivets: integer read FRivets write FRivets;
    property Slit_YN: boolean read FSlit_YN write FSlit_YN;
  end;

var  
  daStorer: tdaStorer;
  CustomItem: tdaCustomPrintItem;


implementation

uses FastFuncs,CommonLib, CommonDBLib, DNMLib;

function tdaCustomPrintItem.NilZero(const V, defaultvalue: integer): integer;
  {Set null string to default value}
begin
  Result := V;
  if (V = 0) then Result := defaultvalue;
end;

procedure tdaCustomPrintItem.LoadDescPrice(const MTDesc: TStringList; const MT_KeyID: TStringList; const MT_Price: TStringList);
var
  stSQL: string;
  //load specvalue 'partsdescription, partsid and "price1". No other quantity prices.
begin
  stSQL :=
    'select s.partsid,specvalue,price1,partsdescription from tblparts p, tblpartsspecifications s WHERE s.partsid=p.partsid and specvalue="CustomPrint"';
  with TMyQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.Add(stSQL);
      Open;
      First;
      while not Eof do begin
        MTDesc.add(FieldByName('partsdescription').AsString);
        MT_KeyID.add(FieldByName('partsid').AsString);
        MT_Price.add(FloatToStr(FieldByName('Price1').AsFloat + FieldByName('Price1').AsFloat * GetTaxRate('GST')));
        Next;
      end;
    finally
      Close;
      Free;
    end;
end;

function tdaCustomPrintItem.LoadSizesLength(const PartsID: integer): integer;
var
  SQLLength: string;
  qry:TMyQuery;
begin
  SQLlength := 'select specvalue from tblpartsspecifications where partsid= :PartsID AND specdescription="Length"';
  Result:=0;
  qry:= TMyQuery.Create(nil);
  with qry do try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.Add(SQLLength);
      ParamBYName('PartsID').AsString := FastFuncs.IntToStr(PartsID);
      Open;
      First;
      if not Eof then Result := FastFuncs.StrToInt(qry.FieldByName('specvalue').Asstring);
    finally
      Close;
      Free;
    end;
end;

function tdaCustomPrintItem.LoadSizesWidth(const PartsID: integer): integer;
var
  SQLwidth: string;
  qry:TMyQuery;
begin
  SQLwidth := 'select specvalue from tblpartsspecifications  where partsid= :PartsID AND specdescription="Width"';
  Result:=0;
  qry:= TMyQuery.Create(nil);
  with qry do try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.Add(SQLWidth);
      ParamBYName('PartsID').AsString := FastFuncs.IntToStr(PartsID);
      Open;
      First;
      if not Eof then Result := FastFuncs.StrToInt(qry.FieldByName('specvalue').Asstring);
    finally
      Close;
      Free;
    end;
end;

procedure tdaCustomPrintItem.SaveToXMLNode(const node: IXMLNode);
var
  SubNode: IXMLNode;
begin
  inherited;
  Subnode := node;
  SubNode.AddChild('Key').NodeValue := Key;
  SubNode.AddChild('Overs').NodeValue := Overs;
  SubNode.AddChild('Qty_Qt').NodeValue := Qty_Qt;
  SubNode.AddChild('Qty').NodeValue := Qty;
  SubNode.AddChild('Brd_Size_L1').NodeValue := Brd_Size_L1;
  SubNode.AddChild('Size3_LC').NodeValue := Size3_LC;
  SubNode.AddChild('Size2_LC').NodeValue := Size2_LC;
  SubNode.AddChild('Brd_Size_W3').NodeValue := Brd_Size_W3;
  SubNode.AddChild('Brd_Size_W2').NodeValue := Brd_Size_W2;
  SubNode.AddChild('Brd_Size_W1').NodeValue := Brd_Size_W1;
  SubNode.AddChild('Size3_WC').NodeValue := Size3_WC;
  SubNode.AddChild('Size2_WC').NodeValue := Size2_WC;
  SubNode.AddChild('Size1_LC').NodeValue := Size1_LC;
  SubNode.AddChild('Lay').NodeValue := Lay;
  SubNode.AddChild('Size1_LF').NodeValue := Size1_LF;
  SubNode.AddChild('Brd_Tot_Cost3').NodeValue := Brd_Tot_Cost3;
  SubNode.AddChild('Brd_Tot_Cost2').NodeValue := Brd_Tot_Cost2;
  SubNode.AddChild('Brd_Tot_Cost1').NodeValue := Brd_Tot_Cost1;
  SubNode.AddChild('Tot_Cost3').NodeValue := Tot_Cost3;
  SubNode.AddChild('Tot_Cost2').NodeValue := Tot_Cost2;
  SubNode.AddChild('Tot_Cost1').NodeValue := Tot_Cost1;
  SubNode.AddChild('Brd_Stk2').NodeValue := Brd_Stk2;
  SubNode.AddChild('Brd_Stk1').NodeValue := Brd_Stk1;
  SubNode.AddChild('Stk_Qty3').NodeValue := Stk_Qty3;
  SubNode.AddChild('Stk_Qty2').NodeValue := Stk_Qty2;
  SubNode.AddChild('Stk_Qty1').NodeValue := Stk_Qty1;
  SubNode.AddChild('Brd_Unit3').NodeValue := Brd_Unit3;
  SubNode.AddChild('Brd_Stk3').NodeValue := Brd_Stk3;
  SubNode.AddChild('Brd_Unit2').NodeValue := Brd_Unit2;
  SubNode.AddChild('Size1_WC').NodeValue := Size1_WC;
  SubNode.AddChild('Grip').NodeValue := Grip;
  SubNode.AddChild('Size1_WF').NodeValue := Size1_WF;
  SubNode.AddChild('Brd_Unit1').NodeValue := Brd_Unit1;
  SubNode.AddChild('Qty_Unit3').NodeValue := Qty_Unit3;
  SubNode.AddChild('Qty_Unit1').NodeValue := Qty_Unit1;
  SubNode.AddChild('Qty_Unit2').NodeValue := Qty_Unit2;
  SubNode.AddChild('Work_Tot_Cost').NodeValue := Work_Tot_Cost;

  SubNode.AddChild('Metal_Code2').NodeValue := Metal_Code2;
  SubNode.AddChild('Metal_Code1').NodeValue := Metal_Code1;
  SubNode.AddChild('Ink_Code').NodeValue := Ink_Code;
  SubNode.AddChild('Brd_Code3').NodeValue := Brd_Code3;
  SubNode.AddChild('Brd_Code2').NodeValue := Brd_Code2;
  SubNode.AddChild('Brd_Code1').NodeValue := Brd_Code1;
  SubNode.AddChild('MT_Key3').NodeValue := MT_Key3;
  SubNode.AddChild('MT_Key2').NodeValue := MT_Key2;
  SubNode.AddChild('MT_Key1').NodeValue := MT_Key1;

  SubNode.AddChild('Other_Material').NodeValue := Other_Material;
  SubNode.AddChild('MetalTotalCost1').NodeValue := MetalTotalCost1;
  SubNode.AddChild('Unit_Cost_Inc').NodeValue := Unit_Cost_Inc;
  SubNode.AddChild('MetalTotalCost2').NodeValue := MetalTotalCost2;
  SubNode.AddChild('Ink_Tot_Cost').NodeValue := Ink_Tot_Cost;
  SubNode.AddChild('Brd_Qty3').NodeValue := Brd_Qty3;
  SubNode.AddChild('Brd_Qty2').NodeValue := Brd_Qty2;
  SubNode.AddChild('Brd_Qty1').NodeValue := Brd_Qty1;
  SubNode.AddChild('Inked_PC').NodeValue := Inked_PC;
  SubNode.AddChild('NUM_UPL').NodeValue := NUM_UPL;
  SubNode.AddChild('Qty2').NodeValue := Qty2;
  SubNode.AddChild('Qty1').NodeValue := Qty1;
  SubNode.AddChild('Gap').NodeValue := Gap;
  SubNode.AddChild('NUM_UPW').NodeValue := NUM_UPW;
  SubNode.AddChild('Qty3').NodeValue := Qty3;
  SubNode.AddChild('Area').NodeValue := Area;
  SubNode.AddChild('Brd_Size_L3').NodeValue := Brd_Size_L3;
  SubNode.AddChild('Brd_Size_L2').NodeValue := Brd_Size_L2;
  SubNode.AddChild('Cost_Art').NodeValue := Cost_Art;
  SubNode.AddChild('Cost_Tooling').NodeValue := Cost_Tooling;
  SubNode.AddChild('Cost_Film').NodeValue := Cost_Film;
  SubNode.AddChild('Unit_Cost_Ex').NodeValue := Unit_Cost_Ex;
  SubNode.AddChild('Total_Inc_S').NodeValue := Total_Inc_S;
  SubNode.AddChild('Metal_Price2').NodeValue := Metal_Price2;
  SubNode.AddChild('Price3').NodeValue := Price3;
  SubNode.AddChild('Other_Mat_Cost').NodeValue := Other_Mat_Cost;
  SubNode.AddChild('Unit_Cost_Inc_S').NodeValue := Unit_Cost_Inc_S;
  SubNode.AddChild('Total_ExTax_S').NodeValue := Total_ExTax_S;
  SubNode.AddChild('Mat_Tot_Cost').NodeValue := Mat_Tot_Cost;
  SubNode.AddChild('Ink_Price').NodeValue := Ink_Price;
  SubNode.AddChild('Brd_Price3').NodeValue := Brd_Price3;
  SubNode.AddChild('Brd_Price2').NodeValue := Brd_Price2;
  SubNode.AddChild('Brd_Price1').NodeValue := Brd_Price1;
  SubNode.AddChild('Metal_Price1').NodeValue := Metal_Price1;
  SubNode.AddChild('Price2').NodeValue := Price2;
  SubNode.AddChild('Price1').NodeValue := Price1;
  SubNode.AddChild('Tax_Amount_S').NodeValue := Tax_Amount_S;
  SubNode.AddChild('Markup_PC').NodeValue := Markup_PC;
  SubNode.AddChild('Mat_Markup_PC').NodeValue := Mat_Markup_PC;
  SubNode.AddChild('Markup_Tax').NodeValue := Markup_Tax;

  SubNode.AddChild('Mach_Cost_Hr').NodeValue := Mach_Cost_Hr;
  SubNode.AddChild('Prints_Hr').NodeValue := Prints_Hr;
  SubNode.AddChild('Num_Up').NodeValue := Num_Up;
  SubNode.AddChild('Colour_lbl').NodeValue := Colour_lbl;
  SubNode.AddChild('Colours_pass').NodeValue := Colours_pass;
  SubNode.AddChild('Screen_Cost').NodeValue := Screen_Cost;
  SubNode.AddChild('Setup_Cost').NodeValue := Setup_Cost;
  SubNode.AddChild('Tot_Prn_Cost').NodeValue := Tot_Prn_Cost;
  SubNode.AddChild('D_Setup_Cost').NodeValue := D_Setup_Cost;
  SubNode.AddChild('D_Num_Up').NodeValue := D_Num_Up;
  SubNode.AddChild('Cost_Hr').NodeValue := Cost_Hr;
  SubNode.AddChild('Imps_Hr').NodeValue := Imps_Hr;
  SubNode.AddChild('BackSlit_Cost').NodeValue := BackSlit_Cost;
  SubNode.AddChild('HandWork_Cost').NodeValue := HandWork_Cost;
  SubNode.AddChild('Guillotine_Cost').NodeValue := Guillotine_Cost;
  SubNode.AddChild('Pack_Cost').NodeValue := Pack_Cost;
  SubNode.AddChild('Del_Cost').NodeValue := Del_Cost;
  SubNode.AddChild('SubCon_Cost').NodeValue := SubCon_Cost;
  SubNode.AddChild('E_Setup_Cost').NodeValue := E_Setup_Cost;
  SubNode.AddChild('CutPVC_Cost').NodeValue := CutPVC_Cost;
  SubNode.AddChild('CutBrd_Cost').NodeValue := CutBrd_Cost;
  SubNode.AddChild('PreWeld_Cost').NodeValue := PreWeld_Cost;
  SubNode.AddChild('Main_Weld_Up').NodeValue := Main_Weld_Up;
  SubNode.AddChild('Main_Welds_Day').NodeValue := Main_Welds_Day;
  SubNode.AddChild('Mach_Cost_Day').NodeValue := Mach_Cost_Day;
  SubNode.AddChild('Weld_Cost').NodeValue := Weld_Cost;
  SubNode.AddChild('Post_Weld_Cost').NodeValue := Post_Weld_Cost;
  SubNode.AddChild('Tot_Weld_Cost').NodeValue := Tot_Weld_Cost;
  SubNode.AddChild('Rivet_Cost').NodeValue := Rivet_Cost;
  SubNode.AddChild('WorkTot_Cost').NodeValue := WorkTot_Cost;
  SubNode.AddChild('Notes').NodeValue := Notes;
  SubNode.AddChild('Prod_Qty').NodeValue := Prod_Qty;
  SubNode.AddChild('Prod_Qty_Qt').NodeValue := Prod_Qty_Qt;
  SubNode.AddChild('Prod_Overs').NodeValue := Prod_Overs;
  SubNode.AddChild('Num_UPT').NodeValue := Num_UPT;
  SubNode.AddChild('Lays_Brd').NodeValue := Lays_Brd;
  SubNode.AddChild('Rivets').NodeValue := Rivets;
  SubNode.AddChild('Slit_YN').NodeValue := Slit_YN;
end;

procedure tdaCustomPrintItem.LoadFromXMLNode(const node: IXMLNode);
var
  ValNode: IXMLNode;
  NodeExists: boolean;
begin
  inherited;
  Key := GetXMLNodeIntegerValue(node, 'Key', NodeExists);
  Overs := GetXMLNodeIntegerValue(node, 'Overs', NodeExists);
  Qty_Qt := GetXMLNodeIntegerValue(node, 'Qty_Qt', NodeExists);
  Qty := GetXMLNodeIntegerValue(node, 'Qty', NodeExists);
  Brd_Size_L1 := GetXMLNodeIntegerValue(node, 'Brd_Size_L1', NodeExists);
  Size2_LC := GetXMLNodeIntegerValue(node, 'Size2_LC', NodeExists);
  Brd_Size_W3 := GetXMLNodeIntegerValue(node, 'Brd_Size_W3', NodeExists);
  Brd_Size_W2 := GetXMLNodeIntegerValue(node, 'Brd_Size_W2', NodeExists);
  Brd_Size_W1 := GetXMLNodeIntegerValue(node, 'Brd_Size_W1', NodeExists);

  Size3_WC := GetXMLNodeIntegerValue(node, 'Size3_WC', NodeExists);
  Size2_WC := GetXMLNodeIntegerValue(node, 'Size2_WC', NodeExists);
  Size1_LC := GetXMLNodeIntegerValue(node, 'Size1_LC', NodeExists);
  Lay := GetXMLNodeIntegerValue(node, 'Lay', NodeExists);
  Size1_LF := GetXMLNodeIntegerValue(node, 'Size1_LF', NodeExists);

  ValNode := node.ChildNodes.FindNode('Brd_Tot_Cost3');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Brd_Tot_Cost3 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Brd_Tot_Cost2');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Brd_Tot_Cost2 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Brd_Tot_Cost1');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Brd_Tot_Cost1 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Tot_Cost3');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Tot_Cost3 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Tot_Cost2');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Tot_Cost2 := ValNode.NodeValue;

  Valnode := node.ChildNodes.FindNode('Tot_Cost1');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Tot_Cost1 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Brd_Stk2');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Brd_Stk2 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Brd_Stk1');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Brd_Stk1 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Brd_Stk1');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Stk_Qty3 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Stk_Qty2');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Stk_Qty2 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Stk_Qty1');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Stk_Qty1 := ValNode.NodeValue;

  Brd_Unit3 := GetXMLNodeIntegerValue(node, 'Brd_Unit3', NodeExists);

  ValNode := node.ChildNodes.FindNode('Brd_Stk3');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Brd_Stk3 := ValNode.NodeValue;

  Brd_Unit2 := GetXMLNodeIntegerValue(node, 'Brd_Unit2', NodeExists);
  Size1_WC := GetXMLNodeIntegerValue(node, 'Size1_WC', NodeExists);
  Grip := GetXMLNodeIntegerValue(node, 'Grip', NodeExists);
  Size1_WF := GetXMLNodeIntegerValue(node, 'Size1_WF', NodeExists);
  Brd_Unit1 := GetXMLNodeIntegerValue(node, 'Brd_Unit1', NodeExists);
  Qty_Unit3 := GetXMLNodeIntegerValue(node, 'Qty_Unit3', NodeExists);
  Qty_Unit2 := GetXMLNodeIntegerValue(node, 'Qty_Unit2', NodeExists);
  Qty_Unit1 := GetXMLNodeIntegerValue(node, 'Qty_Unit1', NodeExists);

  ValNode := node.ChildNodes.FindNode('Work_Tot_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Work_Tot_Cost := ValNode.NodeValue;

  Metal_Code2 := GetXMLNodeIntegerValue(node, 'Metal_Code2', NodeExists);
  Metal_Code1 := GetXMLNodeIntegerValue(node, 'Metal_Code1', NodeExists);
  Ink_Code := GetXMLNodeIntegerValue(node, 'Ink_Code', NodeExists);
  Brd_Code3 := GetXMLNodeIntegerValue(node, 'Brd_Code3', NodeExists);
  Brd_Code2 := GetXMLNodeIntegerValue(node, 'Brd_Code2', NodeExists);
  Brd_Code1 := GetXMLNodeIntegerValue(node, 'Brd_Code1', NodeExists);
  MT_Key3 := GetXMLNodeIntegerValue(node, 'MT_Key3', NodeExists);
  MT_Key2 := GetXMLNodeIntegerValue(node, 'MT_Key2', NodeExists);
  MT_Key1 := GetXMLNodeIntegerValue(node, 'MT_Key1', NodeExists);

  Other_Material := GetXMLNodeIntegerValue(node, 'Other_Material', NodeExists);

  ValNode := node.ChildNodes.FindNode('MetalTotalCost1');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then MetalTotalCost1 := ValNode.NodeValue;

  Valnode := node.ChildNodes.FindNode('Unit_Cost_Inc');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Unit_Cost_Inc := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('MetalTotalCost2');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then MetalTotalCost2 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Ink_Tot_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Ink_Tot_Cost := ValNode.NodeValue;

  Brd_Qty3 := GetXMLNodeIntegerValue(node, 'Brd_Qty3', NodeExists);
  Brd_Qty2 := GetXMLNodeIntegerValue(node, 'Brd_Qty2', NodeExists);
  Brd_Qty1 := GetXMLNodeIntegerValue(node, 'Brd_Qty1', NodeExists);


  ValNode := node.ChildNodes.FindNode('Inked_PC');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Inked_PC := ValNode.NodeValue;

  NUM_UPL := GetXMLNodeIntegerValue(node, 'NUM_UPL', NodeExists);
  Qty3 := GetXMLNodeIntegerValue(node, 'Qty3', NodeExists);
  Qty2 := GetXMLNodeIntegerValue(node, 'Qty2', NodeExists);
  Qty1 := GetXMLNodeIntegerValue(node, 'Qty1', NodeExists);
  Gap := GetXMLNodeIntegerValue(node, 'Gap', NodeExists);
  NUM_UPW := GetXMLNodeIntegerValue(node, 'NUM_UPW', NodeExists);

  ValNode := node.ChildNodes.FindNode('Area');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Area := ValNode.NodeValue;

  Brd_Size_L3 := GetXMLNodeIntegerValue(node, 'Brd_Size_L3', NodeExists);
  Brd_Size_L2 := GetXMLNodeIntegerValue(node, 'Brd_Size_L2', NodeExists);

  ValNode := node.ChildNodes.FindNode('Cost_Art');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Cost_Art := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Cost_Tooling');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Cost_Tooling := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Cost_Film');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Cost_Film := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Unit_Cost_Ex');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Unit_Cost_Ex := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Total_Inc_S');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Total_Inc_S := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Metal_Price2');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Metal_Price2 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Price3');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Price3 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Other_Mat_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Other_Mat_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Unit_Cost_Ex_S');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Unit_Cost_Ex_S := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Unit_Cost_Inc_S');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Unit_Cost_Inc_S := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Total_ExTax_S');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Total_ExTax_S := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Mat_Tot_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Mat_Tot_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Total_ExTax');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Total_ExTax := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Ink_Price');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Ink_Price := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Brd_Price3');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Brd_Price3 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Brd_Price2');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Brd_Price2 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Metal_Price1');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Metal_Price1 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Metal_Price1');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Price2 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Price1');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Price1 := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Tax_Amount_S');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Tax_Amount_S := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Markup_PC');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Markup_PC := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Mat_Markup_PC');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Mat_Markup_PC := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Markup_Tax');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Markup_Tax := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Mach_Cost_Hr');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Mach_Cost_Hr := ValNode.NodeValue;

  Prints_Hr := GetXMLNodeIntegerValue(node, 'Prints_Hr', NodeExists);
  Num_Up := GetXMLNodeIntegerValue(node, 'Num_Up', NodeExists);
  Colour_lbl := GetXMLNodeIntegerValue(node, 'Colour_lbl', NodeExists);
  Colours_pass := GetXMLNodeIntegerValue(node, 'Colours_pass', NodeExists);

  ValNode := node.ChildNodes.FindNode('Screen_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Screen_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Setup_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Setup_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Tot_Prn_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Tot_Prn_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('D_Setup_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then D_Setup_Cost := ValNode.NodeValue;

  D_Num_Up := GetXMLNodeIntegerValue(node, 'D_Num_Up', NodeExists);

  ValNode := node.ChildNodes.FindNode('Cost_Hr');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Cost_Hr := ValNode.NodeValue;

  Imps_Hr := GetXMLNodeIntegerValue(node, 'Imps_Hr', NodeExists);

  ValNode := node.ChildNodes.FindNode('BackSlit_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then BackSlit_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('BackSlit_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then HandWork_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Guillotine_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Guillotine_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Guillotine_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Pack_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Del_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Del_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('SubCon_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then SubCon_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('E_Setup_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then E_Setup_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('CutPVC_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then CutPVC_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('CutBrd_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then CutBrd_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('PreWeld_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then PreWeld_Cost := ValNode.nodeValue;

  ValNode := node.ChildNodes.FindNode('Main_Weld_Up');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Main_Weld_Up := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Main_Welds_Day');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Main_Welds_Day := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Mach_Cost_Day');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Mach_Cost_Day := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Weld_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Weld_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Post_Weld_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Post_Weld_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Tot_Weld_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Tot_Weld_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Rivet_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Rivet_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('WorkTot_Cost');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then WorkTot_Cost := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('Notes');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Notes := ValNode.NodeValue;

  Prod_Qty := GetXMLNodeIntegerValue(node, 'Prod_Qty', NodeExists);
  Prod_Qty_Qt := GetXMLNodeIntegerValue(node, 'Prod_Qty_Qt', NodeExists);
  Prod_Overs := GetXMLNodeIntegerValue(node, 'Prod_Overs', NodeExists);
  Num_UPT := GetXMLNodeIntegerValue(node, 'Num_UPT', NodeExists);
  Lays_Brd := GetXMLNodeIntegerValue(node, 'Lays_Brd', NodeExists);
  Rivets := GetXMLNodeIntegerValue(node, 'Rivets', NodeExists);

  ValNode := node.ChildNodes.FindNode('Slit_YN');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Slit_YN := ValNode.NodeValue;
end;


  //procedure tdaCustomPrintItem.LoadCustomData(da:TdaBase);
  //var Connection: TMyConnection;
  //    Qry: TMyQuery;
  //begin
  //  Connection:= CommonDbLib.GetSharedMyDacConnection;
  //  Qry:= TMyQuery.Create(self);
  //  Qry.Connection:= Connection;
  //
  //  // Define Class Query
  //  Qry.SQL.Text:=
  //    ' SELECT CustomData,SaleLineID FROM tblsaleslines';
  //  if da.ID > 0 then
  //    Qry.SQL.Add('WHERE SaleLineID = ' + FastFuncs.IntToStr(da.ID));
  //
  //  Qry.Open;
  //
  //  // Update object properties with stored values
  //  if not Qry.IsEmpty then
  //  begin
  //    da.XML := Qry.FieldByName('CustomData').AsString;
  //  end;
  //
  //  Qry.Close;
  //end;
  //
  //procedure tdaCustomPrintItem.SaveCustomData(da: TdaBase);
  //var Connection: TMyConnection;
  //    Qry: TMyQuery;
  //begin
  //  Connection:= CommonDbLib.GetSharedMyDacConnection;
  //  Qry:= TMyQuery.Create(self);
  //  Qry.Connection:= Connection;
  //
  //  // Define Class Query
  //  Qry.SQL.Text:=
  //    ' SELECT CustomData,SaleLineID FROM tblSalesLines';
  //  if da.ID > 0 then
  //    Qry.SQL.Add('WHERE SaleLineID = ' + FastFuncs.IntToStr(da.ID));
  //  Qry.Open;
  //
  //  if Qry.IsEmpty then
  //  begin
  //    Qry.Insert;
  //  end
  //  else
  //  begin
  //    if da.ID = 0 then
  //      Qry.Append
  //    else
  //      Qry.Edit;
  //  end;
  //
  //  // Update or insert record with object properties
  //  Qry.FieldByName('CustomData').AsString := da.XML;
  //
  //  Qry.Post;
  //  Qry.Close;
  //
  //end;

procedure tdaCustomPrintItem.MainCalc;
var  
  Mowy: real;
  Moly: real;
  Mowyps: real;
  Molyps: real;
  mwps: real;
  mlps: real;
  pslorpsw: real;
  mowx: real;
  Molx: real;
  Mowxps: real;
  Molxps: real;
  moyps: integer;
  Moxps: integer;
  Psw1: integer;
  Psl1: integer;
begin
  //initialize values
  if psw > Psl then psl1 := psw 
  else psl1 := Psl;
  if psw > Psl then psw1 := Psl  
  else psw1 := psw;
  if psl1 = 0 then psl1 := 1;
  if psw1 = 0 then psw1 := 1;
  if (mwidth mod psl1) < (mwidth mod psw1) then begin
    mwps := (mwidth / psl1);
  end else begin
    mwps := (mwidth / psw1);
  end;

  mowy := mwidth mod Trunc(mwidth / mwps);
  if mwidth / psw1 = mwps then begin
    pslorpsw := psl1;
  end else begin
    pslorpsw := psw1;
  end;
  mlps := mlength / pslorpsw;
  moly := mlength - (mlength mod Trunc(mlength / mlps));

  if mowy < psw1 then mowyps := 0
  else if mowy >= psl1 then mowyps := mowy / psl1
  else mowyps := mowy / psw1;


  if moly < psw1 then molyps := 0
  else if moly >= psl1 then molyps := moly / psl1
  else if Int(mowyps) = Int(mowy / psw1) then molyps := moly / psl1
  else molyps := moly / psw1;

  mowx := mlength - moly;
  molx := mwidth;

  if mowx < psw1 then mowxps := 0
  else if mowx >= psl1 then mowxps := mowx / psl1
  else mowxps := mowx / psw1;


  if molx < psw1 then molxps := 0
  else if molx < psw1 then molxps := 0
  else if Int(mowxps) = Int(mowx / psw1) then molxps := molx / psl1
  else molxps := molx / psw1;

  if mowyps < 1 then moyps := 0
  else if molyps < 1 then moyps := 0
  else moyps := Trunc(Int(mowyps) * Int(molxps));

  if mowxps < 1 then moxps := 0
  else moxps := Trunc(Int(mowxps) * Int(molxps));
  psoms := (Int(mlps) * Int(mwps)) + Int(moyps) + Int(moxps);

  if psoms = 0 then psoms := 1;
  qms := (nps / psoms) * item;
  comat := qms * mprice;
end;


procedure tdaCustomPrintItem.MaterialCalc;
var 
  MATCOST: real;
  Inkcost: currency;
begin
  //CALcULATE ALL VALUES FOR ALL MATERIALS
  //vinylcut calculations Material1
  if mt_key1width = 0 then mt_key1width := 1;
  if mt_key1length = 0 then mt_key1length := 1;
  mwidth := mt_key1width;   //prop
  mlength := mt_key1length;
  item := Qty1;
  //  If item = 0 Then MsgBox 'NO itemS HERE FOR item 1?';
  mprice := Price1;
  if NUM_UPL = 0 then NUM_UPL := 1; //added
  if NUM_UPW = 0 then NUM_UPW := 1;
  Nps := ((qty * Qty_Qt) + overs) / (NUM_UPL * NUM_UPW);
  Psl := Size1_LF * Num_Upl + ((Num_Upl - 1) * GAP) + LAY;
  psw := Size1_WF * Num_Upw + ((Num_Upw - 1) * GAP) + GRIP;

  //  if psl=0 then psl:=1;
  //  if psw=0 then psw:=1;

  MainCalc;

  //values for fields on me= f_QUOTE_qty Material1
  Qty_Unit1 := Trunc(psoms);
  Stk_qty1 := qms;
  if comat < 15 then TOT_COST1 := 15 
  else TOT_COST1 := comat;
  psoms := 0;
  qms := 0; 
  comat := 0;

  //vinylcut calculations MATERIAL 2
  if mt_key2width = 0 then mt_key2width := 1;
  mwidth := mt_key2width;

  if mt_key2length = 0 then mt_key2length := 1;
  mlength := mt_key2length;

  item := qty2;
  mprice := PRICE2;

  nps := ((qty * qty_qt) + overs) / (Num_Upl * Num_Upw);
  if Size2_LC = 0 then begin
    Psl := 1;
  end else begin
    //    Psl := NilZero(Size2_LC, 1);
    if Size2_LC <> 0 then begin 
      Size2_LC := 1;
      psl := Size2_LC;
    end;

    if Size2_WC = 0 then begin
      psw := 1;
    end else begin
      //psw:= NilZero(Size2_WC, 1);
      if Size2_WC <> 0 then Size2_WC := 1;
      psw := Size2_WC;       
    end;

    //If Not mt_key2 = 0 Then MainCalc;  TO DO
    MainCalc;

    //values for fields on := f_QUOTE_qty Material2
    qty_unit2 := Trunc(psoms);
    stk_qty2  := qms;
    Tot_Cost2 := comat;
    psoms     := 0; 
    qms       := 0; 
    comat     := 0;

    //vinylcut calculations MATERIAL 3

    if mt_key3width = 0 then mt_key3width := 1;
    mwidth := mt_key3width;
    if mt_key3length = 0 then mt_key3length := 1;
    mlength := mt_key3length;

    item   := qty3;
    mprice := Price3;

    nps := ((qty * qty_qt) + overs) / (Num_Upl * Num_Upw);

    if Size3_lc = 0 then Size3_lc := 1;
    psl := Size3_lc;

    if Size3_Wc = 0 then Size3_wc := 1;
    psw := Size3_wc;

    //  Psl := NilZero(Size3_Lc, 1);
    //  psw:= NilZero(Size3_Wc, 1);
    if Size3_Lc = 0 then begin
      Psl := 1;
    end else begin
      //    Psl := NilZero(Size3_Lc, 1);
      if Size3_Lc <> 0 then Size3_Lc := 1;
      psl := Size3_Lc;
    end;

    if Size3_Wc = 0 then begin
      psw := 1;
    end else begin
      //psw:= NilZero(Size3_Wc, 1);
      if Size3_Wc <> 0 then Size3_Wc := 1;
      psw := Size3_wc;
    end;

    //  If (Not mt_key3) = 0 Then MainCalc;
    MainCalc;

    //values for fields on = f_QUOTE_qty Material3
    qty_unit3 := Trunc(psoms);
    Stk_qty3  := qms;
    Tot_Cost3 := comat;
    psoms     := 0; 
    qms       := 0; 
    comat     := 0;

    //Board cut Calculations Board1
    if brd_code1width = 0 then brd_code1width := 1;
    mwidth := brd_code1width;

    if brd_code1length = 0 then brd_code1length := 1;
    mlength := brd_code1length;

    item   := brd_qty1;
    mprice := brd_price1;

    nps := ((qty * qty_qt) + overs) / (Num_Upl * Num_Upw);
    if brd_size_L1 = 0 then begin
      Psl := 1;
    end else begin
      //    Psl := NilZero(brd_size_L1, 1);
      if brd_size_L1 = 0 then brd_size_L1 := 1;
      psl := brd_size_L1;
    end;

    if brd_size_W1 = 0 then begin
      psw := 1;
    end else begin
      //    psw:= NilZero(brd_size_W1, 1);
      if brd_size_W1 = 0 then brd_size_W1 := 1;
      psw := brd_size_W1
    end;

    if (not brd_code1) = 0 then MainCalc;

    //Values for Fields on =f_quote_qty Board1
    brd_UNIT1     := Trunc(psoms);
    brd_STK1      := qms;
    brd_Tot_Cost1 := comat;
    psoms         := 0; 
    qms           := 0; 
    comat         := 0;

    //Board cut Calculations Board2
    if brd_code2width = 0 then brd_code2width := 1;
    mwidth := brd_code2width;
    if brd_code2length = 0 then brd_code2length := 1;
    mlength := brd_code2length;

    item   := brd_qty2;
    mprice := brd_price2;

    nps := ((qty * qty_qt) + overs) / (Num_Upl * Num_Upw);
    if brd_size_L2 = 0 then begin
      Psl := 1;
    end else begin
      //    Psl := NilZero(brd_size_L2, 1);
      if brd_size_L2 = 0 then brd_size_L2 := 1;
      psl := brd_size_L2;
    end;

    if brd_size_W2 = 0 then begin
      psw := 1;
    end else begin
      if brd_size_W2 = 0 then brd_size_W2 := 1;
      psw := brd_size_W2;
    end;

    //If (Not brd_code2) = 0 Then MainCalc;
    MainCalc;

    //Values for Fields on =f_quote_qty Board2
    brd_UNIT2     := Trunc(psoms);
    brd_STK2      := Trunc(qms);
    brd_Tot_Cost2 := comat;
    psoms         := 0;
    qms           := 0;  
    comat         := 0;

    //Board cut Calculations Board3

    if brd_code3width = 0 then brd_code3width := 1;
    mwidth := brd_code3width;
    if brd_code3length = 0 then brd_code3length := 1;
    mlength := brd_code3length;

    item   := brd_qty3;
    mprice := brd_Price3;

    nps := ((qty * qty_qt) + overs) / (Num_Upl * Num_Upw);
    if brd_size_L3 = 0 then begin
      Psl := 1;
    end else if brd_size_L3 = 0 then brd_size_L3 := 1;
    psl := brd_size_L3;
  end;
  //    Psl := NilZero(brd_size_L3, 1);
  if brd_size_W3 = 0 then begin
    psw := 1;
  end else begin
    //    psw:= NilZero(brd_size_W3, 1);
    if brd_size_W3 = 0 then brd_size_W3 := 1;
    psw := brd_size_W3;
  end;

  if (not brd_code3) = 0 then MainCalc;
  //Values for Fields on =f_quote_qty Board3
  brd_Unit3 := Trunc(psoms);
  brd_Stk3 := Trunc(qms);
  brd_Tot_Cost3 := comat;
  psoms := 0; 
  qms := 0;  
  comat := 0;

  //calculate total area of label x qty
  Area := (Size1_wf * Size1_lf) / 1000000 * ((qty * qty_qt) + overs);
  //ink cost
  InkCost := (Area / 100) * Inked_Pc * Ink_Price;
  if InkCost < 15 then Ink_Tot_Cost := 15 
  else Ink_Tot_Cost := InkCost;
  //Metal Cost1
  MetalTotalCost1 := (qty * qty_qt) * Metal_price1;
  //Metal Cost2
  MetalTotalCost2 := (qty * qty_qt) * Metal_price2;

  //total Material Cost
  MatCost := Tot_Cost1 + Tot_Cost2 + Tot_Cost3 + brd_Tot_Cost1 + brd_Tot_Cost2 + brd_Tot_Cost3 +
    Ink_Tot_Cost + MetalTotalCost1 + MetalTotalCost2 + Other_Mat_Cost;

  MAT_Tot_Cost := MatCost + (MatCost / 100 * Mat_Markup_PC);
end;

procedure tdaCustomPrintItem.ProductionCalc;
var 
  pruuncost: real;
  dccost: real;
  fCost: real;
  printshr: integer;
  colourlbl: integer;
  colourspass: integer;
  nopasses: integer;
  nopasses1: real;
  dnumup: integer;
  dimpshr: integer;
  wnumup: integer;
  Weldday: integer;
begin
  //printing work
  //    pruuncost := 0;
  //    dccost := 0;
  //    fCost := 0;
  //    printshr := 0;
  //    colourlbl := 0;
  //    colourspass := 0;
  nopasses := 0;
  //    nopasses1 := 0;
  //    dnumup := 0;
  //    dimpshr := 0;
  //    wnumup := 0;
  //    Weldday := 0;
  if Colour_lbl = 0 then colourlbl := 0 
  else colourlbl := NilZero(Colour_lbl, 0);
  if Prints_Hr = 0 then printshr := 1 
  else printshr := NilZero(Prints_Hr, 1);
  if Colours_Pass = 0 then colourspass := 1 
  else colourspass := NilZero(Colours_Pass, 1);
  nopasses1 := colourlbl / colourspass;
  if nopasses1 < 1 then begin 
    nopasses1 := 1;

    if (nopasses1 - Int(nopasses1) = 0) then nopasses := Trunc(nopasses1)
    else nopasses := Trunc(nopasses1) + 1;
  end;

  if Num_Up = 0 then Num_Up := 1;
  pruuncost := ((qty * qty_qt) + overs) / Num_up * nopasses / printShr * Mach_Cost_Hr;
  Tot_Prn_Cost := pruuncost + Screen_Cost + Setup_Cost;

  //die cutting/numbering
  if Num_up = 0 then begin
    dnumup := 1;
  end else begin
    if Num_up = 0 then Num_up := 1;
    dnumup := Num_up;
  end;
  //    dnumup := NilZero(Num_up, 1);
  if Imps_Hr = 0 then begin
    dimpshr := 1;
  end else begin
    if Imps_Hr = 0 then Imps_Hr := 1;
    dimpshr := Imps_Hr;
  end;
  //  dimpshr := NilZero(Imps_Hr, 1);

  dccost := ((qty * qty_qt) + overs) / dnumup / dimpshr * (Cost_Hr);
  Tot_Die_Cost := dccost + Setup_Cost;

  //pvc cutting slit or cut
  if Num_upt = 0 then Num_Upt := 1;
  if slit_Yn = false then CutPvc_Cost := ((qty1 + qty2 + qty3) * 0.025 * (qty / Num_upt))
  else CutPvc_Cost := (stk_qty1 + stk_qty2 + stk_qty3) * 10;

  //Board Cutting selects from items in f_quote_qty or f_quote_prod ?
  if lays_Brd = 0 then CutBrd_Cost := (brd_qty1 + brd_qty2 + brd_qty3) * qty * 0.035
  else CutBrd_Cost := lays_Brd * qty * 0.035;

  //welding costs
  if Main_Weld_Up = 0 then begin
    wnumup := 1;
  end else begin
    if Main_Weld_Up = 0 then Main_Weld_Up := 1;
    wnumup := Main_Weld_Up;
  end;

  if Main_Welds_Day = 0 then begin
    WeldDay := 1;
  end else begin
    if Main_Welds_Day = 0 then Main_Welds_Day := 1;
    WeldDay := Main_Welds_Day;
  end;

  if Mach_Cost_Day = 0 then Mach_Cost_Day := 1;
  Weld_Cost := ((qty * qty_qt) + overs) / wnumup / Weldday * Mach_Cost_Day;

  Tot_Weld_Cost := Setup_Cost + PreWeld_Cost + CutBrd_Cost + CutPvc_Cost + Post_Weld_Cost + WELD_COST;

  //Riveting costs
  Rivet_Cost := ((qty * qty_qt) * Rivets) * 0.09;

  //total work cost to f_quote_qty

  fCost := BackSlit_Cost + HandWork_Cost + Guillotine_Cost + Pack_Cost + Del_Cost + SubCon_Cost;

  WorkTot_Cost := fCost + Tot_Prn_Cost + Tot_Die_Cost + Rivet_Cost + Tot_Weld_Cost;
  Work_Tot_Cost := WorkTot_Cost;
end;



procedure tdaCustomPrintItem.TotalCalc;
begin
  Total_ExTax := (Mat_Tot_Cost + Work_Tot_Cost) * (1 + (Markup_PC / 100));
  Unit_Cost_Ex := Total_ExTax / qty;
  //Me.Parent.LIST_BREAKS.Requery
end;

constructor tdaCustomPrintItem.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor tdaCustomPrintItem.Destroy;
begin
  inherited;
end;


end.
