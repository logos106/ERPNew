unit frmTreeProductSepc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DNMSpeedButton, Shader, StdCtrls, Mask, wwdbedit,
  ExtCtrls, DNMPanel, SelectionDialog, Menus , TreeFrame, Grids, Wwdbigrd,
  Wwdbgrid , BusobjProductFormula, BaseInputForm, ProgressDialog, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts;

type
  TFormulaQtytype = (fqtTotal=1, fqtFromstock=2, fqtBuild = 3, fqtOnOrder =4);

  TfmTreeProductSepc = class(TBaseInputGUI)
    pnlHeader: TDNMPanel;
    Label1: TLabel;
    edtProductName: TEdit;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    btnok: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    pnl5: TDNMPanel;
    lbl5: TLabel;
    edt5: TEdit;
    pnl4: TDNMPanel;
    lbl4: TLabel;
    edt4: TEdit;
    pnl3: TDNMPanel;
    lbl3: TLabel;
    edt3: TEdit;
    pnl2: TDNMPanel;
    lbl2: TLabel;
    edt2: TEdit;
    pnl1: TDNMPanel;
    lbl1: TLabel;
    edt1: TEdit;
    DNMPanel4: TDNMPanel;
    DNMPanel7: TDNMPanel;
    lblQty: TLabel;
    edtQty: TEdit;
    DNMPanel8: TDNMPanel;
    lblFormula: TLabel;
    edtFormula: TEdit;
    DNMPanel9: TDNMPanel;
    lblProductName: TLabel;
    edtProduct: TEdit;
    lblMsg: TLabel;
    btnChooseformula: TDNMSpeedButton;
    Label2: TLabel;
    edtFormulaName: TEdit;
    lblformulaValue: TLabel;
    Label3: TLabel;
    edtFormulaWithValue: TEdit;
    cboLineNos: TComboBox;
    lblLineNo: TLabel;
    Label4: TLabel;
    edtcomments: TEdit;
    chkHide: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure OnchangeValue(Sender: TObject);
    procedure btnokClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SetfocusToEdit(Sender: TObject);
    procedure ValidateInput(Sender: TObject; var Key: Char);
    procedure btnChooseformulaClick(Sender: TObject);
    procedure cboLineNosKeyPress(Sender: TObject; var Key: Char);
    procedure edtcommentsDblClick(Sender: TObject);
    procedure chkHideClick(Sender: TObject);
  private
    fNodeData: PNodeData;
    fiformulaId :Integer;
    fdQty: Double;
    fFormulaQtytype: TformulaQtytype;
    fbIsTemplateTree: Boolean;
    fFormula :Tformula;
    fbonMultiSelectProduct: boolean;
    procedure setNodeData(const Value: PNodeData);
    procedure CalculateRelatedQty;
    procedure DoGetParserVariable(Sender: TObject; const VarName: string;var Value: extended; var FieldFound: Boolean);
    procedure LocateFormula(Sender: TObject);
    procedure Selectformula(Sender: TwwDbGrid);
    function FormulaWithValue: String;
    Function ProductDimension:String;
    Function getComments :String;
    procedure ShowFormulaValue;
    procedure UpdateComments(Sender: TwwDbGrid);
    procedure InitCommentsList(Sender: TObject);
    procedure setComments(const Value: String);
    procedure Initformulafields;
    function Formula :Tformula;

  public
    Constructor Create(AOwner:TComponent); Override;
    destructor Destroy; override;
    Property NodeData: PNodeData read fNodeData write setNodeData;
    Property FormulaQtytype : TformulaQtytype read fFormulaQtytype write fFormulaQtytype default fqtTotal;
    Property IsTemplateTree :Boolean read fbIsTemplateTree write fbIsTemplateTree;
    Property Comments :String read getComments write setComments;
    Property onMultiSelectProduct :boolean read fbonMultiSelectProduct write fbonMultiSelectProduct;
  end;


