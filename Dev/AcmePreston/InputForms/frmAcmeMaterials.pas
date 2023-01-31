unit frmAcmeMaterials;
{
 Date     Version Who What
 -------- ------- --- ---------------------------------------------------------
 ??/??/05 1.00.01 ??? First version.

 13/02/06 1.00.02 AL  Comented DisplayObject in FormPaint.
 04/09/06 1.00.03 DSP Changed StrToInt to StrToIntDef to prevent string to
                      integer conversion error.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, wwdbedit, StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, Mask,
  DBCtrls, wwdbdatetimepicker, wwdblook, ExtCtrls, DNMPanel, DataState,
  DBAccess, MyAccess, SelectionDialog, AppEvnts, DB,  ComCtrls,
  AcmeMaterialsObj, Wwdotdot, Wwdbcomb, Menus, AdvMenus, Shader;

type
  TAcmeInputGUI = class(TBaseInputGUI)
    pnlHeader: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    Label12: TLabel;
    PageControl1: TPageControl;
    tabMaterial: TTabSheet;
    tabProduction: TTabSheet;
    Label92: TLabel;
    Label93: TLabel;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    Key: TEdit;
    Label2: TLabel;
    Qty: TEdit;
    Label3: TLabel;
    Qty_Qt: TEdit;
    Label4: TLabel;
    Overs: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label16: TLabel;
    Brd_Size_W3: TEdit;
    Brd_Size_W2: TEdit;
    Brd_Size_W1: TEdit;
    Size3_WC: TEdit;
    Size2_WC: TEdit;
    Size1_WC: TEdit;
    Grip: TEdit;
    Size1_WF: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Size1_LF: TEdit;
    Lay: TEdit;
    Size1_LC: TEdit;
    Size2_LC: TEdit;
    Size3_LC: TEdit;
    Brd_Size_L1: TEdit;
    Brd_Size_L2: TEdit;
    Brd_Size_L3: TEdit;
    Area: TEdit;
    Label18: TLabel;
    Label17: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Cost_Art: TEdit;
    Cost_Tooling: TEdit;
    Cost_Film: TEdit;
    Label31: TLabel;
    Label32: TLabel;
    Unit_Cost_Inc: TEdit;
    Unit_Cost_Ex: TEdit;
    Unit_Cost_Ex_S: TEdit;
    Label34: TLabel;
    Label33: TLabel;
    Unit_Cost_Inc_S: TEdit;
    Label49: TLabel;
    Label45: TLabel;
    Label43: TLabel;
    Label42: TLabel;
    Other_Material: TEdit;
    Work_Tot_Cost: TEdit;
    Label41: TLabel;
    Label40: TLabel;
    Label39: TLabel;
    Label38: TLabel;
    Label37: TLabel;
    Label36: TLabel;
    Label35: TLabel;
    NumUpWxl: TLabel;
    Label29: TLabel;
    NUM_UPL: TEdit;
    NUM_UPW: TEdit;
    Label28: TLabel;
    Label21: TLabel;
    Gap: TEdit;
    Label27: TLabel;
    Qty1: TEdit;
    Label26: TLabel;
    Qty2: TEdit;
    Label25: TLabel;
    Qty3: TEdit;
    Label24: TLabel;
    Brd_Qty1: TEdit;
    Label23: TLabel;
    Brd_Qty2: TEdit;
    Label22: TLabel;
    Brd_Qty3: TEdit;
    Label99: TLabel;
    Inked_PC: TEdit;
    Label53: TLabel;
    Label52: TLabel;
    Label51: TLabel;
    Label50: TLabel;
    Total_ExTax: TEdit;
    Mat_Tot_Cost: TEdit;
    Total_ExTax_S: TEdit;
    Tax_Amount_S: TEdit;
    Total_Inc_S: TEdit;
    Label54: TLabel;
    Other_Mat_Cost: TEdit;
    MetalTotalCost2: TEdit;
    MetalTotalCost1: TEdit;
    Ink_Tot_Cost: TEdit;
    Brd_Tot_Cost3: TEdit;
    Brd_Tot_Cost2: TEdit;
    Brd_Tot_Cost1: TEdit;
    Tot_Cost3: TEdit;
    Tot_Cost2: TEdit;
    Tot_Cost1: TEdit;
    Label48: TLabel;
    Label47: TLabel;
    Label46: TLabel;
    Label44: TLabel;
    Price1: TEdit;
    Price2: TEdit;
    Price3: TEdit;
    Brd_Price1: TEdit;
    Brd_Price2: TEdit;
    Brd_Price3: TEdit;
    Ink_Price: TEdit;
    Metal_Price1: TEdit;
    Metal_Price2: TEdit;
    Brd_Unit3: TEdit;
    Brd_Unit2: TEdit;
    Brd_Unit1: TEdit;
    Qty_Unit3: TEdit;
    Qty_Unit2: TEdit;
    Qty_Unit1: TEdit;
    Stk_Qty1: TEdit;
    Stk_Qty2: TEdit;
    Stk_Qty3: TEdit;
    Brd_Stk1: TEdit;
    Brd_Stk2: TEdit;
    Brd_Stk3: TEdit;
    Markup_Tax: TEdit;
    Label55: TLabel;
    Markup_PC: TEdit;
    Label56: TLabel;
    Mat_Markup_PC: TEdit;
    Label57: TLabel;
    BitBtn3: TDNMSpeedButton;
    BitBtn2: TDNMSpeedButton;
    BitBtn1: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    Label90: TLabel;
    Label96: TLabel;
    Prod_Overs: TEdit;
    Prod_Qty: TEdit;
    Label97: TLabel;
    Num_UPT: TEdit;
    Label91: TLabel;
    Prod_Qty_Qt: TEdit;
    Label94: TLabel;
    Lays_Brd: TEdit;
    Slit_YN: TCheckBox;
    Label95: TLabel;
    Rivets: TEdit;
    WorkTot_Cost: TEdit;
    Label82: TLabel;
    Label89: TLabel;
    Notes: TMemo;
    Pack_Cost: TEdit;
    Del_Cost: TEdit;
    SubCon_Cost: TEdit;
    Label76: TLabel;
    Label75: TLabel;
    Label74: TLabel;
    Rivet_Cost: TEdit;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label81: TLabel;
    Label80: TLabel;
    Label79: TLabel;
    Label78: TLabel;
    Label77: TLabel;
    E_Setup_Cost: TEdit;
    CutPVC_Cost: TEdit;
    CutBrd_Cost: TEdit;
    PreWeld_Cost: TEdit;
    Main_Weld_Up: TEdit;
    Main_Welds_Day: TEdit;
    Mach_Cost_Day: TEdit;
    Weld_Cost: TEdit;
    Post_Weld_Cost: TEdit;
    Tot_Weld_Cost: TEdit;
    BackSlit_Cost: TEdit;
    Label71: TLabel;
    Label72: TLabel;
    HandWork_Cost: TEdit;
    Guillotine_Cost: TEdit;
    Label73: TLabel;
    Tot_Die_Cost: TEdit;
    Label70: TLabel;
    Label69: TLabel;
    Imps_Hr: TEdit;
    Cost_Hr: TEdit;
    Label68: TLabel;
    Label67: TLabel;
    D_Num_Up: TEdit;
    D_Setup_Cost: TEdit;
    Label66: TLabel;
    Label65: TLabel;
    Tot_Prn_Cost: TEdit;
    Setup_Cost: TEdit;
    Label64: TLabel;
    Label63: TLabel;
    Screen_Cost: TEdit;
    Colours_pass: TEdit;
    Label62: TLabel;
    Label61: TLabel;
    Colour_lbl: TEdit;
    Num_Up: TEdit;
    Label60: TLabel;
    Prints_Hr: TEdit;
    Label59: TLabel;
    Label58: TLabel;
    Mach_Cost_Hr: TEdit;
    BitBtn4: TDNMSpeedButton;
    LblNum_UPT: TLabel;
    cmdSave: TDNMSpeedButton;
    CmdCancel: TDNMSpeedButton;
    Metal_Code1: TwwDBComboBox;
    Metal_Code2: TwwDBComboBox;
    Ink_Code: TwwDBComboBox;
    Brd_Code3: TwwDBComboBox;
    Brd_Code2: TwwDBComboBox;
    Brd_Code1: TwwDBComboBox;
    MT_Key3: TwwDBComboBox;
    MT_Key2: TwwDBComboBox;
    MT_Key1: TwwDBComboBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Size_WC_Enter(Sender: TObject);
    procedure Size_LC_Enter(Sender: TObject);
    procedure Unit_Cost_Ex_S_OnExit(Sender: TObject);
    procedure MT_Key1_OnExit(Sender: TObject);
    procedure MT_Key2_OnExit(Sender: TObject);
    procedure MT_Key3_OnExit(Sender: TObject);
    procedure Brd_Code1_OnExit(Sender: TObject);
    procedure Brd_Code2_OnExit(Sender: TObject);
    procedure Brd_Code3_OnExit(Sender: TObject);
    procedure Ink_Code_OnExit(Sender: TObject);
    procedure Metal_Code1_OnExit(Sender: TObject);
    procedure Metal_Code2_OnExit(Sender: TObject);
    procedure Num_Up_Enter(Sender: TObject);
    procedure CurrencyExit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure UpdateLabel(Sender: TObject);
    procedure CmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure EnableDisableCalcBtns(Sender: TObject);
    procedure UpdateTag(Sender: TObject);
    procedure IsDirty(Sender: TObject);
    procedure tabProductionEnter(Sender: TObject);


  private
    fSaleID: integer;
    fTotalCost: currency;
    fPriceInc: currency;
    function CurrString(const d: currency): string;
    function Currpercent(const d: real): string;
    function MatLookup(KeyList: TwwDBComboBox): string;
    procedure PopulateCombos(Desc: TStringList);
    function GetPrice(PartsID: integer): string;
    procedure PriceUpdate;
    function GetTotalCost: currency;
    function GetPriceInc: currency;
    function GetCustomData: string;
    procedure SetCustomData(const stXML: string);
    { Private declarations }
  public
    { Public declarations }
    
    procedure DisplayObject;
    procedure UpdateObject;
    property SaleID: integer read fSaleID write fSaleID;
    property TotalCost: currency read GetTotalCost write fTotalCost;
    property PriceInc: currency read GetPriceInc write fPriceInc;
    property CustomData: string read GetCustomData write SetCustomData;

  end;

var
  frmAcmeInputGUI: TAcmeInputGUI;
  CustItem: tdaCustomPrintItem;
  MT_KeyID, MTDesc, MTPrice: TStringList;


implementation

uses FastFuncs,daBase, CommonLib;
  {$R *.dfm}
  //Format currency
function TAcmeInputGUI.CurrString(const d: currency): string;
begin
  Result := CurrToStrF(d, ffCurrency, 2)
end;

function TAcmeInputGUI.Currpercent(const d: real): string;
begin
  Result := CurrToStrF(d, ffFixed, 2)
end;

function TAcmeInputGUI.GetPrice(PartsID: integer): string;
var 
  i: integer;
begin
  Result := '0';
  for i := 0 to MT_KeyID.Count - 1 do begin
    if PartsID = StrToIntDef(MT_KeyID.Strings[i], 0) then begin
      Result := MTPrice.strings[i];
      Break;
    end;
  end;
end;

function TAcmeInputGUI.MatLookup(KeyList: TwwDBComboBox): string;
var 
  i: integer;
var 
  KeyID: integer;
begin
  KeyID := KeyList.Tag;
  for i := 0 to KeyList.Items.Count - 1 do begin
    if KeyID = StrToIntDef(MT_KeyID.strings[i], 0) then begin
      Result := MTDesc.strings[i];            //get description
      Break;
    end;
  end;
end;

procedure TAcmeInputGUI.UpdateTag(Sender: TObject);
var 
  i: integer;
begin
  for i := 0 to TwwDBComboBox(Sender).Items.Count - 1 do begin
    if TwwDBComboBox(Sender).Text = MTDesc.strings[i] then begin
      TwwDBComboBox(Sender).tag := StrToIntDef(MT_KeyID.strings[i], 0);            //get id
      Break;
    end;
  end;
end;

procedure TAcmeInputGUI.UpdateObject;
  {assign controls with object properties}
begin
  with CustItem do begin
    Key         := StrToIntDef(Self.Key.Text, 0);
    ID          := StrToIntDef(Self.Key.Text, 0);
    Overs       := StrToIntDef(Self.Overs.Text, 0);
    Qty_Qt      := StrToIntDef(Self.Qty_Qt.Text, 0);
    Qty         := StrToIntDef(Self.Qty.Text, 0);
    Brd_Size_L1 := StrToIntDef(Self.Brd_Size_L1.Text, 0);
    Size2_LC    := StrToIntDef(Self.Size2_LC.Text, 0);
    Size3_LC    := StrToIntDef(Self.Size3_LC.Text, 0);
    Brd_Size_W3 := StrToIntDef(Self.Brd_Size_W3.Text, 0);
    Brd_Size_W2 := StrToIntDef(Self.Brd_Size_W2.Text, 0);
    Brd_Size_W1 := StrToIntDef(Self.Brd_Size_W1.Text, 0);
    Size3_WC    := StrToIntDef(Self.Size3_WC.Text, 0);
    Size2_WC    := StrToIntDef(Self.Size2_WC.Text, 0);
    Size1_LC    := StrToIntDef(Self.Size1_LC.Text, 0);
    Lay         := StrToIntDef(Self.Lay.Text, 0);
    Size1_LF    := StrToIntDef(Self.Size1_LF.Text, 0);
    Brd_Tot_Cost3 := strvalue(Self.Brd_Tot_Cost3.Text);
    Brd_Tot_Cost2 := strvalue(Self.Brd_Tot_Cost2.Text);
    Brd_Tot_Cost1 := strvalue(Self.Brd_Tot_Cost1.Text);
    Tot_Cost3   := strvalue(Self.Tot_Cost3.Text);
    Tot_Cost2   := strvalue(Self.Tot_Cost2.Text);
    Tot_Cost1   := strvalue(Self.Tot_Cost1.Text);
    Brd_Stk2    := strvalue(Self.Brd_Stk2.Text);
    Brd_Stk1    := strvalue(Self.Brd_Stk1.Text);
    Stk_Qty3    := strvalue(Self.Stk_Qty3.Text);
    Stk_Qty2    := strvalue(Self.Stk_Qty2.Text);
    Stk_Qty1    := strvalue(Self.Stk_Qty1.Text);
    Brd_Unit3   := StrToIntDef(Self.Brd_Unit3.Text, 0);
    Brd_Stk3    := strvalue(Self.Brd_Stk3.Text);
    Brd_Unit2   := StrToIntDef(Self.Brd_Unit2.Text, 0);
    Size1_WC    := StrToIntDef(Self.Size1_WC.Text, 0);
    Grip        := StrToIntDef(Self.Grip.Text, 0);
    Size1_WF    := StrToIntDef(Self.Size1_WF.Text, 0);
    Brd_Unit1   := StrToIntDef(Self.Brd_Unit1.Text, 0);
    Qty_Unit3   := StrToIntDef(Self.Qty_Unit3.Text, 0);
    Qty_Unit1   := StrToIntDef(Self.Qty_Unit1.Text, 0);
    Qty_Unit2   := StrToIntDef(Self.Qty_Unit2.Text, 0);
    Work_Tot_Cost := strvalue(Self.Work_Tot_Cost.Text);
    //partsid uses tag
    MT_Key3     := Self.MT_Key3.tag;
    MT_Key2     := Self.MT_Key2.tag;
    MT_Key1     := Self.MT_Key1.tag;
    Brd_Code3   := Self.Brd_Code3.tag;
    Brd_Code2   := Self.Brd_Code2.tag;
    Brd_Code1   := Self.Brd_Code1.tag;
    Ink_Code    := Self.Ink_Code.tag;
    Metal_Code1 := Self.Metal_Code1.tag;
    Metal_Code2 := Self.Metal_Code2.tag;

    //!!Tag holds the parts id
    Brd_Code3length:=CustItem.LoadSizesLength(Self.Brd_Code3.tag);
    Brd_Code3width:=CustItem.LoadSizeswidth(Self.Brd_Code3.tag  );

    Brd_Code2length :=CustItem.LoadSizesLength(Self.Brd_Code2.tag );
    Brd_Code2width:=CustItem.LoadSizesLength(Self.Brd_Code2.tag);

    Brd_Code1length:=CustItem.LoadSizesLength(Self.Brd_Code1.tag );
    Brd_Code1width :=CustItem.LoadSizesWidth(Self.Brd_Code1.tag );

    MT_Key3length:= CustItem.LoadSizesLength(Self.MT_Key3.tag);
    MT_Key3width:=CustItem.LoadSizesWidth(Self.MT_Key3.tag );

    MT_Key2length:=CustItem.LoadSizesLength(Self.MT_Key2.tag  );
    MT_Key2width:=CustItem.LoadSizesWidth(Self.MT_Key2.tag);

    MT_Key1length:=CustItem.LoadSizesLength(Self.MT_Key1.tag);
    MT_Key1width:=CustItem.LoadSizesWidth(Self.MT_Key1.tag );



    Other_Material  := StrToIntDef(Self.Other_Material.Text, 0);
    MetalTotalCost1 := strvalue(Self.MetalTotalCost1.Text);
    Unit_Cost_Inc   := strvalue(Self.Unit_Cost_Inc.Text);
    MetalTotalCost2 := strvalue(Self.MetalTotalCost2.Text);
    Ink_Tot_Cost    := strvalue(Self.Ink_Tot_Cost.Text);
    Brd_Qty3        := StrToIntDef(Self.Brd_Qty3.Text, 0);
    Brd_Qty2        := StrToIntDef(Self.Brd_Qty2.Text, 0);
    Brd_Qty1        := StrToIntDef(Self.Brd_Qty1.Text, 0);
    Inked_PC        := StrToIntDef(Self.Inked_PC.Text, 0);


    NUM_UPL      := StrToIntDef(Self.NUM_UPL.Text, 0);
    Qty2         := StrToIntDef(Self.Qty2.Text, 0);
    Qty1         := StrToIntDef(Self.Qty1.Text, 0);
    Gap          := StrToIntDef(Self.Gap.Text, 0);
    NUM_UPW      := StrToIntDef(Self.NUM_UPW.Text, 0);
    Qty3         := StrToIntDef(Self.Qty3.Text, 0);
    Area         := strvalue(Self.Area.Text);
    Brd_Size_L3  := StrToIntDef(Self.Brd_Size_L3.Text, 0);
    Brd_Size_L2  := StrToIntDef(Self.Brd_Size_L2.Text, 0);
    Cost_Art     := strvalue(Self.Cost_Art.Text);
    Cost_Tooling := strvalue(Self.Cost_Tooling.Text);
    Cost_Film    := strvalue(Self.Cost_Film.Text);
    Unit_Cost_Ex := strvalue(Self.Unit_Cost_Ex.Text);
    Total_Inc_S  := strvalue(Self.Total_Inc_S.Text);
    Metal_Price2 := strvalue(Self.Metal_Price2.Text);
    Price3       := strvalue(Self.Price3.Text);
    Other_Mat_Cost := strvalue(Self.Other_Mat_Cost.Text);
    Unit_Cost_Inc_S := strvalue(Self.Unit_Cost_Inc_S.Text);
    Mat_Tot_Cost := strvalue(Self.Mat_Tot_Cost.Text);

    Total_ExTax   := strvalue(Self.Total_ExTax.Text);
    Total_ExTax_S := strvalue(Self.Total_ExTax_S.Text);
    Tax_Amount_S  := strvalue(Self.Tax_Amount_S.Text);
    Total_Inc_S   := strvalue(Self.Total_Inc_S.Text);

    Ink_Price       := strvalue(Self.Ink_Price.Text);
    Brd_Price3      := strvalue(Self.Brd_Price3.Text);
    Brd_Price2      := strvalue(Self.Brd_Price2.Text);
    Brd_Price1      := strvalue(Self.Brd_Price1.Text);
    Metal_Price1    := strvalue(Self.Metal_Price1.Text);
    Price2          := strvalue(Self.Price2.Text);
    Price1          := strvalue(Self.Price1.Text);
    Tax_Amount_S    := strvalue(Self.Tax_Amount_S.Text);
    Markup_PC       := strvalue(Self.Markup_PC.Text);
    Mat_Markup_PC   := strvalue(Self.Mat_Markup_PC.Text);
    Markup_Tax      := strvalue(Self.Markup_Tax.Text);
    Mach_Cost_Hr    := strvalue(Self.Mach_Cost_Hr.Text);
    Prints_Hr       := StrToIntDef(Self.Prints_Hr.Text, 0);
    Num_Up          := StrToIntDef(Self.Num_Up.Text, 0);
    Colour_lbl      := StrToIntDef(Self.Colour_lbl.Text, 0);
    Colours_pass    := StrToIntDef(Self.Colours_pass.Text, 0);
    Screen_Cost     := strvalue(Self.Screen_Cost.Text);
    Setup_Cost      := strvalue(Self.Setup_Cost.Text);
    Tot_Prn_Cost    := strvalue(Self.Tot_Prn_Cost.Text);
    D_Setup_Cost    := strvalue(Self.D_Setup_Cost.Text);
    D_Num_Up        := StrToIntDef(Self.D_Num_Up.Text, 0);
    Cost_Hr         := strvalue(Self.Cost_Hr.Text);
    Imps_Hr         := StrToIntDef(Self.Imps_Hr.Text, 0);
    Tot_Die_Cost    := strvalue(Self.Tot_Die_cost.Text);
    BackSlit_Cost   := strvalue(Self.BackSlit_Cost.Text);
    HandWork_Cost   := strvalue(Self.HandWork_Cost.Text);
    Guillotine_Cost := strvalue(Self.Guillotine_Cost.Text);
    Pack_Cost       := strvalue(Self.Pack_Cost.Text);
    Del_Cost        := strvalue(Self.Del_Cost.Text);
    SubCon_Cost     := strvalue(Self.SubCon_Cost.Text);
    E_Setup_Cost    := strvalue(Self.E_Setup_Cost.Text);
    CutPVC_Cost     := strvalue(Self.CutPVC_Cost.Text);
    CutBrd_Cost     := strvalue(Self.CutBrd_Cost.Text);
    PreWeld_Cost    := strvalue(Self.PreWeld_Cost.Text);
    Main_Weld_Up    := StrToIntDef(Self.Main_Weld_Up.Text, 0);
    Main_Welds_Day  := StrToIntDef(Self.Main_Welds_Day.Text, 0);
    Mach_Cost_Day   := strvalue(Self.Mach_Cost_Day.Text);
    Weld_Cost       := strvalue(Self.Weld_Cost.Text);
    Post_Weld_Cost  := strvalue(Self.Post_Weld_Cost.Text);
    Tot_Weld_Cost   := strvalue(Self.Tot_Weld_Cost.Text);
    Rivet_Cost      := strvalue(Self.Rivet_Cost.Text);
    WorkTot_Cost    := strvalue(Self.WorkTot_Cost.Text);
    Notes           := Self.Notes.Text;
    Prod_Qty        := StrToIntDef(Self.Prod_Qty.Text, 0);
    Prod_Qty_Qt     := StrToIntDef(Self.Prod_Qty_Qt.Text, 0);
    Prod_Overs      := StrToIntDef(Self.Prod_Overs.Text, 0);
    Num_UPT         := StrToIntDef(Self.Num_UPT.Text, 0);
    Lays_Brd        := StrToIntDef(Self.Lays_Brd.Text, 0);
    Rivets          := StrToIntDef(Self.Rivets.Text, 0);
    Slit_YN         := Self.Slit_YN.Checked;
  end;
end;

procedure TAcmeInputGUI.DisplayObject;
  {assign controls with object properties}
begin
  Self.Key.Text := FastFuncs.IntToStr(CustItem.Key);
  Self.Overs.Text := FastFuncs.IntToStr(CustItem.Overs);
  Self.Qty_Qt.Text := FastFuncs.IntToStr(CustItem.Qty_Qt);
  Self.Qty.Text := FastFuncs.IntToStr(CustItem.Qty);
  Self.Brd_Size_L1.Text := FastFuncs.IntToStr(CustItem.Brd_Size_L1);
  Self.Size2_LC.Text := FastFuncs.IntToStr(CustItem.Size2_LC);
  Self.Size3_LC.Text := FastFuncs.IntToStr(CustItem.Size3_LC);
  Self.Brd_Size_W3.Text := FastFuncs.IntToStr(CustItem.Brd_Size_W3);
  Self.Brd_Size_W2.Text := FastFuncs.IntToStr(CustItem.Brd_Size_W2);
  Self.Brd_Size_W1.Text := FastFuncs.IntToStr(CustItem.Brd_Size_W1);
  Self.Size3_WC.Text := FastFuncs.IntToStr(CustItem.Size3_WC);
  Self.Size2_WC.Text := FastFuncs.IntToStr(CustItem.Size2_WC);
  Self.Size1_LC.Text := FastFuncs.IntToStr(CustItem.Size1_LC);
  Self.Lay.Text := FastFuncs.IntToStr(CustItem.Lay);
  Self.Size1_LF.Text := FastFuncs.IntToStr(CustItem.Size1_LF);
  Self.Brd_Tot_Cost3.Text := currstring(CustItem.Brd_Tot_Cost3);
  Self.Brd_Tot_Cost2.Text := currstring(CustItem.Brd_Tot_Cost2);
  Self.Brd_Tot_Cost1.Text := currstring(CustItem.Brd_Tot_Cost1);
  Self.Tot_Cost3.Text := currstring(CustItem.Tot_Cost3);
  Self.Tot_Cost2.Text := currstring(CustItem.Tot_Cost2);
  Self.Tot_Cost1.Text := currstring(CustItem.Tot_Cost1);
  Self.Brd_Stk2.Text := currpercent(CustItem.Brd_Stk2);
  Self.Brd_Stk1.Text := currpercent(CustItem.Brd_Stk1);
  Self.Stk_Qty3.Text := currpercent(CustItem.Stk_Qty3);
  Self.Stk_Qty2.Text := currpercent(CustItem.Stk_Qty2);
  Self.Stk_Qty1.Text := currpercent(CustItem.Stk_Qty1);
  Self.Brd_Unit3.Text := FastFuncs.IntToStr(CustItem.Brd_Unit3);
  Self.Brd_Stk3.Text := currpercent(CustItem.Brd_Stk3);
  Self.Brd_Unit2.Text := FastFuncs.IntToStr(CustItem.Brd_Unit2);
  Self.Size1_WC.Text := FastFuncs.IntToStr(CustItem.Size1_WC);
  Self.Grip.Text := FastFuncs.IntToStr(CustItem.Grip);
  Self.Size1_WF.Text := FastFuncs.IntToStr(CustItem.Size1_WF);
  Self.Brd_Unit1.Text := FastFuncs.IntToStr(CustItem.Brd_Unit1);
  Self.Qty_Unit3.Text := FastFuncs.IntToStr(CustItem.Qty_Unit3);
  Self.Qty_Unit1.Text := FastFuncs.IntToStr(CustItem.Qty_Unit1);
  Self.Qty_Unit2.Text := FastFuncs.IntToStr(CustItem.Qty_Unit2);
  Self.Work_Tot_Cost.Text := currstring(CustItem.Work_Tot_Cost);

  Self.Brd_Code3.tag := CustItem.Brd_Code3;
  Self.Brd_Code3.Text := MatLookup(Self.Brd_Code3);
  //!!Tag holds the parts id
  CustItem.Brd_Code3length:=CustItem.LoadSizesLength(Self.Brd_Code3.tag );
  CustItem.Brd_Code2width:=CustItem.LoadSizeswidth(Self.Brd_Code3.tag  );

  Self.Brd_Code2.tag := CustItem.Brd_Code2;
  Self.Brd_Code2.Text := MatLookup(Self.Brd_Code2);
  CustItem.Brd_Code2length :=CustItem.LoadSizesLength(Self.Brd_Code2.tag );
  CustItem.Brd_Code2width:=CustItem.LoadSizesLength(Self.Brd_Code2.tag);

  Self.Brd_Code1.Tag := CustItem.Brd_Code1;
  Self.Brd_Code1.Text := MatLookup(Self.Brd_Code1);
  CustItem.Brd_Code1length:=CustItem.LoadSizesLength(Self.Brd_Code1.tag );
  CustItem.Brd_Code1width :=CustItem.LoadSizesWidth(Self.Brd_Code1.tag );

  Self.MT_Key3.Tag := CustItem.MT_Key3;
  Self.MT_Key3.Text := MatLookup(Self.MT_Key3);
  CustItem.MT_Key3length:= CustItem.LoadSizesLength(Self.MT_Key3.tag);
  CustItem.MT_Key3width:=CustItem.LoadSizesWidth(Self.MT_Key3.tag );

  Self.MT_Key2.tag := CustItem.MT_Key2;
  Self.MT_Key2.Text := MatLookup(Self.MT_Key2);
  CustItem.MT_Key2length:=CustItem.LoadSizesLength(Self.MT_Key2.tag  );
  CustItem.MT_Key2width:=CustItem.LoadSizesWidth(Self.MT_Key2.tag);

  Self.MT_Key1.tag := CustItem.MT_Key1;
  Self.MT_Key1.Text := MatLookup(Self.MT_Key1);
  CustItem.MT_Key1length:=CustItem.LoadSizesLength(Self.MT_Key1.tag);
  CustItem.MT_Key1width:=CustItem.LoadSizesWidth(Self.MT_Key1.tag );

  Self.Metal_Code2.tag := CustItem.Metal_Code2;
  Self.Metal_Code2.Text := MatLookup(Self.Metal_Code2);

  Self.Metal_Code1.tag := CustItem.Metal_Code1;
  Self.Metal_Code1.Text := MatLookup(Self.Metal_Code1);

  Self.Ink_Code.tag := CustItem.Ink_Code;
  Self.Ink_Code.Text := MatLookup(Self.Ink_Code);

  Self.Other_Material.Text := FastFuncs.IntToStr(CustItem.Other_Material);
  Self.MetalTotalCost1.Text := currstring(CustItem.MetalTotalCost1);
  Self.Unit_Cost_Inc.Text := currstring(CustItem.Unit_Cost_Inc);
  Self.MetalTotalCost2.Text := currstring(CustItem.MetalTotalCost2);
  Self.Ink_Tot_Cost.Text := currstring(CustItem.Ink_Tot_Cost);
  Self.Brd_Qty3.Text := FastFuncs.IntToStr(CustItem.Brd_Qty3);
  Self.Brd_Qty2.Text := FastFuncs.IntToStr(CustItem.Brd_Qty2);
  Self.Brd_Qty1.Text := FastFuncs.IntToStr(CustItem.Brd_Qty1);
  Self.Inked_PC.Text := FloatToStr(CustItem.Inked_PC);
  Self.NUM_UPL.Text := FastFuncs.IntToStr(CustItem.NUM_UPL);
  Self.Qty2.Text := FastFuncs.IntToStr(CustItem.Qty2);
  Self.Qty1.Text := FastFuncs.IntToStr(CustItem.Qty1);
  Self.Gap.Text := FastFuncs.IntToStr(CustItem.Gap);
  Self.NUM_UPW.Text := FastFuncs.IntToStr(CustItem.NUM_UPW);
  Self.Qty3.Text := FastFuncs.IntToStr(CustItem.Qty3);
  Self.Area.Text := currpercent(CustItem.Area);
  Self.Brd_Size_L3.Text := FastFuncs.IntToStr(CustItem.Brd_Size_L3);
  Self.Brd_Size_L2.Text := FastFuncs.IntToStr(CustItem.Brd_Size_L2);
  Self.Cost_Art.Text := currstring(CustItem.Cost_Art);
  Self.Cost_Tooling.Text := currstring(CustItem.Cost_Tooling);
  Self.Cost_Film.Text := currstring(CustItem.Cost_Film);
  Self.Unit_Cost_Ex.Text := currstring(CustItem.Unit_Cost_Ex);
  Self.Total_Inc_S.Text := currstring(CustItem.Total_Inc_S);
  Self.Metal_Price2.Text := currstring(CustItem.Metal_Price2);
  Self.Price3.Text := currstring(CustItem.Price3);
  Self.Other_Mat_Cost.Text := currstring(CustItem.Other_Mat_Cost);

  Self.Unit_Cost_Ex_S.Text := currstring(CustItem.Unit_Cost_Ex_S);
  Self.Unit_Cost_Inc_S.Text := currstring(CustItem.Unit_Cost_Inc_S);

  Self.Mat_Tot_Cost.Text := currstring(CustItem.Mat_Tot_Cost);

  Self.Total_ExTax.Text := currstring(CustItem.Total_ExTax);
  Self.Total_ExTax_S.Text := currstring(CustItem.Total_ExTax_S);
  Self.Tax_Amount_S.Text := currstring(CustItem.Tax_Amount_S);
  Self.Total_Inc_S.Text := currstring(CustItem.Total_Inc_S);

  Self.Ink_Price.Text := currstring(CustItem.Ink_Price);
  Self.Brd_Price3.Text := currstring(CustItem.Brd_Price3);
  Self.Brd_Price2.Text := currstring(CustItem.Brd_Price2);
  Self.Brd_Price1.Text := currstring(CustItem.Brd_Price1);
  Self.Metal_Price1.Text := currstring(CustItem.Metal_Price1);
  Self.Price2.Text := currstring(CustItem.Price2);
  Self.Price1.Text := currstring(CustItem.Price1);
  Self.Tax_Amount_S.Text := currstring(CustItem.Tax_Amount_S);
  Self.Markup_PC.Text := currpercent(CustItem.Markup_PC);
  Self.Mat_Markup_PC.Text := currpercent(CustItem.Mat_Markup_PC);
  Self.Markup_Tax.Text := currpercent(CustItem.Markup_Tax);
  Self.Mach_Cost_Hr.Text := currstring(CustItem.Mach_Cost_Hr);
  Self.Prints_Hr.Text := FastFuncs.IntToStr(CustItem.Prints_Hr);
  Self.Num_Up.Text := FastFuncs.IntToStr(CustItem.Num_Up);
  Self.Colour_lbl.Text := FastFuncs.IntToStr(CustItem.Colour_lbl);
  Self.Colours_pass.Text := FastFuncs.IntToStr(CustItem.Colours_pass);
  Self.Screen_Cost.Text := currstring(CustItem.Screen_Cost);
  Self.Setup_Cost.Text := currstring(CustItem.Setup_Cost);
  Self.Tot_Prn_Cost.Text := currstring(CustItem.Tot_Prn_Cost);
  Self.D_Setup_Cost.Text := currstring(CustItem.D_Setup_Cost);
  Self.D_Num_Up.Text := FastFuncs.IntToStr(CustItem.D_Num_Up);
  Self.Cost_Hr.Text := currstring(CustItem.Cost_Hr);
  Self.Imps_Hr.Text := FastFuncs.IntToStr(CustItem.Imps_Hr);
  Self.Tot_Die_Cost.Text := currstring(CustItem.Tot_Die_Cost);
  Self.BackSlit_Cost.Text := currstring(CustItem.BackSlit_Cost);
  Self.HandWork_Cost.Text := currstring(CustItem.HandWork_Cost);
  Self.Guillotine_Cost.Text := currstring(CustItem.Guillotine_Cost);
  Self.Pack_Cost.Text := currstring(CustItem.Pack_Cost);
  Self.Del_Cost.Text := currstring(CustItem.Del_Cost);
  Self.SubCon_Cost.Text := currstring(CustItem.SubCon_Cost);
  Self.E_Setup_Cost.Text := currstring(CustItem.E_Setup_Cost);
  Self.CutPVC_Cost.Text := currstring(CustItem.CutPVC_Cost);
  Self.CutBrd_Cost.Text := currstring(CustItem.CutBrd_Cost);
  Self.PreWeld_Cost.Text := currstring(CustItem.PreWeld_Cost);
  Self.Main_Weld_Up.Text := FastFuncs.IntToStr(CustItem.Main_Weld_Up);
  Self.Main_Welds_Day.Text := FastFuncs.IntToStr(CustItem.Main_Welds_Day);
  Self.Mach_Cost_Day.Text := currstring(CustItem.Mach_Cost_Day);
  Self.Weld_Cost.Text := currstring(CustItem.Weld_Cost);
  Self.Post_Weld_Cost.Text := currstring(CustItem.Post_Weld_Cost);
  Self.Tot_Weld_Cost.Text := currstring(CustItem.Tot_Weld_Cost);
  Self.Rivet_Cost.Text := currstring(CustItem.Rivet_Cost);
  Self.WorkTot_Cost.Text := currstring(CustItem.WorkTot_Cost);
  Self.Notes.Text := CustItem.Notes;
  Self.Prod_Qty.Text := FastFuncs.IntToStr(CustItem.Prod_Qty);
  Self.Prod_Qty_Qt.Text := FastFuncs.IntToStr(CustItem.Prod_Qty_Qt);
  Self.Prod_Overs.Text := FastFuncs.IntToStr(CustItem.Prod_Overs);
  Self.Num_UPT.Text := FastFuncs.IntToStr(CustItem.Num_UPT);
  Self.Lays_Brd.Text := FastFuncs.IntToStr(CustItem.Lays_Brd);
  Self.Rivets.Text := FastFuncs.IntToStr(CustItem.Rivets);
  Self.Slit_YN.Checked := CustItem.Slit_YN;
end;

procedure TAcmeInputGUI.PopulateCombos(Desc: TStringList);
begin
  Self.MT_Key1.Items := Desc;
  Self.MT_Key2.Items := Desc;
  Self.Mt_key3.Items := Desc;
  Self.Brd_code1.Items := Desc;
  Self.Brd_Code2.Items := Desc;
  Self.Brd_Code3.Items := Desc;
  Self.Ink_Code.Items := Desc;
  Self.Metal_code1.Items := Desc;
  Self.Metal_Code2.Items := Desc;
end;

procedure TAcmeInputGUI.PriceUpdate;
begin
  CustItem.Price1 := StrToCurr(GetPrice(MT_KEY1.tag));
  Price1.Text := currstring(CustItem.Price1);
  CustItem.Price2 := StrToCurr(GetPrice(MT_KEY2.tag));
  Price2.Text := currstring(CustItem.Price2);
  CustItem.Price3 := StrToCurr(GetPrice(MT_KEY3.tag));
  Price3.Text := currstring(CustItem.Price3);
  CustItem.Brd_Price1 := StrToCurr(GetPrice(BRD_Code1.tag));
  Brd_Price1.Text := currstring(CustItem.BRD_Price1);
  CustItem.BRD_Price2 := StrToCurr(GetPrice(BRD_Code2.tag));
  BRD_Price2.Text := currstring(CustItem.BRD_Price2);
  CustItem.BRD_Price3 := StrToCurr(GetPrice(BRD_Code3.tag));
  BRD_Price3.Text := currstring(CustItem.BRD_Price3);
  CustItem.Ink_Price := StrToCurr(GetPrice(Ink_Code.tag));
  Ink_Price.Text := currstring(CustItem.Ink_Price);
  CustItem.Metal_Price1 := StrToCurr(GetPrice(Metal_Code1.tag));
  Metal_Price1.Text := currstring(CustItem.Metal_Price1);
  CustItem.Metal_Price2 := StrToCurr(GetPrice(Metal_Code2.tag));
  Metal_Price2.Text := currstring(CustItem.Metal_Price2);
end;


procedure TAcmeInputGUI.BitBtn2Click(Sender: TObject);
begin
  UpdateObject;
  CustItem.MaterialCalc;
  DisplayObject;
end;

procedure TAcmeInputGUI.BitBtn1Click(Sender: TObject);
begin
  UpdateObject;
  PriceUpdate;
  DisplayObject;
end;

procedure TAcmeInputGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbIgnoreAccessLevels := true;
  CustItem := tdaCustomPrintItem.Create(nil);
  //load the combo boxes with materials.
  MTDesc := TStringList.Create;
  MT_KeyID := TStringList.Create;
  MTPrice := TStringList.Create;
  CustItem.LoadDescPrice(MTDesc, MT_KeyID, MTPrice);
  PopulateCombos(MTDesc);
end;

procedure TAcmeInputGUI.BitBtn4Click(Sender: TObject);
begin
  inherited;
  UpdateObject;
  CustItem.ProductionCalc;
  DisplayObject;
end;

procedure TAcmeInputGUI.FormShow(Sender: TObject);
begin
  inherited;
  {CustItem.Key := Self.SaleId;}
  CustItem.ID := Self.SaleId;
  CustItem.XML := Self.CustomData;
  CustItem.Key := StrToIntDef(Key.Text, 0);
  //  CustItem.LoadCustomData(CustItem);
  CustItem.Active := true;

  PageControl1.ActivePage := tabMaterial;
  DisplayObject;
  CustItem.Dirty := false;
end;

procedure TAcmeInputGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(MTDesc);
  FreeAndNil(MT_KeyID);
  Action := caFree;
  //notify; // no need at this stage
  frmAcmeInputGUI := nil;
end;

procedure TAcmeInputGUI.FormPaint(Sender: TObject);
begin
  inherited;
  //DisplayObject;
end;

procedure TAcmeInputGUI.Size_WC_Enter(Sender: TObject);
begin
  //press sheet width calc
  Size1_Wc.Text := FastFuncs.IntToStr(StrToIntDef(Size1_Wf.Text, 0) * StrToIntDef(Num_Upw.Text, 0) +
    ((StrToIntDef(Num_Upw.Text, 0) - 1) * StrToIntDef(Gap.Text, 0)) + StrToIntDef(Grip.Text, 0));
end;

procedure TAcmeInputGUI.Size_LC_Enter(Sender: TObject);
begin
  //Press sheet length calc
  Size1_Lc.Text := FastFuncs.IntToStr(StrToIntDef(Size1_Lf.Text, 0) * StrToIntDef(Num_upl.Text, 0) +
    ((StrToIntDef(Num_upl.Text, 0) - 1) * StrToIntDef(Gap.Text, 0)) + StrToIntDef(Lay.Text, 0));
end;

procedure TAcmeInputGUI.Unit_Cost_Ex_S_OnExit(Sender: TObject);
begin
  inherited;
  //calc say prices
  if StrToFloat(Markup_Tax.Text) <> 10 then Markup_Tax.Text := '10';
  CustItem.Markup_Tax := 10;
  Total_ExTax_S.Text := currstring(StrToIntDef(qty.Text, 0) * strvalue(Unit_Cost_Ex_S.Text));   //original src code.
  Tax_Amount_S.Text := CurrString((strvalue(Total_ExTax_S.Text) + strvalue(Cost_Art.Text) +
    strvalue(Cost_Film.Text) + strvalue(Cost_Tooling.Text)) * (strvalue(Markup_Tax.Text) / 100));
  Total_Inc_S.Text := CurrString(strvalue(Total_ExTax_S.Text) + strvalue(Tax_Amount_S.Text) +
    strvalue(Cost_Art.Text) + strvalue(Cost_Film.Text) + strvalue(Cost_Tooling.Text));
  Unit_Cost_Inc_S.Text := CurrString(strvalue(Total_ExTax_S.Text) * (1 + (strvalue(Markup_Tax.Text) / 100)) /
    StrToIntDef(qty.Text, 0));
  //Me.Parent.LIST_BREAKS.Requery
end;

procedure TAcmeInputGUI.UpdateLabel(Sender: TObject);
begin
  if NUM_UPW.Text = '' then NUM_UPW.Text := '0';
  if NUM_UPL.Text = '' then NUM_UPL.Text := '0';
  LblNum_UPT.Caption := FastFuncs.IntToStr(StrToIntDef(NUM_UPW.Text, 0) * StrToIntDef(NUM_UPL.Text, 0));
  IsDirty(Sender);
end;


procedure TAcmeInputGUI.MT_Key1_OnExit(Sender: TObject);
begin
  UpdateTag(MT_KEY1);
  //copy in price from Combo box lookup
  CustItem.Price1 := StrToCurr(GetPrice(MT_KEY1.tag));
  Price1.Text := currstring(CustItem.Price1);
end;

procedure TAcmeInputGUI.MT_Key2_OnExit(Sender: TObject);
begin
  UpdateTag(MT_KEY2);
  //copy in price from Combo box lookup
  CustItem.Price2 := StrToCurr(GetPrice(MT_KEY2.tag));
  Price2.Text := currstring(CustItem.Price2);
end;

procedure TAcmeInputGUI.MT_Key3_OnExit(Sender: TObject);
begin
  UpdateTag(MT_KEY3);
  //copy in price from Combo box lookup
  CustItem.Price3 := StrToCurr(GetPrice(MT_KEY3.tag));
  Price3.Text := currstring(CustItem.Price3);
end;

procedure TAcmeInputGUI.Brd_Code1_OnExit(Sender: TObject);
begin
  UpdateTag(BRD_CODE1);
  //copy in price from Combo box lookup
  CustItem.Brd_Price1 := StrToCurr(GetPrice(BRD_CODE1.tag));
  Brd_Price1.Text := currstring(CustItem.Brd_Price1);
end;

procedure TAcmeInputGUI.Brd_Code2_OnExit(Sender: TObject);
begin
  UpdateTag(BRD_CODE2);
  //copy in price from Combo box lookup
  CustItem.Brd_Price2 := StrToCurr(GetPrice(BRD_CODE2.tag));
  Brd_Price2.Text := currstring(CustItem.Brd_Price2);
end;

procedure TAcmeInputGUI.Brd_Code3_OnExit(Sender: TObject);
begin
  UpdateTag(BRD_CODE3);
  //copy in price from Combo box lookup
  CustItem.Brd_Price3 := StrToCurr(GetPrice(BRD_CODE3.tag));
  Brd_Price3.Text := currstring(CustItem.Brd_Price3);
end;

procedure TAcmeInputGUI.Ink_Code_OnExit(Sender: TObject);
begin
  UpdateTag(INK_CODE);
  //copy in price from Combo box lookup
  CustItem.Ink_Price := StrToCurr(GetPrice(INK_CODE.tag));
  Ink_Price.Text := currstring(CustItem.Ink_Price);
end;

procedure TAcmeInputGUI.Metal_Code1_OnExit(Sender: TObject);
begin
  UpdateTag(METAL_CODE1);
  //copy in price from Combo box lookup
  CustItem.Metal_Price1 := StrToCurr(GetPrice(METAL_CODE1.tag));
  Metal_Price1.Text := currstring(CustItem.Metal_Price1);
end;

procedure TAcmeInputGUI.Metal_Code2_OnExit(Sender: TObject);
begin
  UpdateTag(METAL_CODE2);
  //copy in price from Combo box lookup
  CustItem.Metal_Price2 := StrToCurr(GetPrice(METAL_CODE2.tag));
  Metal_Price2.Text := currstring(CustItem.Metal_Price2);
end;

procedure TAcmeInputGUI.Num_Up_Enter(Sender: TObject);
begin
  if (Num_Up.Text = '0') or (Num_Up.Text = '') then Num_Up.Text := Num_Upt.Text;
end;


procedure TAcmeInputGUI.CurrencyExit(Sender: TObject);
begin
  TEdit(Sender).Text := CurrString(strvalue(TEdit(Sender).Text));
end;

procedure TAcmeInputGUI.BitBtn3Click(Sender: TObject);
begin
  UpdateObject;
  CustItem.TotalCalc;
  DisplayObject;
end;

procedure TAcmeInputGUI.EnableDisableCalcBtns(Sender: TObject);
begin
  if Mach_Cost_Hr.Text = '' then Mach_Cost_Hr.Text := '0';
  if Num_UPT.Text = '' then Num_UPT.Text := '0';
  if Num_UP.Text = '' then Num_UP.Text := '0';
  if Qty.Text = '' then Qty.Text := '0';

  if (StrToIntDef(Qty.Text, 0) > 0) then begin
    BitBtn3.Enabled := true;
  end;
  if (strvalue(Mach_Cost_Hr.Text) > 0) and (StrToIntDef(Num_UPT.Text, 0) > 0) and (StrToIntDef(Num_UP.Text, 0) > 0) and
    (StrToIntDef(Qty.Text, 0) > 0) then begin
    BitBtn4.Enabled := true;
  end else begin
    BitBtn4.Enabled := false;
  end;
  IsDirty(Sender);
end;


procedure TAcmeInputGUI.CmdCancelClick(Sender: TObject);
var
  iExitResult: integer;
begin
  if CustItem.Dirty and cmdSave.Enabled then begin
    iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made ?', mtConfirmation,
      [mbYes, mbNo, mbCancel], 0);
    case iExitResult of
      mrYes:
        begin
          cmdSave.Click;
        end;
      mrNo:
        begin
          Self.Close;
        end;
      mrCancel: Exit;
    end;
  end else begin
    Self.Close;
  end;
