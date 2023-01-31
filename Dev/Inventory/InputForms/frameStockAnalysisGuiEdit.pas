unit frameStockAnalysisGuiEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frameGuiElementEdit, ExtCtrls, StdCtrls, DNMPanel, DNMSpeedButton,
  wwclearbuttongroup, wwradiogroup , IntegerListObj, CheckLst, GuiPrefsObj,
  Grids, Wwdbigrd, Wwdbgrid, Buttons, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents;

type
  TfrStockAnalysisGuiEdit = class(TfrGuiElementEdit)
    pnlmain: TDNMPanel;
    DNMPanel6: TDNMPanel;
    Label5: TLabel;
    DNMPanel7: TDNMPanel;
    pnlReportduration: TDNMPanel;
    Label3: TLabel;
    optREportduration: TwwRadioGroup;
    lstGridColumns: TCheckListBox;
    Shape2: TShape;
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    Label1: TLabel;
    lblProducts: TLabel;
    chkAllProducts: TCheckBox;
    btnchooseproducts: TDNMSpeedButton;
    btnSelectall: TDNMSpeedButton;
    DNMPanel4: TDNMPanel;
    pnlapplyto: TDNMPanel;
    lblApplyto: TLabel;
    edtAvailable: TEdit;
    optApplyTo: TwwRadioGroup;
    edtinstock: TEdit;
    Label6: TLabel;
    optIncreaseDecrease: TwwRadioGroup;
    optPercentageQty: TwwRadioGroup;
    pnlStatencountry: TDNMPanel;
    Label4: TLabel;
    lblcountyrnstate: TLabel;
    chkAllStatenCountries: TCheckBox;
    btnAllStatenCountries: TDNMSpeedButton;
    edtSOQtyPeercent: TEdit;
    pnlclass: TDNMPanel;
    Label2: TLabel;
    lblClasses: TLabel;
    chkAllClasses: TCheckBox;
    btnChooseclasses: TDNMSpeedButton;
    Shape3: TShape;
    procedure chkAllProductsClick(Sender: TObject);
    procedure chkAllClassesClick(Sender: TObject);
    procedure btnChooseProductsClick(Sender: TObject);
    procedure btnChooseclassesClick(Sender: TObject);
    procedure optReportDurationClick(Sender: TObject);
    procedure lstGridColumnsClickCheck(Sender: TObject);
    procedure btnSelectallClick(Sender: TObject);
    procedure optIncreaseDecreaseClick(Sender: TObject);
    procedure optPercentageQtyClick(Sender: TObject);
    procedure optApplyToClick(Sender: TObject);
    procedure edtSOQtyPeercentKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure edtAvailableKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure edtSOQtyPeercentExit(Sender: TObject);
    procedure edtAvailableExit(Sender: TObject);
    procedure edtAvailableEnter(Sender: TObject);
    procedure edtinstockEnter(Sender: TObject);
    procedure edtinstockExit(Sender: TObject);
    procedure edtinstockKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAllStatenCountriesClick(Sender: TObject);
    procedure chkAllStatenCountriesClick(Sender: TObject);
  private
    FsPartsIDs:TIntegerlist;
    FsClassIDs:TIntegerlist;

    function StockAnalysisGuiElement: TStockAnalysisGuiElement;
    procedure onclassselct(Sender: TwwDBGrid);
    procedure onProductselect(Sender: TwwDBGrid);
    Procedure RefreshCounts;
    Procedure RefreshStatenCountries;
    procedure onCountrynStateselect(Sender: TwwDBGrid);
    procedure intCountrynStateselect(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy;Override;
    procedure DisplayGuiSettings(fUserID:Integer =0); Override;
  end;
implementation

uses CommonFormLib, CommonLib, tcConst, AppEnvironment, salesAnalysisLib,
  CommonDbLib,  ClientStatencounties;

{$R *.dfm}

{ TfrStockAnalysisGuiEdit }
destructor TfrStockAnalysisGuiEdit.Destroy;
begin
    Freeandnil(FsPartsIDs);
    Freeandnil(FsClassIDs);
  inherited;
end;

procedure TfrStockAnalysisGuiEdit.DisplayGuiSettings(fUserID: Integer);
var
  ctr:Integer;
begin
  inherited;
  if assigned(EditGuiPrefsForm) and (StockAnalysisGuiElement<> nil) then begin
    With StockAnalysisGuiElement do begin
      if Node.Exists(NodeName_Options+'.'+NodeName_SelectedParts)             then FsPartsIDs.Commatext         := Node[NodeName_Options+'.'+NodeName_SelectedParts].AsString;
      if Node.Exists(NodeName_Options+'.'+NodeName_SelectedClasses)           then FsClassIDs.Commatext         := Node[NodeName_Options+'.'+NodeName_SelectedClasses].AsString;
      if Node.Exists(NodeName_Options+'.'+NodeName_AllProducts)               then chkAllProducts.checked       := Node[NodeName_Options+'.'+NodeName_AllProducts].asBoolean;
      if Node.Exists(NodeName_Options+'.'+NodeName_AllClasses)                then chkAllClasses.checked        := Node[NodeName_Options+'.'+NodeName_AllClasses].asBoolean;
      if Node.Exists(NodeName_Options+'.'+NodeName_ReportDuration)            then optReportDuration.ItemIndex  := Node[NodeName_Options+'.'+NodeName_ReportDuration].asInteger;
      if Node.Exists(NodeName_Options+'.'+NodeName_IncreaseDecrease)          then optIncreaseDecrease.ItemIndex:= Node[NodeName_Options+'.'+NodeName_IncreaseDecrease].asInteger;
      if Node.Exists(NodeName_Options+'.'+NodeName_PercentageQty)             then optPercentageQty.ItemIndex   := Node[NodeName_Options+'.'+NodeName_PercentageQty].asInteger;
      if Node.Exists(NodeName_Options+'.'+NodeName_ApplyTo)                   then optApplyTo.ItemIndex         := Node[NodeName_Options+'.'+NodeName_ApplyTo].asInteger;
      if Node.Exists(NodeName_Options+'.'+NodeName_SOQtyPeercent)             then edtSOQtyPeercent.Text        := FloattoStr(Node[NodeName_Options+'.'+NodeName_SOQtyPeercent].AsFloat);
      if Node.Exists(NodeName_Options+'.'+NodeName_Available)                 then edtAvailable.Text            := FloattoStr(Node[NodeName_Options+'.'+NodeName_Available].AsFloat);
      if Node.Exists(NodeName_Options+'.'+NodeName_instock)                   then edtinstock.Text              := FloattoStr(Node[NodeName_Options+'.'+NodeName_instock].AsFloat);
      RefreshStatenCountries;
      edtAvailable.visible := optApplyTo.ItemIndex=0;
      edtinstock.visible   := optApplyTo.ItemIndex=1;

      for ctr := low(Transtypes) to high(Transtypes) do
        lstGridColumns.Checked[ctr-1] :=  Node.Exists(NodeName_Options+'.'+NodeName_TransType+'.'+nodename(Transtypes[ctr]))     and Node[NodeName_Options+'.'+NodeName_TransType+'.'+nodename(Transtypes[ctr])].asBoolean;
    end;
  end;
  Refreshcounts;
end;
procedure TfrStockAnalysisGuiEdit.btnAllStatenCountriesClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TClientStatencountiesGUI' , onCountrynStateselect, intCountrynStateselect, true)   ;
end;

procedure TfrStockAnalysisGuiEdit.RefreshStatenCountries;
var
  s:String;
  s1, s2:String;
begin
  if chkAllStatenCountries.Checked then
    lblcountyrnstate.Caption := ''
  else begin
    s:= Node[NodeName_Options+'.'+NodeName_StatenCountry].asString;
    s1:=copy(s , 1              , pos('-' , s)-1);
    s2:=copy(s , pos('-' , s)+1 , length(s)     );
    s:= '';
    if s1<> '' then s:='COUNTRY = ' + Quotedstr(s1);
    if s2<> '' then s:= s + iif(s<>'' , ' and ' , '')+ ' STATE =' + Quotedstr(s2);

    lblcountyrnstate.Caption :=s;
  end;

end;

procedure TfrStockAnalysisGuiEdit.edtSOQtyPeercentExit(Sender: TObject);
begin
  inherited;
  try
    Node[NodeName_Options+'.'+NodeName_SOQtyPeercent].asFloat                  := StrtoFloat(edtSOQtyPeercent.text);
  Except
    on E:Exception do begin
      if Node.Exists(NodeName_Options+'.'+NodeName_SOQtyPeercent) then
      edtSOQtyPeercent.text := Floattostr(Node[NodeName_Options+'.'+NodeName_SOQtyPeercent].asFloat )
      else edtSOQtyPeercent.text := '0';
    end;
  end;
end;
procedure TfrStockAnalysisGuiEdit.edtAvailableEnter(Sender: TObject);
begin
  inherited;
  if optApplyTo.itemindex <> 0 then SetControlFocus(optApplyTo);
end;

procedure TfrStockAnalysisGuiEdit.edtAvailableExit(Sender: TObject);
begin
  inherited;
  try
    Node[NodeName_Options+'.'+NodeName_Available].asFloat                  := StrtoFloat(edtAvailable.text);
  Except
    on E:Exception do begin
      if Node.Exists(NodeName_Options+'.'+NodeName_Available) then
      edtAvailable.text := Floattostr(Node[NodeName_Options+'.'+NodeName_Available].asFloat )
      else edtAvailable.text := '0';
    end;
  end;
end;

procedure TfrStockAnalysisGuiEdit.lstGridColumnsClickCheck(Sender: TObject);
var
  s:String;
  ctr:Integer;
begin
  inherited;
  if lstGridColumns.ItemIndex = -1 then exit;
  s:= lstGridColumns.items[lstGridColumns.itemindex];
  for ctr := low(Transtypes) to high(Transtypes) do
    if sametext(s, Transtypes[ctr]    ) then begin
      Node[NodeName_Options+'.'+NodeName_TransType+'.'+nodename(Transtypes[ctr])].asBoolean      := lstGridColumns.Checked[lstGridColumns.itemindex];
      break;
    end;
end;

Function TfrStockAnalysisGuiEdit.StockAnalysisGuiElement : TStockAnalysisGuiElement;
var
  x: integer;
begin
  result := nil;
  if not (assigned(EditGuiPrefsForm.FormGuiPrefs)) then exit;
  with EditGuiPrefsForm.FormGuiPrefs do begin
  for x := 0 to Elements.Count - 1 do
    if Elements[x] is TStockAnalysisGuiElement then begin
      result :=TStockAnalysisGuiElement(Elements[x]);
      exit;
    end;
  end;
end;

procedure TfrStockAnalysisGuiEdit.edtSOQtyPeercentKeyUp(Sender: TObject;var Key: Word; Shift: TShiftState);begin  inherited;  if not(IsNumber(trim(edtSOQtyPeercent.text)+chr(Key))) then Key :=0;end;
procedure TfrStockAnalysisGuiEdit.edtAvailableKeyUp    (Sender: TObject;var Key: Word; Shift: TShiftState);begin  inherited;  if not(IsNumber(trim(edtAvailable.text)    +chr(Key))) then Key :=0;end;

procedure TfrStockAnalysisGuiEdit.edtinstockEnter(Sender: TObject);
begin
  inherited;
  if optApplyTo.itemindex <> 1 then SetControlFocus(optApplyTo);
end;

procedure TfrStockAnalysisGuiEdit.edtinstockExit(Sender: TObject);
begin
  inherited;
  try
    Node[NodeName_Options+'.'+NodeName_instock].asFloat                  := StrtoFloat(edtinstock.text);
  Except
    on E:Exception do begin
      if Node.Exists(NodeName_Options+'.'+NodeName_instock) then
      edtinstock.text := Floattostr(Node[NodeName_Options+'.'+NodeName_instock].asFloat )
      else edtinstock.text := '0';
    end;
  end;

end;
procedure TfrStockAnalysisGuiEdit.onCountrynStateselect(Sender: TwwDBGrid);
begin
  lblcountyrnstate.Caption := '';
  Node[NodeName_Options+'.'+NodeName_StatenCountry].asString   :='';
  try
      if Sender.Datasource.DataSet.FieldByName('country').asString <> '' then
        Node[NodeName_Options+'.'+NodeName_StatenCountry].asString   :=Sender.Datasource.DataSet.FieldByName('country').asString;
      Node[NodeName_Options+'.'+NodeName_StatenCountry].asString  := Node[NodeName_Options+'.'+NodeName_StatenCountry].asString  +'-';
      if Sender.Datasource.DataSet.FieldByName('State').asString <> '' then
        Node[NodeName_Options+'.'+NodeName_StatenCountry].asString   :=Node[NodeName_Options+'.'+NodeName_StatenCountry].asString +Sender.Datasource.DataSet.FieldByName('State').asString;
  finally
    chkAllStatenCountries.Checked :=Node[NodeName_Options+'.'+NodeName_StatenCountry].asString  = '';
    RefreshStatenCountries;
  end;
end;
procedure TfrStockAnalysisGuiEdit.intCountrynStateselect(Sender: TObject);
begin
  if sender is TClientStatencountiesGUI then begin
    TClientStatencountiesGUI(Sender).StatenCountry :=Node[NodeName_Options+'.'+NodeName_StatenCountry].asString;
  end;
end;

procedure TfrStockAnalysisGuiEdit.edtinstockKeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);begin  inherited;if not(IsNumber(trim(edtinstock.text)    +chr(Key))) then Key :=0;end;
procedure TfrStockAnalysisGuiEdit.onclassselct   (Sender: TwwDBGrid);begin  CommonLib.SelectedIDs(Sender, 'ClassId', FsClassIDs, True);Node[NodeName_Options+'.'+NodeName_SelectedClasses].asString := FsClassIDs.commatext; chkAllClasses.checked := FsClassIDs.commatext=''; RefreshCounts;end;
procedure TfrStockAnalysisGuiEdit.onProductselect(Sender: TwwDBGrid);begin  CommonLib.SelectedIDs(Sender, 'PartsId', FsPartsIDs, True);Node[NodeName_Options+'.'+NodeName_SelectedParts].asString   := FsPartsIDs.commatext; chkAllProducts.checked:= FsPartsIDs.commatext='';RefreshCounts;end;
procedure TfrStockAnalysisGuiEdit.btnChooseclassesClick   (Sender: TObject);begin  OpenERPListFormultiselectModal('TClassExpressListGUI'   , nil , onclassselct)      ;end;
procedure TfrStockAnalysisGuiEdit.btnChooseProductsClick  (Sender: TObject);begin  OpenERPListFormultiselectModal('TProductListExpressGUI' , nil , onProductselect)   ;end;