implementation

uses DbSharedObjectsObj, tcDataUtils, ParserLib,
  CommonLib, CommonFormLib, ProductformulaList, LogLib, InventoryLib,
  CommentsListFrm, CommentsLib, AppEnvironment;

{$R *.dfm}

{ TfmTreeProductSepc }

procedure TfmTreeProductSepc.FormCreate(Sender: TObject);
var
  FormulaEntry : TFormulaEntry;
begin
  inherited;
  FormulaEntry := TFormulaEntry.CreateWithNewConn(Self);
  try
    FormulaEntry.load;
    lbl1.Visible := False; edt1.Visible := False;
    lbl2.Visible := False; edt2.Visible := False;
    lbl3.Visible := False; edt3.Visible := False;
    lbl4.Visible := False; edt4.Visible := False;
    lbl5.Visible := False; edt5.Visible := False;

    if FormulaEntry.count >0 then begin FormulaEntry.first; lbl1.Visible := (FormulaEntry.FormulaEntryActive); edt1.Visible := (FormulaEntry.FormulaEntryActive); lbl1.caption := FormulaEntry.FormulaEntryName; end;
    if FormulaEntry.count >1 then begin FormulaEntry.Next ; lbl2.Visible := (FormulaEntry.FormulaEntryActive); edt2.Visible := (FormulaEntry.FormulaEntryActive); lbl2.caption := FormulaEntry.FormulaEntryName; end;
    if FormulaEntry.count >2 then begin FormulaEntry.Next ; lbl3.Visible := (FormulaEntry.FormulaEntryActive); edt3.Visible := (FormulaEntry.FormulaEntryActive); lbl3.caption := FormulaEntry.FormulaEntryName; end;
    if FormulaEntry.count >3 then begin FormulaEntry.Next ; lbl4.Visible := (FormulaEntry.FormulaEntryActive); edt4.Visible := (FormulaEntry.FormulaEntryActive); lbl4.caption := FormulaEntry.FormulaEntryName; end;
    if FormulaEntry.count >4 then begin FormulaEntry.Next ; lbl5.Visible := (FormulaEntry.FormulaEntryActive); edt5.Visible := (FormulaEntry.FormulaEntryActive); lbl5.caption := FormulaEntry.FormulaEntryName; end;
  finally
    FreeandNil(FormulaEntry);
  end;
end;

procedure TfmTreeProductSepc.FormShow(Sender: TObject);
begin
  inherited;
  SetControlfocus(edt1);
  ISFormshown := True;

    LineNumbers(cboLineNos);
    if (cboLineNos.Items.Count = 0)  then cboLineNos.text := '1'
    else begin
      if Nodedata.Data.BuildLineNo <> 0 then cboLineNos.itemindex := cboLineNos.Items.IndexOf(inttostr(Nodedata.Data.BuildLineNo))
      else cboLineNos.text := '1';
    end;

  Initformulafields;
  chkHide.visible := onMultiSelectProduct;
  chkHide.checked := not(Appenv.employee.OpenTreeFromSalesOrder);
  CalculateRelatedQty;
end;