end;


procedure TAcmeInputGUI.cmdSaveClick(Sender: TObject);
begin
  UpdateObject;
  //  CustItem.SaveCustomData(CustItem);
  Self.Close;
end;

procedure TAcmeInputGUI.IsDirty(Sender: TObject);
begin
  CustItem.Dirty := true;
end;

function TAcmeInputGUI.GetTotalCost: currency;
begin
  UpdateObject;
  {calc production cost}
  CustItem.ProductionCalc;
  {calc material costs}
  CustItem.MaterialCalc;
  {Total ExTax - say price}
  Result := CustItem.Total_ExTax_S;
end;


function TAcmeInputGUI.GetPriceInc: currency;
begin
  Result := CustItem.Total_Inc_S;
end;

function TAcmeInputGUI.GetCustomData: string;
begin
  Result := CustItem.XML;
end;

procedure TAcmeInputGUI.SetCustomData(const stXML: string);
begin
  CustItem.XML := stXML;
end;



procedure TAcmeInputGUI.tabProductionEnter(Sender: TObject);
begin
  inherited;
  Prod_Qty.Text := Qty.Text;
  Prod_Overs.Text := Overs.Text;
  Num_UPT.Text := Num_UPW.Text;
end;

initialization
  RegisterClassOnce(TAcmeInputGUI);
end.