procedure TfrStockAnalysisGuiEdit.chkAllClassesClick        (Sender: TObject);begin  Node[NodeName_Options+'.'+NodeName_AllClasses].asBoolean               := chkAllClasses.checked        ;RefreshCounts;end;
procedure TfrStockAnalysisGuiEdit.chkAllStatenCountriesClick(Sender: TObject);begin  Node[NodeName_Options+'.'+NodeName_AllStatenCountries].asBoolean       := chkAllStatenCountries.checked        ;RefreshCounts;end;

procedure TfrStockAnalysisGuiEdit.chkAllProductsClick     (Sender: TObject);begin  Node[NodeName_Options+'.'+NodeName_AllProducts].asBoolean              := chkAllProducts.checked       ;RefreshCounts;end;
procedure TfrStockAnalysisGuiEdit.optReportDurationClick  (Sender: TObject);begin  Node[NodeName_Options+'.'+NodeName_ReportDuration].asInteger           := optReportDuration.ItemIndex  ;end;
procedure TfrStockAnalysisGuiEdit.optIncreaseDecreaseClick(Sender: TObject);begin  Node[NodeName_Options+'.'+NodeName_IncreaseDecrease].asInteger         := optIncreaseDecrease.ItemIndex;end;
procedure TfrStockAnalysisGuiEdit.optPercentageQtyClick   (Sender: TObject);begin  Node[NodeName_Options+'.'+NodeName_PercentageQty].asInteger            := optPercentageQty.ItemIndex   ;end;