procedure TfmTreeProductSepc.setNodeData(const Value: PNodeData);
begin
  fNodeData := Value;
  edtProductName.text := GetProduct(Value.Data.PARTSiD);
  edtProduct.text := edtProductName.text;
  if fNodeData.Data.FormulaId =0 then begin
    edtFormula.text := GetProductFormula(Value.Data.PARTSiD);
    edtFormulaName.text := edtFormula.text;
    fiformulaId  := GetProductFormulaID(Value.Data.PARTSiD);
    fNodeData.Data.FormulaId := fiformulaId;
  end  else begin
    edtFormula.text := getFormula(fNodeData.Data.FormulaId);
    edtFormulaName.text := edtFormula.text;
    fiformulaId := fNodeData.Data.FormulaId;
  end;

  edtFormulaWithValue.text := getFormulaName(fNodeData.Data.FormulaId);  //GetProductFormulaName(Value.Data.PARTSiD);
  fdQty := Value.Data.Quantity;

  if FormulaQtytype = fqtTotal then begin
    edt1.text := FloatToStrF(Nodedata.Data.FormulaQtyValue1, FFGeneral, 15,2);
    edt2.text := FloatToStrF(Nodedata.Data.FormulaQtyValue2, FFGeneral, 15,2);
    edt3.text := FloatToStrF(Nodedata.Data.FormulaQtyValue3, FFGeneral, 15,2);
    edt4.text := FloatToStrF(Nodedata.Data.FormulaQtyValue4, FFGeneral, 15,2);
    edt5.text := FloatToStrF(Nodedata.Data.FormulaQtyValue5, FFGeneral, 15,2);
    edtQty.text := FloatToStrF(Nodedata.Data.Quantity, FFGeneral, 15,2);
  end else if FormulaQtytype = fqtFromstock then begin
    edt1.text := FloatToStrF(Nodedata.Data.FormulaQtyValue1, FFGeneral, 15,2);
    edt2.text := FloatToStrF(Nodedata.Data.FormulaQtyValue2, FFGeneral, 15,2);
    edt3.text := FloatToStrF(Nodedata.Data.FormulaQtyValue3, FFGeneral, 15,2);
    edt4.text := FloatToStrF(Nodedata.Data.FormulaQtyValue4, FFGeneral, 15,2);
    edt5.text := FloatToStrF(Nodedata.Data.FormulaQtyValue5, FFGeneral, 15,2);
    edtQty.text := FloatToStrF(Nodedata.Data.FromStockQty, FFGeneral, 15,2);
  end else if FormulaQtytype = fqtBuild then begin
    edt1.text := FloatToStrF(Nodedata.Data.BuildFormulaQtyValue1, FFGeneral, 15,2);
    edt2.text := FloatToStrF(Nodedata.Data.BuildFormulaQtyValue2, FFGeneral, 15,2);
    edt3.text := FloatToStrF(Nodedata.Data.BuildFormulaQtyValue3, FFGeneral, 15,2);
    edt4.text := FloatToStrF(Nodedata.Data.BuildFormulaQtyValue4, FFGeneral, 15,2);
    edt5.text := FloatToStrF(Nodedata.Data.BuildFormulaQtyValue5, FFGeneral, 15,2);
    edtQty.text := FloatToStrF(Nodedata.Data.ManufactureQty, FFGeneral, 15,2);
  end else if FormulaQtytype = fqtOnOrder then begin
    edt1.text := FloatToStrF(Nodedata.Data.OrderFormulaQtyValue1, FFGeneral, 15,2);
    edt2.text := FloatToStrF(Nodedata.Data.OrderFormulaQtyValue2, FFGeneral, 15,2);
    edt3.text := FloatToStrF(Nodedata.Data.OrderFormulaQtyValue3, FFGeneral, 15,2);
    edt4.text := FloatToStrF(Nodedata.Data.OrderFormulaQtyValue4, FFGeneral, 15,2);
    edt5.text := FloatToStrF(Nodedata.Data.OrderFormulaQtyValue5, FFGeneral, 15,2);
    edtQty.text := FloatToStrF(Nodedata.Data.OnOrderQty, FFGeneral, 15,2);
  end;
  if Nodedata.Data.BuildLineNo <> 0 then cboLineNos.text := inttostr(Nodedata.Data.BuildLineNo);
  edtComments.text :=Nodedata.Data.Comments;
  ShowFormulaValue;
end;
Procedure TfmTreeProductSepc.ShowFormulaValue;
begin
  lblformulaValue.caption :=ProductDimension;//FormulaWithValue;
  lblformulaValue.REfresh;
end;
Function TfmTreeProductSepc.ProductDimension:String;
(*begin
  REsult := FormulaLib.ProductDimension(fiformulaId , strtoFloat(edt1.text), strtoFloat(edt2.text), strtoFloat(edt3.text), strtoFloat(edt4.text), strtoFloat(edt5.text));*)
  Function addtoResult(const curResult, Value: String; FEName:String):String;
  var
    sepStr: string;
  begin
    if sametext(FEName  , Appenv.CompanyPrefs.FeQtyField ) then      sepStr:=Appenv.CompanyPrefs.FeQtyFieldInfodisplayLabel +' ' else    sepStr:= ' x ';
    REsult := curResult;
    if trim(value) ='' then exit;
    if trim(REsult) <> '' then Result := Trim(Result)+ sepStr ;
    Result := Result + Value;
  end;

begin
  Result := '';
  if (Formula.FormulatypeId =0) or (Formula.FeFormulaType.Fe1visible) then Result :=addtoResult( result , Trim(edt1.text), Appenv.CompanyPrefs.Fe1Name);
  if (Formula.FormulatypeId =0) or (Formula.FeFormulaType.Fe2visible) then Result :=addtoResult( result , Trim(edt2.text), Appenv.CompanyPrefs.Fe2Name);
  if (Formula.FormulatypeId =0) or (Formula.FeFormulaType.Fe3visible) then Result :=addtoResult( result , Trim(edt3.text), Appenv.CompanyPrefs.Fe3Name);
  if (Formula.FormulatypeId =0) or (Formula.FeFormulaType.Fe4visible) then Result :=addtoResult( result , Trim(edt4.text), Appenv.CompanyPrefs.Fe4Name);
  if (Formula.FormulatypeId =0) or (Formula.FeFormulaType.Fe5visible) then Result :=addtoResult( result , Trim(edt5.text), Appenv.CompanyPrefs.Fe5Name);


end;
function TfmTreeProductSepc.Formula: Tformula;
begin
  if   fFormula = Nil then begin
      fFormula := TFormula.create(self);
      fFormula.load(fiformulaId);
  end;
  if fFormula.Id <> fiformulaId then fFormula.load(fiformulaId);
  result := fFormula;
end;

function TfmTreeProductSepc.FormulaWithValue: String;
begin
  Result := edtFormulaName.text;
  Result := ReplaceStr(Result , 'Field1', '[' + Trim(edt1.text)+']');
  Result := ReplaceStr(Result , 'Field2', '[' + Trim(edt2.text)+']');
  Result := ReplaceStr(Result , 'Field3', '[' + Trim(edt3.text)+']');
  Result := ReplaceStr(Result , 'Field4', '[' + Trim(edt4.text)+']');
  Result := ReplaceStr(Result , 'Field5', '[' + Trim(edt5.text)+']');
end;


procedure TfmTreeProductSepc.ValidateInput(Sender: TObject; var Key: Char);
begin
  inherited;
  if ((Key >= '0') and (Key <= '9')) or (Key = chr(VK_BACK)) or (Key = chr(VK_DELETE))  or (Key ='.') then else  Key := chr(0);
  if Key ='.' then if StringCount('.' , TEdit(Sender).Text) >0 then Key := chr(0);
end;

procedure TfmTreeProductSepc.CalculateRelatedQty;
var
  ErrMsg:String;
begin
  if (fiformulaId <>0) then begin
    fdQty := ParserValue(Self , DoGetParserVariable , edtFormula.text, errMsg);
    if errmsg <> '' then lblMsg.caption :=errmsg
    else  begin
      lblMsg.caption :='';
      edtQty.text := FloatToStrF(fdQty , ffGeneral, 15,2);
      ShowFormulaValue;
    end;
  end;
end;
destructor TfmTreeProductSepc.Destroy;
begin
  inherited;
end;