procedure TfrStockAnalysisGuiEdit.optApplyToClick         (Sender: TObject);
begin
  Node[NodeName_Options+'.'+NodeName_ApplyTo].asInteger                  := optApplyTo.ItemIndex      ;
  edtAvailable.visible := optApplyTo.ItemIndex=0;
  edtinstock.visible   := optApplyTo.ItemIndex=1;
end;

procedure TfrStockAnalysisGuiEdit.RefreshCounts;
begin
  if not(chkAllClasses.checked)  and (FsClassIDs.count = 0) then chkAllClasses.checked :=  true;
  if not(chkAllProducts.checked) and (FsPartsIDs.count = 0) then chkAllProducts.checked:=  true;
  if chkAllProducts.checked then lblProducts.caption := '' else lblProducts.caption := inttostr(FsPartsIDs.count)+' '(*+ AppEnv.DefaultClass.PartColumn*)  +'Product(s) ' +'Selected';(*lblProducts.visible := not(chkAllProducts.checked);*)
  if chkAllClasses.checked  then lblClasses.caption  := '' else lblClasses.caption  := inttostr(FsClassIDs.count)+' '+ AppEnv.DefaultClass.ClassHeading +'(s) ' +'Selected';(*lblClasses.visible := not(chkAllClasses.checked);*)