procedure TfmTreeProductSepc.btnokClick(Sender: TObject);
begin
  inherited;
  Nodedata.Data.FormulaId := fiformulaId;
  Nodedata.Data.PartCalcformula := edtFormulaName.text;
  if FormulaQtytype = fqtTotal then begin
    if edt1.text <> '' then Nodedata.Data.FormulaQtyValue1 := strTofloat(edt1.text) else Nodedata.Data.FormulaQtyValue1 := 0;
    if edt2.text <> '' then Nodedata.Data.FormulaQtyValue2 := strTofloat(edt2.text) else Nodedata.Data.FormulaQtyValue2 := 0;
    if edt3.text <> '' then Nodedata.Data.FormulaQtyValue3 := strTofloat(edt3.text) else Nodedata.Data.FormulaQtyValue3 := 0;
    if edt4.text <> '' then Nodedata.Data.FormulaQtyValue4 := strTofloat(edt4.text) else Nodedata.Data.FormulaQtyValue4 := 0;
    if edt5.text <> '' then Nodedata.Data.FormulaQtyValue5 := strTofloat(edt5.text) else Nodedata.Data.FormulaQtyValue5 := 0;
    Nodedata.Data.Quantity := fdQty;
    Nodedata.Data.Info := Nodedata.Data.caption + ' ' +ProductDimension + ' ' +Comments;//FormulaWithValue;
  end else if FormulaQtytype = fqtFromstock then begin
    if edt1.text <> '' then Nodedata.Data.FormulaQtyValue1 := strTofloat(edt1.text) else Nodedata.Data.FormulaQtyValue1 := 0;
    if edt2.text <> '' then Nodedata.Data.FormulaQtyValue2 := strTofloat(edt2.text) else Nodedata.Data.FormulaQtyValue2 := 0;
    if edt3.text <> '' then Nodedata.Data.FormulaQtyValue3 := strTofloat(edt3.text) else Nodedata.Data.FormulaQtyValue3 := 0;
    if edt4.text <> '' then Nodedata.Data.FormulaQtyValue4 := strTofloat(edt4.text) else Nodedata.Data.FormulaQtyValue4 := 0;
    if edt5.text <> '' then Nodedata.Data.FormulaQtyValue5 := strTofloat(edt5.text) else Nodedata.Data.FormulaQtyValue5 := 0;
    if Nodedata.Data.TreePartUOMTotalQty <fdQty then Nodedata.Data.TreePartUOMTotalQty  := fdQty;
    Nodedata.Data.FormulaQtyValue :=1;
    Nodedata.Data.FromStockQty := fdQty;
    Nodedata.Data.Info := Nodedata.Data.caption + ' ' +ProductDimension+ ' ' +Comments;//FormulaWithValue;
  end else if FormulaQtytype = fqtBuild then begin
    if edt1.text <> '' then Nodedata.Data.BuildFormulaQtyValue1 := strTofloat(edt1.text) else Nodedata.Data.BuildFormulaQtyValue1 := 0;
    if edt2.text <> '' then Nodedata.Data.BuildFormulaQtyValue2 := strTofloat(edt2.text) else Nodedata.Data.BuildFormulaQtyValue2 := 0;
    if edt3.text <> '' then Nodedata.Data.BuildFormulaQtyValue3 := strTofloat(edt3.text) else Nodedata.Data.BuildFormulaQtyValue3 := 0;
    if edt4.text <> '' then Nodedata.Data.BuildFormulaQtyValue4 := strTofloat(edt4.text) else Nodedata.Data.BuildFormulaQtyValue4 := 0;
    if edt5.text <> '' then Nodedata.Data.BuildFormulaQtyValue5 := strTofloat(edt5.text) else Nodedata.Data.BuildFormulaQtyValue5 := 0;
    if Nodedata.Data.TreePartUOMTotalQty <fdQty then Nodedata.Data.TreePartUOMTotalQty  := fdQty;
    //Nodedata.Data.FormulaQtyValue :=1;
    //Nodedata.Data.BuildFormulaQtyValue := fdQty;
    Nodedata.Data.ManufactureQty := fdQty;
    Nodedata.Data.Info := Nodedata.Data.caption + ' ' +ProductDimension+ ' ' +Comments;//FormulaWithValue;
  end else if FormulaQtytype = fqtOnOrder then begin
    if edt1.text <> '' then Nodedata.Data.OrderFormulaQtyValue1 := strTofloat(edt1.text) else Nodedata.Data.OrderFormulaQtyValue1 := 0;
    if edt2.text <> '' then Nodedata.Data.OrderFormulaQtyValue2 := strTofloat(edt2.text) else Nodedata.Data.OrderFormulaQtyValue2 := 0;
    if edt3.text <> '' then Nodedata.Data.OrderFormulaQtyValue3 := strTofloat(edt3.text) else Nodedata.Data.OrderFormulaQtyValue3 := 0;
    if edt4.text <> '' then Nodedata.Data.OrderFormulaQtyValue4 := strTofloat(edt4.text) else Nodedata.Data.OrderFormulaQtyValue4 := 0;
    if edt5.text <> '' then Nodedata.Data.OrderFormulaQtyValue5 := strTofloat(edt5.text) else Nodedata.Data.OrderFormulaQtyValue5 := 0;
    if Nodedata.Data.TreePartUOMTotalQty <fdQty then Nodedata.Data.TreePartUOMTotalQty  := fdQty;
    Nodedata.Data.OrderFormulaQtyValue := 1;
    Nodedata.Data.OnOrderQty := fdQty;
    Nodedata.Data.Info := Nodedata.Data.caption + ' ' +ProductDimension+ ' ' +Comments;//FormulaWithValue;
  end;
  if cboLineNos.visible and (cboLineNos.Text<> '') then
      Nodedata.Data.BuildLineNo := strtoint(cboLineNos.Text) else Nodedata.Data.BuildLineNo := 0;
  Nodedata.Data.Comments := Comments;
  ModalResult := mrOk;
end;

procedure TfmTreeProductSepc.btnCancelClick(Sender: TObject);
begin
  inherited;
  Modalresult := mrCancel;
end;

procedure TfmTreeProductSepc.btnChooseformulaClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TfmProductformulaList' , Selectformula , LocateFormula);
end;
procedure TfmTreeProductSepc.LocateFormula(Sender: TObject);
begin
  if not(Sender is TfmProductformulaList) then exit;
  TfmProductformulaList(Sender).KeyIdtoLocate := fiformulaId ;
end;
procedure TfmTreeProductSepc.Selectformula(Sender: TwwDbGrid);
begin
  if fiFormulaId =sender.datasource.dataset.FieldByName('FormulaId').asInteger then exit;
  if sametext(Formula.comments ,edtcomments.Text) then edtcomments.Text := '';
  edtFormula.text := sender.datasource.dataset.FieldByName('Formula').asString;
  edtFormulaName.text := edtFormula.text;
  fiformulaId  := sender.datasource.dataset.FieldByName('FormulaId').asInteger;
  edtFormulaWithValue.text :=getFormulaName(fiformulaId);
  CalculateRelatedQty;
  Initformulafields;
end;

procedure TfmTreeProductSepc.DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
   Value := 0;
       if sametext(VArname , 'Field1') then Value := strTofloat(edt1.text)
  else if sametext(VArname , 'Field2') then Value := strTofloat(edt2.text)
  else if sametext(VArname , 'Field3') then Value := strTofloat(edt3.text)
  else if sametext(VArname , 'Field4') then Value := strTofloat(edt4.text)
  else if sametext(VArname , 'Field5') then Value := strTofloat(edt5.text)
  else Exit;
  FieldFound := True;
end;

procedure TfmTreeProductSepc.edtcommentsDblClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TCommentsListGUI' , UpdateComments, InitCommentsList);
end;
procedure TfmTreeProductSepc.InitCommentsList(Sender: TObject);
begin
  if sender is  TCommentsListGUI then
    TCommentsListGUI(Sender).CommentsType := ctTreeComments;