end;

constructor TfrStockAnalysisGuiEdit.Create(AOwner: TComponent);
var
  ctr:Integer;
begin
  inherited;
  lstGridColumns.items.clear;
  for ctr := low(Transtypes) to high(Transtypes) do
    lstGridColumns.items.add(Transtypes[ctr]);


  FsPartsIDs:= TIntegerlist.create;
  FsClassIDs:= TIntegerlist.create;
  TabsheetIndex := 0;
  //pnlapplyto.height := 160;
  //optApplyTo.height := 145;
  //pnlReportduration.height := 57;
  //lstGridColumns.height := 270;
  //pnlclass.width :=pnlStatencountry.width;
  for ctr := 0 to componentcount-1 do
         if components[ctr] is TCheckbox then TCheckbox(components[ctr]).color := Self.color
    else if components[ctr] is TLabel then TLabel(components[ctr]).color := Self.color
    else if components[ctr] is TDnMSpeedbutton then TDnMSpeedbutton(components[ctr]).color := Self.color
    else if components[ctr] is TCheckListbox then TCheckListbox(components[ctr]).color := Self.color
    else if components[ctr] is TwwRadioGroup then TwwRadioGroup(components[ctr]).color := Self.color
end;
procedure TfrStockAnalysisGuiEdit.btnSelectallClick(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  for ctr := 0 to lstGridColumns.items.count-1 do begin
    lstGridColumns.Checked[ctr] := True;
    lstGridColumns.ItemIndex := ctr;
    lstGridColumnsClickCheck(lstGridColumns);
  end;
end;

initialization
  RegisterClassOnce(TfrStockAnalysisGuiEdit);

end.