end;
procedure TfmTreeProductSepc.UpdateComments(Sender: TwwDbGrid);
begin
   edtcomments.text := Sender.DataSource.DataSet.FieldByName('Comments').AsString;
   edtcomments.Refresh;
end;
procedure TfmTreeProductSepc.SetfocusToEdit(Sender: TObject);
begin
  inherited;
  SetControlfocus(edt1);
end;

procedure TfmTreeProductSepc.OnchangeValue(Sender: TObject);
begin
  inherited;
  if not(ISFormshown) then exit;
  CalculateRelatedQty;
  IsTemplateTree := True;
end;
procedure TfmTreeProductSepc.cboLineNosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key in ['0','1','2','3','4','5','6','7','8','9'] then
  else if ord(Key) = vk_back then
  else if ord(Key) = vk_return then
  else if ord(Key) = vk_Delete then
  else if ord(Key) = vk_tab then
  else Key := #0;
end;


procedure TfmTreeProductSepc.chkHideClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkHide then Appenv.employee.OpenTreeFromSalesOrder := not(chkHide.checked);
end;

constructor TfmTreeProductSepc.Create(AOwner: TComponent);
begin
  inherited;
  onMultiSelectProduct := False;
    fFormula := Nil;
end;

function TfmTreeProductSepc.getComments: String;
begin
  REsult := Trim(edtcomments.text);
end;
procedure TfmTreeProductSepc.setComments(const Value: String);
begin
  edtcomments.text := Value;
end;
Procedure TfmTreeProductSepc.Initformulafields;
begin
        pnl1.visible := (Formula.FormulatypeId =0) or (Formula.FeFormulaType.Fe1visible);
        pnl2.visible := (Formula.FormulatypeId =0) or (Formula.FeFormulaType.Fe2visible);
        pnl3.visible := (Formula.FormulatypeId =0) or (Formula.FeFormulaType.Fe3visible);
        pnl4.visible := (Formula.FormulatypeId =0) or (Formula.FeFormulaType.Fe4visible);
        pnl5.visible := (Formula.FormulatypeId =0) or (Formula.FeFormulaType.Fe5visible);

        if (strtofloat(edt1.text) =0) and (Formula.HasFe1DefaultValue) and (Formula.Fe1DefaultValue<>0) then edt1.Text := floattostr(Formula.Fe1DefaultValue);
        if (strtofloat(edt2.text) =0) and (Formula.HasFe2DefaultValue) and (Formula.Fe2DefaultValue<>0) then edt2.Text := floattostr(Formula.Fe2DefaultValue);
        if (strtofloat(edt3.text) =0) and (Formula.HasFe3DefaultValue) and (Formula.Fe3DefaultValue<>0) then edt3.Text := floattostr(Formula.Fe3DefaultValue);
        if (strtofloat(edt4.text) =0) and (Formula.HasFe4DefaultValue) and (Formula.Fe4DefaultValue<>0) then edt4.Text := floattostr(Formula.Fe4DefaultValue);
        if (strtofloat(edt5.text) =0) and (Formula.HasFe5DefaultValue) and (Formula.Fe5DefaultValue<>0) then edt5.Text := floattostr(Formula.Fe5DefaultValue);

        if (Formula.comments <> '') and (edtcomments.Text = '') then edtcomments.Text :=Formula.comments;
(*    if devmode then begin
        if (strtofloat(edt1.text) =0) then edt1.Text := '11';
        if (strtofloat(edt2.text) =0) then edt2.Text := '22';
        if (strtofloat(edt3.text) =0) then edt3.Text := '33';
        if (strtofloat(edt4.text) =0) then edt4.Text := '44';
        if (strtofloat(edt5.text) =0) then edt5.Text := '55';

    end;*)
end;

end.
